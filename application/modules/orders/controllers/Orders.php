<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Orders extends Admin_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Order_management_model');
        $this->load->model('menu/Menu_model');
    }

    private function _is_superadmin() {
        $admin_data = $this->session->userdata('admin_user');
        return (isset($admin_data['role_id']) && $admin_data['role_id'] == 1) || 
               (isset($admin_data['user_role']) && $admin_data['user_role'] == 1);
    }

    /**
     * Table Selection Grid (Primary flow)
     */
    public function index()
    {
        $data['title'] = 'Table Selection | Dine Master';
        $data['page_title'] = 'Select Table';
        
        $floors = $this->Order_management_model->get_floors();
        $tables = $this->Order_management_model->get_tables();
        $is_superadmin = $this->_is_superadmin();
        
        $data['is_superadmin'] = $is_superadmin;
        
        $restaurants = [];
        $stats = [
            'total' => count($tables),
            'free' => 0,
            'occupied' => 0,
            'reserved' => 0
        ];

        // First map tables to floors
        $floor_tables = [];
        foreach ($tables as $table) {
            $floor_tables[$table['floor_id']][] = $table;
            
            // Calculate Stats
            if ($table['status'] == 'FREE') $stats['free']++;
            elseif ($table['status'] == 'OCCUPIED') $stats['occupied']++;
            elseif ($table['status'] == 'RESERVED') $stats['reserved']++;
        }
        
        // Map floors to restaurants
        foreach ($floors as $floor) {
            $rest_id = $floor['restaurant_id'] ?? 1;
            if (!isset($restaurants[$rest_id])) {
                $restaurants[$rest_id] = [
                    'restaurant_id' => $rest_id,
                    'restaurant_name' => $floor['restaurant_name'] ?: 'Unknown Restaurant',
                    'floors' => []
                ];
            }
            
            $floor['tables'] = $floor_tables[$floor['floor_id']] ?? [];
            $restaurants[$rest_id]['floors'][] = $floor;
        }
        
        $data['restaurants'] = array_values($restaurants); // re-key numerically
        $data['stats'] = $stats;
        $this->render('tables.tpl', $data);
    }

    /**
     * Start a new order from a table
     */
    public function create()
    {
        $table_id = $this->input->get('table_id');
        if (!$table_id) {
            redirect('admin/orders');
        }
        
        // Find the table to get its restaurant_id
        $this->db->where('table_id', $table_id);
        $table = $this->db->get('dining_tables')->row_array();
        if (!$table) {
            redirect('admin/orders');
        }

        // 1. Create New Order
        $order_number = 'ORD' . str_pad(mt_rand(1, 9999), 4, '0', STR_PAD_LEFT);
        $order_data = [
            'order_number'  => $order_number,
            'restaurant_id' => $table['restaurant_id'], 
            'table_id'      => $table_id,
            'status'        => 'RUNNING',
            'order_type'    => 'DINE_IN',
            'waiter_id'     => $this->session->userdata('admin_user_id'),
            'placed_at'     => date('Y-m-d H:i:s'),
            'added_by'      => $this->session->userdata('admin_user_id')
        ];

        $this->db->insert('orders', $order_data);
        $order_id = $this->db->insert_id();

        // 2. Update Table Status
        $this->db->where('table_id', $table_id);
        $this->db->update('dining_tables', [
            'status'           => 'OCCUPIED',
            'current_order_id' => $order_id
        ]);

        redirect('admin/orders/manage/' . $order_id);
    }

    /**
     * POS Style Order Management View
     */
    public function manage($order_id)
    {
        $data['order'] = $this->Order_management_model->get_order_by_id($order_id);
        if (empty($data['order'])) {
            show_404();
        }

        $data['title'] = 'Manage Order #' . $data['order']['order_number'] . ' | Dine Master';
        $data['categories'] = $this->Menu_model->get_categories();
        
        // Ideally we fetch items only for this restaurant, but Menu_model might handle that or it's a future step
        $data['items'] = $this->Menu_model->get_all_items();
        
        // Fetch existing items already in this order
        $data['order_items'] = $this->Order_management_model->get_order_items($order_id);
        
        $this->render('manage.tpl', $data);
    }

    /**
     * AJAX: Send items to kitchen (KOT)
     */
    public function send_to_kitchen()
    {
        $order_id = $this->input->post('order_id');
        $items = $this->input->post('items');

        if (!$order_id || empty($items)) {
            echo json_encode(['success' => false, 'message' => 'No items or order ID provided']);
            return;
        }

        $this->db->trans_start();

        // 1. Create KOT Ticket
        $kot_data = [
            'order_id'      => $order_id,
            'status'        => 'QUEUED',
            'added_by'      => $this->session->userdata('admin_user_id'),
            'added_date'    => date('Y-m-d H:i:s')
        ];
        $this->db->insert('kot_tickets', $kot_data);
        $kot_id = $this->db->insert_id();

        // 2. Insert Order Items and KOT Items
        foreach ($items as $item) {
            $order_item_data = [
                'order_id'      => $order_id,
                'item_id'       => $item['item_id'],
                'item_name'     => $item['name'],
                'veg_type'      => $item['veg_type'],
                'unit_price'    => $item['base_price'],
                'quantity'      => $item['qty'],
                'notes'         => $item['note'],
                'status'        => 'PENDING',
                'line_subtotal' => $item['base_price'] * $item['qty'],
                'line_total'    => $item['base_price'] * $item['qty'], // Simplified for now
                'added_by'      => $this->session->userdata('admin_user_id')
            ];
            $this->db->insert('order_items', $order_item_data);
            $order_item_id = $this->db->insert_id();

            // Insert into KOT items
            $this->db->insert('kot_items', [
                'kot_id'         => $kot_id,
                'order_item_id'  => $order_item_id,
                'quantity'       => $item['qty'],
                'added_by'       => $this->session->userdata('admin_user_id')
            ]);
        }

        // 3. Update Order Subtotal
        $this->db->select_sum('line_total');
        $this->db->where('order_id', $order_id);
        $subtotal = $this->db->get('order_items')->row()->line_total;

        $this->db->where('order_id', $order_id);
        $this->db->update('orders', [
            'subtotal_amount' => $subtotal,
            'total_payable'   => $subtotal // Simplified, tax will be on billing
        ]);

        $this->db->trans_complete();

        if ($this->db->trans_status() === FALSE) {
            echo json_encode(['success' => false, 'message' => 'Database error']);
        } else {
            echo json_encode(['success' => true, 'message' => 'KOT generated successfully']);
        }
    }

    /**
     * Bill Generation View
     */
    public function bill($order_id)
    {
        $this->load->model('restaurant/Restaurant_model');
        $data['order'] = $this->Order_management_model->get_order_by_id($order_id);
        
        if (empty($data['order'])) {
            show_404();
        }

        $data['restaurant'] = $this->Restaurant_model->get_details($data['order']['restaurant_id'] ?: 1);

        $data['title'] = 'Generate Bill #' . $data['order']['order_number'] . ' | Dine Master';
        $data['items'] = $this->Order_management_model->get_order_items($order_id);
        
        // Calculations based on restaurant GST settings
        $subtotal = 0;
        foreach ($data['items'] as $item) {
            $subtotal += $item['line_total'];
        }
        
        $gst_applicable = ($data['restaurant']['gst_applicable'] ?? 'no') === 'yes';
        $gst_percentage = floatval($data['restaurant']['gst_percentage'] ?? 0);
        
        $data['subtotal'] = $subtotal;
        $data['tax_amount'] = $gst_applicable ? ($subtotal * ($gst_percentage / 100)) : 0;
        $data['total_payable'] = $data['subtotal'] + $data['tax_amount'];

        $this->render('bill.tpl', $data);
    }

    /**
     * AJAX: Process Payment and Complete Order
     */
    public function process_payment()
    {
        $order_id = $this->input->post('order_id');
        $payment_method = $this->input->post('payment_method');
        $amount = $this->input->post('amount');

        if (!$order_id || !$payment_method) {
            echo json_encode(['success' => false, 'message' => 'Invalid data']);
            return;
        }

        $this->db->trans_start();

        // 0. Get Order Details (needed for restaurant_id and table reset)
        $order = $this->Order_management_model->get_order_by_id($order_id);
        if (!$order) {
            echo json_encode(['success' => false, 'message' => 'Order not found']);
            return;
        }

        // 1. Insert Payment
        $payment_data = [
            'order_id'      => $order_id,
            'restaurant_id' => $order['restaurant_id'], 
            'method'        => $payment_method, 
            'amount'        => $amount,
            'status'        => 'SUCCESS',
            'added_by'      => $this->session->userdata('admin_user_id'),
            'paid_at'       => date('Y-m-d H:i:s') 
        ];
        $this->db->insert('payments', $payment_data);

        // 2. Update Order Status
        $this->db->where('order_id', $order_id);
        $this->db->update('orders', [
            'status'         => 'COMPLETED',
            'payment_status' => 'PAID',
            'completed_at'   => date('Y-m-d H:i:s')
        ]);

        // 3. Reset Table Status
        if ($order && isset($order['table_id'])) {
            $this->db->where('table_id', $order['table_id']);
            $this->db->set('status', 'FREE');
            $this->db->set('current_order_id', NULL);
            $this->db->update('dining_tables');
        }

        $this->db->trans_complete();

        if ($this->db->trans_status() === FALSE) {
            echo json_encode(['success' => false, 'message' => 'Database transaction failed']);
        } else {
            echo json_encode(['success' => true, 'message' => 'Payment processed successfully']);
        }
    }

    /**
     * AJAX: Cancel Ordered Item
     */
    public function cancel_item()
    {
        $order_item_id = $this->input->post('order_item_id');
        if (!$order_item_id) {
            echo json_encode(['success' => false, 'message' => 'Invalid Request']);
            return;
        }

        $this->db->trans_start();

        // 1. Get Order Item Details
        $this->db->where('order_item_id', $order_item_id);
        $item = $this->db->get('order_items')->row_array();

        if (!$item) {
            echo json_encode(['success' => false, 'message' => 'Item not found']);
            return;
        }

        // 2. Update status to CANCELLED
        $this->db->where('order_item_id', $order_item_id);
        $this->db->update('order_items', ['status' => 'CANCELLED']);

        // 3. Recalculate Order Subtotal (excluding cancelled items)
        $order_id = $item['order_id'];
        $this->db->select_sum('line_total');
        $this->db->where('order_id', $order_id);
        $this->db->where('status !=', 'CANCELLED');
        $subtotal = $this->db->get('order_items')->row()->line_total;

        $this->db->where('order_id', $order_id);
        $this->db->update('orders', [
            'subtotal_amount' => $subtotal ? $subtotal : 0,
            'total_payable'   => $subtotal ? $subtotal : 0
        ]);

        $this->db->trans_complete();

        if ($this->db->trans_status() === FALSE) {
            echo json_encode(['success' => false, 'message' => 'Database error']);
        } else {
            echo json_encode(['success' => true, 'message' => 'Item cancelled cancelled successfully']);
        }
    }

    /**
     * AJAX: Release table (Set from CLEANING to FREE)
     */
    public function release_table()
    {
        $table_id = $this->input->post('table_id');
        if (!$table_id) {
            echo json_encode(['success' => false, 'message' => 'Invalid table ID']);
            return;
        }

        $this->db->where('table_id', $table_id);
        if ($this->db->update('dining_tables', ['status' => 'FREE'])) {
            echo json_encode(['success' => true, 'message' => 'Table is now available']);
        } else {
            echo json_encode(['success' => false, 'message' => 'Failed to release table']);
        }
    }

    /**
     * List all orders (Order History)
     */
    public function all()
    {
        $data['title'] = 'Order History | Dine Master';
        $data['page_title'] = 'Orders';
        $data['current_status'] = $this->input->get('status');
        $data['is_superadmin']  = $this->_is_superadmin();
        
        $this->render('index.tpl', $data);
    }

    /**
     * DataTables Server-side List
     */
    public function ajax_list()
    {
        $list = $this->Order_management_model->get_datatables();
        $is_superadmin = $this->_is_superadmin();
        $data = [];
        $no = $_POST['start'];
        
        foreach ($list as $order) {
            $no++;
            $row = [];
            
            // Order ID & Customer
            $row[] = '
                <div class="flex items-center">
                    <div class="w-10 h-10 rounded-full bg-blue-50 flex items-center justify-center text-blue-600 font-bold mr-3">
                        #' . $order->order_id . '
                    </div>
                    <div>
                        <div class="font-bold text-gray-800">' . ($order->customer_name ?: "Guest") . '</div>
                        <div class="text-xs text-gray-400">' . date('h:i A, d M', strtotime($order->placed_at)) . '</div>
                    </div>
                </div>';
                
            if ($is_superadmin) {
                $row[] = '<span class="px-3 py-1 bg-orange-50 text-orange-600 text-xs font-bold uppercase tracking-widest rounded-lg">' . ($order->restaurant_name ?: "Unknown") . '</span>';
            }
            
            // Table
            $row[] = '<span class="px-3 py-1 bg-gray-100 text-gray-700 text-xs font-bold rounded-lg">' . ($order->table_no ?: "N/A") . '</span>';
            
            // Amount
            $row[] = '<div class="font-bold text-gray-900">₹' . number_format($order->total_payable, 2) . '</div>';
            
            // Status Badge
            $status_class = [
                'PLACED'    => 'bg-blue-100 text-blue-700',
                'PREPARING' => 'bg-orange-100 text-orange-700',
                'READY'     => 'bg-purple-100 text-purple-700',
                'SERVED'    => 'bg-green-100 text-green-700',
                'COMPLETED' => 'bg-gray-100 text-gray-700',
                'CANCELLED' => 'bg-red-100 text-red-700'
            ];
            $class = $status_class[$order->status] ?? 'bg-gray-100 text-gray-700';
            $row[] = '<span class="px-3 py-1 ' . $class . ' text-[10px] font-black uppercase tracking-wider rounded-full">' . $order->status . '</span>';
            
            // Actions
            $row[] = '
                <div class="flex justify-center space-x-2">
                    <a href="' . base_url('admin/orders/details/' . $order->order_id) . '" class="w-9 h-9 flex items-center justify-center bg-blue-50 text-blue-600 rounded-lg hover:bg-blue-600 hover:text-white transition-all">
                        <i class="fa-solid fa-eye"></i>
                    </a>
                    <button onclick="updateOrderStatus(' . $order->order_id . ', \'COMPLETED\')" class="w-9 h-9 flex items-center justify-center bg-green-50 text-green-600 rounded-lg hover:bg-green-600 hover:text-white transition-all" title="Mark as Completed">
                        <i class="fa-solid fa-check"></i>
                    </button>
                </div>';
            
            $data[] = $row;
        }

        $output = [
            "draw" => $_POST['draw'],
            "recordsTotal" => $this->Order_management_model->count_all(),
            "recordsFiltered" => $this->Order_management_model->count_filtered(),
            "data" => $data,
        ];
        echo json_encode($output);
    }

    /**
     * View order details
     */
    public function details($id)
    {
        $data['title'] = 'Order Details | Dine Master Admin';
        $data['page_title'] = 'Order #' . $id;
        
        $data['order'] = $this->Order_management_model->get_order_by_id($id);
        if (empty($data['order'])) {
            show_404();
        }

        $data['items'] = $this->Order_management_model->get_order_items($id);
        
        $this->render('details.tpl', $data);
    }

    /**
     * Update order status (AJAX)
     */
    public function update_status()
    {
        $id = $this->input->post('order_id');
        $status = $this->input->post('status');

        if ($this->Order_management_model->update_status($id, $status)) {
            echo json_encode(['success' => true, 'message' => 'Order status updated to ' . $status]);
        } else {
            echo json_encode(['success' => false, 'message' => 'Failed to update status.']);
        }
    }
}
