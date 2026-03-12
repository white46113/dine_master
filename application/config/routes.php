<?php
defined('BASEPATH') or exit('No direct script access allowed');

#------------ Login -----------------------------
$route['default_controller'] = 'LogonDashboard/login';
// $route['login'] = 'LogonDashboard/login';
/* login & forgot password */
$route['login'] = 'user/login/index';
$route['forgot_password/(:any)/(:any)'] = 'user/login/forgot_password/$1/$2';
$route['logout'] = 'user/login/logout';
$route['login1'] = 'login_old';

/* admin panel */
$route['admin'] = 'dashboard/index';
$route['admin/login'] = 'admin_auth/login';
$route['admin/logout'] = 'admin_auth/logout';
$route['admin/dashboard'] = 'dashboard/index';
$route['admin/menu(.*)'] = 'menu$1';
$route['admin/orders(.*)'] = 'orders$1';
$route['admin/restaurant(.*)'] = 'restaurant$1';

$route['sitemap'] = 'user/login/site_map';
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

$route['WS/(.*)'] = "wsengine/api_execute/wscontroller/$1";

$GLOBALS['is_ws'] = false;
if (isset($this->uri->segments[1]) && ($this->uri->segments[1] == "WS" || $this->uri->segments[1] == "api_docs")) {
$GLOBALS['is_ws'] = true;
}