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
    "title" => "Oder",
    "folder" => "orders",
    "method" => "GET_POST",
    "params" => array(
        
    )
);
$config["playlist_list"] = array(
    "title" => "Play List",
    "folder" => "api",
    "method" => "GET_POST",
    "params" => array(
        "email",
        "password"
    )
);
$config["song_list"] = array(
    "title" => "Song List",
    "folder" => "api",
    "method" => "GET_POST",
    "params" => array(
        "email",
        "password"
    )
);


#####GENERATED_CONFIG_SETTINGS_END#####

/* End of file cit_webservices.php */
/* Location: ./application/config/cit_webservices.php */
    
