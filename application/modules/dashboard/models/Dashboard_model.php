<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Dashboard_model extends CI_Model
{
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Get summary statistics
     */
    public function get_stats()
    {
        $stats = [];
        
        // Total Orders
        $this->db->from('orders');
        $stats['total_orders'] = $this->db->count_all_results();

        // Today's Orders
        $this->db->from('orders');
        $this->db->where('DATE(placed_at)', date('Y-m-d'));
        $stats['today_orders'] = $this->db->count_all_results();

        // Total Revenue (Completed Orders)
        $this->db->select_sum('total_payable');
        $this->db->from('orders');
        $this->db->where('status', 'COMPLETED');
        $query = $this->db->get();
        $stats['total_revenue'] = isset($query->row()->total_payable) ? $query->row()->total_payable : 0;

        // Total Menu Items
        $this->db->from('menu_items');
        $stats['menu_items'] = $this->db->count_all_results();

        return $stats;
    }

    /**
     * Get recent orders
     */
    public function get_recent_orders($limit = 5)
    {
        $this->db->select('o.*, c.name as customer_name');
        $this->db->from('orders o');
        $this->db->join('customers c', 'c.customer_id = o.customer_id', 'left');
        $this->db->order_by('o.placed_at', 'DESC');
        $this->db->limit($limit);
        $query = $this->db->get();
        return $query->result_array();
    }
}
