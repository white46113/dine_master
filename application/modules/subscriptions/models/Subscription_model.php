<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Subscription_model extends CI_Model
{
    protected $table = 'subscription_plans';

    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Get all subscription plans
     */
    public function get_plans($restaurant_id = null, $role_id = null)
    {
        $this->db->select('s.*, r.name as restaurant_name');
        $this->db->from($this->table . ' s');
        $this->db->join('restaurants r', 's.restaurant_id = r.restaurant_id', 'left');

        if ($role_id != 1) {
            $this->db->where('s.is_active', 1);
            if ($restaurant_id !== null) {
                $this->db->where('s.restaurant_id', $restaurant_id);
            }
        }

        $this->db->order_by('s.id', 'DESC');
        return $this->db->get()->result_array();
    }

    /**
     * Get single plan details
     */
    public function get_plan($id)
    {
        return $this->db->get_where($this->table, ['id' => $id])->row_array();
    }

    /**
     * Save or update a plan
     */
    public function save_plan($data, $id = null)
    {
        $current_user_id = $this->session->userdata('admin_user_id');
        
        if ($id) {
            $data['updated_by'] = $current_user_id;
            $data['updated_date'] = date('Y-m-d H:i:s');
            $this->db->where('id', $id);
            return $this->db->update($this->table, $data);
        } else {
            $data['added_by'] = $current_user_id;
            $data['added_date'] = date('Y-m-d H:i:s');
            return $this->db->insert($this->table, $data);
        }
    }

    /**
     * Delete a plan
     */
    public function delete_plan($id)
    {
        return $this->db->delete($this->table, ['id' => $id]);
    }

    /**
     * Check if a restaurant has an active subscription
     */
    public function get_active_subscription($restaurant_id)
    {
        $this->db->where('rs.restaurant_id', $restaurant_id);
        $this->db->where('status', 'ACTIVE');
        $this->db->where('expiry_date >=', date('Y-m-d'));
        $this->db->order_by('id', 'DESC');
        
        $this->db->select('rs.*, sp.plan_name, sp.price, sp.validity');
        $this->db->from('restaurant_subscriptions rs');
        $this->db->join('subscription_plans sp', 'rs.plan_id = sp.id');
        
        return $this->db->get()->row_array();
    }

    /**
     * Activate a plan for a restaurant
     */
    public function activate_plan($restaurant_id, $plan_id)
    {
        $plan = $this->get_plan($plan_id);
        if (!$plan) return false;

        $current_user_id = $this->session->userdata('admin_user_id');

        // Parse validity (e.g., "30 Days")
        preg_match('/\d+/', $plan['validity'], $matches);
        $days = isset($matches[0]) ? (int)$matches[0] : 30;

        $data = [
            'restaurant_id' => $restaurant_id,
            'plan_id' => $plan_id,
            'activation_date' => date('Y-m-d'),
            'expiry_date' => date('Y-m-d', strtotime("+$days days")),
            'status' => 'ACTIVE',
            'added_by' => $current_user_id,
            'added_date' => date('Y-m-d H:i:s')
        ];

        // Deactivate previous active subscriptions
        $this->db->where('restaurant_id', $restaurant_id);
        $this->db->update('restaurant_subscriptions', [
            'status' => 'EXPIRED',
            'updated_by' => $current_user_id,
            'updated_date' => date('Y-m-d H:i:s')
        ]);

        return $this->db->insert('restaurant_subscriptions', $data);
    }
}
