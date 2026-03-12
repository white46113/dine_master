<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class api_execute extends MX_Controller {

	/**
	 * Index Page for this controller.
	 */
	public function __construct(){
	    parent::__construct();
	}

	public function wscontroller()
	{
		$this->config->load('api_config', TRUE);
		$all_methods = $this->config->item('api_config');
		
		// Use rsegments (routed segments) for better flexibility with routes.php
		// However, to keep compatibility with existing URL structures, we'll try to detect the position
		$segments = $this->uri->rsegments;
		
		// If called through wscontroller, segments[1] is api_execute, segments[2] is wscontroller
		// The API method name is usually segments[3]
		$api_method_name = $segments[3] ?? $this->uri->segments[2] ?? null;
		$api_func = $segments[4] ?? $this->uri->segments[3] ?? null;
		
		// Collect extra segments as parameters
		$extra_params = array_slice($this->uri->rsegments, 5);
		
		if($api_method_name && array_key_exists($api_method_name, $all_methods)){
			require_once APPPATH.'libraries/REST_Controller.php';
		
			/* get api method details */
			$method_details = $all_methods[$api_method_name];
			
			// Allow overriding the controller name in config
			$controller_name = $method_details['controller'] ?? $api_method_name;
			$controller_file = ucfirst($controller_name);
			
			/* create api path and load module */
			$this->load->module($method_details['folder'] . "/" . $controller_name);
            
			$request_method = $this->input->server('REQUEST_METHOD');
			$params = $request_method === 'GET' ? $this->input->get() : $this->input->post();
			
			$call_params = $extra_params;
			if (!empty($params)) {
				$call_params[] = $params;
			}

			// We need to check if the module was loaded correctly into $this
			$instance = $this->$controller_name ?? null;

			if ($instance) {
				if ($api_func && method_exists($instance, $api_func)) {
					call_user_func_array([$instance, $api_func], $call_params);
				} else {
					// Map HTTP verbs to method names
					$method_map = [
						'GET' => 'index_get',
						'POST' => 'index_post',
						'PUT' => 'index_put',
						'DELETE' => 'index_delete',
						'PATCH' => 'index_patch'
					];
					$method_to_call = $method_map[$request_method] ?? null;
					
					if ($method_to_call && method_exists($instance, $method_to_call)) {
						call_user_func_array([$instance, $method_to_call], $call_params);
					} else {
						$this->_send_error(REST_Controller::HTTP_NOT_FOUND, "API method not found.");
					}
				}
			} else {
				$this->_send_error(REST_Controller::HTTP_INTERNAL_SERVER_ERROR, "Failed to load API controller.");
			}

		}else{
			$this->_send_error(REST_Controller::HTTP_NOT_FOUND, "API code does not exist.");
		}
	}

	private function _send_error($status, $message) {
		$this->output
			->set_content_type('application/json')
			->set_status_header($status)
			->set_output(json_encode([
				'settings' => [
					"success" => false,
					"message" => $message,
				],
				"data" => []
			]));
	}
}
