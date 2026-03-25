<?php
defined('BASEPATH') or exit('No direct script access allowed');

#------------ Login -----------------------------
$route['default_controller'] = 'admin_auth/login';


/* admin panel */
$route['admin'] = 'dashboard/index';
$route['admin/login'] = 'admin_auth/login';
$route['admin/login/forgot_password'] = 'admin_auth/forgot_password';
$route['admin/login/reset_password/(:any)'] = 'admin_auth/reset_password/$1';
$route['admin/logout'] = 'admin_auth/logout';
$route['admin/dashboard'] = 'dashboard/index';
$route['admin/menu(.*)'] = 'menu$1';
$route['admin/orders(.*)'] = 'orders$1';
$route['admin/orders/bill/(:any)'] = 'orders/bill/$1';
$route['admin/kitchen(.*)'] = 'kitchen$1';
$route['admin/restaurant(.*)'] = 'restaurant$1';
$route['admin/tables(.*)'] = 'tables$1';
$route['admin/waiter(.*)'] = 'waiter$1';
$route['admin/subscriptions(.*)'] = 'subscriptions$1';
$route['admin/reports(.*)'] = 'reports/reports$1';


$route['user_list'] = 'user1/user_login/start';
$route['group_master'] = 'user/user/groupMaster';
$route['group_menu'] = 'user/user/groupMenu';
$route['api_docs'] = 'Api_docs/index';


// /*   api execute */
// $route['WS'] = "wsengine/api_execute/wscontroller";
// $route['WS/(:any)'] = "wsengine/api_execute/wscontroller/$1";
// $route['WS/(:any)/(:any)'] = "wsengine/api_execute/wscontroller/$1/$2";
// $route['WS/(:any)/(:any)/(:any)/(:any)'] = "wsengine/api_execute/wscontroller/$1/$2";

#------------ Order API Aliases -----------------
$route['WS/new_orders'] = "wsengine/api_execute/wscontroller/order/new_orders";
$route['WS/gets_orders'] = "wsengine/api_execute/wscontroller/order/gets_orders";
$route['WS/get_order_details'] = "wsengine/api_execute/wscontroller/order/get_order_details";
$route['WS/add_order_items'] = "wsengine/api_execute/wscontroller/order/add_order_items";
$route['WS/update_item'] = "wsengine/api_execute/wscontroller/order/update_item";
$route['WS/delete_item'] = "wsengine/api_execute/wscontroller/order/delete_item";

#------------ Tables API Alias -----------------
$route['WS/tables'] = "wsengine/api_execute/wscontroller/tables/index";

$route['WS/(.*)'] = "wsengine/api_execute/wscontroller/$1";

$GLOBALS['is_ws'] = false;
if (isset($this->uri->segments[1]) && ($this->uri->segments[1] == "WS")) {
    $GLOBALS['is_ws'] = true;
}