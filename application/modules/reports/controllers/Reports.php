<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Reports extends Admin_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Reports_model');
    }

    public function daily_sales()
    {
        $start_date = $this->input->get('start_date') ?: date('Y-m-01');
        $end_date   = $this->input->get('end_date') ?: date('Y-m-d');

        $data['title'] = 'Daily Sales Report | Dine Master';
        $data['page_title'] = 'Daily Sales';
        $data['start_date'] = $start_date;
        $data['end_date'] = $end_date;
        $data['reports'] = $this->Reports_model->get_daily_sales($start_date, $end_date);
        
        $this->render('daily_sales.tpl', $data);
    }

    public function item_wise()
    {
        $start_date = $this->input->get('start_date') ?: date('Y-m-01');
        $end_date   = $this->input->get('end_date') ?: date('Y-m-d');

        $data['title'] = 'Item Wise Sales Report | Dine Master';
        $data['page_title'] = 'Item Wise Sales';
        $data['start_date'] = $start_date;
        $data['end_date'] = $end_date;
        $data['reports'] = $this->Reports_model->get_item_wise_sales($start_date, $end_date);
        
        $this->render('item_wise.tpl', $data);
    }

    public function table_wise()
    {
        $start_date = $this->input->get('start_date') ?: date('Y-m-01');
        $end_date   = $this->input->get('end_date') ?: date('Y-m-d');

        $data['title'] = 'Table Wise Sales Report | Dine Master';
        $data['page_title'] = 'Table Wise Sales';
        $data['start_date'] = $start_date;
        $data['end_date'] = $end_date;
        $data['reports'] = $this->Reports_model->get_table_wise_sales($start_date, $end_date);
        
        $this->render('table_wise.tpl', $data);
    }

    public function waiter_performance()
    {
        $start_date = $this->input->get('start_date') ?: date('Y-m-01');
        $end_date   = $this->input->get('end_date') ?: date('Y-m-d');

        $data['title'] = 'Waiter Performance Report | Dine Master';
        $data['page_title'] = 'Waiter Performance';
        $data['start_date'] = $start_date;
        $data['end_date'] = $end_date;
        $data['reports'] = $this->Reports_model->get_waiter_performance($start_date, $end_date);
        
        $this->render('waiter_performance.tpl', $data);
    }
}
