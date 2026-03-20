<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Api_docs extends CI_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->library('session');
        $this->load->helper('url');
    }

    public function index() {
        // Enforce Super Admin only
        $admin_data = $this->session->userdata('admin_user');
        if (!$admin_data || ($admin_data['role_id'] != 1 && $admin_data['user_role'] != 1)) {
            show_404();
        }

        $data['title'] = "Dine Master API Reference";
        
        // Define all APIs in a structured array
        $data['apis'] = [
            [
                'category' => 'Auth',
                'name' => 'User Login',
                'url' => '/WS/auth/login',
                'method' => 'POST',
                'params' => [
                    ['name' => 'email', 'type' => 'string', 'description' => 'User email address'],
                    ['name' => 'password', 'type' => 'string', 'description' => 'User password']
                ],
                'description' => 'Authenticates a user and returns a JWT token.',
                'example_response' => '{
    "success": true,
    "message": "Login successful",
    "data": {
        "id": "1",
        "token": "eyJhbG...",
        "name": "John Doe",
        "email": "john@example.com",
        "restaurant_id": "1"
    }
}'
            ],
            [
                'category' => 'Auth',
                'name' => 'User Logout',
                'url' => '/WS/auth/logout',
                'method' => 'POST',
                'params' => [],
                'description' => 'Logs out the user and invalidates the token.',
                'example_response' => '{
    "success": true,
    "status": true,
    "message": "Logged out",
    "data": []
}'
            ],
            [
                'category' => 'Auth',
                'name' => 'Forgot Password',
                'url' => '/WS/user_login/forgot_password',
                'method' => 'POST',
                'params' => [
                    ['name' => 'email', 'type' => 'string', 'description' => 'Registered email address of the user'],
                    ['name' => 'password', 'type' => 'string', 'description' => 'New password to set']
                ],
                'description' => 'Resets the user password. Requires the registered email and the new password.',
                'example_response' => '{
    "success": true,
    "status": true,
    "message": "Password updated successfully.",
    "data": []
}'
            ],
            [
                'category' => 'User',
                'name' => 'Get User Details',
                'url' => '/WS/user_login/get_user_details',
                'method' => 'GET',
                'params' => [
                    ['name' => 'id', 'type' => 'int', 'description' => 'User ID (Optional, defaults to logged in user)']
                ],
                'description' => 'Fetches detailed information about a user.',
                'example_response' => '{
    "success": true,
    "status": true,
    "message": "User details fetched successfully",
    "data": {
        "user_id": "1",
        "user_name": "odell44",
        "user_email": "adrienne.schaden@gmail.com",
        "status": "Active",
        ...
    }
}'
            ],
            [
                'category' => 'Restaurant',
                'name' => 'Get Restaurant Details',
                'url' => '/WS/user_login/get_restaurant_details',
                'method' => 'GET',
                'params' => [
                    ['name' => 'id', 'type' => 'int', 'description' => 'User ID to fetch associated restaurant details']
                ],
                'description' => 'Fetches details of the restaurant associated with the given user.',
                'example_response' => '{
    "success": true,
    "status": true,
    "message": "Restaurant details fetched successfully",
    "data": {
        "restaurant_id": "1",
        "name": "Thiel, Batz and Labadie",
        "contact_email": "kiarra.gleason@hotmail.com",
        "city": "Lisandrobury",
        ...
    }
}'
            ],
            [
                'category' => 'Menu',
                'name' => 'Get Menu',
                'url' => '/WS/menu_items/get_menu',
                'method' => 'GET',
                'params' => [
                    ['name' => 'restaurant_id', 'type' => 'int', 'description' => 'Required. ID of the restaurant'],
                    ['name' => 'category_id', 'type' => 'int', 'description' => 'Optional. Filter by category'],
                    ['name' => 'veg_type', 'type' => 'string', 'description' => 'Optional. Filter by VEG/NON_VEG/EGG']
                ],
                'description' => 'Retrieves the menu items for a restaurant.',
                'example_response' => '{
    "success": true,
    "status": true,
    "message": "Menus found successfully.",
    "data": [
        {
            "item_id": "1",
            "item_name": "Paneer Tikka",
            "price": "250.00",
            ...
        }
    ]
}'
            ],
            [
                'category' => 'Menu',
                'name' => 'Get Item Details',
                'url' => '/WS/menu_items/get_item_details',
                'method' => 'GET',
                'params' => [
                    ['name' => 'item_id', 'type' => 'int', 'description' => 'Required. ID of the menu item']
                ],
                'description' => 'Fetches detailed information about a specific menu item.',
                'example_response' => '{
    "success": true,
    "status": true,
    "message": "Item details found successfully.",
    "data": {
        "item_id": "1",
        "item_name": "Paneer Tikka",
        "price": "250.00",
        "description": "Grilled cottage cheese cubes marinated in spices",
        ...
    }
}'
            ],
            [
                'category' => 'Menu',
                'name' => 'Get Categories',
                'url' => '/WS/categories?id={restaurant_id}',
                'method' => 'GET',
                'params' => [
                    ['name' => 'id', 'type' => 'int', 'description' => 'Required. The unique ID of the restaurant']
                ],
                'description' => 'Fetches all menu categories for a specific restaurant.',
                'example_response' => '{
    "settings": {
        "success": true,
        "message": "catagories found successfully."
    },
    "data": [
        {
            "category_id": "1",
            "category_name": "Starters",
            "category_image": "starters.jpg"
        },
        {
            "category_id": "2",
            "category_name": "Main Course",
            "category_image": "main.jpg"
        }
    ]
}'
            ],
            [
                'category' => 'Orders',
                'name' => 'gets_orders',
                'url' => '/WS/gets_orders',
                'method' => 'GET',
                'params' => [
                    ['name' => 'restaurant_id', 'type' => 'int', 'description' => 'Required. Filter orders by restaurant']
                ],
                'description' => 'Retrieves a list of orders for the authenticated user for a specific restaurant.',
                'example_response' => '{
    "settings": {
        "success": true,
        "message": "Orders fetched successfully"
    },
    "data": [
        {
            "order_id": "19",
            "restaurant_id": "4",
            "table_id": "60",
            "customer_id": "48",
            "waiter_id": "55",
            "order_type": "DINE_IN",
            "status": "PLACED",
            "placed_at": "2025-09-06 16:46:39",
            "items": [
                {
                    "id": "25",
                    "item_name": "Paneer Tikka",
                    "unit_price": "250.00",
                    "quantity": "2"
                }
            ]
        }
    ]
}'
            ],
            [
                'category' => 'Orders',
                'name' => 'get_order_details',
                'url' => '/WS/get_order_details?id={order_id}',
                'method' => 'GET',
                'params' => [
                    ['name' => 'id', 'type' => 'int', 'description' => 'Required. The unique ID of the order']
                ],
                'description' => 'Fetches detailed information about a specific order, including items and addons.',
                'example_response' => '{
    "settings": {
        "success": true,
        "message": "Order details fetched successfully"
    },
    "data": {
        "order_id": "19",
        "restaurant_id": "4",
        "table_id": "60",
        "items": [
            {
                "id": "25",
                "item_name": "Paneer Tikka",
                "unit_price": "250.00",
                "quantity": "2",
                "addons": []
            }
        ]
    }
}'
            ],
            [
                'category' => 'Orders',
                'name' => 'New Order',
                'url' => '/WS/new_orders',
                'method' => 'POST',
                'params' => [
                    ['name' => 'restaurant_id', 'type' => 'int', 'description' => 'ID of the restaurant'],
                    ['name' => 'table_no', 'type' => 'int', 'description' => 'Table number for the order'],
                    ['name' => 'items', 'type' => 'array', 'description' => 'Array of order items with IDs, names, and quantities']
                ],
                'description' => 'Creates a new order. Supports both nested "order" object or flat parameters (restaurant_id, table_no).',
                'example_response' => '{
    "settings": {
        "success": true,
        "message": "Order created successfully"
    },
    "data": {
        "order_id": 20
    }
}'
            ],
        ];

        $this->load->view('api_documentation', $data);
    }
}
