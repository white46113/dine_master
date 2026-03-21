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
            $addons = $it['addons'] ?? [];
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
        $this->db->trans_complete();
        if ($this->db->trans_status() === FALSE)
            return false;
        return $order_id;
    }
    public function get($id)
    {
        // Fetch full order record
        $order = $this->db->get_where($this->orders, ['order_id' => $id])->row_array();
        if (!$order)
            return null;

        // Fetch full item records, joining menu_items for veg_type
        $this->db->select('oi.*, mi.veg_type');
        $this->db->from($this->order_items . ' oi');
        $this->db->join('menu_items mi', 'mi.item_id = oi.item_id', 'left');
        $this->db->where('oi.order_id', $id);
        $items = $this->db->get()->result_array();

        foreach ($items as &$item) {
            // Fetch addons for this item
            $item['addons'] = $this->db
                ->get_where($this->order_item_addons, ['order_item_id' => $item['order_item_id']])
                ->result_array();
        }

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

        // Compute total_payable = subtotal_amount - discount_amount + service_charge_amt + tax_amount + rounding_adjustment
        $total_payable = $subtotal
            - floatval($order['discount_amount'] ?? 0)
            + floatval($order['service_charge_amt'] ?? 0)
            + floatval($order['tax_amount'] ?? 0)
            + floatval($order['rounding_adjustment'] ?? 0);
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
}
