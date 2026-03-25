<?php defined('BASEPATH') or exit('No direct script access allowed');
class Order extends My_Api_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('order_model');
    }

    /** POST /WS/new_orders - Create a new order */
    public function new_orders()
    {
        if ($this->authenticate() !== true)
            return;
            
        $input = $this->post();
        if (empty($input)) {
            $input = json_decode($this->input->raw_input_stream, true);
        }

        // Support top-level params by wrapping them into the 'order' object if missing
        if (!isset($input['order']) || !is_array($input['order'])) {
            $input['order'] = [
                'order_number'  => 'ODN' . date('YmdHis'),
                'restaurant_id' => isset($input['restaurant_id']) ? $input['restaurant_id'] : null,
                'table_id'      => isset($input['table_no']) ? $input['table_no'] : (isset($input['table_id']) ? $input['table_id'] : null),
                'customer_id'   => isset($input['customer_id']) ? $input['customer_id'] : null,
                'waiter_id'     => isset($input['waiter_id']) ? $input['waiter_id'] : null,
                'status'        => isset($input['status']) ? $input['status'] : 'PLACED',
                'placed_at'     => date('Y-m-d H:i:s')
            ];
        } else {
            // Ensure order_number is set if the 'order' object is already provided
            if (!isset($input['order']['order_number'])) {
                $input['order']['order_number'] = 'ODN' . date('YmdHis');
            }
            if (!isset($input['order']['placed_at'])) {
                $input['order']['placed_at'] = date('Y-m-d H:i:s');
            }
        }

        if (empty($input['items']) || !is_array($input['items'])) {
            return $this->response([
                'success' => false,
                'status' => false, 
                'message' => 'Items array is required and cannot be empty.'
            ], REST_Controller::HTTP_BAD_REQUEST);
        }

        $input['order']['added_by'] = $this->current_user->user_id;

        $id = $this->order_model->create_order($input);
        if (!$id) {
            return $this->response([
                'success' => false, 
                'status' => false, 
                'message' => 'Failed to create order.'
            ], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
        }

        return $this->response([
            'success' => true, 
            'message' => 'Order created successfully',
            'data' => [
                'order_id' => $id
            ]
        ], REST_Controller::HTTP_CREATED);
    }

    /** POST /WS/add_order_items - Add items to an existing order */
    public function add_order_items()
    {
        if ($this->authenticate() !== true)
            return;

        $input = $this->post();
        if (empty($input)) {
            $input = json_decode($this->input->raw_input_stream, true);
        }

        $order_id = isset($input['order_id']) ? intval($input['order_id']) : null;
        $items    = isset($input['items']) && is_array($input['items']) ? $input['items'] : [];

        if (!$order_id) {
            return $this->response(['status' => false, 'message' => 'order_id is required'], REST_Controller::HTTP_BAD_REQUEST);
        }
        if (empty($items)) {
            return $this->response(['status' => false, 'message' => 'items array is required and cannot be empty'], REST_Controller::HTTP_BAD_REQUEST);
        }

        // Validate order exists
        $order = $this->order_model->get_order_row($order_id);
        if (!$order) {
            return $this->response(['status' => false, 'message' => 'Order not found'], REST_Controller::HTTP_NOT_FOUND);
        }

        // Validate each menu item exists
        foreach ($items as $item) {
            $menu_id = isset($item['item_id']) ? $item['item_id'] : (isset($item['menu_id']) ? $item['menu_id'] : null);
            if (!$menu_id || !$this->order_model->menu_item_exists($menu_id)) {
                return $this->response([
                    'status'  => false,
                    'message' => 'Invalid menu_id: ' . $menu_id
                ], REST_Controller::HTTP_BAD_REQUEST);
            }
        }

        $result = $this->order_model->add_items_to_order($order_id, $items, $this->current_user->user_id);
        if (!$result) {
            return $this->response([
                'success' => false,
                'message' => 'Failed to add items to order',
                'data'    => []
            ], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
        }

        return $this->response([
            'success'  => true,
            'message'  => 'Items added to order successfully',
            'data'     => ['order_id' => $order_id]
        ], REST_Controller::HTTP_OK);
    }

    /** POST /WS/update_item - Update items in an existing order */
    public function update_item()
    {
        if ($this->authenticate() !== true)
            return;

        $input = $this->post();
        if (empty($input)) {
            $input = json_decode($this->input->raw_input_stream, true);
        }

        $order_id = isset($input['order_id']) ? intval($input['order_id']) : null;
        $items    = isset($input['items']) && is_array($input['items']) ? $input['items'] : [];

        if (!$order_id) {
            return $this->response([
                'success' => false,
                'message' => 'order_id is required',
                'data'    => []
            ], REST_Controller::HTTP_BAD_REQUEST);
        }
        if (empty($items)) {
            return $this->response([
                'success' => false,
                'message' => 'items array is required and cannot be empty',
                'data'    => []
            ], REST_Controller::HTTP_BAD_REQUEST);
        }

        // Validate order exists
        $order = $this->order_model->get_order_row($order_id);
        if (!$order) {
            return $this->response([
                'success' => false,
                'message' => 'Order not found',
                'data'    => []
            ], REST_Controller::HTTP_NOT_FOUND);
        }

        $result = $this->order_model->update_item_in_order($order_id, $items, $this->current_user->user_id);
        if (!$result) {
            return $this->response([
                'success' => false,
                'message' => 'Failed to update order items',
                'data'    => []
            ], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
        }

        return $this->response([
            'success'  => true,
            'message'  => 'Order items updated successfully',
            'data'     => ['order_id' => $order_id]
        ], REST_Controller::HTTP_OK);
    }

    /** GET /WS/get_order_details?id={order_id} - Get single order details */
    public function get_order_details($id = null)
    {
        if ($this->authenticate() !== true)
            return;

        if (is_array($id) && isset($id['id'])) {
            $id = $id['id'];
        } elseif (is_array($id)) {
            $id = null;
        }

        if (!$id) {
            $id = $this->param('id');
        }

        if (empty($id)) {
            return $this->response(['success' => false, 'status' => false, 'message' => 'Order ID is required'], REST_Controller::HTTP_BAD_REQUEST);
        }

        $o = $this->order_model->get($id);
       
        if (!$o)
            return $this->response(['success' => false, 'status' => false, 'message' => 'Order not found'], REST_Controller::HTTP_NOT_FOUND);
        
        return $this->response(['success' => true,'status' => true, 'message' => 'Order details fetched successfully', 'data' => $o], REST_Controller::HTTP_OK);
    }

    /** GET /WS/gets_orders - List all orders */
    public function gets_orders()
    {   
        if ($this->authenticate() !== true)
            return;

        $filters = [];
        $filters['user_id'] = $this->current_user->user_id;
        
        $restaurant_id = $this->param('restaurant_id');
        if (empty($restaurant_id))
        {
            return $this->response([
                'success' => false,
                'status' => false,
                'message' => 'The restaurant_id field is required.',
                'data' => []
            ], REST_Controller::HTTP_BAD_REQUEST);
        }

        $filters['restaurant_id'] = $restaurant_id;

        $list = $this->order_model->list($filters);
        return $this->response(['success' => true,'status' => true, 'message' => 'Orders fetched successfully', 'data' => $list], REST_Controller::HTTP_OK);
    }

    // Keep old endpoints for backward compatibility
    public function index_post()
    {
        return $this->new_orders();
    }

    public function index($id = null)
    {   
        if ($id) {
            return $this->get_order_details($id);
        }
        return $this->gets_orders();
    }

    public function index_get($id = null)
    {
        return $this->index($id);
    }
}
