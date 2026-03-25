<?php defined('BASEPATH') or exit('No direct script access allowed');
class Menu_item_model extends CI_Model
{
    private $table = 'menu_items';
    public function list_by_category($restaurant_id, $category_id = 0, $veg_type = null, $search_param = null)
    {
        $this->db->where('restaurant_id', $restaurant_id);
        $this->db->where('is_active', 1);

        if ($category_id > 0) {
            $this->db->where('category_id', $category_id);
        }

        if (!empty($veg_type)) {
            $this->db->where('veg_type', $veg_type);
        }

        if (!empty($search_param)) {
            $this->db->like('name', $search_param);
        }

        $this->db->select('*, name as item_name');
        return $this->db->get($this->table)->result();
    }

    public function get_item_details($item_id)
    {
        $this->db->where('item_id', $item_id);
        $this->db->where('is_active', 1);
        return $this->db->get($this->table)->row();
    }

    public function insert($data)
    {
        $this->db->insert($this->table, $data);
        return $this->db->insert_id();
    }
}
