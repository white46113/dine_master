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
            $data['user_password'] = password_hash($data['password'], PASSWORD_BCRYPT);
            unset($data['password']);
        }
        $this->db->insert($this->table, $data);
        return $this->db->insert_id();
    }

    public function get_by_email($email) {
        return $this->db->get_where($this->table, ['user_email'=>$email, 'status'=>"Active"])->row();
    }

    public function get_by_id($id) {
        $this->db->select('u.user_id, u.restaurant_id, u.user_role, u.user_email, u.phone, u.user_name, u.status, u.user_password, r.name as role_name');
        $this->db->from($this->table . ' u');
        $this->db->join('roles r', 'r.role_id = u.user_role', 'left');
        $this->db->where('u.user_id', $id);
        return $this->db->get()->row();
    }

    public function update_user($id, $data) {
        if (isset($data['password'])) {
            $data['user_password'] = password_hash($data['password'], PASSWORD_BCRYPT);
            unset($data['password']);
        }
        $this->db->where('user_id', $id)->update($this->table, $data);
        return $this->db->affected_rows() > 0;
    }

    public function set_token($id, $token) {
      
      return $this->db->where('user_id',$id)->update($this->table, ['api_token'=>$token, 'token_issued_at'=>date('Y-m-d H:i:s')]);;
    }

    public function update_password_by_email($email, $new_password) {
    $hashed_password = password_hash($new_password, PASSWORD_BCRYPT);

    $this->db->where('user_email', $email)
             ->where('status', 'Active'); // only update active users

    return $this->db->update($this->table, [
        'user_password' => $hashed_password,
        'updated_date'  => date('Y-m-d H:i:s')
    ]);
}

    public function get_restaurant_by_user_id($user_id) {
        $this->db->select('r.*');
        $this->db->from('restaurants r');
        $this->db->join('users u', 'u.restaurant_id = r.restaurant_id');
        $this->db->where('u.user_id', $user_id);
        $this->db->where('r.is_active', 1);
        return $this->db->get()->row();
    }

    public function get_order_stats($user_id) {
        $stats = [];

        // Total orders
        $this->db->where('added_by', $user_id);
        $stats['total_orders'] = $this->db->count_all_results('orders');

        // Today's orders
        $this->db->where('added_by', $user_id);
        $this->db->where('DATE(placed_at)', date('Y-m-d'));
        $stats['today_orders'] = $this->db->count_all_results('orders');

        // Last 7 days orders
        $this->db->where('added_by', $user_id);
        $this->db->where('placed_at >=', date('Y-m-d H:i:s', strtotime('-7 days')));
        $stats['last_7_days_orders'] = $this->db->count_all_results('orders');

        return $stats;
    }

}

 ?>
