<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Tables extends Admin_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Tables_model');
    }

    /**
     * List all tables
     */
    public function index()
    {
        $data['title'] = 'Table Management | Dine Master Admin';
        $data['page_title'] = 'Restaurant Tables';
        
        $this->render('index.tpl', $data);
    }

    /**
     * DataTables Server-side List
     */
    public function ajax_list()
    {
        $list = $this->Tables_model->get_datatables();
        $data = [];
        $no = $_POST['start'];
        
        foreach ($list as $table) {
            $no++;
            $row = [];
            
            // Table Info
            $row[] = '
                <div class="flex items-center">
                    <div class="w-10 h-10 flex-shrink-0 rounded-xl bg-blue-50 text-blue-600 flex items-center justify-center mr-4">
                        <i class="fa-solid fa-chair"></i>
                    </div>
                    <div>
                        <div class="font-bold text-gray-800">' . $table->name . '</div>
                        <div class="text-[10px] text-gray-400 font-bold uppercase tracking-widest">Code: ' . $table->code . '</div>
                    </div>
                </div>';
            
            // Floor
            $row[] = '<span class="px-3 py-1 bg-gray-100 text-gray-600 text-[10px] font-black rounded-lg uppercase tracking-widest">' . ($table->floor_name ?: "Main Floor") . '</span>';
            
            // Capacity
            $row[] = '
                <div class="flex items-center text-gray-700">
                    <i class="fa-solid fa-users text-[10px] mr-2 text-gray-400"></i>
                    <span class="font-bold">' . $table->capacity . ' Persons</span>
                </div>';
            
            // Status
            $status_classes = [
                'FREE' => 'bg-green-100 text-green-700',
                'OCCUPIED' => 'bg-blue-100 text-blue-700',
                'RESERVED' => 'bg-orange-100 text-orange-700',
                'BLOCKED' => 'bg-red-100 text-red-700'
            ];
            $class = $status_classes[$table->status] ?? 'bg-gray-100 text-gray-700';
            $row[] = '<span class="px-3 py-1 ' . $class . ' text-[10px] font-black rounded-lg uppercase tracking-widest">' . $table->status . '</span>';
            
            // Active Toggle
            $checked = $table->is_active ? 'checked' : '';
            $row[] = '
                <label class="relative inline-flex items-center cursor-pointer">
                    <input type="checkbox" value="" class="sr-only peer" ' . $checked . ' onchange="toggleStatus(' . $table->table_id . ')">
                    <div class="w-11 h-6 bg-gray-200 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[\'\'] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-blue-600"></div>
                </label>';
            
            // Actions
            $row[] = '
                <div class="flex justify-center space-x-2">
                    <a href="' . base_url('admin/tables/edit/' . $table->table_id) . '" class="w-9 h-9 flex items-center justify-center bg-blue-50 text-blue-600 rounded-lg hover:bg-blue-600 hover:text-white transition-all">
                        <i class="fa-solid fa-pen-to-square"></i>
                    </a>
                    <button onclick="deleteTable(' . $table->table_id . ')" class="w-9 h-9 flex items-center justify-center bg-red-50 text-red-600 rounded-lg hover:bg-red-600 hover:text-white transition-all">
                        <i class="fa-solid fa-trash"></i>
                    </button>
                </div>';
            
            $data[] = $row;
        }

        $output = [
            "draw" => $_POST['draw'],
            "recordsTotal" => $this->Tables_model->count_all(),
            "recordsFiltered" => $this->Tables_model->count_filtered(),
            "data" => $data,
        ];
        echo json_encode($output);
    }

    /**
     * Add new table
     */
    public function add()
    {
        if ($this->input->post()) {
            $data = [
                'restaurant_id' => $this->admin_data['restaurant_id'] ?? 1,
                'floor_id'      => $this->input->post('floor_id'),
                'code'          => $this->input->post('code'),
                'name'          => $this->input->post('name'),
                'capacity'      => $this->input->post('capacity'),
                'status'        => 'FREE',
                'qr_token'      => bin2hex(random_bytes(16)),
                'is_active'     => 1,
                'added_by'      => $this->admin_data['admin_user_id']
            ];
            
            $this->Tables_model->save($data);
            $this->session->set_flashdata('success', 'Table added successfully');
            redirect('admin/tables');
        }

        $data['title'] = 'Add New Table | Dine Master Admin';
        $data['floors'] = $this->Tables_model->get_floors();
        $this->render('add.tpl', $data);
    }

    /**
     * Edit table
     */
    public function edit($id)
    {
        if ($this->input->post()) {
            $data = [
                'floor_id' => $this->input->post('floor_id'),
                'code'     => $this->input->post('code'),
                'name'     => $this->input->post('name'),
                'capacity' => $this->input->post('capacity'),
                'status'   => $this->input->post('status'),
                'updated_by' => $this->admin_data['admin_user_id']
            ];
            
            $this->Tables_model->update(['table_id' => $id], $data);
            $this->session->set_flashdata('success', 'Table updated successfully');
            redirect('admin/tables');
        }

        $data['title'] = 'Edit Table | Dine Master Admin';
        $data['table'] = $this->Tables_model->get_by_id($id);
        $data['floors'] = $this->Tables_model->get_floors();
        $this->render('edit.tpl', $data);
    }

    /**
     * AJAX: Toggle table active status
     */
    public function toggle_status($id)
    {
        $table = $this->Tables_model->get_by_id($id);
        if ($table) {
            $new_status = $table->is_active ? 0 : 1;
            $this->Tables_model->update(['table_id' => $id], ['is_active' => $new_status]);
            echo json_encode(['success' => true]);
        }
    }

    /**
     * AJAX: Delete table
     */
    public function delete($id)
    {
        $this->Tables_model->delete_by_id($id);
        echo json_encode(['success' => true, 'message' => 'Table deleted successfully']);
    }
}
