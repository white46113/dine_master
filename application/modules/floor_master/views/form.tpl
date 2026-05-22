<div class="max-w-3xl mx-auto bg-white rounded-xl shadow-sm border border-gray-100 p-8">
    <h2 class="text-2xl font-bold text-gray-800 mb-6"><%if isset($item)%>Edit Floor<%else%>Add New Floor<%/if%></h2>
    <form id="floorForm" enctype="multipart/form-data" class="space-y-6">
        <%if isset($item)%>
            <input type="hidden" name="floor_id" value="<%$item.floor_id%>" />
        <%/if%>
        <%if isset($admin_user.role_id) && $admin_user.role_id == 1%>
            <div class="space-y-2">
                <label class="block text-sm font-semibold text-gray-700">Restaurant <span class="text-red-500">*</span></label>
                <select name="restaurant_id" id="restaurant_id" required class="w-full select2-restaurant border border-gray-300 rounded-lg px-4 py-2.5 outline-none transition-all bg-gray-50 hover:bg-white">
                    <option value="">Select Restaurant</option>
                    <%foreach from=$restaurants item=res%>
                        <option value="<%$res.restaurant_id%>" <%if isset($item) && $item.restaurant_id == $res.restaurant_id%>selected<%/if%>>
                            <%$res.name%>
                        </option>
                    <%/foreach%>
                </select>
            </div>
        <%/if%>
        <div class="space-y-2">
            <label class="block text-sm font-semibold text-gray-700">Floor Name <span class="text-red-500">*</span></label>
            <input type="text" name="name" value="<%$item.name|default:''%>" required class="w-full border border-gray-300 rounded-lg px-4 py-2.5 focus:ring-2 focus:ring-blue-100 focus:border-blue-400 outline-none transition-all" placeholder="e.g. Ground Floor" />
        </div>
        <div class="space-y-2">
            <label class="block text-sm font-semibold text-gray-700">Description</label>
            <textarea name="description" rows="3" class="w-full border border-gray-300 rounded-lg px-4 py-2.5 focus:ring-2 focus:ring-blue-100 focus:border-blue-400 outline-none transition-all" placeholder="Optional description"><%$item.description|default:''%></textarea>
        </div>
        <div class="flex justify-end">
            <a href="<%base_url('admin/floor_master')%>" class="mr-4 text-gray-600 hover:text-gray-900 mt-2">Cancel</a>
            <button type="submit" id="saveBtn" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-lg transition-all">
                <%if isset($item)%>Update Floor<%else%>Save Floor<%/if%>
            </button>
        </div>
    </form>
</div>

<!-- Load Select2 & Validation -->
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
<script>
$(document).ready(function(){
    // Initialize Select2 for restaurant
    $('.select2-restaurant').select2({placeholder: 'Select a restaurant...', allowClear: true, width: '100%'});
    // Validation
    $.validator.setDefaults({errorElement: 'p', errorClass: 'text-sm text-red-500 mt-1'});
    $('#floorForm').validate({
        rules: {
            <%if isset($admin_user.role_id) && $admin_user.role_id == 1%>restaurant_id: {required: true},<%/if%>
            name: {required: true, minlength: 2, maxlength: 100}
        },
        messages: {
            <%if isset($admin_user.role_id) && $admin_user.role_id == 1%>restaurant_id: {required: 'Please select a restaurant'},<%/if%>
            name: {required: 'Please enter floor name', minlength: 'Floor name must be at least 2 characters', maxlength: 'Floor name cannot exceed 100 characters'}
        },
        submitHandler: function(form, e){
            e.preventDefault();
            var btn = $('#saveBtn');
            var orig = btn.html();
            btn.prop('disabled', true).html('<i class="fa-solid fa-spinner fa-spin mr-2"></i> Saving...');
            $.ajax({
                url: '<%base_url('admin/floor_master/save')%>',
                type: 'POST',
                data: $(form).serialize(),
                dataType: 'json',
                success: function(res){
                    if(res.success){
                        Swal.fire({icon:'success',title:'Success!',text:res.message,showConfirmButton:false,timer:1500}).then(()=>{window.location.href=res.redirect;});
                    } else {
                        Swal.fire('Error', res.message, 'error');
                        btn.prop('disabled', false).html(orig);
                    }
                },
                error: function(){
                    Swal.fire('Error','Server error occurred','error');
                    btn.prop('disabled', false).html(orig);
                }
            });
        }
    });
});
</script>
<style>
/* Custom Select2 Styling to match Tailwind inputs */
.select2-container--default .select2-selection--single {
    border: 1px solid #d1d5db; /* border-gray-300 */
    border-radius: 0.5rem; /* rounded-lg */
    height: 46px; /* Match standard input height */
    background-color: #f9fafb; /* bg-gray-50 */
    transition: all 0.2s ease-in-out;
}
.select2-container--default .select2-selection--single:hover {
    background-color: #ffffff; /* hover:bg-white */
}
.select2-container--default.select2-container--open .select2-selection--single,
.select2-container--default.select2-container--focus .select2-selection--single {
    border-color: #60a5fa; /* focus:border-blue-400 */
    box-shadow: 0 0 0 2px #dbeafe; /* focus:ring-2 focus:ring-blue-100 */
    background-color: #ffffff;
}
.select2-container--default .select2-selection--single .select2-selection__rendered {
    line-height: 44px; /* Center text vertically */
    padding-left: 1rem; /* px-4 */
    color: #374151; /* text-gray-700 */
}
.select2-container--default .select2-selection--single .select2-selection__arrow {
    height: 44px;
    right: 12px;
}
.select2-dropdown {
    border: 1px solid #d1d5db;
    border-radius: 0.5rem;
    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
}
.select2-search--dropdown .select2-search__field {
    border-radius: 0.375rem;
    border: 1px solid #d1d5db;
    padding: 0.375rem 0.75rem;
}
.select2-search--dropdown .select2-search__field:focus {
    border-color: #60a5fa;
    outline: none;
    box-shadow: 0 0 0 2px #dbeafe;
}
</style>
