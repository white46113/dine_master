<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Category_master extends Admin_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Category_master_model');
    }

    /**
     * List all category items
     */
    public function index()
    {
        $data['title'] = 'Category Master | Dine Master Admin';
        $data['page_title'] = 'Categories';
        $data['role_id'] = $this->admin_data['role_id'];
        
        $this->render('category_master/index.tpl', $data);
    }

    /**
     * DataTables Server-side List
     */
    public function ajax_list()
    {
        $role_id = $this->admin_data['role_id'];
        $restaurant_id = $this->admin_data['restaurant_id'];
        
        $list = $this->Category_master_model->get_datatables($role_id, $restaurant_id);
        $data = [];
        $no = $_POST['start'];
        
        foreach ($list as $item) {
            $no++;
            $row = [];
            
            $row[] = $no;
            
            // Name and description
            $row[] = '
                <div>
                    <div class="font-bold text-gray-800">' . $item->name . '</div>
                    <div class="text-xs text-gray-400">' . ($item->description ?: '') . '</div>
                </div>';
            
            // Restaurant (Only for Super Admin)
            if ($role_id == 1) {
                $row[] = '<span class="font-semibold text-gray-700">' . ($item->restaurant_name ?: "N/A") . '</span>';
            }


            
            // Actions
            $row[] = '
                <div class="flex justify-center space-x-2">
                    <a href="' . base_url('admin/category_master/edit/' . $item->category_id) . '" class="w-9 h-9 flex items-center justify-center bg-blue-50 text-blue-600 rounded-lg hover:bg-blue-600 hover:text-white transition-all">
                        <i class="fa-solid fa-pen-to-square"></i>
                    </a>
                    <button onclick="deleteItem(' . $item->category_id . ')" class="w-9 h-9 flex items-center justify-center bg-red-50 text-red-600 rounded-lg hover:bg-red-600 hover:text-white transition-all">
                        <i class="fa-solid fa-trash"></i>
                    </button>
                </div>';
            
            $data[] = $row;
        }

        $output = [
            "draw" => $_POST['draw'],
            "recordsTotal" => $this->Category_master_model->count_all(),
            "recordsFiltered" => $this->Category_master_model->count_filtered($role_id, $restaurant_id),
            "data" => $data,
        ];
        echo json_encode($output);
    }

    /**
     * Add new category item form
     */
    public function add()
    {
        $data['title'] = 'Add Category | Dine Master Admin';
        $data['page_title'] = 'Add New Category';
        $data['role_id'] = $this->admin_data['role_id'];
        if ($this->admin_data['role_id'] == 1) {
            $this->load->model('restaurant/Restaurant_model');
            $data['restaurants'] = $this->Restaurant_model->get_all();
            $restaurant_id = $this->input->get('restaurant_id') ? $this->input->get('restaurant_id') : (isset($data['restaurants'][0]['restaurant_id']) ? $data['restaurants'][0]['restaurant_id'] : null);
        } else {
            $restaurant_id = $this->admin_data['restaurant_id'];
        }

        $this->render('category_master/form.tpl', $data);
    }

    /**
     * Edit category item form
     */
    public function edit($id)
    {
        $data['title'] = 'Edit Category | Dine Master Admin';
        $data['page_title'] = 'Edit Category';
        $data['role_id'] = $this->admin_data['role_id'];
        $data['item'] = $this->Category_master_model->get_item_by_id($id);
        
        if ($this->admin_data['role_id'] == 1) {
            $this->load->model('restaurant/Restaurant_model');
            $data['restaurants'] = $this->Restaurant_model->get_all();
            $restaurant_id = $data['item']['restaurant_id'];
        } else {
            $restaurant_id = $this->admin_data['restaurant_id'];
        }
        
        if (empty($data['item'])) {
            show_404();
        }

        $this->render('category_master/form.tpl', $data);
    }

    /**
     * Save category item (AJAX)
     */
    public function save()
    {
        $id = $this->input->post('category_id');
        $restaurant_id = ($this->admin_data['role_id'] == 1) ? $this->input->post('restaurant_id') : $this->admin_data['restaurant_id'];
        
        $data = [
            'restaurant_id' => $restaurant_id,
            'name'          => $this->input->post('name'),
            'description'   => $this->input->post('description'),
            'is_active'     => $this->input->post('is_active') !== null ? 1 : 0,
            'added_by'      => $this->admin_data['user_id']
        ];

        if ($id) {
            $data['updated_date'] = date('Y-m-d H:i:s');
            $this->Category_master_model->update_item($id, $data);
            $message = 'Category updated successfully!';
        } else {
            $data['added_date'] = date('Y-m-d H:i:s');
            $this->Category_master_model->insert_item($data);
            $message = 'Category added successfully!';
        }

        echo json_encode(['success' => true, 'message' => $message, 'redirect' => base_url('admin/category_master')]);
    }

    /**
     * Delete category item (AJAX)
     */
    public function delete($id)
    {
        $this->Category_master_model->delete_item($id);
        echo json_encode(['success' => true, 'message' => 'Category deleted successfully!']);
    }
}
