<div class="max-w-4xl mx-auto">
    <div class="flex justify-between items-center mb-8">
        <div>
            <h2 class="text-2xl font-bold text-gray-800">
                <%$page_title%>
            </h2>
            <p class="text-gray-500 text-sm">
                <%if $item.item_id%>Modify existing menu item details<%else%>Create a new addition to your menu<%/if%>
            </p>
        </div>
        <a href="<%base_url('admin/menu')%>"
            class="w-12 h-12 rounded-2xl bg-white border border-gray-100 flex items-center justify-center text-gray-400 hover:text-blue-600 hover:border-blue-100 transition-all shadow-sm">
            <i class="fa-solid fa-arrow-left"></i>
        </a>
    </div>

    <form id="menuForm" class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden"
        enctype="multipart/form-data">
        <input type="hidden" name="item_id" value="<%$item.item_id|default:''%>">

        <div class="p-8 space-y-8">
            <%if $admin_user.role_id==1%>
                <div class="space-y-2">
                    <label class="text-sm font-bold text-gray-700">Restaurant <span
                            class="text-red-500">*</span></label>
                    <select name="restaurant_id" id="restaurant_id" required
                        class="w-full select2-restaurant px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                        <option value="">Select Restaurant</option>
                        <%foreach from=$restaurants item=res%>
                            <option value="<%$res.restaurant_id%>" <%if $item.restaurant_id==$res.restaurant_id%>
                                selected<%/if%>><%$res.name%>
                            </option>
                            <%/foreach%>
                    </select>
                </div>
                <%/if%>

                    <!-- Basic Info Section -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="space-y-2">
                            <label class="text-sm font-bold text-gray-700">Item Name <span
                                    class="text-red-500">*</span></label>
                            <input type="text" name="name" value="<%$item.name|default:''%>" required
                                class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all"
                                placeholder="e.g. Paneer Tikka">
                        </div>

                        <div class="space-y-2">
                            <label class="text-sm font-bold text-gray-700">Category <span
                                    class="text-red-500">*</span></label>
                            <select name="category_id" required
                                class="w-full select2-category px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                                <option value="">Select Category</option>
                                <%foreach from=$categories item=cat%>
                                    <option value="<%$cat.category_id%>" <%if $item.category_id==$cat.category_id%>
                                        selected<%/if%>><%$cat.name%>
                                    </option>
                                    <%/foreach%>
                            </select>
                        </div>

                        <div class="space-y-2">
                            <label class="text-sm font-bold text-gray-700">Base Price (₹) <span
                                    class="text-red-500">*</span></label>
                            <input type="number" step="0.01" name="base_price" value="<%$item.base_price|default:''%>"
                                required
                                class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all"
                                placeholder="0.00">
                        </div>

                        <div class="space-y-2">
                            <label class="text-sm font-bold text-gray-700">Food Type</label>
                            <div class="flex space-x-4  items-center pt-0">
                                <label class="flex items-center space-x-2 cursor-pointer group">
                                    <input type="radio" name="veg_type" value="VEG" <%if
                                        $item.veg_type|default:'VEG'=='VEG' %>checked<%/if%> class="hidden peer">
                                        <div
                                            class="px-4 py-2 border border-gray-200 rounded-lg group-hover:bg-gray-50 peer-checked:bg-green-50 peer-checked:border-green-500 peer-checked:text-green-700 transition-all font-semibold text-sm">
                                            <i class="fa-solid fa-leaf mr-1"></i> Veg
                                        </div>
                                </label>
                                <label class="flex items-center space-x-2 cursor-pointer group">
                                    <input type="radio" name="veg_type" value="NON_VEG" <%if $item.veg_type=='NON_VEG'
                                        %>checked<%/if%> class="hidden peer">
                                        <div
                                            class="px-4 py-2 border border-gray-200 rounded-lg group-hover:bg-gray-50 peer-checked:bg-red-50 peer-checked:border-red-500 peer-checked:text-red-700 transition-all font-semibold text-sm">
                                            <i class="fa-solid fa-drumstick-bite mr-1"></i> Non-Veg
                                        </div>
                                </label>
                                <label class="flex items-center space-x-2 cursor-pointer group">
                                    <input type="radio" name="veg_type" value="EGG" <%if $item.veg_type=='EGG' %>checked
                                    <%/if%> class="hidden peer">
                                        <div
                                            class="px-4 py-2 border border-gray-200 rounded-lg group-hover:bg-gray-50 peer-checked:bg-orange-50 peer-checked:border-orange-500 peer-checked:text-orange-700 transition-all font-semibold text-sm">
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
                            <div id="image-preview"
                                class="w-24 h-24 bg-gray-50 rounded-2xl border-2 border-dashed border-gray-200 flex items-center justify-center overflow-hidden">
                                <%if $item.image_url%>
                                    <img src="<%$item.image_url%>" class="w-full h-full object-cover">
                                    <%else%>
                                        <img src="<%base_url('public/img/food-placeholder.svg')%>"
                                            class="w-full h-full object-cover opacity-50 p-4">
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
                            <input type="checkbox" name="is_available" value="1" <%if
                                $item.is_available|default:1%>checked<%/if%> class="sr-only peer">
                                <div
                                    class="w-11 h-6 bg-gray-200 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-blue-600">
                                </div>
                        </label>
                    </div>
        </div>

        <div class="bg-gray-50 px-8 py-5 flex justify-end space-x-3">
            <a href="<%base_url('admin/menu')%>"
                class="bg-white hover:bg-gray-100 text-gray-700 font-bold py-2.5 px-6 rounded-xl transition-all border border-gray-200 ml-auto">Cancel</a>
            <button type="submit" id="saveBtn"
                class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2.5 px-8 rounded-xl transition-all shadow-lg shadow-blue-500/30">
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
    /* Select2 styled to match input fields */
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

    .select2-container .select2-selection--single .select2-selection__placeholder {
        color: #9ca3af !important;
    }

    .select2-container .select2-selection--single .select2-selection__arrow {
        height: 48px !important;
        right: 8px !important;
    }

    .select2-container--default.select2-container--focus .select2-selection--single,
    .select2-container--default.select2-container--open .select2-selection--single {
        border-color: #3b82f6 !important;
        box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.2) !important;
    }

    .select2-dropdown {
        border: 1px solid #e5e7eb !important;
        border-radius: 0.75rem !important;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -2px rgba(0, 0, 0, 0.1) !important;
        overflow: hidden;
        margin-top: 4px;
    }

    .select2-search__field {
        border-radius: 0.5rem !important;
        border: 1px solid #e5e7eb !important;
        padding: 0.5rem 0.75rem !important;
        outline: none !important;
    }

    .select2-search__field:focus {
        border-color: #3b82f6 !important;
        box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.2) !important;
    }

    .select2-results__option {
        padding: 0.625rem 1rem !important;
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
    $(document).ready(function () {
        // Initialize Select2 for Category and Restaurant
        $('.select2-category').select2({
            placeholder: "Search for a category...",
            allowClear: true,
            width: '100%'
        }).on('change', function() {
            $(this).valid();
        });
        $('.select2-restaurant').select2({
            placeholder: "Search for a restaurant...",
            allowClear: true,
            width: '100%'
        }).on('change', function() {
            $(this).valid();
        });

        // Validation defaults for Select2 fields
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
            highlight: function (element) {
                $(element).addClass('border-red-500 focus:ring-red-100 focus:border-red-500')
                    .removeClass('border-gray-200 focus:ring-blue-100 focus:border-blue-400');
            },
            unhighlight: function (element) {
                $(element).removeClass('border-red-500 focus:ring-red-100 focus:border-red-500')
                    .addClass('border-gray-200 focus:ring-blue-100 focus:border-blue-400');
            }
        });

        // Image Preview
        $('#imageInput').on('change', function () {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    $('#image-preview').html(`<img src="${e.target.result}" class="w-full h-full object-cover">`);
                }
                reader.readAsDataURL(file);
            }
        });

        // Dynamic Category Loading
        $('#restaurant_id').on('change', function () {
            const restaurantId = $(this).val();
            if (!restaurantId) return;

            const catSelect = $('select[name="category_id"]');
            catSelect.prop('disabled', true).html('<option value="">Loading Categories...</option>');

            $.ajax({
                url: '<%base_url("admin/menu/ajax_get_categories")%>',
                type: 'GET',
                data: { restaurant_id: restaurantId },
                dataType: 'json',
                success: function (response) {
                    if (response.success) {
                        let options = '<option value="">Select Category</option>';
                        response.data.forEach(function (cat) {
                            options += `<option value="${cat.category_id}">${cat.name}</option>`;
                        });
                        catSelect.html(options).prop('disabled', false).trigger('change.select2');
                    }
                }
            });
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
            submitHandler: function (form, e) {
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
                    success: function (response) {
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
                    error: function () {
                        Swal.fire('Error', 'Something went wrong!', 'error');
                        btn.prop('disabled', false).html(originalText);
                    }
                });
            }
        });
    });
</script>
