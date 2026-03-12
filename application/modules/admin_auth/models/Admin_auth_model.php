<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Admin_auth_model extends CI_Model
{
    protected $table = 'users';

    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Get user by username or email
     */
    public function get_user_by_username($username)
    {
        $this->db->select('*');
        $this->db->from($this->table);
        $this->db->group_start();
        $this->db->where('user_name', $username);
        $this->db->or_where('user_email', $username);
        $this->db->group_end();
        $query = $this->db->get();
        return $query->row_array();
    }

    /**
     * Update last login timestamp
     */
    public function update_last_login($user_id)
    {
        $this->db->where('user_id', $user_id);
        $this->db->update($this->table, ['last_login_at' => date('Y-m-d H:i:s')]);
    }
}
