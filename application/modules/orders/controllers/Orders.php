<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Orders extends Admin_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Order_management_model');
    }

    /**
     * List all orders
     */
    public function index()
    {
        $data['title'] = 'Order Management | Dine Master Admin';
        $data['page_title'] = 'Orders';
        $data['current_status'] = $this->input->get('status');
        
        $this->render('index.tpl', $data);
    }

    /**
     * DataTables Server-side List
     */
    public function ajax_list()
    {
        $list = $this->Order_management_model->get_datatables();
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
