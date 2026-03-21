<?php defined('BASEPATH') or exit('No direct script access allowed');

class Table extends My_Api_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('table_model');
    }

    /** GET /WS/tables - List tables */
    public function index_get()
    {
        if ($this->authenticate() !== true) {
            return;
        }

        $restaurant_id = $this->param('restaurant_id');
        $search = $this->param('search');
        $status = $this->param('status');

        // RBAC logic
        $is_superadmin = ($this->current_user->role == 'superadmin' || $this->current_user->role_id == 1);
        
        if (!$is_superadmin) {
            // Regular admins/managers only see their own restaurant
            if (isset($this->current_user->restaurant_id)) {
                $restaurant_id = $this->current_user->restaurant_id;
            } else {
                return $this->response([
                    'success' => false,
                    'message' => 'Unauthorized: No restaurant associated with this user.',
                    'data'    => []
                ], REST_Controller::HTTP_FORBIDDEN);
            }
        }

        if ($is_superadmin) {
            // Super Admin can see all or filter by restaurant
            $tables = $this->table_model->get_all_tables_for_superadmin($restaurant_id, $search, $status);
        } else {
            // For regular users, the request specifically asked for ONLY available tables
            $tables = $this->table_model->get_available_tables($restaurant_id, $search);
        }

        return $this->response([
            'success' => true,
            'message' => 'Table list fetched successfully',
            'data' => $tables
        ], REST_Controller::HTTP_OK);
    }

    /** POST /WS/tables - Alias for GET (supports JSON body with restaurant_id) */
    public function index_post()
    {
        return $this->index_get();
    }

    /** index() - Direct dispatch from Api_execute wscontroller */
    public function index()
    {
        return $this->index_get();
    }
}
