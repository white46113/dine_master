<?php defined('BASEPATH') or exit('No direct script access allowed');

class Table_model extends CI_Model
{
    private $table = 'dining_tables';

    public function get_available_tables($restaurant_id, $search = null)
    {
        $this->db->select('table_id, code as table_code, name as table_name, capacity, status, restaurant_id');
        $this->db->from($this->table);
        $this->db->where('restaurant_id', $restaurant_id);
        $this->db->where('status', 'FREE');
        $this->db->where('is_active', 1);

        if ($search) {
            $this->db->group_start();
            $this->db->like('name', $search);
            $this->db->or_like('code', $search);
            $this->db->group_end();
        }

        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_all_tables_for_superadmin($restaurant_id = null, $search = null, $status = null)
    {
        $this->db->select('t.table_id, t.code as table_code, t.name as table_name, t.capacity, t.status, t.restaurant_id, r.name as restaurant_name');
        $this->db->from($this->table . ' t');
        $this->db->join('restaurants r', 'r.restaurant_id = t.restaurant_id', 'left');

        if ($restaurant_id) {
            $this->db->where('t.restaurant_id', $restaurant_id);
        }

        if ($status) {
            $this->db->where('t.status', $status);
        }

        if ($search) {
            $this->db->group_start();
            $this->db->like('t.name', $search);
            $this->db->or_like('t.code', $search);
            $this->db->or_like('r.name', $search);
            $this->db->group_end();
        }

        $query = $this->db->get();
        return $query->result_array();
    }
}
