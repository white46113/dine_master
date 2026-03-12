<?php
defined('BASEPATH') or exit('No direct script access allowed');

/**
 * Admin_Controller
 * 
 * Base controller for all Admin modules.
 * Handles authentication, common layouts, and session management.
 */
class Admin_Controller extends MY_Controller
{
    public $admin_data = null;

    public function __construct()
    {
        parent::__construct();
        
        // 1. Check Authentication
        if (!$this->is_admin_logged_in()) {
            // Allow login and forgot password pages
            $allowed_methods = ['login', 'forgot_password', 'authenticate'];
            $current_method = $this->router->fetch_method();
            $current_class = $this->router->fetch_class();

            if ($current_class !== 'admin_auth' || !in_array($current_method, $allowed_methods)) {
                redirect(base_url('admin/login'));
            }
        } else {
            $this->admin_data = $this->session->userdata('admin_user');
            $this->smarty->assign('admin_user', $this->admin_data);
        }

        // 2. Set default layouts
        $this->smarty->assign('current_module', $this->router->fetch_module());
        $this->smarty->assign('current_controller', $this->router->fetch_class());
        $this->smarty->assign('current_method', $this->router->fetch_method());
    }

    /**
     * Check if admin session is active
     */
    protected function is_admin_logged_in()
    {
        return $this->session->has_userdata('admin_user_id');
    }

    /**
     * Render common admin view with layout
     */
    protected function render($view, $data = [])
    {
        $this->smarty->assign($data);
        
        // Header, Sidebar, and Footer are usually common
        $header = $this->smarty->fetch('admin/layout/header.tpl');
        $sidebar = $this->smarty->fetch('admin/layout/sidebar.tpl');
        $footer = $this->smarty->fetch('admin/layout/footer.tpl');
        
        $content = $this->smarty->fetch($view);

        $this->smarty->assign('header', $header);
        $this->smarty->assign('sidebar', $sidebar);
        $this->smarty->assign('footer', $footer);
        $this->smarty->assign('content', $content);

        $this->smarty->display('admin/layout/main.tpl');
    }
}
