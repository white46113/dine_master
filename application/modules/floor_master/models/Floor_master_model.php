<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Floor_master_model extends CI_Model {
    private $table = 'floors';

    public function __construct() {
        parent::__construct();
    }

    // DataTables: get paginated list
    public function get_datatables($role_id, $restaurant_id) {
        $this->_get_query($role_id, $restaurant_id);
        if ($_POST['length'] != -1) {
            $this->db->limit($_POST['length'], $_POST['start']);
        }
        return $this->db->get()->result();
    }

    private function _get_query($role_id, $restaurant_id) {
        $this->db->select('f.*, r.name as restaurant_name');
        $this->db->from($this->table . ' f');
        $this->db->join('restaurants r', 'r.restaurant_id = f.restaurant_id', 'left');
        if ($role_id != 1) {
            $this->db->where('f.restaurant_id', $restaurant_id);
        }
        $i = 0;
        $column_search = ['f.name'];
        foreach ($column_search as $item) {
            if ($_POST['search']['value']) {
                if ($i === 0) {
                    $this->db->group_start();
                    $this->db->like($item, $_POST['search']['value']);
                } else {
                    $this->db->or_like($item, $_POST['search']['value']);
                }
                if (count($column_search) - 1 == $i) {
                    $this->db->group_end();
                }
            }
            $i++;
        }
        if (isset($_POST['order'])) {
            $order = ['f.name', 'f.sort_order'];
            $this->db->order_by($order[$_POST['order']['0']['column']], $_POST['order']['0']['dir']);
        } else {
            $this->db->order_by('f.floor_id', 'DESC');
        }
    }

    public function count_all() {
        return $this->db->count_all_results($this->table);
    }

    public function count_filtered($role_id, $restaurant_id) {
        $this->_get_query($role_id, $restaurant_id);
        return $this->db->get()->num_rows();
    }

    public function get_by_id($id) {
        return $this->db->where('floor_id', $id)->get($this->table)->row_array();
    }

    public function insert($data) {
        return $this->db->insert($this->table, $data);
    }

    public function update($id, $data) {
        return $this->db->where('floor_id', $id)->update($this->table, $data);
    }

    public function delete($id) {
        return $this->db->where('floor_id', $id)->delete($this->table);
    }

    // Duplicate name check per restaurant
    public function duplicate_name($name, $restaurant_id, $exclude_id = null) {
        $this->db->where('name', $name);
        $this->db->where('restaurant_id', $restaurant_id);
        if ($exclude_id) {
            $this->db->where('floor_id !=', $exclude_id);
        }
        return $this->db->get($this->table)->row();
    }
}
?>
