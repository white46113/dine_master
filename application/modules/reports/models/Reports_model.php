<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Reports_model extends CI_Model
{
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Daily Sales Report
     */
    public function get_daily_sales($start_date = null, $end_date = null)
    {
        $this->db->select('DATE(placed_at) as date, COUNT(order_id) as total_orders, SUM(total_payable) as revenue');
        $this->db->from('orders');
        $this->db->where('status', 'COMPLETED');
        
        if ($start_date) $this->db->where('placed_at >=', $start_date . ' 00:00:00');
        if ($end_date) $this->db->where('placed_at <=', $end_date . ' 23:59:59');

        $this->db->group_by('DATE(placed_at)');
        $this->db->order_by('date', 'DESC');
        return $this->db->get()->result_array();
    }

    /**
     * Item Wise Sales Report
     */
    public function get_item_wise_sales($start_date = null, $end_date = null)
    {
        $this->db->select('mi.name as item_name, mi.image_url, SUM(oi.quantity) as total_qty, SUM(oi.unit_price * oi.quantity) as revenue');
        $this->db->from('order_items oi');
        $this->db->join('menu_items mi', 'mi.item_id = oi.item_id');
        $this->db->join('orders o', 'o.order_id = oi.order_id');
        $this->db->where('o.status', 'COMPLETED');
        $this->db->where('oi.status !=', 'CANCELLED');

        if ($start_date) $this->db->where('o.placed_at >=', $start_date . ' 00:00:00');
        if ($end_date) $this->db->where('o.placed_at <=', $end_date . ' 23:59:59');

        $this->db->group_by('oi.item_id');
        $this->db->order_by('revenue', 'DESC');
        return $this->db->get()->result_array();
    }

    /**
     * Table Wise Sales Report
     */
    public function get_table_wise_sales($start_date = null, $end_date = null)
    {
        $this->db->select('t.code as table_no, COUNT(o.order_id) as total_orders, SUM(o.total_payable) as revenue');
        $this->db->from('orders o');
        $this->db->join('dining_tables t', 't.table_id = o.table_id');
        $this->db->where('o.status', 'COMPLETED');

        if ($start_date) $this->db->where('o.placed_at >=', $start_date . ' 00:00:00');
        if ($end_date) $this->db->where('o.placed_at <=', $end_date . ' 23:59:59');

        $this->db->group_by('o.table_id');
        $this->db->order_by('revenue', 'DESC');
        return $this->db->get()->result_array();
    }

    /**
     * Waiter Performance Report
     */
    public function get_waiter_performance($start_date = null, $end_date = null)
    {
        $this->db->select('u.user_name as waiter_name, COUNT(o.order_id) as total_orders, SUM(o.total_payable) as revenue');
        $this->db->from('orders o');
        $this->db->join('users u', 'u.user_id = o.added_by');
        $this->db->where('o.status', 'COMPLETED');

        if ($start_date) $this->db->where('o.placed_at >=', $start_date . ' 00:00:00');
        if ($end_date) $this->db->where('o.placed_at <=', $end_date . ' 23:59:59');

        $this->db->group_by('o.added_by');
        $this->db->order_by('revenue', 'DESC');
        return $this->db->get()->result_array();
    }
}
