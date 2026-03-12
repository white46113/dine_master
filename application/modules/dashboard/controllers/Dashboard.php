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

        $this->render('index.tpl', $data);
    }
}
