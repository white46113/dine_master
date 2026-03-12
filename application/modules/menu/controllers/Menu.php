<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Menu extends Admin_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Menu_model');
    }

    /**
     * List all menu items
     */
    public function index()
    {
        $data['title'] = 'Menu Management | Dine Master Admin';
        $data['page_title'] = 'Menu Items';
        
        $data['items'] = $this->Menu_model->get_all_items();
        
        $this->render('index.tpl', $data);
    }

    /**
     * Add new menu item form
     */
    public function add()
    {
        $data['title'] = 'Add Menu Item | Dine Master Admin';
        $data['page_title'] = 'Add New Item';
        $data['categories'] = $this->Menu_model->get_categories();
        
        $this->render('form.tpl', $data);
    }

    /**
     * Edit menu item form
     */
    public function edit($id)
    {
        $data['title'] = 'Edit Menu Item | Dine Master Admin';
        $data['page_title'] = 'Edit Item';
        $data['item'] = $this->Menu_model->get_item_by_id($id);
        $data['categories'] = $this->Menu_model->get_categories();
        
        if (empty($data['item'])) {
            show_404();
        }

        $this->render('form.tpl', $data);
    }

    /**
     * Save menu item (AJAX)
     */
    public function save()
    {
        $id = $this->input->post('item_id');
        $data = [
            'restaurant_id' => $this->admin_data['restaurant_id'] ?? 1, // Fallback if not set
            'category_id'   => $this->input->post('category_id'),
            'name'          => $this->input->post('name'),
            'description'   => $this->input->post('description'),
            'base_price'    => $this->input->post('base_price'),
            'veg_type'      => $this->input->post('veg_type'),
            'is_available'  => $this->input->post('is_available') ? 1 : 0,
            'added_by'      => $this->admin_data['user_id']
        ];

        // Handle Image Upload
        if (!empty($_FILES['image']['name'])) {
            $config['upload_path']   = './public/uploads/menu/';
            $config['allowed_types'] = 'gif|jpg|png|jpeg';
            $config['file_name']     = time() . '_' . $_FILES['image']['name'];
            
            if (!is_dir($config['upload_path'])) {
                mkdir($config['upload_path'], 0777, true);
            }

            $this->load->library('upload', $config);

            if ($this->upload->do_upload('image')) {
                $upload_data = $this->upload->data();
                $data['image_url'] = base_url('public/uploads/menu/' . $upload_data['file_name']);
            }
        }

        if ($id) {
            $this->Menu_model->update_item($id, $data);
            $message = 'Menu item updated successfully!';
        } else {
            $this->Menu_model->insert_item($data);
            $message = 'Menu item added successfully!';
        }

        echo json_encode(['success' => true, 'message' => $message, 'redirect' => base_url('admin/menu')]);
    }

    /**
     * Delete menu item (AJAX)
     */
    public function delete($id)
    {
        $this->Menu_model->delete_item($id);
        echo json_encode(['success' => true, 'message' => 'Menu item deleted successfully!']);
    }
}
