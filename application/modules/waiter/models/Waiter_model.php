<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Waiter_model extends CI_Model
{
    protected $table = 'users';
    
    public function __construct()
    {
        parent::__construct();
        
        if ($this->_is_superadmin()) {
            $this->column_order = [null, 'u.user_name', 'u.phone', 'r.name', 'u.status', null];
            $this->column_search = ['u.user_name', 'u.user_email', 'u.phone', 'r.name'];
        } else {
            $this->column_order = [null, 'u.user_name', 'u.phone', 'u.status', null];
            $this->column_search = ['u.user_name', 'u.user_email', 'u.phone'];
        }
        
        $this->order = ['u.user_id' => 'desc'];
    }

    private function _is_superadmin() {
        $admin_data = $this->session->userdata('admin_user');
        return (isset($admin_data['role_id']) && $admin_data['role_id'] == 1) || 
               (isset($admin_data['user_role']) && $admin_data['user_role'] == 1);
    }

    private function _get_datatables_query()
    {
        $this->db->select('u.*, r.name as restaurant_name');
        $this->db->from($this->table . ' u');
        $this->db->join('restaurants r', 'r.restaurant_id = u.restaurant_id', 'left');
        $this->db->where('u.user_role', '4');

        if (!$this->_is_superadmin()) {
            $admin_data = $this->session->userdata('admin_user');
            $this->db->where('u.restaurant_id', $admin_data['restaurant_id']);
        }

        $i = 0;
        foreach ($this->column_search as $item) {
            if ($_POST['search']['value']) {
                if ($i === 0) {
                    $this->db->group_start();
                    $this->db->like($item, $_POST['search']['value']);
                } else {
                    $this->db->or_like($item, $_POST['search']['value']);
                }
                if (count($this->column_search) - 1 == $i)
                    $this->db->group_end();
            }
            $i++;
        }

        if (isset($_POST['order'])) {
            $this->db->order_by($this->column_order[$_POST['order']['0']['column']], $_POST['order']['0']['dir']);
        } else if (isset($this->order)) {
            $order = $this->order;
            $this->db->order_by(key($order), $order[key($order)]);
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
        $this->db->from($this->table . ' u');
        $this->db->where('u.user_role', '4');
        
        if (!$this->_is_superadmin()) {
            $admin_data = $this->session->userdata('admin_user');
            $this->db->where('u.restaurant_id', $admin_data['restaurant_id']);
        }
        return $this->db->count_all_results();
    }

    public function get_by_id($id)
    {
        $this->db->from($this->table);
        $this->db->where('user_id', $id);
        $this->db->where('user_role', '4');
        
        if (!$this->_is_superadmin()) {
            $admin_data = $this->session->userdata('admin_user');
            $this->db->where('restaurant_id', $admin_data['restaurant_id']);
        }
        
        $query = $this->db->get();
        return $query->row();
    }

    public function save($data)
    {
        $this->db->insert($this->table, $data);
        return $this->db->insert_id();
    }

    public function update($where, $data)
    {
        $this->db->update($this->table, $data, $where);
        return $this->db->affected_rows();
    }

    public function delete_by_id($id)
    {
        $this->db->where('user_id', $id);
        $this->db->where('user_role', '4');
        
        if (!$this->_is_superadmin()) {
            $admin_data = $this->session->userdata('admin_user');
            $this->db->where('restaurant_id', $admin_data['restaurant_id']);
        }
        
        $this->db->delete($this->table);
    }
    
    public function get_restaurants()
    {
        $this->db->from('restaurants');
        $this->db->where('is_active', 1);
        $query = $this->db->get();
        return $query->result_array();
    }
}
