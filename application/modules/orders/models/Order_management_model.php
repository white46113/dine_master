<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Order_management_model extends CI_Model
{
    protected $table = 'orders';

    public function __construct()
    {
        parent::__construct();
    }

    private function _is_superadmin() {
        $admin_data = $this->session->userdata('admin_user');
        return (isset($admin_data['role_id']) && $admin_data['role_id'] == 1) || 
               (isset($admin_data['user_role']) && $admin_data['user_role'] == 1);
    }

    /**
     * Get all orders with customer and table details
     */
    public function get_all_orders($status = null)
    {
        $this->db->select('o.*, c.name as customer_name, t.code as table_no, r.name as restaurant_name');
        $this->db->from($this->table . ' o');
        $this->db->join('customers c', 'c.customer_id = o.customer_id', 'left');
        $this->db->join('dining_tables t', 't.table_id = o.table_id', 'left');
        $this->db->join('restaurants r', 'r.restaurant_id = o.restaurant_id', 'left');
        
        if ($status) {
            $this->db->where('o.status', $status);
        }
        
        if (!$this->_is_superadmin()) {
            $admin_data = $this->session->userdata('admin_user');
            if (isset($admin_data['restaurant_id'])) {
                $this->db->where('o.restaurant_id', $admin_data['restaurant_id']);
            }
        }
        
        $this->db->order_by('o.placed_at', 'DESC');
        $query = $this->db->get();
        return $query->result_array();
    }

    /**
     * DataTables Server-side
     */
    private function _get_datatables_query()
    {
        $this->db->select('o.*, c.name as customer_name, t.code as table_no, r.name as restaurant_name');
        $this->db->from($this->table . ' o');
        $this->db->join('customers c', 'c.customer_id = o.customer_id', 'left');
        $this->db->join('dining_tables t', 't.table_id = o.table_id', 'left');
        $this->db->join('restaurants r', 'r.restaurant_id = o.restaurant_id', 'left');

        if ($this->input->post('status')) {
            $this->db->where('o.status', $this->input->post('status'));
        }
        
        if (!$this->_is_superadmin()) {
            $admin_data = $this->session->userdata('admin_user');
            if (isset($admin_data['restaurant_id'])) {
                $this->db->where('o.restaurant_id', $admin_data['restaurant_id']);
            }
        }

        if ($this->_is_superadmin()) {
            $column_order = [null, 'o.order_id', 'r.name', 't.code', 'o.total_payable', 'o.status', 'o.placed_at'];
            $column_search = ['o.order_id', 'c.name', 't.code', 'r.name'];
        } else {
            $column_order = [null, 'o.order_id', 'c.name', 't.code', 'o.total_payable', 'o.status', 'o.placed_at'];
            $column_search = ['o.order_id', 'c.name', 't.code'];
        }

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
            $this->db->order_by('o.placed_at', 'DESC');
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
        $this->db->from($this->table . ' o');
        if (!$this->_is_superadmin()) {
            $admin_data = $this->session->userdata('admin_user');
            if (isset($admin_data['restaurant_id'])) {
                $this->db->where('o.restaurant_id', $admin_data['restaurant_id']);
            }
        }
        return $this->db->count_all_results();
    }

    /**
     * Get order details by ID
     */
    public function get_order_by_id($id)
    {
        $this->db->select('o.*, c.name as customer_name, c.email as customer_email, c.phone as customer_phone, t.code as table_no, r.name as restaurant_name, r.address_line1 as restaurant_address');
        $this->db->from($this->table . ' o');
        $this->db->join('customers c', 'c.customer_id = o.customer_id', 'left');
        $this->db->join('dining_tables t', 't.table_id = o.table_id', 'left');
        $this->db->join('restaurants r', 'r.restaurant_id = o.restaurant_id', 'left');
        $this->db->where('o.order_id', $id);
        
        if (!$this->_is_superadmin()) {
            $admin_data = $this->session->userdata('admin_user');
            if (isset($admin_data['restaurant_id'])) {
                $this->db->where('o.restaurant_id', $admin_data['restaurant_id']);
            }
        }
        
        $query = $this->db->get();
        return $query->row_array();
    }

    /**
     * Get items for a specific order
     */
    public function get_order_items($order_id)
    {
        $this->db->select('oi.*, mi.name as item_name, mi.image_url');
        $this->db->from('order_items oi');
        $this->db->join('menu_items mi', 'mi.item_id = oi.item_id', 'left');
        $this->db->where('oi.order_id', $order_id);
        $query = $this->db->get();
        return $query->result_array();
    }

    /**
     * Update order status
     */
    public function update_status($id, $status)
    {
        $data = ['status' => $status];
        if ($status == 'COMPLETED') {
            $data['completed_at'] = date('Y-m-d H:i:s');
            $data['payment_status'] = 'PAID';
        }
        
        $this->db->where('order_id', $id);
        return $this->db->update($this->table, $data);
    }
    
    /**
     * Get all floors
     */
    public function get_floors()
    {
        $this->db->select('f.*, r.name as restaurant_name');
        $this->db->from('floors f');
        $this->db->join('restaurants r', 'r.restaurant_id = f.restaurant_id', 'left');
        $this->db->where('f.is_active', 1);
        
        if (!$this->_is_superadmin()) {
            $admin_data = $this->session->userdata('admin_user');
            if (isset($admin_data['restaurant_id'])) {
                $this->db->where('f.restaurant_id', $admin_data['restaurant_id']);
            }
        }
        
        $this->db->order_by('f.sort_order', 'ASC');
        return $this->db->get()->result_array();
    }

    /**
     * Get all tables for a specific floor or all floors
     */
    public function get_tables($floor_id = null)
    {
        $this->db->select('t.*, o.order_number, o.status as order_status, r.name as restaurant_name');
        $this->db->from('dining_tables t');
        $this->db->join('orders o', 'o.order_id = t.current_order_id', 'left');
        $this->db->join('restaurants r', 'r.restaurant_id = t.restaurant_id', 'left');
        $this->db->where('t.is_active', 1);
        
        if ($floor_id) {
            $this->db->where('t.floor_id', $floor_id);
        }
        
        if (!$this->_is_superadmin()) {
            $admin_data = $this->session->userdata('admin_user');
            if (isset($admin_data['restaurant_id'])) {
                $this->db->where('t.restaurant_id', $admin_data['restaurant_id']);
            }
        }
        
        $this->db->order_by('t.floor_id', 'ASC');
        $this->db->order_by('t.table_id', 'ASC');
        return $this->db->get()->result_array();
    }
}
