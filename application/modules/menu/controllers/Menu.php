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
        
        $this->render('index.tpl', $data);
    }

    /**
     * DataTables Server-side List
     */
    public function ajax_list()
    {
        $restaurant_id = $this->admin_data['restaurant_id'] ?? 1;
        $list = $this->Menu_model->get_datatables();
        $data = [];
        $no = $_POST['start'];
        
        foreach ($list as $item) {
            $no++;
            $row = [];
            
            // Item & Image
            $img_url = $item->image_url ?: base_url('public/img/food-placeholder.svg');
            $img_class = $item->image_url ? 'object-cover' : 'object-cover opacity-50 p-2';
            
            $row[] = '
                <div class="flex items-center">
                    <div class="w-12 h-12 flex-shrink-0 rounded-lg overflow-hidden bg-gray-100 mr-4">
                        <img src="' . $img_url . '" class="w-full h-full ' . $img_class . '" onerror="this.src=\'' . base_url('public/img/food-placeholder.svg') . '\'; this.classList.add(\'opacity-50\'); this.classList.add(\'p-2\');">
                    </div>
                    <div>
                        <div class="font-bold text-gray-800">' . $item->name . '</div>
                        <div class="text-xs text-gray-400">#' . $item->item_id . '</div>
                    </div>
                </div>';
            
            // Category
            $row[] = '<span class="px-3 py-1 bg-gray-100 text-gray-600 text-xs font-semibold rounded-full">' . ($item->category_name ?: "Uncategorized") . '</span>';
            
            // Price
            $row[] = '<div class="font-bold text-gray-900">₹' . number_format($item->base_price, 2) . '</div>';
            
            // Type
            if ($item->veg_type == 'VEG') {
                $row[] = '<span class="flex items-center text-green-600 text-xs font-bold"><i class="fa-solid fa-leaf mr-1"></i> VEG</span>';
            } elseif ($item->veg_type == 'NON_VEG') {
                $row[] = '<span class="flex items-center text-red-600 text-xs font-bold"><i class="fa-solid fa-meat mr-1"></i> NON-VEG</span>';
            } else {
                $row[] = '<span class="flex items-center text-orange-600 text-xs font-bold"><i class="fa-solid fa-egg mr-1"></i> EGG</span>';
            }
            
            // Availability
            if ($item->is_available) {
                $row[] = '<div class="flex items-center"><span class="w-2 h-2 bg-green-500 rounded-full mr-2"></span><span class="text-xs text-green-700 font-semibold">Available</span></div>';
            } else {
                $row[] = '<div class="flex items-center"><span class="w-2 h-2 bg-red-500 rounded-full mr-2"></span><span class="text-xs text-red-700 font-semibold">Sold Out</span></div>';
            }
            
            // Actions
            $row[] = '
                <div class="flex justify-center space-x-2">
                    <a href="' . base_url('admin/menu/edit/' . $item->item_id) . '" class="w-9 h-9 flex items-center justify-center bg-blue-50 text-blue-600 rounded-lg hover:bg-blue-600 hover:text-white transition-all">
                        <i class="fa-solid fa-pen-to-square"></i>
                    </a>
                    <button onclick="deleteItem(' . $item->item_id . ')" class="w-9 h-9 flex items-center justify-center bg-red-50 text-red-600 rounded-lg hover:bg-red-600 hover:text-white transition-all">
                        <i class="fa-solid fa-trash"></i>
                    </button>
                </div>';
            
            $data[] = $row;
        }

        $output = [
            "draw" => $_POST['draw'],
            "recordsTotal" => $this->Menu_model->count_all(),
            "recordsFiltered" => $this->Menu_model->count_filtered(),
            "data" => $data,
        ];
        echo json_encode($output);
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
            $config['encrypt_name']  = TRUE;
            
            if (!is_dir($config['upload_path'])) {
                mkdir($config['upload_path'], 0777, true);
            }

            $this->load->library('upload', $config);

            if ($this->upload->do_upload('image')) {
                $upload_data = $this->upload->data();
                $data['image_url'] = base_url('public/uploads/menu/' . $upload_data['file_name']);
            } else {
                echo json_encode(['success' => false, 'message' => $this->upload->display_errors('', '')]);
                return;
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
