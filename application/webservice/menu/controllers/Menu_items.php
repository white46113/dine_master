<?php defined('BASEPATH') or exit('No direct script access allowed');
class Menu_items extends My_Api_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('menu_item_model', 'item');

    }
    public function get_menu($params = array())
    {
        $restaurant_id = $this->get('restaurant_id') ? $this->get('restaurant_id') : $this->post('restaurant_id');
        $category_id = $this->get('category_id') ? $this->get('category_id') : ($this->post('category_id') ? $this->post('category_id') : 0);
        $veg_type = $this->get('veg_type') ? $this->get('veg_type') : ($this->post('veg_type') ? $this->post('veg_type') : null);

        if (empty($restaurant_id)) {
            return $this->response([
                'success' => false,
                'status' => false, 
                'message' => 'The restaurant_id field is required.',
                'data' => []
            ], REST_Controller::HTTP_BAD_REQUEST);
        }

        $data = $this->item->list_by_category($restaurant_id, $category_id, $veg_type);
        
        if ($data) {
            return $this->response([
                'success' => true, 
                'status' => true,
                'message' => 'Menus found successfully.', 
                'data' => $data
            ], REST_Controller::HTTP_OK);
        }

        return $this->response([
            'success' => false, 
            'status' => false, 
            'message' => 'No data found',
            'data' => []
        ], REST_Controller::HTTP_OK);
    }

    public function get_item_details()
    {
        $item_id = $this->get('item_id') ? $this->get('item_id') : $this->post('item_id');

        if (empty($item_id)) {
            return $this->response([
                'success' => false,
                'status' => false, 
                'message' => 'The item_id field is required.',
                'data' => []
            ], REST_Controller::HTTP_BAD_REQUEST);
        }

        $data = $this->item->get_item_details($item_id);
        
        if ($data) {
            return $this->response([
                'success' => true, 
                'status' => true,
                'message' => 'Item details found successfully.', 
                'data' => $data
            ], REST_Controller::HTTP_OK);
        }

        return $this->response([
            'success' => false, 
            'status' => false, 
            'message' => 'Item not found.',
            'data' => []
        ], REST_Controller::HTTP_NOT_FOUND);
    }

    public function index_post()
    {
        if ($this->authenticate() !== true) {
            return;
        }

        $this->require_role(['admin']);
        $id = $this->item->insert($this->post());
        return $this->response(['status' => true, 'id' => $id], REST_Controller::HTTP_CREATED);
    }
}
