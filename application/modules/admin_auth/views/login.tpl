<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Dine Master Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; }
        .gradient-bg { 
            background: linear-gradient(135deg, rgba(30,41,59,0.85) 0%, rgba(15,23,42,0.95) 100%), 
                        url('https://images.unsplash.com/photo-1555396273-367ea4eb4db5?q=80&w=1974&auto=format&fit=crop') center/cover no-repeat fixed; 
        }
    </style>
</head>
<body class="gradient-bg min-h-screen flex items-center justify-center p-4">

    <div class="max-w-md w-full">
        <div class="bg-white rounded-2xl shadow-2xl overflow-hidden transform transition-all hover:scale-[1.01]">
            <div class="p-8">
                <div class="flex justify-center mb-8">
                    <div class="w-16 h-16 bg-blue-600 rounded-xl flex items-center justify-center shadow-lg shadow-blue-500/50">
                        <i class="fa-solid fa-utensils text-3xl text-white"></i>
                    </div>
                </div>

                <div class="text-center mb-10">
                    <h2 class="text-3xl font-bold text-gray-800">Welcome Back</h2>
                    <p class="text-gray-500 mt-2">Sign in to manage your restaurant</p>
                </div>

                <form id="loginForm" class="space-y-6">
                    <div>
                        <label class="block text-sm font-semibold text-gray-700 mb-2">Username or Email</label>
                        <div class="relative">
                            <span class="absolute inset-y-0 left-0 pl-3 flex items-center text-gray-400">
                                <i class="fa-solid fa-user"></i>
                            </span>
                            <input type="text" name="username" required 
                                class="block w-full pl-10 pr-3 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all outline-none" 
                                placeholder="Enter your username">
                        </div>
                    </div>

                    <div>
                        <div class="flex justify-between mb-2">
                            <label class="block text-sm font-semibold text-gray-700">Password</label>
                            <a href="<%base_url('admin/login/forgot_password')%>" class="text-sm font-semibold text-blue-600 hover:text-blue-500">Forgot?</a>
                        </div>
                        <div class="relative">
                            <span class="absolute inset-y-0 left-0 pl-3 flex items-center text-gray-400">
                                <i class="fa-solid fa-lock"></i>
                            </span>
                            <input type="password" id="password" name="password" required 
                                class="block w-full pl-10 pr-12 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all outline-none" 
                                placeholder="••••••••">
                            <button type="button" id="togglePassword" class="absolute inset-y-0 right-0 pr-4 flex items-center text-gray-400 hover:text-gray-600 transition-colors">
                                <i class="fa-solid fa-eye" id="eyeIcon"></i>
                            </button>
                        </div>
                    </div>

                    <div class="flex items-center">
                        <input type="checkbox" id="remember" class="w-4 h-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500">
                        <label for="remember" class="ml-2 text-sm text-gray-600">Remember me for 30 days</label>
                    </div>

                    <button type="submit" id="submitBtn"
                        class="w-full bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-4 rounded-xl transition-all shadow-lg shadow-blue-500/30 flex items-center justify-center">
                        <span>Sign In</span>
                        <i class="fa-solid fa-arrow-right ml-2 text-sm"></i>
                    </button>
                </form>
            </div>

            <div class="px-8 py-6 bg-gray-50 border-t border-gray-100 text-center">
                <p class="text-sm text-gray-600">
                    Proprietary system of <span class="font-bold text-gray-800">Dine Master</span>.
                </p>
            </div>
        </div>
        
        <p class="text-center text-gray-400 text-xs mt-8 uppercase tracking-widest drop-shadow-md">
            Authorized Personnel Only
        </p>
        <p class="text-center text-gray-400/60 text-[10px] mt-2 uppercase tracking-widest font-semibold drop-shadow-md">
            All copyrights reserved by Code Crafter Infotech
        </p>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!-- Custom Global Toasts (Replaces Swal success/error) -->
    <script>
    function showToast(type, title, message) {
        const container = document.getElementById('toast-container') || (function() {
            const div = document.createElement('div');
            div.id = 'toast-container';
            div.className = 'fixed top-6 right-6 z-[9999] flex flex-col gap-4 max-w-sm w-full';
            document.body.appendChild(div);
            return div;
        })();

        const isSuccess = type === 'success';
        const bgColor = isSuccess ? 'bg-[#c6f0c2]' : 'bg-[#fecdd3]';
        const iconColor = isSuccess ? 'text-green-500' : 'text-red-500';
        const iconClass = isSuccess ? 'fa-check' : 'fa-exclamation';
        const darkBlobClass = isSuccess ? 'bg-green-300' : 'bg-red-300';

        const blobs = `
            <div class="absolute -left-4 -top-4 w-24 h-24 ${darkBlobClass} rounded-full mix-blend-multiply filter blur-xl opacity-40"></div>
            <div class="absolute -right-4 -bottom-4 w-24 h-24 ${darkBlobClass} rounded-full mix-blend-multiply filter blur-xl opacity-40"></div>
        `;

        const toastHTML = `
            <div class="relative overflow-hidden w-full ${bgColor} rounded-[2rem] p-5 flex items-start gap-4 shadow-2xl transform transition-all duration-300 translate-x-full opacity-0 pointer-events-auto border border-white/40">
                ${blobs}
                <div class="relative z-10 flex-shrink-0 w-12 h-12 bg-white rounded-full flex items-center justify-center shadow-sm">
                    <i class="fa-solid ${iconClass} ${iconColor} text-xl"></i>
                </div>
                <div class="relative z-10 flex-1 min-w-0 pr-6 pt-1">
                    <h4 class="text-sm font-black text-gray-900 mb-1 truncate tracking-tight text-opacity-90">${title}</h4>
                    <p class="text-[11px] font-bold text-gray-700 leading-tight tracking-wide text-opacity-70">${message}</p>
                </div>
                <button class="relative z-10 absolute top-5 right-5 text-gray-500 hover:text-gray-800 transition-colors" onclick="this.closest('.relative').remove()">
                    <i class="fa-solid fa-xmark"></i>
                </button>
            </div>
        `;

        const tempDiv = document.createElement('div');
        tempDiv.innerHTML = toastHTML.trim();
        const toastEl = tempDiv.firstChild;
        
        container.appendChild(toastEl);
        
        requestAnimationFrame(() => {
            toastEl.classList.remove('translate-x-full', 'opacity-0');
            toastEl.classList.add('translate-x-0', 'opacity-100');
        });

        setTimeout(() => {
            if(toastEl.parentNode) {
                toastEl.classList.remove('translate-x-0', 'opacity-100');
                toastEl.classList.add('translate-x-full', 'opacity-0');
                setTimeout(() => toastEl.remove(), 300);
            }
        }, 4000);
    }

    // Intercept Swal.fire
    const originalSwalFire = Swal.fire;
    Swal.fire = function(...args) {
        let config = args[0];
        let type = null;
        let title = '';
        let message = '';
        let timer = 0;

        if (typeof config === 'string') {
            title = args[0];
            message = args[1] || '';
            type = args[2];
        } else if (config && typeof config === 'object') {
            type = config.icon;
            title = config.title || '';
            message = config.text || '';
            timer = config.timer || 0;
        }

        if (type === 'success' || type === 'error') {
            showToast(type, title || (type === 'success' ? 'Success' : 'Error'), message);
            
            return new Promise((resolve) => {
                const delay = timer > 0 ? timer : 2000;
                setTimeout(() => {
                    resolve({ isConfirmed: true, isDismissed: true });
                }, delay);
            });
        }
        
        return originalSwalFire.apply(this, args);
    };
    </script>

    <script>
        $(document).ready(function() {
            // Password toggle functionality
            $('#togglePassword').on('click', function() {
                const passwordField = $('#password');
                const eyeIcon = $('#eyeIcon');
                
                if (passwordField.attr('type') === 'password') {
                    passwordField.attr('type', 'text');
                    eyeIcon.removeClass('fa-eye').addClass('fa-eye-slash');
                } else {
                    passwordField.attr('type', 'password');
                    eyeIcon.removeClass('fa-eye-slash').addClass('fa-eye');
                }
            });

            $('#loginForm').on('submit', function(e) {
                e.preventDefault();
                
                const btn = $('#submitBtn');
                const btnContent = btn.html();
                
                // Loading state
                btn.prop('disabled', true).html('<i class="fa-solid fa-circle-notch fa-spin mr-2"></i> Signing in...');

                $.ajax({
                    url: '<%base_url("admin_auth/authenticate")%>',
                    type: 'POST',
                    data: $(this).serialize(),
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Success!',
                                text: response.message,
                                timer: 1500,
                                showConfirmButton: false
                            }).then(() => {
                                window.location.href = response.redirect;
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Login Failed',
                                text: response.message,
                                confirmButtonColor: '#3b82f6'
                            });
                            btn.prop('disabled', false).html(btnContent);
                        }
                    },
                    error: function() {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'An unexpected error occurred. Please try again.',
                            confirmButtonColor: '#3b82f6'
                        });
                        btn.prop('disabled', false).html(btnContent);
                    }
                });
            });
        });
    </script>
</body>
</html>
