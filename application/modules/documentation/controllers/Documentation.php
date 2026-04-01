<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Documentation extends Admin_Controller
{
    public function __construct()
    {
        parent::__construct();
        
        // Super admin only check
        $admin_data = $this->session->userdata('admin_user');
        $is_superadmin = (isset($admin_data['role_id']) && $admin_data['role_id'] == 1) || 
                         (isset($admin_data['user_role']) && $admin_data['user_role'] == 1);
        if (!$is_superadmin) {
            redirect('admin/dashboard');
        }
    }

    public function index()
    {
        $data['title'] = 'System Manual | Dine Master Admin';
        $data['page_title'] = 'Dine Master – System Manual';

        $this->render('index.tpl', $data);
    }
}
