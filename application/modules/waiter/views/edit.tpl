<div class="max-w-4xl mx-auto">
    <div class="flex justify-between items-center mb-8">
        <div>
            <h2 class="text-2xl font-bold text-gray-800">Edit Restaurant Members</h2>
            <p class="text-gray-500 text-sm">Update information for waiter <span class="text-blue-600 font-bold"><%$waiter->user_name%></span></p>
        </div>
        <a href="<%base_url('admin/waiter')%>"
            class="w-12 h-12 rounded-2xl bg-white border border-gray-100 flex items-center justify-center text-gray-400 hover:text-blue-600 hover:border-blue-100 transition-all shadow-sm">
            <i class="fa-solid fa-arrow-left"></i>
        </a>
    </div>

    <form id="waiterForm" action="<%base_url('admin/waiter/edit/')%><%$waiter->user_id%>" method="POST"
          class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
        <div class="p-8 space-y-8">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <!-- Full Name -->
                <div class="space-y-2">
                    <label class="text-sm font-bold text-gray-700">Full Name <span class="text-red-500">*</span></label>
                    <input type="text" name="user_name" required placeholder="John Doe" value="<%$waiter->user_name%>"
                           class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                </div>

                <!-- Email Address -->
                <div class="space-y-2">
                    <label class="text-sm font-bold text-gray-700">Email Address <span class="text-red-500">*</span></label>
                    <input type="email" name="user_email" required placeholder="john@example.com" value="<%$waiter->user_email%>"
                           class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                </div>

                <!-- Phone Number -->
                <div class="space-y-2">
                    <label class="text-sm font-bold text-gray-700">Phone Number <span class="text-red-500">*</span></label>
                    <input type="text" name="phone" required placeholder="e.g. 555-1234" value="<%$waiter->phone%>"
                           class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                </div>

                <!-- Password -->
                <div class="space-y-2">
                    <label class="text-sm font-bold text-gray-700">Password</label>
                    <div class="relative">
                        <input type="password" name="password" placeholder="Enter new password"
                               class="w-full px-4 py-3 pr-12 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                        <button type="button" class="pwd-toggle absolute inset-y-0 right-0 pr-4 flex items-center text-gray-400 hover:text-blue-500 transition-colors"
                                onclick="togglePassword(this)">
                            <i class="fa-regular fa-eye"></i>
                        </button>
                    </div>
                </div>

                <!-- Assign to Restaurant (Super Admin only) -->
                <%if $is_superadmin%>
                <div class="space-y-2">
                    <label class="text-sm font-bold text-gray-700">Assign to Restaurant <span class="text-red-500">*</span></label>
                    <select name="restaurant_id" required
                            class="w-full select2-restaurant px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-5 outline-none transition-all">
                        <option value="">Select Restaurant</option>
                        <%foreach $restaurants as $res%>
                        <option value="<%$res.restaurant_id%>" <%if $waiter->restaurant_id == $res.restaurant_id%>selected<%/if%>><%$res.name%></option>
                        <%/foreach%>
                    </select>
                </div>
                <%/if%>

                <!-- Role Type -->
                <div class="space-y-2">
                    <label class="text-sm font-bold text-gray-700">Role Type <span class="text-red-500">*</span></label>
                    <select name="user_role" required class="w-full select2-role px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-5 outline-none transition-all">
                        <%foreach $roles as $role%>
                        <%if $role.role_id != 1%>
                        <option value="<%$role.role_id%>" <%if $waiter->user_role == $role.role_id%>selected<%/if%>><%$role.name%></option>
                        <%/if%>
                        <%/foreach%>
                    </select>
                </div>

                <!-- Active Account -->
                <div class="flex items-center p-4 bg-gray-50 rounded-2xl">
                    <div class="flex-1">
                        <h4 class="font-bold text-gray-800 text-sm">Active Account</h4>
                        <p class="text-xs text-gray-500">Toggling this will grant or revoke access.</p>
                    </div>
                    <label class="relative inline-flex items-center cursor-pointer">
                        <input type="checkbox" name="status" value="1" class="sr-only peer" <%if $waiter->status == 'Active'%>checked<%/if%>>
                        <div class="w-11 h-6 bg-gray-200 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full 
                                    peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] 
                                    after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all 
                                    peer-checked:bg-blue-600"></div>
                    </label>
                </div>
            </div>

            <div class="bg-gray-50 px-8 py-5 flex justify-end space-x-3">
                <a href="<%base_url('admin/waiter')%>"
                    class="bg-white hover:bg-gray-100 text-gray-700 font-bold py-2.5 px-6 rounded-xl transition-all border border-gray-200 ml-auto">Cancel</a>
                <button type="submit"
                    class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2.5 px-8 rounded-xl transition-all shadow-lg shadow-blue-500/30">
                    Update Waiter
                </button>
            </div>
        </div>
    </form>

    <!-- Load Select2 & Validation -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
    <script>
    $(document).ready(function(){
        $('.select2-role').select2({placeholder:'Select Role', allowClear:true, width:'100%'}).on('change', function(){ $(this).valid(); });
        $('.select2-restaurant').select2({placeholder:'Select Restaurant', allowClear:true, width:'100%'}).on('change', function(){ $(this).valid(); });

        $.validator.setDefaults({
            errorElement: 'p',
            errorClass: 'text-sm text-red-500 mt-1',
            errorPlacement: function(error, element){
                if (element.hasClass('select2-hidden-accessible') || element.prop('tagName') === 'SELECT'){
                    error.insertAfter(element.next('.select2-container'));
                } else {
                    error.insertAfter(element);
                }
            },
            highlight: function(element){
                $(element).addClass('border-red-500 focus:ring-red-100 focus:border-red-500')
                          .removeClass('border-gray-200 focus:ring-blue-100 focus:border-blue-400');
            },
            unhighlight: function(element){
                $(element).removeClass('border-red-500 focus:ring-red-100 focus:border-red-500')
                          .addClass('border-gray-200 focus:ring-blue-100 focus:border-blue-400');
            }
        });

        $('#waiterForm').validate({
            rules:{
                user_name:{required:true, minlength:2, maxlength:100},
                user_email:{required:true, email:true},
                phone:{required:true},
                user_role:{required:true},
                restaurant_id:{required:true}
            },
            messages:{
                user_name:{required:'Please enter full name', minlength:'Name must be at least 2 chars', maxlength:'Name too long'},
                user_email:{required:'Please enter email', email:'Enter a valid email'},
                phone:{required:'Please enter phone number'},
                user_role:{required:'Select a role'},
                restaurant_id:{required:'Select a restaurant'}
            },
            submitHandler: function(form) {
                $.ajax({
                    url: $(form).attr('action'),
                    type: 'POST',
                    data: $(form).serialize(),
                    dataType: 'json',
                    success: function(res) {
                        if (res.success) {
                            toastr.success(res.message, 'Success', {
                                timeOut: 2000,
                                closeButton: true,
                                progressBar: true
                            });
                            setTimeout(function() {
                                window.location.href = res.redirect;
                            }, 2000);
                        } else {
                            toastr.error(res.message || 'Something went wrong.', 'Error');
                        }
                    },
                    error: function(xhr) {
                        var resp = xhr.responseJSON || {};
                        toastr.error(resp.message || 'Something went wrong.', 'Error');
                    }
                });
                return false;
            }
        });
    });
    </script>
    <style>
    .select2-container .select2-selection--single {
        background-color: #ffffff !important;
        border: 1px solid #e5e7eb !important;
        border-radius: 0.75rem !important;
        height: 48px !important;
        padding-left: 0.75rem !important;
        display: flex;
        align-items: center;
        transition: all 0.2s;
    }
    .select2-container .select2-selection--single .select2-selection__rendered {
        color: #374151 !important;
        font-weight: 400;
        padding-left: 0.25rem;
        line-height: 48px !important;
    }
    .select2-container .select2-selection--single .select2-selection__placeholder {color:#9ca3af !important;}
    .select2-container .select2-selection--single .select2-selection__arrow {
        height: 48px !important;
        right: 8px !important;
    }
    .select2-container--default.select2-container--focus .select2-selection--single,
    .select2-container--default.select2-container--open .select2-selection--single{
        border-color:#3b82f6 !important;
        box-shadow:0 0 0 2px rgba(59,130,246,0.2) !important;
    }
    .select2-dropdown{
        border:1px solid #e5e7eb !important;
        border-radius:0.75rem !important;
        box-shadow:0 4px 6px -1px rgba(0,0,0,0.1),0 2px 4px -2px rgba(0,0,0,0.1) !important;
        overflow:hidden;
        margin-top:4px;
    }
    .select2-search__field{
        border-radius:0.5rem !important;
        border:1px solid #e5e7eb !important;
        padding:0.5rem 0.75rem !important;
        outline:none !important;
    }
    .select2-search__field:focus{
        border-color:#3b82f6 !important;
        box-shadow:0 0 0 2px rgba(59,130,246,0.2) !important;
    }
    .select2-results__option{
        padding:0.625rem 1rem !important;
        font-weight:400;
        color:#374151;
        transition:all 0.15s;
    }
    .select2-container--default .select2-results__option--highlighted[aria-selected]{
        background-color:#3b82f6 !important;
        color:white !important;
    }
    .select2-container--default .select2-results__option[aria-selected=true]{
        background-color:#eff6ff !important;
        color:#3b82f6 !important;
    }
    </style>
</div>
