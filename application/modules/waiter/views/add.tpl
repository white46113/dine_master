<div class="max-w-4xl mx-auto">
    <div class="flex justify-between items-center mb-8">
        <div>
            <h2 class="text-2xl font-bold text-gray-800">Add New Restaurant Members</h2>
            <p class="text-gray-500 text-sm">Create a new restaurant member</p>
        </div>
        <a href="<%base_url('admin/waiter')%>" class="w-12 h-12 rounded-2xl bg-white border border-gray-100 flex items-center justify-center text-gray-400 hover:text-blue-600 hover:border-blue-100 transition-all shadow-sm">
            <i class="fa-solid fa-arrow-left"></i>
        </a>
    </div>

    <form id="waiterForm" action="<%base_url('admin/waiter/add')%>" method="POST" class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
        <div class="p-8 space-y-8">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <!-- Name -->
                <div class="space-y-2">
                    <label class="text-sm font-bold text-gray-700">Full Name <span class="text-red-500">*</span></label>
                    <input type="text" name="user_name" required placeholder="John Doe"
                           class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                </div>

                <!-- Email -->
                <div class="space-y-2">
                    <label class="text-sm font-bold text-gray-700">Email Address <span class="text-red-500">*</span></label>
                    <input type="email" name="user_email" required placeholder="john@example.com"
                           class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                </div>

                <!-- Phone -->
                <div class="space-y-2">
                    <label class="text-sm font-bold text-gray-700">Phone Number <span class="text-red-500">*</span></label>
                    <input type="text" name="phone" required placeholder="e.g. 555-1234"
                           class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                </div>

                <!-- Password -->
                <div class="space-y-2">
                    <label class="text-sm font-bold text-gray-700">Password <span class="text-red-500">*</span></label>
                    <div class="relative">
                        <input type="password" name="password" required placeholder="Enter password"
                               class="w-full px-4 py-3 pr-12 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                        <button type="button" class="pwd-toggle absolute inset-y-0 right-0 pr-4 flex items-center text-gray-400 hover:text-blue-500 transition-colors" onclick="togglePassword(this)">
                            <i class="fa-regular fa-eye"></i>
                        </button>
                    </div>
                </div>

            </div>

            <!-- Restaurant Selection (Super Admin only) -->
            <%if $is_superadmin%>
            <div class="space-y-2">
                <label class="text-sm font-bold text-gray-700">Assign to Restaurant <span class="text-red-500">*</span></label>
                <select name="restaurant_id" required class="w-full select2-restaurant px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all" style="width:100%"><%foreach $restaurants as $res%>
                    <option value="<%$res.restaurant_id%>"><%$res.name%></option>
                    <%/foreach%>
                </select>
            </div>
            <%/if%>

            <!-- Role Type -->
            <div class="space-y-2">
                <label class="text-sm font-bold text-gray-700">Role Type <span class="text-red-500">*</span></label>
                <select name="user_role" required class="w-full select2-role px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all" style="width:100%"><%foreach $roles as $role%>
                    <%if $role.role_id != 1%>
                    <option value="<%$role.role_id%>"><%$role.name%></option>
                    <%/if%>
                    <%/foreach%>
                </select>
            </div>

            <!-- Active Status -->
            <div class="flex items-center p-4 bg-gray-50 rounded-2xl">
                <div class="flex-1">
                    <h4 class="font-bold text-gray-800 text-sm">Active Account</h4>
                    <p class="text-xs text-gray-500">Toggling this will grant or revoke access.</p>
                </div>
                <label class="relative inline-flex items-center cursor-pointer">
                    <input type="checkbox" name="status" value="1" class="sr-only peer" checked>
                    <div class="w-11 h-6 bg-gray-200 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-blue-600"></div>
                </label>
            </div>
        </div>

        <div class="bg-gray-50 px-8 py-5 flex justify-end space-x-3">
            <a href="<%base_url('admin/waiter')%>"
                class="bg-white hover:bg-gray-100 text-gray-700 font-bold py-2.5 px-6 rounded-xl transition-all border border-gray-200 ml-auto">Cancel</a>
            <button type="submit"
                class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2.5 px-8 rounded-xl transition-all shadow-lg shadow-blue-500/30">
                Save Account
            </button>
        </div>
    </form>
    <!-- Load Select2 & Validation -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
<style>

.select2-container .select2-selection--single {
    background-color: #f9fafb !important; /* gray-50 */
    border: 1px solid #e5e7eb !important; /* gray-200 */
    border-radius: 0.75rem !important; /* rounded-2xl */
    height: 48px !important;
    padding-left: 0.75rem !important;
    display: flex;
    align-items: center;
    transition: all 0.2s;
}
.select2-container .select2-selection--single .select2-selection__rendered {
    line-height: 48px !important;
    padding: 0 0.5rem;
    color: #374151 !important;
    font-weight: 400;
}
.select2-container--default .select2-selection--single .select2-selection__arrow {
    height: 48px !important;
    right: 8px !important;
}
.select2-container--default.select2-container--focus .select2-selection--single,
.select2-container--default.select2-container--open .select2-selection--single {
    border-color: #3b82f6 !important;
    box-shadow: 0 0 0 2px rgba(59,130,246,0.2) !important;
}
.select2-dropdown {
    border: 1px solid #e5e7eb !important;
    border-radius: 0.75rem !important;
    box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -2px rgba(0,0,0,0.1) !important;
    margin-top: 4px;
    overflow: hidden;
}
.select2-results__option {
    padding: 0.5rem 0.75rem !important;
    font-weight: 400;
    color: #374151;
    transition: all 0.15s;
}
.select2-container--default .select2-results__option--highlighted[aria-selected] {
    background-color: #3b82f6 !important;
    color: white !important;
}
.select2-container--default .select2-results__option[aria-selected=true] {
    background-color: #eff6ff !important;
    color: #3b82f6 !important;
}
</style>
    <script>
    $(document).ready(function(){
        $('.select2-role').select2({placeholder:'Select Role', allowClear:true, width:'100%'}).on('change', function() {
            $(this).valid();
        });
        $('.select2-restaurant').select2({placeholder:'Select Restaurant', allowClear:true, width:'100%'}).on('change', function() {
            $(this).valid();
        });
        
        $.validator.setDefaults({
            errorElement: 'p',
            errorClass: 'text-sm text-red-500 mt-1',
            errorPlacement: function(error, element) {
                if (element.hasClass('select2-hidden-accessible') || element.prop('tagName') === 'SELECT') {
                    error.insertAfter(element.next('.select2-container'));
                } else if (element.parent().hasClass('relative')) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
            },
            highlight: function(element) {
                $(element).addClass('border-red-500 focus:ring-red-100 focus:border-red-500');
                $(element).removeClass('border-gray-200 focus:ring-blue-100 focus:border-blue-400');
            },
            unhighlight: function(element) {
                $(element).removeClass('border-red-500 focus:ring-red-100 focus:border-red-500');
                $(element).addClass('border-gray-200 focus:ring-blue-100 focus:border-blue-400');
            }
        });
        $('#waiterForm').validate({
            rules:{
                user_name:{required:true, minlength:2, maxlength:100},
                user_email:{required:true, email:true},
                phone:{required:true},
                password:{required:true},
                user_role:{required:true},
                restaurant_id:{required:true}
            },
            messages:{
                user_name:{required:'Please enter full name', minlength:'Name must be at least 2 chars', maxlength:'Name too long'},
                user_email:{required:'Please enter email', email:'Enter a valid email'},
                phone:{required:'Please enter phone number'},
                password:{required:'Please enter password'},
                user_role:{required:'Select a role'},
                restaurant_id:{required:'Select a restaurant'}
            },
            submitHandler:function(form,e){e.preventDefault(); var btn=$(form).find('button[type=submit]'); var orig=btn.html(); btn.prop('disabled',true).html('<i class="fa-solid fa-spinner fa-spin mr-2"></i> Saving...'); $.ajax({url:$(form).attr('action'), type:'POST', data:$(form).serialize(), dataType:'json', success:function(res){if(res.success){Swal.fire({icon:"success",title:"Success!",text:res.message,showConfirmButton:false,timer:1500}).then(()=>{window.location.href=res.redirect;});}else{Swal.fire('Error',res.message,'error'); btn.prop('disabled',false).html(orig);} }, error:function(){Swal.fire('Error','Server error','error'); btn.prop('disabled',false).html(orig);} }); }
        });
    });

    function togglePassword(btn) {
        const input = btn.parentElement.querySelector('input');
        const icon = btn.querySelector('i');
        if (input.type === 'password') {
            input.type = 'text';
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
            btn.classList.add('text-blue-500');
        } else {
            input.type = 'password';
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
            btn.classList.remove('text-blue-500');
        }
    }
    </script>
</div>
