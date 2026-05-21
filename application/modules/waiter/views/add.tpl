<div class="max-w-4xl mx-auto">
    <div class="flex items-center gap-4 mb-8">
        <a href="<%base_url('admin/waiter')%>" class="w-12 h-12 rounded-2xl bg-white border border-gray-100 flex items-center justify-center text-gray-400 hover:text-blue-600 hover:border-blue-100 transition-all shadow-sm">
            <i class="fa-solid fa-arrow-left"></i>
        </a>
        <div>
            <h2 class="text-2xl font-bold text-gray-800">Add New Customer</h2>
            <p class="text-gray-500 text-sm">Create a new customer or staff account</p>
        </div>
    </div>

    <form id="waiterForm" action="<%base_url('admin/waiter/add')%>" method="POST" class="bg-white rounded-[2.5rem] p-10 border border-gray-100 shadow-xl space-y-8">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
            <!-- Name -->
            <div class="space-y-2">
                <label class="text-[10px] font-black text-gray-400 uppercase tracking-widest ml-1">Full Name<span class="text-red-500">*</span></label>
                <div class="relative">
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                        <i class="fa-solid fa-user text-xs"></i>
                    </span>
                    <input type="text" name="user_name" required placeholder="John Doe"
                           class="w-full pl-10 pr-4 py-4 bg-gray-50 border-none rounded-2xl focus:ring-2 focus:ring-blue-500/20 transition-all font-bold text-gray-700">
                </div>
            </div>

            <!-- Email -->
            <div class="space-y-2">
                <label class="text-[10px] font-black text-gray-400 uppercase tracking-widest ml-1">Email Address<span class="text-red-500">*</span></label>
                <div class="relative">
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                        <i class="fa-solid fa-envelope text-xs"></i>
                    </span>
                    <input type="email" name="user_email" required placeholder="john@example.com"
                           class="w-full pl-10 pr-4 py-4 bg-gray-50 border-none rounded-2xl focus:ring-2 focus:ring-blue-500/20 transition-all font-bold text-gray-700">
                </div>
            </div>

            <!-- Phone -->
            <div class="space-y-2">
                <label class="text-[10px] font-black text-gray-400 uppercase tracking-widest ml-1">Phone Number</label>
                <div class="relative">
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                        <i class="fa-solid fa-phone text-xs"></i>
                    </span>
                    <input type="text" name="phone" placeholder="e.g. 555-1234"
                           class="w-full pl-10 pr-4 py-4 bg-gray-50 border-none rounded-2xl focus:ring-2 focus:ring-blue-500/20 transition-all font-bold text-gray-700">
                </div>
            </div>

            <!-- Password -->
            <div class="space-y-2">
                <label class="text-[10px] font-black text-gray-400 uppercase tracking-widest ml-1">Password</label>
                <div class="relative">
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                        <i class="fa-solid fa-lock text-xs"></i>
                    </span>
                    <input type="password" name="password" required placeholder="Enter password"
                           class="w-full pl-10 pr-4 py-4 bg-gray-50 border-none rounded-2xl focus:ring-2 focus:ring-blue-500/20 transition-all font-bold text-gray-700">
                </div>
            </div>

            <!-- Role Type -->
            <div class="space-y-2">
                <label class="text-[10px] font-black text-gray-400 uppercase tracking-widest ml-1">Role Type<span class="text-red-500">*</span></label>
                <div class="relative">
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                        <i class="fa-solid fa-user-shield text-xs"></i>
                    </span>
                    <select name="user_role" required class="w-full pl-10 pr-10 py-4 bg-gray-50 border-none rounded-2xl focus:ring-2 focus:ring-blue-500/20 transition-all font-bold text-gray-700 appearance-none select2-role" style="width:100%" ><%foreach $roles as $role%>
                        <option value="<%$role.role_id%>"><%$role.name%></option>
                        <%/foreach%>
                    </select>
                    <span class="absolute inset-y-0 right-0 pr-4 flex items-center pointer-events-none text-gray-400">
                        <i class="fa-solid fa-chevron-down text-xs"></i>
                    </span>
                </div>
            </div>

            <!-- Restaurant Selection (Super Admin only) -->
            <%if $is_superadmin%>
            <div class="space-y-2">
                <label class="text-[10px] font-black text-gray-400 uppercase tracking-widest ml-1">Assign to Restaurant<span class="text-red-500">*</span></label>
                <div class="relative">
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                        <i class="fa-solid fa-shop text-xs"></i>
                    </span>
                    <select name="restaurant_id" required class="w-full pl-10 pr-4 py-4 bg-gray-50 border-none rounded-2xl focus:ring-2 focus:ring-blue-500/20 transition-all font-bold text-gray-700 appearance-none select2-restaurant" style="width:100%" ><%foreach $restaurants as $res%>
                        <option value="<%$res.restaurant_id%>"><%$res.name%></option>
                        <%/foreach%>
                    </select>
                </div>
            </div>
            <%/if%>

            <!-- Active Status -->
            <div class="space-y-2 flex items-center pt-8">
                <label class="text-sm font-bold text-gray-700 mr-4">Active Account</label>
                <label class="relative inline-flex items-center cursor-pointer">
                    <input type="checkbox" name="status" value="1" class="sr-only peer" checked>
                    <div class="w-11 h-6 bg-gray-200 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-blue-600"></div>
                </label>
            </div>
        </div>

        <div class="pt-6">
            <button type="submit" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-black py-5 rounded-2xl shadow-xl shadow-blue-200 transition-all flex items-center justify-center gap-3 tracking-widest uppercase text-sm">
                <i class="fa-solid fa-circle-check"></i>
                SAVE CUSTOMER ACCOUNT
            </button>
        </div>
    </form>
    <!-- Load Select2 & Validation -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
<style>
.select2-container .select2-selection--single {
    height: 3.5rem !important;
    padding-left: 2.5rem !important;
    border-radius: 0.75rem !important;
    border: 1px solid #d1d5db !important;
    background-color: #f9fafb !important;
    font-weight: 700;
    color: #374151 !important;
}
.select2-container .select2-selection--single .select2-selection__rendered {
    line-height: 3.5rem !important;
    padding: 0 0.75rem;
}
.select2-container--default .select2-selection--single .select2-selection__arrow {
    height: 3.5rem !important;
    right: 0.75rem;
}
</style>
    <script>
    $(document).ready(function(){
        $('.select2-role').select2({placeholder:'Select Role', allowClear:true, width:'100%'});
        $('.select2-restaurant').select2({placeholder:'Select Restaurant', allowClear:true, width:'100%'});
        $.validator.setDefaults({errorElement:'p', errorClass:'text-sm text-red-500 mt-1'});
        $('#waiterForm').validate({
            rules:{
                user_name:{required:true, minlength:2, maxlength:100},
                user_email:{required:true, email:true},
                user_role:{required:true},
                restaurant_id:{required:true}
            },
            messages:{
                user_name:{required:'Please enter full name', minlength:'Name must be at least 2 chars', maxlength:'Name too long'},
                user_email:{required:'Please enter email', email:'Enter a valid email'},
                user_role:{required:'Select a role'},
                restaurant_id:{required:'Select a restaurant'}
            },
            submitHandler:function(form,e){e.preventDefault(); var btn=$(form).find('button[type=submit]'); var orig=btn.html(); btn.prop('disabled',true).html('<i class="fa-solid fa-spinner fa-spin mr-2"></i> Saving...'); $.ajax({url:$(form).attr('action'), type:'POST', data:$(form).serialize(), dataType:'json', success:function(res){if(res.success){Swal.fire({icon:"success",title:"Success!",text:res.message,showConfirmButton:false,timer:1500}).then(()=>{window.location.href=res.redirect;});}else{Swal.fire('Error',res.message,'error'); btn.prop('disabled',false).html(orig);} }, error:function(){Swal.fire('Error','Server error','error'); btn.prop('disabled',false).html(orig);} }); }
        });
    });
    </script>
</div>
