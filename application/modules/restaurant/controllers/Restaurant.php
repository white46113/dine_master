<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Restaurant extends Admin_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Restaurant_model');
    }

    /**
     * View/Edit Restaurant Profile OR List Restaurants for Super Admin
     */
    public function index()
    {
        $is_superadmin = ($this->admin_data['user_role'] == 1);
        
        if ($is_superadmin) {
            $data['title'] = 'Restaurants | Dine Master Admin';
            $data['page_title'] = 'Restaurant Management';
            $this->render('list.tpl', $data);
        } else {
            $data['title'] = 'Restaurant Information | Dine Master Admin';
            $data['page_title'] = 'Restaurant Profile';
            
            $restaurant_id = $this->admin_data['restaurant_id'] ?? 1;
            $data['restaurant'] = $this->Restaurant_model->get_details($restaurant_id);
            $data['mode'] = 'edit';
            
            $this->render('index.tpl', $data);
        }
    }

    /**
     * View/Edit Arbitrary Restaurant Profile (Super Admin Only)
     */
    public function profile($id, $mode = 'edit')
    {
        $role_id = $this->admin_data['role_id'] ?? $this->admin_data['user_role'] ?? 0;
        $is_superadmin = ($role_id == 1);
        
        if (!$is_superadmin) {
             show_error('Unauthorized access. Only Super Admins can view arbitary profiles.', 403);
             return;
        }

        $data['title'] = $mode == 'view' ? 'View Restaurant | Dine Master Admin' : 'Edit Restaurant | Dine Master Admin';
        $data['page_title'] = 'Restaurant Profile';
        $data['restaurant'] = $this->Restaurant_model->get_details($id);
        $data['mode'] = $mode;
        
        $this->render('index.tpl', $data);
    }

    /**
     * DataTables Server-side List for Super Admin
     */
    public function ajax_list()
    {
        $list = $this->Restaurant_model->get_datatables();
        $data = [];
        $no = $_POST['start'];
        
        foreach ($list as $res) {
            $no++;
            $row = [];
            
            // Info
            $row[] = '
                <div class="flex items-center">
                    <div class="w-10 h-10 flex-shrink-0 rounded-xl bg-orange-50 text-orange-600 flex items-center justify-center mr-4">
                        <i class="fa-solid fa-shop"></i>
                    </div>
                    <div>
                        <div class="font-bold text-gray-800">' . $res->name . '</div>
                        <div class="text-[10px] text-gray-400 font-bold tracking-widest">' . $res->legal_name . '</div>
                    </div>
                </div>';
            
            $row[] = '<span class="text-sm font-bold text-gray-700">' . $res->contact_email . '</span>';
            $row[] = '<span class="text-sm text-gray-600">' . $res->contact_phone . '</span>';
            $row[] = '<span class="text-sm text-gray-600 font-bold uppercase">' . $res->city . '</span>';
            
            // Status
            $status_classes = [
                '1' => 'bg-green-100 text-green-700',
                '0' => 'bg-red-100 text-red-700'
            ];
            $class = $status_classes[$res->is_active] ?? 'bg-gray-100 text-gray-700';
            $label = $res->is_active ? 'Active' : 'Inactive';
            $row[] = '<span class="px-3 py-1 ' . $class . ' text-[10px] font-black rounded-lg uppercase tracking-widest">' . $label . '</span>';
            
            // Actions
            $row[] = '
                <div class="flex justify-center space-x-2">
                    <a href="' . base_url('admin/restaurant/profile/' . $res->restaurant_id . '/view') . '" class="w-9 h-9 flex items-center justify-center bg-green-50 text-green-600 rounded-lg hover:bg-green-600 hover:text-white transition-all" title="View Property">
                        <i class="fa-regular fa-eye"></i>
                    </a>
                    <a href="' . base_url('admin/restaurant/profile/' . $res->restaurant_id . '/edit') . '" class="w-9 h-9 flex items-center justify-center bg-blue-50 text-blue-600 rounded-lg hover:bg-blue-600 hover:text-white transition-all" title="Edit Property">
                        <i class="fa-solid fa-pen-to-square"></i>
                    </a>
                </div>';
            
            $data[] = $row;
        }

        $output = [
            "draw" => $_POST['draw'],
            "recordsTotal" => $this->Restaurant_model->count_all(),
            "recordsFiltered" => $this->Restaurant_model->count_filtered(),
            "data" => $data,
        ];
        echo json_encode($output);
    }

    /**
     * Save Restaurant Details (AJAX)
     */
    public function save()
    {
        $id = $this->input->post('restaurant_id');
        $data = [
            'name'          => $this->input->post('name'),
            'legal_name'    => $this->input->post('legal_name'),
            'contact_email' => $this->input->post('contact_email'),
            'contact_phone' => $this->input->post('contact_phone'),
            'address_line1' => $this->input->post('address_line1'),
            'address_line2' => $this->input->post('address_line2'),
            'city'          => $this->input->post('city'),
            'state'         => $this->input->post('state'),
            'postal_code'   => $this->input->post('postal_code'),
            'updated_by'    => $this->admin_data['admin_user_id'] ?? 1
        ];

        // Handle Logo Upload
        if (!empty($_FILES['logo']['name'])) {
            $config['upload_path']   = './public/uploads/restaurant/';
            $config['allowed_types'] = 'gif|jpg|png|jpeg';
            $config['encrypt_name']  = TRUE;
            
            if (!is_dir($config['upload_path'])) {
                mkdir($config['upload_path'], 0777, true);
            }

            $this->load->library('upload', $config);

            if ($this->upload->do_upload('logo')) {
                $upload_data = $this->upload->data();
                $data['logo_url'] = base_url('public/uploads/restaurant/' . $upload_data['file_name']);
            } else {
                echo json_encode(['success' => false, 'message' => $this->upload->display_errors('', '')]);
                return;
            }
        }

        if ($this->Restaurant_model->update_details($id, $data)) {
            echo json_encode(['success' => true, 'message' => 'Restaurant profile updated successfully!']);
        } else {
            echo json_encode(['success' => false, 'message' => 'No changes made or update failed.']);
        }
    }
}
