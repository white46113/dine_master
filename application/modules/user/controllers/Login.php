<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Login extends MY_Controller {
	public function __construct() {
        parent::__construct();
        $this->load->model('Login_model');
    }
	public function index() {
    	header('X-Debug-Target: Login_Controller_Index');
		$data['base_url'] = base_url();
		$this->smarty->loadView('login.tpl',$data,'No','No');
	}
	public function logout()
	{

		$user_data = array();
		$this->session->set_userdata($user_data);
		unset($_SESSION["userdata"]);
		session_destroy();
		redirect(base_url("login"));
	}
	public function signin()
	{
		$login_attempt_count = $this->config->item("login_attempt");
		$login_attempt_count = !empty($login_attempt_count) ? $login_attempt_count : 5; 

		$this->form_validation->set_rules('email', ' Email', 'trim|required|min_length[3]');
		$this->form_validation->set_rules('password', ' Password', 'trim|required|min_length[3]');

		$email = trim($this->input->post('email'));
		$password = trim($this->input->post('password'));
		
		$redirect_url = "";
		$success = 0;
		$messages = "";

		$user = $this->Login_model->get_user_exist($email);	
		
		if ($user) {
			if ($user['status'] == 'Block') {
				$messages = "User temporary block!";
			} else if (password_verify($password, $user['user_password'])) {
				// Success
				$user_data = array(
					'user_id' => $user['user_id'],
					'user_email' => $user['user_email'],
					'user_login' => true,
					'user_name' => $user['user_name'],
					'type' => isset($user['type']) ? $user['type'] : '',
					'role' => $user['user_role'],
					'groups' => $user['groups']
				);
				$this->session->set_userdata($user_data);

				$group_rights = $this->Login_model->getGroupRightData($user['groups'],"");
				$this->session->set_userdata('group_rights_arr', base64_encode(json_encode($group_rights)));
				
				// Reset login attempts on success
				$this->Login_model->updateUserData(['login_attempt' => 0], $user['user_id']);

				$redirect_url = "sitemap";
				$success = 1;
				$messages = "User Login successfully";
			} else {
				// Password incorrect
				$login_attempt = $user['login_attempt'] + 1;
				if($login_attempt >= $login_attempt_count){
					$messages = "User temporary block!";
					$update_data = array(
						'status' => "Block",
						'login_attempt' => $login_attempt
					);
				} else {
					$messages = "Invalid credentials!";
					$update_data = array(
						'login_attempt' => $login_attempt,
					);
				}
				$this->Login_model->updateUserData($update_data, $user['user_id']);
			}
		} else {
			// User not found
			$messages = "Invalid credentials! (DEBUG_VERIFY: NOT FOUND)";
			$return_arr['debug'] = "User Not Found for email: " . $email;
		}
		$return_arr['redirect_url']= $redirect_url;
		$return_arr['success']=$success;
		$return_arr['messages']=$messages;
		if (isset($user) && $user) {
			$return_arr['debug'] = "User Found. ID: " . $user['user_id'] . ". Hash starts with: " . substr($user['user_password'], 0, 7);
		}
        $return_arr['DEBUG_ID'] = "UNIQUE_ID_REPLY_12345";
        header('X-Debug-Target: Login_Controller_Signin');
		echo json_encode($return_arr);
		exit;
	}
	public function reset_password(){
		$username = $this->input->post('username');
		$result = $this->Login_model->get_user_exist_check($username);	
		if(is_valid_array($result)){
	        $success = 1;
			$messages = "Password sent successfully";
			$user_id = $result['user_id'];
			$email_data = [
				"time_stramp" => time(),
				"user_id" => $user_id,
				"email_name" => "Reset Password ",
				"email_subject" => "Reset Password Of ".$this->config->item("company_name")
			];
			$this->email_sender($email_data,$result['user_email'],"forgot_password");
		}else{
			$success = 0;
			$messages = "User not exist";
		}
		$return_arr['success']=$success;
		$return_arr['messages']=$messages;
		echo json_encode($return_arr);
		exit;
		
	}
	public function reset_password_action(){
		$post_data = $this->input->post();
		$update_data = array(
	        'user_password' => $post_data['password']
	    );
	    $result = $this->Login_model->updateUserData($update_data, $post_data['user_id']);
	    $success = 0;
		$messages = "Password not reset";
	    if($result > 0){
	    	$success = 1;
			$messages = "Password reset successful!";
	    }
	    $return_arr['redirect_url'] = "login";
		$return_arr['success']=$success;
		$return_arr['messages']=$messages;
		echo json_encode($return_arr);
		exit;
	}
	public function forgot_password($timestamp="",$user_id){
		$current_time = time();
		$time_difference = $current_time - $timestamp;
		$expiry_time = $this->config->item("password_link_expiry")*60;
		$expired_link = "Yes";
		if ($time_difference <= $expiry_time) {
		    $expired_link = "No";
		}
		$data['base_url'] = base_url();
		$data['user_id'] = $user_id;
		$data['expired_link'] = $expired_link;
		$this->smarty->setTemplateDir(APPPATH.'modules/user/views/');
		$this->smarty->loadView('forgot_password.tpl',$data,'No','No');
	}
	public function site_map(){
		$data['base_url'] = base_url();
		$data['sitemap'] = true;
		$data['site_path'] = $this->config->item("site_path")."views/templates/quick_menu.tpl";
		$this->smarty->loadView('site_map.tpl',$data,'Yes','Yes');
	}

	
}

