<?php defined('BASEPATH') or exit('No direct script access allowed');
class Categories extends My_Api_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('category_model', 'category');
    }
    public function index_get()
    {
        $rid = $this->get('restaurant_id');
        if (!$rid)
            return $this->response(['status' => false, 'message' => 'restaurant_id required'], REST_Controller::HTTP_BAD_REQUEST);
        $data = $this->category->list_by_restaurant($rid);
        return $this->response(['status' => true, 'data' => $data], REST_Controller::HTTP_OK);
    }
    public function index_post()
    {
        if ($this->authenticate() !== true)
            return;
        $this->require_role(['admin']);
        $id = $this->category->insert($this->post());
        return $this->response(['status' => true, 'id' => $id], REST_Controller::HTTP_CREATED);
    }
}
