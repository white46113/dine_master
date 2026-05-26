<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Waiter extends Admin_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Waiter_model');
    }

    private function _is_superadmin() {
        $admin_data = $this->session->userdata('admin_user');
        return (isset($admin_data['role_id']) && $admin_data['role_id'] == 1) || 
               (isset($admin_data['user_role']) && $admin_data['user_role'] == 1);
    }

    public function index()
    {
        $data['title'] = 'Restaurant Members | Dine Master Admin';
        $data['page_title'] = 'Restaurant Members';
        $data['is_superadmin'] = $this->_is_superadmin();
        
        $this->render('index.tpl', $data);
    }

    public function ajax_list()
    {
        $list = $this->Waiter_model->get_datatables();
        $data = [];
        $no = $_POST['start'];
        $is_superadmin = $this->_is_superadmin();
        
        $role_names = [
            '1' => 'Super Admin',
            '2' => 'Admin',
            '3' => 'Manager',
            '4' => 'Waiter'
        ];
        $role_colors = [
            '1' => 'bg-red-50 text-red-600 border border-red-100',
            '2' => 'bg-blue-50 text-blue-600 border border-blue-100',
            '3' => 'bg-green-50 text-green-600 border border-green-100',
            '4' => 'bg-purple-50 text-purple-600 border border-purple-100'
        ];
        
        foreach ($list as $waiter) {
            $no++;
            $row = [];
            
            $role_name = $role_names[$waiter->user_role] ?? 'Unknown';
            $role_color = $role_colors[$waiter->user_role] ?? 'bg-gray-50 text-gray-600 border border-gray-100';
            
            // User/Customer Info
            $row[] = '
                <div class="flex items-center">
                    <div class="w-10 h-10 flex-shrink-0 rounded-xl bg-purple-50 text-purple-600 flex items-center justify-center mr-4">
                        <i class="fa-solid fa-user"></i>
                    </div>
                    <div>
                        <div class="font-bold text-gray-800 flex items-center gap-2">
                            ' . $waiter->user_name . '
                            <span class="px-2 py-0.5 text-[9px] font-bold rounded-md uppercase tracking-wider ' . $role_color . '">' . $role_name . '</span>
                        </div>
                        <div class="text-[10px] text-gray-400 font-bold tracking-widest">' . $waiter->user_email . '</div>
                    </div>
                </div>';
            
            // Phone
            $row[] = '<span class="text-sm text-gray-600">' . $waiter->phone . '</span>';
            
            // Restaurant (Only for superadmin)
            if ($is_superadmin) {
                $row[] = '<span class="px-3 py-1 bg-gray-100 text-gray-600 text-[10px] font-black rounded-lg uppercase tracking-widest">' . ($waiter->restaurant_name ?: "Unknown") . '</span>';
            }
            
            // Status
            $status_classes = [
                'Active' => 'bg-green-100 text-green-700',
                'Inactive' => 'bg-red-100 text-red-700'
            ];
            $class = $status_classes[$waiter->status] ?? 'bg-gray-100 text-gray-700';
            $row[] = '<span class="px-3 py-1 ' . $class . ' text-[10px] font-black rounded-lg uppercase tracking-widest">' . $waiter->status . '</span>';
            
            // Actions
            $row[] = '
                <div class="flex justify-center space-x-2">
                    <a href="' . base_url('admin/waiter/edit/' . $waiter->user_id) . '" class="w-9 h-9 flex items-center justify-center bg-blue-50 text-blue-600 rounded-lg hover:bg-blue-600 hover:text-white transition-all">
                        <i class="fa-solid fa-pen-to-square"></i>
                    </a>
                    <button onclick="deleteWaiter(' . $waiter->user_id . ')" class="w-9 h-9 flex items-center justify-center bg-red-50 text-red-600 rounded-lg hover:bg-red-600 hover:text-white transition-all">
                        <i class="fa-solid fa-trash"></i>
                    </button>
                </div>';
            
            $data[] = $row;
        }

        $output = [
            "draw" => $_POST['draw'],
            "recordsTotal" => $this->Waiter_model->count_all(),
            "recordsFiltered" => $this->Waiter_model->count_filtered(),
            "data" => $data,
        ];
        echo json_encode($output);
    }

    public function add()
    {
        $is_superadmin = $this->_is_superadmin();
        $admin_data = $this->session->userdata('admin_user');
        
        if ($this->input->post()) {
            $role_id = $this->input->post('user_role');
            if (!$is_superadmin) {
                if (!in_array($role_id, ['3', '4'])) {
                    $role_id = '4';
                }
            }
            $data = [
                'restaurant_id' => $is_superadmin ? $this->input->post('restaurant_id') : $admin_data['restaurant_id'],
                'user_role'     => $role_id,
                'user_name'     => $this->input->post('user_name'),
                'user_email'    => $this->input->post('user_email'),
                'phone'         => $this->input->post('phone'),
                'user_password' => password_hash($this->input->post('password'), PASSWORD_BCRYPT),
                'status'        => $this->input->post('status') ? 'Active' : 'Inactive',
                'added_by'      => $admin_data['admin_user_id'] ?? 1,
            ];
            
            $this->Waiter_model->save($data);
            
            if ($this->input->is_ajax_request()) {
                echo json_encode(['success' => true, 'message' => 'User added successfully', 'redirect' => base_url('admin/waiter')]);
                exit;
            }

            $this->session->set_flashdata('success', 'User added successfully');
            redirect('admin/waiter');
        }

        $roles = [
            ['role_id' => '1', 'name' => 'Super Admin'],
            ['role_id' => '2', 'name' => 'Admin'],
            ['role_id' => '3', 'name' => 'Manager'],
            ['role_id' => '4', 'name' => 'Waiter']
        ];
        if (!$is_superadmin) {
            $roles = [
                ['role_id' => '3', 'name' => 'Manager'],
                ['role_id' => '4', 'name' => 'Waiter']
            ];
        }

        $data['title'] = 'Add New Customer | Dine Master Admin';
        $data['page_title'] = 'Add Customer';
        $data['is_superadmin'] = $is_superadmin;
        $data['roles'] = $roles;
        if ($is_superadmin) {
            $data['restaurants'] = $this->Waiter_model->get_restaurants();
        }
        $this->render('add.tpl', $data);
    }

    public function edit($id)
    {
        $is_superadmin = $this->_is_superadmin();
        $waiter = $this->Waiter_model->get_by_id($id);
        $admin_data = $this->session->userdata('admin_user');
        
        if (!$waiter) {
            show_404();
        }

        if ($this->input->post()) {
            $role_id = $this->input->post('user_role');
            if (!$is_superadmin) {
                if (!in_array($role_id, ['3', '4'])) {
                    $role_id = '4';
                }
            }
            $data = [
                'user_name'     => $this->input->post('user_name'),
                'user_email'    => $this->input->post('user_email'),
                'phone'         => $this->input->post('phone'),
                'user_role'     => $role_id,
                'status'        => $this->input->post('status') ? 'Active' : 'Inactive',
                'updated_by'    => $admin_data['admin_user_id'] ?? 1
            ];
            
            if ($is_superadmin && $this->input->post('restaurant_id')) {
                $data['restaurant_id'] = $this->input->post('restaurant_id');
            }

            if ($this->input->post('password')) {
                $data['user_password'] = password_hash($this->input->post('password'), PASSWORD_BCRYPT);
            }
            
            $this->Waiter_model->update(['user_id' => $id], $data);
            
            if ($this->input->is_ajax_request()) {
                echo json_encode(['success' => true, 'message' => 'User updated successfully', 'redirect' => base_url('admin/waiter')]);
                exit;
            }

            $this->session->set_flashdata('success', 'User updated successfully');
            redirect('admin/waiter');
        }

        $roles = [
            ['role_id' => '1', 'name' => 'Super Admin'],
            ['role_id' => '2', 'name' => 'Admin'],
            ['role_id' => '3', 'name' => 'Manager'],
            ['role_id' => '4', 'name' => 'Waiter']
        ];
        if (!$is_superadmin) {
            $roles = [
                ['role_id' => '3', 'name' => 'Manager'],
                ['role_id' => '4', 'name' => 'Waiter']
            ];
        }

        $data['title'] = 'Edit Customer | Dine Master Admin';
        $data['page_title'] = 'Edit Customer';
        $data['waiter'] = $waiter;
        $data['is_superadmin'] = $is_superadmin;
        $data['roles'] = $roles;
        if ($is_superadmin) {
            $data['restaurants'] = $this->Waiter_model->get_restaurants();
        }
        $this->render('edit.tpl', $data);
    }

    public function delete($id)
    {
        $this->Waiter_model->delete_by_id($id);
        echo json_encode(['success' => true, 'message' => 'Waiter deleted successfully']);
    }
}
