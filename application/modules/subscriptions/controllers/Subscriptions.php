<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Subscriptions extends Admin_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Subscription_model');
        $this->load->model('restaurant/Restaurant_model');
    }

    /**
     * Listing page (Recharge Card UI)
     */
    public function index()
    {
        $restaurant_id = $this->admin_data['restaurant_id'];
        $role_id = $this->admin_data['role_id'];

        $data['plans'] = $this->Subscription_model->get_plans($restaurant_id, $role_id);
        $data['active_sub'] = $this->Subscription_model->get_active_subscription($restaurant_id);
        $data['is_super_admin'] = ($role_id == 1);
        $data['razorpay_key_id'] = $this->config->item('razorpay_key_id');

        $this->render('index.tpl', $data);
    }

    /**
     * Add new plan (Super Admin only)
     */
    public function add()
    {
        if ($this->admin_data['role_id'] != 1) {
            redirect(base_url('admin/subscriptions'));
        }

        $data['restaurants'] = $this->Restaurant_model->get_all();
        $this->render('form.tpl', $data);
    }

    /**
     * Edit plan (Super Admin only)
     */
    public function edit($id)
    {
        if ($this->admin_data['role_id'] != 1) {
            redirect(base_url('admin/subscriptions'));
        }

        $data['plan'] = $this->Subscription_model->get_plan($id);
        $data['restaurants'] = $this->Restaurant_model->get_all();
        $this->render('form.tpl', $data);
    }

    /**
     * Save/Update plan
     */
    public function save()
    {
        if ($this->admin_data['role_id'] != 1) {
            echo json_encode(['success' => false, 'message' => 'Unauthorized']);
            return;
        }

        $id = $this->input->post('id');
        $data = [
            'restaurant_id' => $this->input->post('restaurant_id'),
            'plan_name' => $this->input->post('plan_name'),
            'price' => $this->input->post('price'),
            'validity' => $this->input->post('validity'),
            'features' => $this->input->post('features'),
            'is_active' => $this->input->post('is_active') ? 1 : 0,
        ];

        if ($this->Subscription_model->save_plan($data, $id)) {
            echo json_encode(['success' => true, 'message' => 'Plan saved successfully.']);
        } else {
            echo json_encode(['success' => false, 'message' => 'Failed to save plan.']);
        }
    }

    /**
     * Activate a plan (AJAX)
     */
    public function activate()
    {
        $plan_id = $this->input->post('plan_id');
        $restaurant_id = $this->admin_data['restaurant_id'];
        $payment_id = $this->input->post('payment_id');

        if (empty($payment_id)) {
            echo json_encode(['success' => false, 'message' => 'Payment verification failed.']);
            return;
        }

        // Log Transaction First
        $plan = $this->Subscription_model->get_plan($plan_id);
        
        if (!$plan) {
            echo json_encode(['success' => false, 'message' => 'Invalid plan selected.']);
            return;
        }

        $this->db->db_debug = FALSE;
        $this->db->trans_start();
        
        $this->Subscription_model->log_transaction([
            'transaction_id' => $payment_id,
            'user_id' => $this->admin_data['user_id'],
            'amount' => $plan['price'],
            'subscription_id' => $plan_id,
            'status' => 'success',
            'response_json' => json_encode($_POST)
        ]);

        $activated = $this->Subscription_model->activate_plan($restaurant_id, $plan_id, $payment_id);
        
        $this->db->trans_complete();

        if ($this->db->trans_status() === FALSE || !$activated) {
            $error = $this->db->error();
            echo json_encode([
                'success' => false, 
                'message' => 'Failed to activate subscription. ' . (isset($error['message']) ? $error['message'] : ''),
                'db_error' => $error
            ]);
        } else {
            echo json_encode(['success' => true, 'message' => 'Subscription activated successfully!']);
        }
    }

    /**
     * Delete plan
     */
    public function delete($id)
    {
        if ($this->admin_data['role_id'] != 1) {
            echo json_encode(['success' => false, 'message' => 'Unauthorized']);
            return;
        }

        if ($this->Subscription_model->delete_plan($id)) {
            echo json_encode(['success' => true, 'message' => 'Plan deleted successfully.']);
        } else {
            echo json_encode(['success' => false, 'message' => 'Failed to delete plan.']);
        }
    }
}
