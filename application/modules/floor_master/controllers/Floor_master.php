<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Floor_master extends Admin_Controller {
    public function __construct() {
        parent::__construct();
        $this->load->model('Floor_master_model');
    }

    // List page
    public function index() {
        $data['title'] = 'Floor Master | Dine Master Admin';
        $data['page_title'] = 'Floor Master';
        $this->render('index.tpl', $data);
    }

    // DataTables ajax
    public function ajax_list() {
        $role_id = $this->admin_data['role_id'];
        $restaurant_id = ($role_id == 1) ? $this->input->get('restaurant_id') : $this->admin_data['restaurant_id'];
        $list = $this->Floor_master_model->get_datatables($role_id, $restaurant_id);
        $data = [];
        $no = $_POST['start'];
        foreach ($list as $floor) {
            $no++;
            $row = [];
            $row[] = $floor->name;
            if ($role_id == 1) {
                $row[] = $floor->restaurant_name;
            }
            $row[] = '
                <div class="flex justify-center space-x-2">
                    <a href="' . base_url('admin/floor_master/edit/' . $floor->floor_id) . '" class="w-9 h-9 flex items-center justify-center bg-blue-50 text-blue-600 rounded-lg hover:bg-blue-600 hover:text-white transition-all">
                        <i class="fa-solid fa-pen-to-square"></i>
                    </a>
                    <button onclick="deleteFloor(' . $floor->floor_id . ')" class="w-9 h-9 flex items-center justify-center bg-red-50 text-red-600 rounded-lg hover:bg-red-600 hover:text-white transition-all">
                        <i class="fa-solid fa-trash"></i>
                    </button>
                </div>';
            $data[] = $row;
        }
        $output = [
            "draw" => $_POST['draw'],
            "recordsTotal" => $this->Floor_master_model->count_all(),
            "recordsFiltered" => $this->Floor_master_model->count_filtered($role_id, $restaurant_id),
            "data" => $data,
        ];
        echo json_encode($output);
    }

    // Add form
    public function add() {
        $data['title'] = 'Add Floor | Dine Master Admin';
        $data['page_title'] = 'Add Floor';
        if ($this->admin_data['role_id'] == 1) {
            $this->load->model('restaurant/Restaurant_model');
            $data['restaurants'] = $this->Restaurant_model->get_all();
        }
        $this->render('form.tpl', $data);
    }

    // Edit form
    public function edit($id) {
        $data['title'] = 'Edit Floor | Dine Master Admin';
        $data['page_title'] = 'Edit Floor';
        $data['item'] = $this->Floor_master_model->get_by_id($id);
        if ($this->admin_data['role_id'] == 1) {
            $this->load->model('restaurant/Restaurant_model');
            $data['restaurants'] = $this->Restaurant_model->get_all();
        }
        $this->render('form.tpl', $data);
    }

    // Save (add/update) via AJAX
    public function save() {
        $id = $this->input->post('floor_id');
        $role_id = $this->admin_data['role_id'];
        $restaurant_id = ($role_id == 1) ? $this->input->post('restaurant_id') : $this->admin_data['restaurant_id'];
        $name = trim($this->input->post('name'));
        // Duplicate check
        if ($this->Floor_master_model->duplicate_name($name, $restaurant_id, $id)) {
            echo json_encode(['success' => false, 'message' => 'Same Floor Name cannot be added.']);
            return;
        }
        $data = [
            'restaurant_id' => $restaurant_id,
            'name' => $name,
            'sort_order' => $this->input->post('sort_order') ? $this->input->post('sort_order') : 0,
            'added_by' => $this->admin_data['user_id'],
        ];
        if ($id) {
            $this->Floor_master_model->update($id, $data);
            $msg = 'Floor updated successfully!';
        } else {
            $this->Floor_master_model->insert($data);
            $msg = 'Floor added successfully!';
        }
        echo json_encode(['success' => true, 'message' => $msg, 'redirect' => base_url('admin/floor_master')]);
    }

    // Delete via AJAX
    public function delete($id) {
        $this->Floor_master_model->delete($id);
        echo json_encode(['success' => true, 'message' => 'Floor deleted successfully!']);
    }
}
?>
