<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Menu_model extends CI_Model
{
    protected $table = 'menu_items';

    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Get all menu items with category names
     */
    public function get_all_items($restaurant_id = null)
    {
        $this->db->select('m.*, c.name as category_name');
        $this->db->from($this->table . ' m');
        $this->db->join('categories c', 'c.category_id = m.category_id', 'left');
        if ($restaurant_id) {
            $this->db->where('m.restaurant_id', $restaurant_id);
        }
        $this->db->order_by('m.item_id', 'DESC');
        $query = $this->db->get();
        return $query->result_array();
    }

    /**
     * Get item by ID
     */
    public function get_item_by_id($id)
    {
        $this->db->where('item_id', $id);
        $query = $this->db->get($this->table);
        return $query->row_array();
    }

    /**
     * Get all categories
     */
    public function get_categories($restaurant_id = null)
    {
        $this->db->from('categories');
        if ($restaurant_id) {
            $this->db->where('restaurant_id', $restaurant_id);
        }
        $query = $this->db->get();
        return $query->result_array();
    }

    /**
     * CRUD Operations
     */
    public function insert_item($data)
    {
        return $this->db->insert($this->table, $data);
    }

    public function update_item($id, $data)
    {
        $this->db->where('item_id', $id);
        return $this->db->update($this->table, $data);
    }

    public function delete_item($id)
    {
        $this->db->where('item_id', $id);
        return $this->db->delete($this->table);
    }
}
