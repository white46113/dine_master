<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Kitchen_model extends CI_Model
{
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Get all active KOTs (Queued or Preparing)
     */
    public function get_active_kots()
    {
        $this->db->select('k.*, o.order_number, t.table_no');
        $this->db->from('kot_tickets k');
        $this->db->join('orders o', 'o.order_id = k.order_id');
        $this->db->join('dining_tables t', 't.table_id = o.table_id');
        $this->db->where_in('k.status', ['QUEUED', 'PREPARING']);
        $this->db->order_by('k.added_date', 'ASC');
        $query = $this->db->get();
        return $query->result_array();
    }

    /**
     * Get items for a specific KOT
     */
    public function get_kot_items($kot_id)
    {
        $this->db->select('ki.*, oi.item_name, oi.veg_type, oi.status, oi.notes');
        $this->db->from('kot_items ki');
        $this->db->join('order_items oi', 'oi.order_item_id = ki.order_item_id');
        $this->db->where('ki.kot_id', $kot_id);
        return $this->db->get()->result_array();
    }

    /**
     * Update order item status
     */
    public function update_item_status($order_item_id, $status)
    {
        $this->db->where('order_item_id', $order_item_id);
        return $this->db->update('order_items', ['status' => $status]);
    }

    /**
     * Update KOT status
     */
    public function update_kot_status($kot_id, $status)
    {
        $this->db->where('kot_id', $kot_id);
        return $this->db->update('kot_tickets', ['status' => $status]);
    }
}
