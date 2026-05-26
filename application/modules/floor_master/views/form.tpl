<div class="max-w-4xl mx-auto">
    <div class="flex justify-between items-center mb-8">
        <div>
            <h2 class="text-2xl font-bold text-gray-800">
                <%if isset($page_title)%><%$page_title%><%else%>Add New Floor<%/if%>
            </h2>
            <p class="text-gray-500 text-sm">
                <%if isset($item)%>Modify existing floor details<%else%>Create a new floor<%/if%>
            </p>
        </div>
        <a href="<%base_url('admin/floor_master')%>"
            class="w-12 h-12 rounded-2xl bg-white border border-gray-100 flex items-center justify-center text-gray-400 hover:text-blue-600 hover:border-blue-100 transition-all shadow-sm">
            <i class="fa-solid fa-arrow-left"></i>
        </a>
    </div>

    <form id="floorForm" enctype="multipart/form-data" class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
        <%if isset($item)%>
            <input type="hidden" name="floor_id" value="<%$item.floor_id%>" />
        <%/if%>
        
        <div class="p-8 space-y-8">
        <%if isset($admin_user.role_id) && $admin_user.role_id == 1%>
            <div class="space-y-2">
                <label class="block text-sm font-semibold text-gray-700">Restaurant <span class="text-red-500">*</span></label>
                <select name="restaurant_id" id="restaurant_id" required class="w-full select2-restaurant px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
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
            <input type="text" name="name" value="<%$item.name|default:''%>" required class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all" placeholder="e.g. Ground Floor" />
        </div>
        </div>

        <div class="bg-gray-50 px-8 py-5 flex justify-end space-x-3">
            <a href="<%base_url('admin/floor_master')%>"
                class="bg-white hover:bg-gray-100 text-gray-700 font-bold py-2.5 px-6 rounded-xl transition-all border border-gray-200 ml-auto">Cancel</a>
            <button type="submit" id="saveBtn"
                class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2.5 px-8 rounded-xl transition-all shadow-lg shadow-blue-500/30">
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
    $('.select2-restaurant').select2({placeholder: 'Select a restaurant...', allowClear: true, width: '100%'}).on('change', function() {
        $(this).valid();
    });
    // Validation
    $.validator.setDefaults({
        errorElement: 'p', 
        errorClass: 'text-sm text-red-500 mt-1',
        errorPlacement: function (error, element) {
            if (element.hasClass('select2-hidden-accessible') || element.prop('tagName') === 'SELECT') {
                error.insertAfter(element.next('.select2-container'));
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
/* Select2 styled to match input fields */
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
