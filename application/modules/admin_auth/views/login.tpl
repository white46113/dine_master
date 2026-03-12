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
        .gradient-bg { background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%); }
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
                            <a href="#" class="text-sm font-semibold text-blue-600 hover:text-blue-500">Forgot?</a>
                        </div>
                        <div class="relative">
                            <span class="absolute inset-y-0 left-0 pl-3 flex items-center text-gray-400">
                                <i class="fa-solid fa-lock"></i>
                            </span>
                            <input type="password" name="password" required 
                                class="block w-full pl-10 pr-3 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all outline-none" 
                                placeholder="••••••••">
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
        
        <p class="text-center text-gray-400 text-xs mt-8 uppercase tracking-widest">
            Authorized Personnel Only
        </p>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
        $(document).ready(function() {
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
