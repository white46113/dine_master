<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Category_master_model extends CI_Model {
    private $table = 'categories';

    public function __construct() {
        parent::__construct();
    }

    /**
     * DataTables Server-side
     */
    private function _get_datatables_query($role_id = null, $restaurant_id = null)
    {
        $this->db->select('c.*, r.name as restaurant_name');
        $this->db->from($this->table . ' c');
        $this->db->join('restaurants r', 'r.restaurant_id = c.restaurant_id', 'left');
        $this->db->where('c.is_active', 1);

        // Role-based filtering
        if ($role_id != 1) { // Not Superadmin
            if ($restaurant_id) {
                $this->db->where('c.restaurant_id', $restaurant_id);
            }
        }

        if ($this->input->post('restaurant_id')) {
            $this->db->where('c.restaurant_id', $this->input->post('restaurant_id'));
        }

        $column_order = [null, 'c.name', 'c.description', 'r.name', null];
        $column_search = ['c.name', 'c.description', 'r.name'];

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
            $this->db->order_by('c.category_id', 'DESC');
        }
    }

    public function get_datatables($role_id = null, $restaurant_id = null)
    {
        $this->_get_datatables_query($role_id, $restaurant_id);
        if ($_POST['length'] != -1)
            $this->db->limit($_POST['length'], $_POST['start']);
        $query = $this->db->get();
        return $query->result();
    }

    public function count_filtered($role_id = null, $restaurant_id = null)
    {
        $this->_get_datatables_query($role_id, $restaurant_id);
        $query = $this->db->get();
        return $query->num_rows();
    }

    public function count_all()
    {
        $this->db->from($this->table);
        $this->db->where('is_active', 1);
        return $this->db->count_all_results();
    }

    // Fetch single category by ID
    public function get_item_by_id($id) {
        $query = $this->db->get_where($this->table, ['category_id' => $id, 'is_active' => 1]);
        return $query->row_array();
    }

    // Insert new category
    public function insert_item($data) {
        $this->db->insert($this->table, $data);
        return $this->db->insert_id();
    }

    // Update existing category
    public function update_item($id, $data) {
        $this->db->where('category_id', $id);
        return $this->db->update($this->table, $data);
    }

    // Soft‑delete category (set is_active = 0)
    public function delete_item($id) {
        $this->db->where('category_id', $id);
        return $this->db->update($this->table, ['is_active' => 0]);
    }
}
?>
