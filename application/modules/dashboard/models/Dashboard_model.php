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
        
        // Today's Revenue (Completed Orders Today)
        $this->db->select_sum('total_payable');
        $this->db->from('orders');
        $this->db->where('status', 'COMPLETED');
        $this->db->where('DATE(placed_at)', date('Y-m-d'));
        $stats['today_revenue'] = (float)($this->db->get()->row()->total_payable ?? 0);

        // Occupied Tables
        $this->db->from('dining_tables');
        $this->db->where('status', 'OCCUPIED');
        $stats['occupied_tables'] = $this->db->count_all_results();

        // Available Tables
        $this->db->from('dining_tables');
        $this->db->where('status', 'FREE');
        $stats['available_tables'] = $this->db->count_all_results();

        // Active Orders (Not Completed/Cancelled)
        $this->db->from('orders');
        $this->db->where_in('status', ['PLACED', 'PREPARING', 'READY', 'SERVED']);
        $stats['active_orders'] = $this->db->count_all_results();

        // Total Tables
        $this->db->from('dining_tables');
        $stats['total_tables'] = $this->db->count_all_results();

        // Total Orders (All time)
        $this->db->from('orders');
        $stats['total_orders'] = $this->db->count_all_results();

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
