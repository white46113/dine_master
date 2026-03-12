<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Order_management_model extends CI_Model
{
    protected $table = 'orders';

    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Get all orders with customer and table details
     */
    public function get_all_orders($status = null)
    {
        $this->db->select('o.*, c.name as customer_name, t.table_no');
        $this->db->from($this->table . ' o');
        $this->db->join('customers c', 'c.customer_id = o.customer_id', 'left');
        $this->db->join('dining_tables t', 't.table_id = o.table_id', 'left');
        
        if ($status) {
            $this->db->where('o.status', $status);
        }
        
        $this->db->order_by('o.placed_at', 'DESC');
        $query = $this->db->get();
        return $query->result_array();
    }

    /**
     * Get order details by ID
     */
    public function get_order_by_id($id)
    {
        $this->db->select('o.*, c.name as customer_name, c.email as customer_email, c.phone as customer_phone, t.table_no');
        $this->db->from($this->table . ' o');
        $this->db->join('customers c', 'c.customer_id = o.customer_id', 'left');
        $this->db->join('dining_tables t', 't.table_id = o.table_id', 'left');
        $this->db->where('o.order_id', $id);
        $query = $this->db->get();
        return $query->row_array();
    }

    /**
     * Get items for a specific order
     */
    public function get_order_items($order_id)
    {
        $this->db->select('oi.*, mi.name as item_name, mi.image_url');
        $this->db->from('order_items oi');
        $this->db->join('menu_items mi', 'mi.item_id = oi.item_id', 'left');
        $this->db->where('oi.order_id', $order_id);
        $query = $this->db->get();
        return $query->result_array();
    }

    /**
     * Update order status
     */
    public function update_status($id, $status)
    {
        $data = ['status' => $status];
        if ($status == 'COMPLETED') {
            $data['completed_at'] = date('Y-m-d H:i:s');
            $data['payment_status'] = 'PAID';
        }
        
        $this->db->where('order_id', $id);
        return $this->db->update($this->table, $data);
    }
}
