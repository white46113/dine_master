<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Dashboard_model extends CI_Model
{
    public function __construct()
    {
        parent::__construct();
    }

    private function _is_superadmin()
    {
        $admin_data = $this->session->userdata('admin_user');
        return (isset($admin_data['role_id']) && $admin_data['role_id'] == 1) ||
            (isset($admin_data['user_role']) && $admin_data['user_role'] == 1);
    }

    private function _apply_restaurant_filter($alias = '')
    {
        if (!$this->_is_superadmin()) {
            $admin_data = $this->session->userdata('admin_user');
            if (isset($admin_data['restaurant_id'])) {
                $prefix = empty($alias) ? '' : $alias . '.';
                $this->db->where($prefix . 'restaurant_id', $admin_data['restaurant_id']);
            }
        }
    }

    /**
     * Get summary statistics
     */
    public function get_stats()
    {
        $stats = [];

        // Today's Revenue (Completed Orders Today)
        $this->db->select('o.*, r.gst_applicable, r.gst_percentage');
        $this->db->from('orders o');
        $this->db->join('restaurants r', 'r.restaurant_id = o.restaurant_id', 'left');
        $this->db->where('o.status', 'COMPLETED');
        $this->db->where('DATE(o.placed_at)', date('Y-m-d'));
        $this->_apply_restaurant_filter('o');
        $today_orders = $this->db->get()->result_array();

        $today_revenue = 0;
        foreach ($today_orders as $order) {
            $should_recalculate = (floatval($order['subtotal_amount']) == 0 || (floatval($order['tax_amount']) == 0 && ($order['gst_applicable'] ?? 'no') === 'yes'));

            if ($should_recalculate) {
                $this->db->select('unit_price, quantity');
                $this->db->where('order_id', $order['order_id']);
                $items = $this->db->get('order_items')->result_array();
                $subtotal = 0;
                foreach ($items as $item) {
                    $subtotal += floatval($item['unit_price']) * floatval($item['quantity']);
                }

                $gst_applicable = ($order['gst_applicable'] ?? 'no') === 'yes';
                $gst_percent = floatval($order['gst_percentage'] ?? 0);
                $tax_amount = $gst_applicable ? ($subtotal * ($gst_percent / 100)) : 0;
                $service_charge = floatval($order['service_charge_amt'] ?? 0);

                $today_revenue += ($subtotal + $tax_amount + $service_charge);
            } else {
                $today_revenue += floatval($order['total_payable']);
            }
        }
        $stats['today_revenue'] = $today_revenue;

        // Occupied Tables
        $this->db->from('dining_tables');
        $this->db->where('status', 'OCCUPIED');
        $this->_apply_restaurant_filter();
        $stats['occupied_tables'] = $this->db->count_all_results();

        // Available Tables
        $this->db->from('dining_tables');
        $this->db->where('status', 'FREE');
        $this->_apply_restaurant_filter();
        $stats['available_tables'] = $this->db->count_all_results();

        // Active Orders (Not Completed/Cancelled)
        $this->db->from('orders');
        $this->db->where_in('status', ['PLACED', 'PREPARING', 'READY', 'SERVED', 'RUNNING']);
        $this->_apply_restaurant_filter();
        $stats['active_orders'] = $this->db->count_all_results();

        // Total Tables
        $this->db->from('dining_tables');
        $this->_apply_restaurant_filter();
        $stats['total_tables'] = $this->db->count_all_results();

        // Total Orders (All time)
        $this->db->from('orders');
        $this->_apply_restaurant_filter();
        $stats['total_orders'] = $this->db->count_all_results();

        return $stats;
    }

    /**
     * Get recent orders
     */
    public function get_recent_orders($limit = 5)
    {
        $this->db->select('o.*, c.name as customer_name, r.gst_applicable, r.gst_percentage');
        $this->db->from('orders o');
        $this->db->join('customers c', 'c.customer_id = o.customer_id', 'left');
        $this->db->join('restaurants r', 'r.restaurant_id = o.restaurant_id', 'left');
        $this->_apply_restaurant_filter('o');
        $this->db->order_by('o.placed_at', 'DESC');
        $this->db->limit($limit);
        $orders = $this->db->get()->result_array();

        foreach ($orders as &$order) {
            $should_recalculate = (floatval($order['subtotal_amount']) == 0 || (floatval($order['tax_amount']) == 0 && ($order['gst_applicable'] ?? 'no') === 'yes'));

            if ($should_recalculate) {
                $this->db->select('unit_price, quantity');
                $this->db->where('order_id', $order['order_id']);
                $items = $this->db->get('order_items')->result_array();
                $subtotal = 0;
                foreach ($items as $item) {
                    $subtotal += floatval($item['unit_price']) * floatval($item['quantity']);
                }

                $gst_applicable = ($order['gst_applicable'] ?? 'no') === 'yes';
                $gst_percent = floatval($order['gst_percentage'] ?? 0);
                $tax_amount = $gst_applicable ? ($subtotal * ($gst_percent / 100)) : 0;
                $service_charge = floatval($order['service_charge_amt'] ?? 0);

                $order['total_payable'] = number_format($subtotal + $tax_amount + $service_charge, 2, '.', '');
            }
        }

        return $orders;
    }
}
