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
     * DataTables Server-side
     */
    private function _get_datatables_query()
    {
        $this->db->select('m.*, c.name as category_name');
        $this->db->from($this->table . ' m');
        $this->db->join('categories c', 'c.category_id = m.category_id', 'left');

        if ($this->input->post('restaurant_id')) {
            $this->db->where('m.restaurant_id', $this->input->post('restaurant_id'));
        }

        $column_order = [null, 'm.name', 'c.name', 'm.base_price', 'm.veg_type', 'm.is_available', null];
        $column_search = ['m.name', 'c.name', 'm.item_id'];

        $i = 0;
        foreach ($column_search as $item) {
            if ($_POST['search']['value']) {
                if ($i === 0) {
                    $this->db->group_start();
                    $this->db->like($item, $_POST['search']['value']);
                } else {
                    $this->db->or_like($item, $_POST['search']['value']);
                }
                if (count($column_search) - 1 == $i)
                    $this->db->group_end();
            }
            $i++;
        }

        if (isset($_POST['order'])) {
            $this->db->order_by($column_order[$_POST['order']['0']['column']], $_POST['order']['0']['dir']);
        } else {
            $this->db->order_by('m.item_id', 'DESC');
        }
    }

    public function get_datatables()
    {
        $this->_get_datatables_query();
        if ($_POST['length'] != -1)
            $this->db->limit($_POST['length'], $_POST['start']);
        $query = $this->db->get();
        return $query->result();
    }

    public function count_filtered()
    {
        $this->_get_datatables_query();
        $query = $this->db->get();
        return $query->num_rows();
    }

    public function count_all()
    {
        $this->db->from($this->table);
        return $this->db->count_all_results();
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
        $this->db->select('name, MAX(category_id) as category_id');
        $this->db->from('categories');
        if ($restaurant_id) {
            $this->db->where('restaurant_id', $restaurant_id);
        }
        $this->db->group_by('name');
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
