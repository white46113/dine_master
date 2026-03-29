<?php defined('BASEPATH') or exit('No direct script access allowed');
class Order_model extends CI_Model
{
    private $orders = 'orders';
    private $order_items = 'order_items';
    private $order_item_addons = 'order_item_addons';
    public function create_order($payload)
    {
        $this->db->trans_start();
        $order = $payload['order'];
        $this->db->insert($this->orders, $order);
        $order_id = $this->db->insert_id();
        foreach ($payload['items'] as $it) {
            $addons = isset($it['addons']) ? $it['addons'] : [];
            $it_insert = [
                'order_id' => $order_id,
                'item_id' => $it['item_id'],
                'item_name' => $it['item_name'] ,
                'unit_price' => $it['unit_price'],
                'quantity' => $it['quantity'] ,
                'added_by' => $order['added_by']
            ];
            $this->db->insert($this->order_items, $it_insert);
            $oid = $this->db->insert_id();
            foreach ($addons as $ad) {
                $ad_insert = [
                    'order_item_id' => $oid,
                    'addon_option_id' => $ad['addon_option_id'] ,
                    'addon_name' => $ad['addon_name'] ,
                    'price_delta' => $ad['price_delta'] ,
                    'added_by' => $order['added_by']
                ];
                $this->db->insert($this->order_item_addons, $ad_insert);
            }
        }
        // Update Table Status to OCCUPIED and link this Order
        if (isset($order['table_id']) && !empty($order['table_id'])) {
            $this->db->where('table_id', $order['table_id'])->update('dining_tables', [
                'status'           => 'OCCUPIED',
                'current_order_id' => $order_id
            ]);
        }

        $this->db->trans_complete();
        if ($this->db->trans_status() === FALSE)
            return false;
        return $order_id;
    }
    public function get($id)
    {
        // Fetch full order record
        // Fetch order with restaurant GST settings
        $this->db->select('o.*, r.name as restaurant_name, r.gst_applicable, r.gst_percentage');
        $this->db->from($this->orders . ' o');
        $this->db->join('restaurants r', 'r.restaurant_id = o.restaurant_id', 'left');
        $this->db->where('o.order_id', $id);
        $order = $this->db->get()->row_array();
        if (!$order)
            return null;

        // Populate order_number if missing for existing orders
        if (empty($order['order_number'])) {
            $order_number = 'ORD' . date('YmdHis', strtotime($order['placed_at']));
            $this->db->where('order_id', $id)->update($this->orders, ['order_number' => $order_number]);
            $order['order_number'] = $order_number;
        }

        // Fetch full item records, joining menu_items for veg_type
        $this->db->select('oi.*, mi.veg_type');
        $this->db->from($this->order_items . ' oi');
        $this->db->join('menu_items mi', 'mi.item_id = oi.item_id', 'left');
        $this->db->where('oi.order_id', $id);
        $items = $this->db->get()->result_array();

        foreach ($items as &$item) {
            // Fetch addons for this item
            $this->db->select('*, price_delta as price');
            $item['addons'] = $this->db
                ->get_where($this->order_item_addons, ['order_item_id' => $item['order_item_id']])
                ->result_array();
        }
        unset($item); // Important: Fix PHP reference bug to avoid duplicate items in later loops

        // Merge duplicate items (same item_id, unit_price, and addons)
        $merged_items = [];
        foreach ($items as $item) {
            // Create a unique key for grouping: item_id + unit_price + serialized addons
            $addon_keys = [];
            if (!empty($item['addons'])) {
                foreach ($item['addons'] as $ad) {
                    $addon_keys[] = $ad['addon_option_id'] . ':' . $ad['price'];
                }
                sort($addon_keys); // Ensure consistent key regardless of DB order
            }
            $merge_key = $item['item_id'] . '_' . number_format($item['unit_price'], 2, '.', '') . '_' . implode('|', $addon_keys);

            if (!isset($merged_items[$merge_key])) {
                // Initialize merged item with first instance's data
                $merged_items[$merge_key] = $item;
                $merged_items[$merge_key]['quantity'] = floatval($item['quantity']);
            } else {
                // Add quantity to existing merged item
                $merged_items[$merge_key]['quantity'] += floatval($item['quantity']);
            }
        }

        // Finalize merged items: format quantity and compute line_total
        foreach ($merged_items as &$m_item) {
            $m_item['quantity'] = number_format($m_item['quantity'], 2, '.', '');
            $m_item['line_subtotal'] = number_format(floatval($m_item['unit_price']) * floatval($m_item['quantity']), 2, '.', '');
            $m_item['line_total'] = $m_item['line_subtotal']; // For now, line_total = line_subtotal
        }
        unset($m_item);
        $items = array_values($merged_items); // Replace original items with merged ones

        // Compute order-level status based on item statuses
        if (!empty($items)) {
            $item_statuses = array_column($items, 'status');
            if (in_array('PENDING', $item_statuses)) {
                $order['status'] = 'PENDING';
            } elseif (count(array_unique($item_statuses)) === 1 && $item_statuses[0] === 'COMPLETED') {
                $order['status'] = 'COMPLETED';
            }
        }

        // Compute subtotal_amount = SUM(unit_price * quantity) for all items
        $subtotal = 0;
        foreach ($items as $item) {
            $subtotal += floatval($item['unit_price']) * floatval($item['quantity']);
        }
        $order['subtotal_amount'] = number_format($subtotal, 2, '.', '');

        // Compute GST if applicable
        $tax_amount = 0;
        if (isset($order['gst_applicable']) && $order['gst_applicable'] === 'yes') {
            $gst_percent = floatval($order['gst_percentage'] ?? 0);
            $tax_amount = $subtotal * ($gst_percent / 100);
        }
        $order['tax_amount'] = number_format($tax_amount, 2, '.', '');
        
        // Use restaurant_name selected from the join
        if (!isset($order['restaurant_name']) || empty($order['restaurant_name'])) {
            $order['restaurant_name'] = 'Dine Master';
        }

        // Compute total_payable = subtotal_amount - discount_amount + service_charge_amt + tax_amount + rounding_adjustment
        $total_payable = $subtotal
            - floatval(isset($order['discount_amount']) ? $order['discount_amount'] : 0)
            + floatval(isset($order['service_charge_amt']) ? $order['service_charge_amt'] : 0)
            + $tax_amount
            + floatval(isset($order['rounding_adjustment']) ? $order['rounding_adjustment'] : 0);
        $order['total_payable'] = number_format($total_payable, 2, '.', '');

        $order['items'] = $items;
        return $order;
    }
    public function list($filters = [])
    {
        if (isset($filters['user_id']))
            $this->db->where('o.added_by', $filters['user_id']);
        if (isset($filters['restaurant_id']))
            $this->db->where('o.restaurant_id', $filters['restaurant_id']);
        $this->db->select('o.*, oi.order_item_id as item_id, oi.item_name, oi.unit_price, oi.quantity, oi.added_by as item_added_by')
            ->from($this->orders . ' o')
            ->join($this->order_items . ' oi', 'oi.order_id = o.order_id', 'left')
            ->order_by('o.placed_at', 'desc');
        $result = $this->db->get()->result();
        // Group results by order and items (no addons)
        $orders = [];
        foreach ($result as $row) {
            $oid = $row->order_id;
            if (!isset($orders[$oid])) {
                $order = clone $row;
                // Status mapping: consolidate active statuses to RUNNING
                if (in_array($order->status, ['PLACED', 'RUNNING', 'PREPARING', 'READY', 'SERVED'])) {
                    $order->status = 'RUNNING';
                }
                $order->items = [];
                unset($order->item_id, $order->item_name, $order->unit_price, $order->quantity, $order->item_added_by);
                $orders[$oid] = $order;
            }
            if ($row->item_id) {
                $item_key = $row->item_id;
                if (!isset($orders[$oid]->items[$item_key])) {
                    $item = new \stdClass();
                    $item->id = $row->item_id;
                    $item->item_name = $row->item_name;
                    $item->unit_price = $row->unit_price;
                    $item->quantity = $row->quantity;
                    $item->added_by = $row->item_added_by;
                    $orders[$oid]->items[] = $item;
                }
            }
        }
        return array_values($orders);
         
    }

    /** Fetch a single order row (without items) to validate it exists */
    public function get_order_row($order_id)
    {
        return $this->db->get_where($this->orders, ['order_id' => $order_id])->row_array();
    }

    /** Check that a menu item exists */
    public function menu_item_exists($item_id)
    {
        return $this->db->where('item_id', $item_id)->count_all_results('menu_items') > 0;
    }

    /** Add items to an existing order and recompute totals */
    public function add_items_to_order($order_id, $items, $added_by)
    {
        $this->db->trans_start();

        foreach ($items as $it) {
            // Accept both item_id and menu_id as field names
            $item_id   = isset($it['item_id']) ? $it['item_id'] : (isset($it['menu_id']) ? $it['menu_id'] : null);
            $item_name = isset($it['item_name']) ? $it['item_name'] : null;

            // Fetch item name from menu_items if not provided
            if (!$item_name && $item_id) {
                $menu = $this->db->get_where('menu_items', ['item_id' => $item_id])->row();
                $item_name = $menu ? $menu->name : 'Unknown';
            }

            $row = [
                'order_id'  => $order_id,
                'item_id'   => $item_id,
                'item_name' => $item_name,
                'unit_price'=> isset($it['price']) ? $it['price'] : (isset($it['unit_price']) ? $it['unit_price'] : 0),
                'quantity'  => isset($it['quantity']) ? $it['quantity'] : 1,
                'status'    => 'PENDING',
                'added_by'  => $added_by,
                'added_date'=> date('Y-m-d H:i:s'),
            ];
            $this->db->insert($this->order_items, $row);

            // Insert addons if provided
            $oid = $this->db->insert_id();
            if (!empty($it['addons']) && is_array($it['addons'])) {
                foreach ($it['addons'] as $ad) {
                    $this->db->insert($this->order_item_addons, [
                        'order_item_id'   => $oid,
                        'addon_option_id' => $ad['addon_option_id'],
                        'addon_name'      => $ad['addon_name'],
                        'price_delta'     => $ad['price_delta'],
                        'added_by'        => $added_by,
                    ]);
                }
            }
        }

        // Recompute subtotal and total_payable from all current items
        $all_items = $this->db->get_where($this->order_items, ['order_id' => $order_id])->result_array();
        $subtotal  = 0;
        foreach ($all_items as $item) {
            $subtotal += floatval($item['unit_price']) * floatval($item['quantity']);
        }
        $order = $this->get_order_row($order_id);
        $total_payable = $subtotal
            - floatval(isset($order['discount_amount']) ? $order['discount_amount'] : 0)
            + floatval(isset($order['service_charge_amt']) ? $order['service_charge_amt'] : 0)
            + floatval(isset($order['tax_amount']) ? $order['tax_amount'] : 0)
            + floatval(isset($order['rounding_adjustment']) ? $order['rounding_adjustment'] : 0);

        $this->db->where('order_id', $order_id)->update($this->orders, [
            'subtotal_amount' => number_format($subtotal, 2, '.', ''),
            'total_payable'   => number_format($total_payable, 2, '.', ''),
            'updated_date'    => date('Y-m-d H:i:s'),
        ]);

        $this->db->trans_complete();
        return $this->db->trans_status();
    }

    /** Update items in an existing order and recompute totals */
    public function update_item_in_order($order_id, $items, $user_id)
    {
        $this->db->trans_start();

        foreach ($items as $it) {
            $order_item_id = isset($it['order_item_id']) ? intval($it['order_item_id']) : null;
            $menu_id       = isset($it['menu_id']) ? intval($it['menu_id']) : null;
            $quantity      = isset($it['quantity']) ? intval($it['quantity']) : (isset($it['qty']) ? intval($it['qty']) : null);
            $unit_price    = isset($it['price']) ? floatval($it['price']) : (isset($it['unit_price']) ? floatval($it['unit_price']) : null);

            $where = [];
            if ($order_item_id) {
                $where['order_item_id'] = $order_item_id;
            } elseif ($menu_id && $order_id) {
                $where['order_id'] = $order_id;
                $where['item_id']  = $menu_id;
            }

            if (empty($where)) continue;

            if ($quantity === 0) {
                // Delete item and its addons
                // First find the item ID if we only have menu_id
                if (!$order_item_id) {
                    $item_row = $this->db->get_where($this->order_items, $where)->row();
                    $order_item_id = $item_row ? $item_row->order_item_id : null;
                }
                
                if ($order_item_id) {
                    $this->db->delete($this->order_item_addons, ['order_item_id' => $order_item_id]);
                    $this->db->delete($this->order_items, ['order_item_id' => $order_item_id]);
                }
            } else {
                // Update item
                $data = [];
                if ($quantity !== null) $data['quantity'] = $quantity;
                if ($unit_price !== null) $data['unit_price'] = $unit_price;
                
                if (!empty($data)) {
                    $this->db->where($where)->update($this->order_items, $data);
                }
            }
        }

        $this->recompute_order_totals($order_id);

        $this->db->trans_complete();
        return $this->db->trans_status();
    }

    /** Recompute subtotal and total_payable for an order */
    public function recompute_order_totals($order_id)
    {
        // Recompute subtotal from all current items
        $all_items = $this->db->get_where($this->order_items, ['order_id' => $order_id])->result_array();
        $subtotal  = 0;
        foreach ($all_items as $item) {
            $subtotal += floatval($item['unit_price']) * floatval($item['quantity']);
        }
        
        // Fetch order with restaurant GST settings
        $this->db->select('o.*, r.gst_applicable, r.gst_percentage');
        $this->db->from($this->orders . ' o');
        $this->db->join('restaurants r', 'r.restaurant_id = o.restaurant_id', 'left');
        $this->db->where('o.order_id', $order_id);
        $order = $this->db->get()->row_array();
        
        if (!$order) return false;

        $tax_amount = 0;
        if (isset($order['gst_applicable']) && $order['gst_applicable'] === 'yes') {
            $gst_percent = floatval($order['gst_percentage'] ?? 0);
            $tax_amount = $subtotal * ($gst_percent / 100);
        }

        $total_payable = $subtotal
            - floatval(isset($order['discount_amount']) ? $order['discount_amount'] : 0)
            + floatval(isset($order['service_charge_amt']) ? $order['service_charge_amt'] : 0)
            + $tax_amount
            + floatval(isset($order['rounding_adjustment']) ? $order['rounding_adjustment'] : 0);

        return $this->db->where('order_id', $order_id)->update($this->orders, [
            'subtotal_amount' => number_format($subtotal, 2, '.', ''),
            'tax_amount'      => number_format($tax_amount, 2, '.', ''),
            'total_payable'   => number_format($total_payable, 2, '.', ''),
            'updated_date'    => date('Y-m-d H:i:s'),
        ]);
    }

    /** Delete an item from an order */
    public function delete_order_item($order_id, $item_id = null, $order_item_id = null)
    {
        $this->db->trans_start();

        $where = ['order_id' => $order_id];
        if ($order_item_id) {
            $where['order_item_id'] = $order_item_id;
        } elseif ($item_id) {
            $where['item_id'] = $item_id;
        } else {
            return false;
        }

        // Get affected item ids for addon cleanup
        $this->db->select('order_item_id');
        $affected = $this->db->get_where($this->order_items, $where)->result_array();
        
        foreach ($affected as $it) {
            $this->db->delete($this->order_item_addons, ['order_item_id' => $it['order_item_id']]);
        }

        $this->db->delete($this->order_items, $where);

        $this->recompute_order_totals($order_id);

        $this->db->trans_complete();
        return $this->db->trans_status();
    }
}
