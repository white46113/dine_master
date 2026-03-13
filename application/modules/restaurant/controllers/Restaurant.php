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
     * View/Edit Restaurant Profile
     */
    public function index()
    {
        $data['title'] = 'Restaurant Information | Dine Master Admin';
        $data['page_title'] = 'Restaurant Profile';
        
        $restaurant_id = $this->admin_data['restaurant_id'] ?? 1;
        $data['restaurant'] = $this->Restaurant_model->get_details($restaurant_id);
        
        $this->render('index.tpl', $data);
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
            'updated_by'    => $this->admin_data['user_id']
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
