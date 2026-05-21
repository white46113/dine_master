<div class="max-w-4xl mx-auto">
    <div class="flex items-center mb-8">
        <a href="<%base_url('admin/menu')%>" class="mr-4 text-gray-500 hover:text-gray-900 transition-colors">
            <i class="fa-solid fa-arrow-left text-xl"></i>
        </a>
        <div>
            <h2 class="text-2xl font-bold text-gray-800"><%$page_title%></h2>
            <p class="text-gray-500 text-sm"><%if $item.item_id%>Modify existing menu item details<%else%>Create a new addition to your menu<%/if%></p>
        </div>
    </div>

    <form id="menuForm" class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden" enctype="multipart/form-data">
        <input type="hidden" name="item_id" value="<%$item.item_id|default:''%>">
        
        <div class="p-8 space-y-8">
            <%if $admin_user.role_id == 1%>
            <div class="space-y-2">
                <label class="text-sm font-bold text-gray-700">Select Restaurant <span class="text-red-500">*</span></label>
                <select name="restaurant_id" id="restaurant_id" required
                    class="w-full select2-restaurant px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                    <option value="">Select Restaurant</option>
                    <%foreach from=$restaurants item=res%>
                    <option value="<%$res.restaurant_id%>" <%if $item.restaurant_id == $res.restaurant_id%>selected<%/if%>><%$res.name%></option>
                    <%/foreach%>
                </select>
            </div>
            <%/if%>

            <!-- Basic Info Section -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="space-y-2">
                    <label class="text-sm font-bold text-gray-700">Item Name <span class="text-red-500">*</span></label>
                    <input type="text" name="name" value="<%$item.name|default:''%>" required
                        class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all"
                        placeholder="e.g. Paneer Tikka">
                </div>
                
                <div class="space-y-2">
                    <label class="text-sm font-bold text-gray-700">Category <span class="text-red-500">*</span></label>
                    <select name="category_id" required
                        class="w-full select2-category px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                        <option value="">Select Category</option>
                        <%foreach from=$categories item=cat%>
                        <option value="<%$cat.category_id%>" <%if $item.category_id == $cat.category_id%>selected<%/if%>><%$cat.name%></option>
                        <%/foreach%>
                    </select>
                </div>

                <div class="space-y-2">
                    <label class="text-sm font-bold text-gray-700">Base Price (₹) <span class="text-red-500">*</span></label>
                    <input type="number" step="0.01" name="base_price" value="<%$item.base_price|default:''%>" required
                        class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all"
                        placeholder="0.00">
                </div>

                <div class="space-y-2">
                    <label class="text-sm font-bold text-gray-700">Food Type</label>
                    <div class="flex space-x-4 h-full items-center pt-1">
                        <label class="flex items-center space-x-2 cursor-pointer group">
                            <input type="radio" name="veg_type" value="VEG" <%if $item.veg_type|default:'VEG' == 'VEG'%>checked<%/if%> class="hidden peer">
                            <div class="px-4 py-2 border border-gray-200 rounded-lg group-hover:bg-gray-50 peer-checked:bg-green-50 peer-checked:border-green-500 peer-checked:text-green-700 transition-all font-semibold text-sm">
                                <i class="fa-solid fa-leaf mr-1"></i> Veg
                            </div>
                        </label>
                        <label class="flex items-center space-x-2 cursor-pointer group">
                            <input type="radio" name="veg_type" value="NON_VEG" <%if $item.veg_type == 'NON_VEG'%>checked<%/if%> class="hidden peer">
                            <div class="px-4 py-2 border border-gray-200 rounded-lg group-hover:bg-gray-50 peer-checked:bg-red-50 peer-checked:border-red-500 peer-checked:text-red-700 transition-all font-semibold text-sm">
                                <i class="fa-solid fa-meat-bone mr-1"></i> Non-Veg
                            </div>
                        </label>
                        <label class="flex items-center space-x-2 cursor-pointer group">
                            <input type="radio" name="veg_type" value="EGG" <%if $item.veg_type == 'EGG'%>checked<%/if%> class="hidden peer">
                            <div class="px-4 py-2 border border-gray-200 rounded-lg group-hover:bg-gray-50 peer-checked:bg-orange-50 peer-checked:border-orange-500 peer-checked:text-orange-700 transition-all font-semibold text-sm">
                                <i class="fa-solid fa-egg mr-1"></i> Egg
                            </div>
                        </label>
                    </div>
                </div>
            </div>

            <!-- Description -->
            <div class="space-y-2">
                <label class="text-sm font-bold text-gray-700">Description</label>
                <textarea name="description" rows="3" 
                    class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all placeholder-gray-400"
                    placeholder="Describe the dish, ingredients, etc."><%$item.description|default:''%></textarea>
            </div>

            <!-- Image Upload -->
            <div class="space-y-2">
                <label class="text-sm font-bold text-gray-700">Item Image</label>
                <div class="flex items-center space-x-6">
                    <div id="image-preview" class="w-24 h-24 bg-gray-50 rounded-2xl border-2 border-dashed border-gray-200 flex items-center justify-center overflow-hidden">
                        <%if $item.image_url%>
                        <img src="<%$item.image_url%>" class="w-full h-full object-cover">
                        <%else%>
                        <img src="<%base_url('public/img/food-placeholder.svg')%>" class="w-full h-full object-cover opacity-50 p-4">
                        <%/if%>
                    </div>
                    <div>
                        <input type="file" name="image" id="imageInput" class="hidden" accept="image/*">
                        <button type="button" onclick="document.getElementById('imageInput').click()" 
                            class="bg-white border border-gray-200 hover:bg-gray-50 text-gray-700 font-bold py-2 px-4 rounded-xl text-sm transition-all shadow-sm">
                            Choose Image
                        </button>
                        <p class="text-xs text-gray-400 mt-2 italic">PNG, JPG or JPEG up to 2MB</p>
                    </div>
                </div>
            </div>

            <!-- Availability -->
            <div class="flex items-center p-4 bg-gray-50 rounded-2xl">
                <div class="flex-1">
                    <h4 class="font-bold text-gray-800 text-sm">Availability Status</h4>
                    <p class="text-xs text-gray-500">Toggling this will show/hide the item in the menu.</p>
                </div>
                <label class="relative inline-flex items-center cursor-pointer">
                    <input type="checkbox" name="is_available" value="1" <%if $item.is_available|default:1%>checked<%/if%> class="sr-only peer">
                    <div class="w-11 h-6 bg-gray-200 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-blue-600"></div>
                </label>
            </div>
        </div>

        <div class="bg-gray-50 px-8 py-5 flex justify-end space-x-3">
            <a href="<%base_url('admin/menu')%>" class="bg-white hover:bg-gray-100 text-gray-700 font-bold py-2.5 px-6 rounded-xl transition-all border border-gray-200">Cancel</a>
            <button type="submit" id="saveBtn" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2.5 px-8 rounded-xl transition-all shadow-lg shadow-blue-500/30">
                <%if $item.item_id%>Update Item<%else%>Save Item<%/if%>
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
    height: 48px; /* matching py-3 padding */
    border-radius: 0.75rem; /* rounded-xl */
    border-color: #e5e7eb; /* border-gray-200 */
    display: flex;
    align-items: center;
}
.select2-container--default .select2-selection--single .select2-selection__arrow {
    height: 46px;
    right: 12px;
}
.select2-container--default.select2-container--focus .select2-selection--single {
    border-color: #3b82f6; /* blue-500 */
    box-shadow: 0 0 0 2px #bfdbfe; /* blue-200 */
}
</style>

<script>
$(document).ready(function() {
    // Initialize Select2 for Category and Restaurant
    $('.select2-category').select2({
        placeholder: "Search for a category...",
        allowClear: true,
        width: '100%'
    });
    $('.select2-restaurant').select2({
        placeholder: "Search for a restaurant...",
        allowClear: true,
        width: '100%'
    });
    // Image Preview
    $('#imageInput').on('change', function() {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                $('#image-preview').html(`<img src="${e.target.result}" class="w-full h-full object-cover">`);
            }
            reader.readAsDataURL(file);
        }
    });

    // Dynamic Category Loading
    $('#restaurant_id').on('change', function() {
        const restaurantId = $(this).val();
        if (!restaurantId) return;

        const catSelect = $('select[name="category_id"]');
        catSelect.prop('disabled', true).html('<option value="">Loading Categories...</option>');

        $.ajax({
            url: '<%base_url("admin/menu/ajax_get_categories")%>',
            type: 'GET',
            data: { restaurant_id: restaurantId },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    let options = '<option value="">Select Category</option>';
                    response.data.forEach(function(cat) {
                        options += `<option value="${cat.category_id}">${cat.name}</option>`;
                    });
                    catSelect.html(options).prop('disabled', false).trigger('change.select2');
                }
            }
        });
    });

    // Custom styling for jQuery validation errors
    $.validator.setDefaults({
        errorElement: 'p',
        errorClass: 'text-sm text-red-500 mt-1',
        highlight: function(element) {
            $(element).addClass('border-red-500 focus:ring-red-100 focus:border-red-500');
            $(element).removeClass('border-gray-200 focus:ring-blue-100 focus:border-blue-400');
        },
        unhighlight: function(element) {
            $(element).removeClass('border-red-500 focus:ring-red-100 focus:border-red-500');
            $(element).addClass('border-gray-200 focus:ring-blue-100 focus:border-blue-400');
        }
    });

    // Initialize Form Validation
    $('#menuForm').validate({
        rules: {
            restaurant_id: {
                required: true
            },
            name: {
                required: true,
                minlength: 2,
                maxlength: 150
            },
            category_id: {
                required: true
            },
            base_price: {
                required: true,
                number: true,
                min: 0
            }
        },
        messages: {
            restaurant_id: {
                required: "Please select a restaurant"
            },
            name: {
                required: "Please enter the item name",
                minlength: "Item name must be at least 2 characters",
                maxlength: "Item name cannot exceed 150 characters"
            },
            category_id: {
                required: "Please select a category"
            },
            base_price: {
                required: "Please enter a base price",
                number: "Please enter a valid number",
                min: "Price cannot be negative"
            }
        },
        submitHandler: function(form, e) {
            e.preventDefault();
            
            const btn = $('#saveBtn');
            const formData = new FormData(form);
            const originalText = btn.html();
            
            btn.prop('disabled', true).html('<i class="fa-solid fa-circle-notch fa-spin mr-2"></i> Saving...');

            $.ajax({
                url: '<%base_url("admin/menu/save")%>',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
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
                        Swal.fire('Error', response.message, 'error');
                        btn.prop('disabled', false).html(originalText);
                    }
                },
                error: function() {
                    Swal.fire('Error', 'Something went wrong!', 'error');
                    btn.prop('disabled', false).html(originalText);
                }
            });
        }
    });
});
</script>
