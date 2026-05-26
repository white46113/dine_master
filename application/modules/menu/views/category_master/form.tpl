<div class="max-w-4xl mx-auto">
    <div class="flex justify-between items-center mb-8">
        <div>
            <h2 class="text-2xl font-bold text-gray-800">
                <%$page_title%>
            </h2>
            <p class="text-gray-500 text-sm">
                <%if isset($item)%>Modify existing category details<%else%>Create a new category<%/if%>
            </p>
        </div>
        <a href="<%base_url('admin/category_master')%>"
            class="w-12 h-12 rounded-2xl bg-white border border-gray-100 flex items-center justify-center text-gray-400 hover:text-blue-600 hover:border-blue-100 transition-all shadow-sm">
            <i class="fa-solid fa-arrow-left"></i>
        </a>
    </div>

    <form id="categoryForm" class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
        <input type="hidden" name="category_id" value="<%if isset($item)%><%$item.category_id%><%/if%>">
        
        <div class="p-8 space-y-8">
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

        <div class="bg-gray-50 px-8 py-5 flex justify-end space-x-3">
            <a href="<%base_url('admin/category_master')%>"
                class="bg-white hover:bg-gray-100 text-gray-700 font-bold py-2.5 px-6 rounded-xl transition-all border border-gray-200 ml-auto">Cancel</a>
            <button type="submit" id="submitBtn"
                class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2.5 px-8 rounded-xl transition-all shadow-lg shadow-blue-500/30">
                <%if isset($item)%>Update Category<%else%>Save Category<%/if%>
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

<script>
$(document).ready(function() {
    // Initialize Select2
    $('.select2-restaurant').select2({
        placeholder: "Search for a restaurant...",
        allowClear: true,
        width: '100%'
    }).on('change', function() {
        $(this).valid();
    });
    // Custom styling for jQuery validation errors
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
