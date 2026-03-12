<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Restaurant_model extends CI_Model
{
    protected $table = 'restaurants';

    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Get restaurant details by ID
     */
    public function get_details($id)
    {
        $this->db->where('restaurant_id', $id);
        $query = $this->db->get($this->table);
        return $query->row_array();
    }

    /**
     * Update restaurant details
     */
    public function update_details($id, $data)
    {
        $this->db->where('restaurant_id', $id);
        return $this->db->update($this->table, $data);
    }
}
