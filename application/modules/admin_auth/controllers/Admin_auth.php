<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Admin_auth extends Admin_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Admin_auth_model');
    }

    /**
     * Display Login Page
     */
    public function login()
    {
        if ($this->is_admin_logged_in()) {
            redirect(base_url('admin/dashboard'));
        }

        $data['title'] = 'Admin Login | Dine Master';
        $this->smarty->display('login.tpl');
    }

    /**
     * Handle Authentication AJAX
     */
    public function authenticate()
    {
        $username = $this->input->post('username');
        $password = $this->input->post('password');

        if (empty($username) || empty($password)) {
            echo json_encode(['success' => false, 'message' => 'Please enter both username and password.']);
            return;
        }

        $user = $this->Admin_auth_model->get_user_by_username($username);

        if ($user && password_verify($password, $user['user_password'])) {
            if ($user['status'] !== 'Active') {
                echo json_encode(['success' => false, 'message' => 'Your account is inactive. Please contact support.']);
                return;
            }

            // Set Session
            $session_data = [
                'admin_user_id' => $user['user_id'],
                'admin_user' => [
                    'user_id'       => $user['user_id'],
                    'user_name'     => $user['user_name'],
                    'user_email'    => $user['user_email'],
                    'role_id'       => $user['user_role'],
                    'user_role'     => $user['user_role'],
                    'role_name'     => isset($user['role_name']) ? $user['role_name'] : 'Admin',
                    'restaurant_id' => $user['restaurant_id']
                ]
            ];
            $this->session->set_userdata($session_data);

            // Update last login
            $this->Admin_auth_model->update_last_login($user['user_id']);

            echo json_encode(['success' => true, 'message' => 'Login successful! Redirecting...', 'redirect' => base_url('admin/dashboard')]);
        } else {
            echo json_encode(['success' => false, 'message' => 'Invalid username or password.']);
        }
    }

    /**
     * Logout
     */
    public function logout()
    {
        $this->session->unset_userdata('admin_user_id');
        $this->session->unset_userdata('admin_user');
        $this->session->sess_destroy();
        redirect(base_url('admin/login'));
    }

    /**
     * Forgot Password Page
     */
    public function forgot_password()
    {
        $data['title'] = 'Forgot Password | Dine Master';
        $this->smarty->display('forgot_password.tpl');
    }

    /**
     * Send Reset Link AJAX
     */
    public function send_reset_link()
    {
        $email = $this->input->post('email');
        if (empty($email)) {
            echo json_encode(['success' => false, 'message' => 'Please enter your email address.']);
            return;
        }

        $user = $this->Admin_auth_model->get_user_by_username($email);
        if (!$user) {
            echo json_encode(['success' => false, 'message' => 'Email address not found in our records.']);
            return;
        }

        // Generate Token
        $token = bin2hex(random_bytes(32));
        $expiry = date('Y-m-d H:i:s', strtotime('+1 hour'));

        if ($this->Admin_auth_model->update_reset_token($email, $token, $expiry)) {
            // Send Email
            $reset_link = base_url('admin_auth/reset_password/' . $token);
            
            $this->load->library('phpmailer_lib');
            $mail = $this->phpmailer_lib->load();
            
            try {
                // SMTP Configuration
                $mail->isSMTP();
                $mail->Host       = $this->config->item('smtp_host');
                $mail->SMTPAuth   = true;
                $mail->Username   = $this->config->item('smtp_user');
                $mail->Password   = $this->config->item('smtp_pass');
                $mail->SMTPSecure = $this->config->item('smtp_crypto');
                $mail->Port       = $this->config->item('smtp_port');

                // Email components: to, subject, message
                $mail->setFrom($this->config->item('smtp_from_email'), $this->config->item('smtp_from_name'));
                $mail->clearAddresses();
                $mail->addAddress($email);
                $mail->isHTML(true);
                $mail->Subject = 'Password Reset Request - Dine Master';
                $mail->Body    = "
                    <div style='font-family: sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #eee; border-radius: 10px;'>
                        <h2 style='color: #2563eb;'>Password Reset Request</h2>
                        <p>You requested a password reset for your Dine Master Admin account.</p>
                        <p>Please click the button below to reset your password. This link will expire in 1 hour.</p>
                        <div style='text-align: center; margin: 30px 0;'>
                            <a href='{$reset_link}' style='background-color: #2563eb; color: white; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold;'>Reset Password</a>
                        </div>
                        <p style='color: #666; font-size: 12px;'>If you're having trouble clicking the button, copy and paste the link below into your web browser:</p>
                        <p style='color: #666; font-size: 12px;'>{$reset_link}</p>
                        <hr style='border: 0; border-top: 1px solid #eee; margin: 20px 0;'>
                        <p style='color: #999; font-size: 12px;'>If you did not request this, please ignore this email.</p>
                    </div>
                ";

                if ($mail->send()) {
                    echo json_encode(['success' => true, 'message' => 'A password reset link has been sent to your email.']);
                } else {
                    echo json_encode(['success' => false, 'message' => 'Failed to send email. Error: ' . $mail->ErrorInfo]);
                }
            } catch (\Exception $e) {
                echo json_encode(['success' => false, 'message' => "An error occurred: {$e->getMessage()}"]);
            } catch (\Throwable $t) {
                echo json_encode(['success' => false, 'message' => "A critical system error occurred."]);
            }
        }
    }

    /**
     * Reset Password Page
     */
    public function reset_password($token = NULL)
    {
        if (!$token) {
            redirect(base_url('admin/login'));
        }

        $user = $this->Admin_auth_model->get_user_by_reset_token($token);
        if (!$user) {
            $this->session->set_flashdata('error', 'Invalid or expired reset token.');
            redirect(base_url('admin/login'));
        }

        $data['title'] = 'Reset Password | Dine Master';
        $data['token'] = $token;
        $this->smarty->assign($data);
        $this->smarty->display('reset_password.tpl');
    }

    /**
     * Update New Password AJAX
     */
    public function update_new_password()
    {
        $token = $this->input->post('token');
        $password = $this->input->post('password');
        $confirm_password = $this->input->post('confirm_password');

        if (empty($password) || empty($confirm_password)) {
            echo json_encode(['success' => false, 'message' => 'Please fill in all fields.']);
            return;
        }

        if ($password !== $confirm_password) {
            echo json_encode(['success' => false, 'message' => 'Passwords do not match.']);
            return;
        }

        $user = $this->Admin_auth_model->get_user_by_reset_token($token);
        if (!$user) {
            echo json_encode(['success' => false, 'message' => 'Invalid or expired reset token.']);
            return;
        }

        $hashed_password = password_hash($password, PASSWORD_DEFAULT);
        if ($this->Admin_auth_model->update_password($user['user_id'], $hashed_password)) {
            echo json_encode(['success' => true, 'message' => 'Password reset successful! You can now log in.', 'redirect' => base_url('admin/login')]);
        } else {
            echo json_encode(['success' => false, 'message' => 'Failed to reset password. Please try again.']);
        }
    }
}
