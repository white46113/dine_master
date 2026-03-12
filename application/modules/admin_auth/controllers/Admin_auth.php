<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Admin_auth extends Admin_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Admin_auth_model');
    }

    /**
     * Display Login Page
     */
    public function login()
    {
        if ($this->is_admin_logged_in()) {
            redirect(base_url('admin/dashboard'));
        }

        $data['title'] = 'Admin Login | Dine Master';
        $this->smarty->display('login.tpl');
    }

    /**
     * Handle Authentication AJAX
     */
    public function authenticate()
    {
        $username = $this->input->post('username');
        $password = $this->input->post('password');

        if (empty($username) || empty($password)) {
            echo json_encode(['success' => false, 'message' => 'Please enter both username and password.']);
            return;
        }

        $user = $this->Admin_auth_model->get_user_by_username($username);

        if ($user && password_verify($password, $user['user_password'])) {
            if ($user['status'] !== 'Active') {
                echo json_encode(['success' => false, 'message' => 'Your account is inactive. Please contact support.']);
                return;
            }

            // Set Session
            $session_data = [
                'admin_user_id' => $user['user_id'],
                'admin_user' => [
                    'user_id'   => $user['user_id'],
                    'user_name' => $user['user_name'],
                    'user_email' => $user['user_email'],
                    'role_id'   => $user['user_role']
                ]
            ];
            $this->session->set_userdata($session_data);

            // Update last login
            $this->Admin_auth_model->update_last_login($user['user_id']);

            echo json_encode(['success' => true, 'message' => 'Login successful! Redirecting...', 'redirect' => base_url('admin/dashboard')]);
        } else {
            echo json_encode(['success' => false, 'message' => 'Invalid username or password.']);
        }
    }

    /**
     * Logout
     */
    public function logout()
    {
        $this->session->unset_userdata('admin_user_id');
        $this->session->unset_userdata('admin_user');
        $this->session->sess_destroy();
        redirect(base_url('admin/login'));
    }
}
