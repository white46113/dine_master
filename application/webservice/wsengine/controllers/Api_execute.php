<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class api_execute extends MX_Controller {

	/**
	 * Index Page for this controller.
	 *
	 * Maps to the following URL
	 * 		http://example.com/index.php/welcome
	 *	- or -
	 * 		http://example.com/index.php/welcome/index
	 *	- or -
	 * Since this controller is set as the default controller in
	 * config/routes.php, it's displayed at http://example.com/
	 *
	 * So any other public methods not prefixed with an underscore will
	 * map to /index.php/welcome/<method_name>
	 * @see https://codeigniter.com/userguide3/general/urls.html
	 */
	public function __construct(){

	    parent::__construct();
	    //load database

	  }
	public function wscontroller()
	{
		
		$this->config->load('api_config', TRUE);
		$all_methods = $this->config->item('api_config');
		$api_method_name = $this->uri->segments[2];
		if(array_key_exists($api_method_name, $all_methods)){
			require APPPATH.'libraries/REST_Controller.php';
			
			/* get api method details */
			$method_details = $all_methods[$api_method_name];
			/* create api path */
			
			$api_path = $method_details['folder']."/controllers/".ucfirst($api_method_name);
			// $this->load->module('user/user_login');
			$this->load->module($method_details['folder'] . "/" . $api_method_name);

			// Now you can access the module instance through $this
			$className = ucfirst($api_method_name); 
	        $api_instant = new $className(); 
            
	        /* call respective api */
	        if($this->input->server('REQUEST_METHOD') == "GET"){
	        	$this->$api_method_name->index_get();
				
	        }else if($this->input->server('REQUEST_METHOD') == "POST"){
	        	 $this->$api_method_name->index_post();
	        }

		}else{
          
			require_once(APPPATH.'controllers/Api_response.php');
			$api_instant = new Api_response(); 
			$return_arr = array(
		        "success" => 0,
		        "message" => "API code does not exist.",
		    );
		    $return_arr = array(
		        "success" => 0,
		        "message" => "API code does not exist.",
		        "data" => []
		    );
		    $server_error = REST_Controller::HTTP_OK;
		    $api_instant->response_return($return_arr,$server_error);
		}
		
		
	}
}
