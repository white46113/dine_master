<?php defined('BASEPATH') or exit('No direct script access allowed');
class Categories extends My_Api_Controller
{
    public function __construct()
    {

        parent::__construct();
        $this->load->model('category_model', 'category');
    }
    public function index($rid = 0)
    {
        if (is_array($rid) && isset($rid['id'])) {
            $rid = $rid['id'];
        } elseif (is_array($rid)) {
            $rid = null;
        }

        if (!$rid) {
            $rid = $this->get('id');
        }

        if (!$rid)
            return $this->response(['success' => false, 'status' => false, 'message' => 'restaurant_id required'], REST_Controller::HTTP_BAD_REQUEST);

        $data = $this->category->list_by_restaurant($rid);

        // Prepend "All" category at the first position
        $all_category = (object) [
            'category_id'    => "0",
            'category_name'  => "All",
            'category_image' => ""
        ];
        array_unshift($data, $all_category);

        return $this->response([
            'success' => true,
            'message' => 'catagories found successfully.',
            'status'  => true,
            'data'    => $data
        ], REST_Controller::HTTP_OK);
    }
    public function index_post()
    {
        if ($this->authenticate() !== true)
            return;
        $this->require_role(['admin']);
        $id = $this->category->insert($this->post());
        return $this->response(['status' => true, 'id' => $id], REST_Controller::HTTP_CREATED);
    }

    public function index_get($rid = 0)
    {
        return $this->index($rid);
    }
}
