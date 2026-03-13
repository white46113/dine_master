<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Kitchen extends Admin_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Kitchen_model');
    }

    /**
     * KDS Index View
     */
    public function index()
    {
        $data['title'] = 'Kitchen Display System | Dine Master';
        $data['page_title'] = 'Kitchen Orders';
        
        $kots = $this->Kitchen_model->get_active_kots();
        foreach ($kots as &$kot) {
            $kot['items'] = $this->Kitchen_model->get_kot_items($kot['kot_id']);
        }
        $data['kots'] = $kots;

        $this->render('index.tpl', $data);
    }

    /**
     * AJAX: Update Item Status
     */
    public function update_item_status()
    {
        $id = $this->input->post('order_item_id');
        $status = $this->input->post('status');

        if ($this->Kitchen_model->update_item_status($id, $status)) {
            echo json_encode(['success' => true]);
        } else {
            echo json_encode(['success' => false]);
        }
    }

    /**
     * AJAX: Complete KOT
     */
    public function complete_kot()
    {
        $id = $this->input->post('kot_id');
        if ($this->Kitchen_model->update_kot_status($id, 'DONE')) {
            echo json_encode(['success' => true]);
        } else {
            echo json_encode(['success' => false]);
        }
    }
}
