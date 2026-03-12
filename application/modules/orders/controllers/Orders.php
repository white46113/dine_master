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
        
        $status = $this->input->get('status');
        $data['orders'] = $this->Order_management_model->get_all_orders($status);
        $data['current_status'] = $status;
        
        $this->render('index.tpl', $data);
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
