<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Tables_model extends CI_Model
{
    protected $table = 'dining_tables';
    protected $column_order = [null, 't.table_id', 't.code', 't.name', 't.capacity', 'f.name', 't.status', 't.is_active'];
    protected $column_search = ['t.code', 't.name', 'f.name'];
    protected $order = ['t.table_id' => 'desc'];

    public function __construct()
    {
        parent::__construct();
    }

    private function _get_datatables_query()
    {
        $this->db->select('t.*, f.name as floor_name');
        $this->db->from($this->table . ' t');
        $this->db->join('floors f', 'f.floor_id = t.floor_id', 'left');

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
        $this->db->from($this->table);
        return $this->db->count_all_results();
    }

    public function get_by_id($id)
    {
        $this->db->from($this->table);
        $this->db->where('table_id', $id);
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
        $this->db->where('table_id', $id);
        $this->db->delete($this->table);
    }

    public function get_floors()
    {
        $this->db->from('floors');
        $this->db->where('is_active', 1);
        $query = $this->db->get();
        return $query->result_array();
    }
}
