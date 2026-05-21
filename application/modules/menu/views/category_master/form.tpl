<div class="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden max-w-3xl mx-auto">
    <div class="p-6 border-b border-gray-100 flex justify-between items-center bg-gray-50/50">
        <div>
            <h2 class="text-lg font-bold text-gray-800"><%$page_title%></h2>
            <p class="text-sm text-gray-500 mt-1">Fill in the details below</p>
        </div>
        <a href="<%base_url('admin/category_master')%>" class="text-gray-500 hover:text-gray-700 transition-colors w-8 h-8 flex items-center justify-center rounded-full hover:bg-gray-200">
            <i class="fa-solid fa-xmark text-lg"></i>
        </a>
    </div>

    <form id="categoryForm" class="p-6">
        <input type="hidden" name="category_id" value="<%if isset($item)%><%$item.category_id%><%/if%>">
        
        <div class="space-y-6">
            <%if isset($restaurants) && $role_id == 1%>
            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-2">Restaurant <span class="text-red-500">*</span></label>
                <select name="restaurant_id" id="restaurant_id" required class="w-full select2-restaurant border border-gray-300 rounded-lg px-4 py-2.5 focus:ring-2 focus:ring-blue-100 focus:border-blue-400 outline-none transition-all bg-gray-50 hover:bg-white focus:bg-white text-gray-700 cursor-pointer">
                    <option value="">Select Restaurant</option>
                    <%foreach from=$restaurants item=restaurant%>
                        <option value="<%$restaurant.restaurant_id%>" <%if isset($item) && $item.restaurant_id == $restaurant.restaurant_id%>selected<%/if%>>
                            <%$restaurant.name%>
                        </option>
                    <%/foreach%>
                </select>
            </div>
            <%/if%>

            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-2">Category Name <span class="text-red-500">*</span></label>
                <input type="text" name="name" required value="<%if isset($item)%><%$item.name%><%/if%>" 
                    class="w-full border border-gray-300 rounded-lg px-4 py-2.5 focus:ring-2 focus:ring-blue-100 focus:border-blue-400 outline-none transition-all bg-gray-50 hover:bg-white focus:bg-white"
                    placeholder="e.g. Starters">
            </div>

            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-2">Description</label>
                <textarea name="description" rows="3" 
                    class="w-full border border-gray-300 rounded-lg px-4 py-2.5 focus:ring-2 focus:ring-blue-100 focus:border-blue-400 outline-none transition-all bg-gray-50 hover:bg-white focus:bg-white resize-none"
                    placeholder="Category description..."><%if isset($item)%><%$item.description%><%/if%></textarea>
            </div>

            <div class="grid grid-cols-1 gap-6">
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-2">Status</label>
                    <label class="relative inline-flex items-center cursor-pointer mt-2">
                        <input type="checkbox" name="is_active" class="sr-only peer" <%if !isset($item) || (isset($item) && $item.is_active == 1)%>checked<%/if%>>
                        <div class="w-11 h-6 bg-gray-200 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-green-500"></div>
                        <span class="ml-3 text-sm font-medium text-gray-700 peer-checked:text-green-600 transition-colors">Active</span>
                    </label>
                </div>
            </div>
        </div>

        <div class="mt-8 pt-6 border-t border-gray-100 flex items-center justify-end gap-3">
            <a href="<%base_url('admin/category_master')%>" class="px-6 py-2.5 border border-gray-300 text-gray-700 font-semibold rounded-lg hover:bg-gray-50 transition-colors">
                Cancel
            </a>
            <button type="submit" id="submitBtn" class="px-6 py-2.5 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition-colors flex items-center">
                <i class="fa-solid fa-floppy-disk mr-2"></i>
                Save Category
            </button>
        </div>
    </form>
</div>

<!-- Load jQuery Validate Plugin -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
<!-- Load Select2 Plugin -->
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<style>
/* Custom styling for Select2 to match the theme */
.select2-container .select2-selection--single {
    height: 46px;
    border-radius: 0.5rem;
    border-color: #d1d5db;
    background-color: #f9fafb;
    display: flex;
    align-items: center;
}
.select2-container--default .select2-selection--single .select2-selection__arrow {
    height: 44px;
    right: 10px;
}
.select2-container--default .select2-selection--single:hover {
    background-color: #ffffff;
}
.select2-container--default.select2-container--focus .select2-selection--single {
    border-color: #60a5fa;
    box-shadow: 0 0 0 2px #dbeafe;
    background-color: #ffffff;
}
</style>

<script>
$(document).ready(function() {
    // Initialize Select2
    $('.select2-restaurant').select2({
        placeholder: "Search for a restaurant...",
        allowClear: true,
        width: '100%'
    });
    // Custom styling for jQuery validation errors
    $.validator.setDefaults({
        errorElement: 'p',
        errorClass: 'text-sm text-red-500 mt-1',
        highlight: function(element) {
            $(element).addClass('border-red-500 focus:ring-red-100 focus:border-red-500');
            $(element).removeClass('border-gray-300 focus:ring-blue-100 focus:border-blue-400');
        },
        unhighlight: function(element) {
            $(element).removeClass('border-red-500 focus:ring-red-100 focus:border-red-500');
            $(element).addClass('border-gray-300 focus:ring-blue-100 focus:border-blue-400');
        }
    });

    // Initialize Form Validation
    $('#categoryForm').validate({
        rules: {
            restaurant_id: {
                required: true
            },
            name: {
                required: true,
                minlength: 2,
                maxlength: 100
            }
        },
        messages: {
            restaurant_id: {
                required: "Please select a restaurant"
            },
            name: {
                required: "Please enter the category name",
                minlength: "Category name must be at least 2 characters",
                maxlength: "Category name cannot exceed 100 characters"
            }
        },
        submitHandler: function(form, e) {
            e.preventDefault();
            let submitBtn = $('#submitBtn');
            let originalText = submitBtn.html();
            
            submitBtn.html('<i class="fa-solid fa-spinner fa-spin mr-2"></i> Saving...').prop('disabled', true);
            
            $.ajax({
                url: '<%base_url("admin/category_master/save")%>',
                type: 'POST',
                data: $(form).serialize(),
                success: function(response) {
                    let res = JSON.parse(response);
                    if(res.success) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Success!',
                            text: res.message,
                            showConfirmButton: false,
                            timer: 1500
                        }).then(() => {
                            window.location.href = res.redirect;
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error!',
                            text: res.message || 'Something went wrong'
                        });
                        submitBtn.html(originalText).prop('disabled', false);
                    }
                },
                error: function() {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error!',
                        text: 'Server error occurred'
                    });
                    submitBtn.html(originalText).prop('disabled', false);
                }
            });
        }
    });
});
</script>
