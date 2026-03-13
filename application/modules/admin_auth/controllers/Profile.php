<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Profile extends Admin_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Admin_auth_model');
    }

    /**
     * Display Profile/Change Password Page
     */
    public function index()
    {
        $data['title'] = 'My Profile | Dine Master Admin';
        $data['page_title'] = 'Account Settings';
        
        $this->render('profile.tpl', $data);
    }

    /**
     * AJAX: Update Password
     */
    public function update_password()
    {
        $current_password = $this->input->post('current_password');
        $new_password     = $this->input->post('new_password');
        $confirm_password = $this->input->post('confirm_password');

        if (empty($current_password) || empty($new_password) || empty($confirm_password)) {
            echo json_encode(['success' => false, 'message' => 'All fields are required.']);
            return;
        }

        if ($new_password !== $confirm_password) {
            echo json_encode(['success' => false, 'message' => 'New passwords do not match.']);
            return;
        }

        if (strlen($new_password) < 6) {
            echo json_encode(['success' => false, 'message' => 'Password must be at least 6 characters long.']);
            return;
        }

        $user_id = $this->session->userdata('admin_user_id');
        $this->db->where('user_id', $user_id);
        $user = $this->db->get('users')->row_array();

        if ($user && password_verify($current_password, $user['user_password'])) {
            $hashed_password = password_hash($new_password, PASSWORD_BCRYPT);
            if ($this->Admin_auth_model->update_password($user_id, $hashed_password)) {
                echo json_encode(['success' => true, 'message' => 'Password updated successfully!']);
            } else {
                echo json_encode(['success' => false, 'message' => 'Failed to update password.']);
            }
        } else {
            echo json_encode(['success' => false, 'message' => 'Invalid current password.']);
        }
    }
}
