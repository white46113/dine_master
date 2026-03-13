<div class="max-w-4xl mx-auto">
    <div class="bg-white rounded-3xl shadow-sm border border-gray-100 overflow-hidden">
        <div class="p-8">
            <div class="flex items-center space-x-4 mb-8">
                <div class="w-16 h-16 rounded-2xl bg-blue-600 flex items-center justify-center text-white text-2xl font-bold shadow-lg shadow-blue-500/20">
                    <%$admin_user.user_name|substr:0:1|upper%>
                </div>
                <div>
                    <h2 class="text-2xl font-black text-gray-800"><%$admin_user.user_name%></h2>
                    <p class="text-gray-500 font-medium"><%$admin_user.user_email%></p>
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <div class="md:col-span-1">
                    <h3 class="text-sm font-black text-gray-400 uppercase tracking-widest mb-2">Change Password</h3>
                    <p class="text-xs text-gray-500 leading-relaxed">
                        Update your login credentials here. We recommend using a strong password with at least 8 characters.
                    </p>
                </div>

                <div class="md:col-span-2">
                    <form id="password-form" class="space-y-4">
                        <div>
                            <label class="block text-xs font-bold text-gray-500 uppercase tracking-wider mb-2">Current Password</label>
                            <input type="password" name="current_password" required
                                class="w-full px-4 py-3 rounded-xl border border-gray-100 bg-gray-50 focus:bg-white focus:border-blue-500 focus:ring-4 focus:ring-blue-500/10 outline-none transition-all">
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label class="block text-xs font-bold text-gray-500 uppercase tracking-wider mb-2">New Password</label>
                                <input type="password" name="new_password" id="new_password" required
                                    class="w-full px-4 py-3 rounded-xl border border-gray-100 bg-gray-50 focus:bg-white focus:border-blue-500 focus:ring-4 focus:ring-blue-500/10 outline-none transition-all">
                            </div>
                            <div>
                                <label class="block text-xs font-bold text-gray-500 uppercase tracking-wider mb-2">Confirm New Password</label>
                                <input type="password" name="confirm_password" required
                                    class="w-full px-4 py-3 rounded-xl border border-gray-100 bg-gray-50 focus:bg-white focus:border-blue-500 focus:ring-4 focus:ring-blue-500/10 outline-none transition-all">
                            </div>
                        </div>

                        <div class="pt-4">
                            <button type="submit" 
                                class="px-8 py-3 bg-blue-600 text-white font-bold rounded-xl shadow-lg shadow-blue-600/20 hover:bg-blue-700 transform active:scale-95 transition-all">
                                Update Password
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .error { color: #ef4444; font-size: 0.75rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.025em; margin-top: 0.25rem; display: block; }
    input.error { border-color: #ef4444; background-color: #fef2f2; }
</style>

<script>
$(document).ready(function() {
    $("#password-form").validate({
        rules: {
            current_password: {
                required: true
            },
            new_password: {
                required: true,
                minlength: 6
            },
            confirm_password: {
                required: true,
                equalTo: "#new_password"
            }
        },
        messages: {
            current_password: {
                required: "Current password is required"
            },
            new_password: {
                required: "Please provide a new password",
                minlength: "Password must be at least 6 characters"
            },
            confirm_password: {
                required: "Please confirm your new password",
                equalTo: "Passwords do not match"
            }
        },
        errorElement: 'span',
        errorClass: 'error',
        submitHandler: function(form) {
            const btn = $(form).find('button[type="submit"]');
            const originalText = btn.text();
            
            btn.prop('disabled', true).text('Updating...');

            $.ajax({
                url: '<%base_url("admin_auth/profile/update_password")%>',
                type: 'POST',
                data: $(form).serialize(),
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Success!',
                            text: response.message,
                            timer: 2000,
                            showConfirmButton: false
                        }).then(() => {
                            window.location.reload();
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Oops...',
                            text: response.message
                        });
                    }
                },
                error: function() {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Something went wrong. Please try again.'
                    });
                },
                complete: function() {
                    btn.prop('disabled', false).text(originalText);
                }
            });
            return false; // Prevent traditional form submittal
        }
    });
});
</script>
