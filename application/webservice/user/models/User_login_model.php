<?php

class User_login_model extends CI_Model{

  private $table = 'users';

    public function __construct() {
        parent::__construct();
        $this->load->database();
        // ini_set('display_errors', 1);
// ini_set('display_startup_errors', 1);
// error_reporting(E_ALL);
    }

    public function register($data) {
        $data['added_date'] = date('Y-m-d H:i:s');
        if (isset($data['password'])) {
            $data['password_hash'] = password_hash($data['password'], PASSWORD_BCRYPT);
            unset($data['password']);
        }
        $this->db->insert($this->table, $data);
        return $this->db->insert_id();
    }

    public function get_by_email($email) {
        return $this->db->get_where($this->table, ['email'=>$email, 'is_active'=>1])->row();
    }

    public function get_by_id($id) {
        return $this->db->get_where($this->table, ['user_id'=>$id])->row();
    }

    public function update_user($id, $data) {
        if (isset($data['password'])) {
            $data['password_hash'] = password_hash($data['password'], PASSWORD_BCRYPT);
            unset($data['password']);
        }
        $this->db->where('user_id', $id)->update($this->table, $data);
        return $this->db->affected_rows() > 0;
    }

    public function set_token($id, $token) {
      
      return $this->db->where('user_id',$id)->update($this->table, ['api_token'=>$token, 'token_issued_at'=>date('Y-m-d H:i:s')]);;
    }

}

 ?>
