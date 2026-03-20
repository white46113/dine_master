<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Dashboard extends Admin_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Dashboard_model');
    }

    public function index()
    {
        $data['title'] = 'Dashboard | Dine Master Admin';
        $data['page_title'] = 'Dashboard Overview';

        // Fetch real statistics
        $data['stats'] = $this->Dashboard_model->get_stats();
        $data['recent_orders'] = $this->Dashboard_model->get_recent_orders(5);

        // Fetch subscription if not superadmin
        if ($this->admin_data['role_id'] != 1) {
            $this->load->model('subscriptions/Subscription_model');
            $data['active_sub'] = $this->Subscription_model->get_active_subscription($this->admin_data['restaurant_id']);
        }

        $this->render('index.tpl', $data);
    }
}
