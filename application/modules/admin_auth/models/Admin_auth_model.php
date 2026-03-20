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
        $this->db->select('u.*, r.name as role_name');
        $this->db->from($this->table . ' u');
        $this->db->join('roles r', 'r.role_id = u.user_role', 'left');
        $this->db->group_start();
        $this->db->where('u.user_name', $username);
        $this->db->or_where('u.user_email', $username);
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

    /**
     * Update user password
     */
    public function update_password($user_id, $hashed_password)
    {
        $this->db->where('user_id', $user_id);
        return $this->db->update($this->table, ['user_password' => $hashed_password, 'reset_token' => NULL, 'token_expiry' => NULL]);
    }

    /**
     * Store reset token
     */
    public function update_reset_token($email, $token, $expiry)
    {
        $this->db->where('user_email', $email);
        return $this->db->update($this->table, [
            'reset_token' => $token,
            'token_expiry' => $expiry
        ]);
    }

    /**
     * Get user by reset token
     */
    public function get_user_by_reset_token($token)
    {
        $this->db->where('reset_token', $token);
        $this->db->where('token_expiry >=', date('Y-m-d H:i:s'));
        $query = $this->db->get($this->table);
        return $query->row_array();
    }
}
