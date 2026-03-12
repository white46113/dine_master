<?php
defined('BASEPATH') OR exit('No direct script access allowed');

$config = array();

#####GENERATED_CONFIG_SETTINGS_START#####

$config["user_login"] = array(
    "title" => "User Login",
    "folder" => "user",
    "method" => "GET_POST",
    "params" => array(
        "email",
        "password"
    )
);
$config["auth"] = array(
    "title" => "Auth",
    "folder" => "user",
    "method" => "GET_POST",
    "params" => array(
        "email",
        "password"
    )
);

$config["order"] = array(
    "title" => "Order",
    "folder" => "orders",
    "method" => "GET_POST",
    "params" => array(
        
    )
);

// New Clean Order Endpoints
$config["new_orders"] = array(
    "title" => "New Order",
    "folder" => "orders",
    "controller" => "order",
    "method" => "POST"
);
$config["gets_orders"] = array(
    "title" => "Get Orders",
    "folder" => "orders",
    "controller" => "order",
    "method" => "GET"
);
$config["get_order_details"] = array(
    "title" => "Get Order Details",
    "folder" => "orders",
    "controller" => "order",
    "method" => "GET"
);

$config["menu_items"] = array(
    "title" => "Menu",
    "folder" => "menu",
    "method" => "GET_POST",
    "params" => array(
        
    )
);
$config['categories'] = array(
    "title" => "Categories",
    "folder" => "menu",
    "method" => "GET_POST",
    "params" => array(
        
    )
);


#####GENERATED_CONFIG_SETTINGS_END#####

/* End of file cit_webservices.php */
/* Location: ./application/config/cit_webservices.php */
