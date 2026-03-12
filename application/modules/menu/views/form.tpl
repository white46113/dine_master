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
            <!-- Basic Info Section -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="space-y-2">
                    <label class="text-sm font-bold text-gray-700">Item Name</label>
                    <input type="text" name="name" value="<%$item.name|default:''%>" required
                        class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all"
                        placeholder="e.g. Paneer Tikka">
                </div>
                
                <div class="space-y-2">
                    <label class="text-sm font-bold text-gray-700">Category</label>
                    <select name="category_id" required
                        class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                        <option value="">Select Category</option>
                        <%foreach from=$categories item=cat%>
                        <option value="<%$cat.category_id%>" <%if $item.category_id == $cat.category_id%>selected<%/if%>><%$cat.name%></option>
                        <%/foreach%>
                    </select>
                </div>

                <div class="space-y-2">
                    <label class="text-sm font-bold text-gray-700">Base Price (₹)</label>
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
                        <i class="fa-solid fa-cloud-arrow-up text-gray-300 text-2xl"></i>
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

<script>
$(document).ready(function() {
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

    // Form Submission
    $('#menuForm').on('submit', function(e) {
        e.preventDefault();
        
        const btn = $('#saveBtn');
        const formData = new FormData(this);
        
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
                    btn.prop('disabled', false).html('Save Item');
                }
            },
            error: function() {
                Swal.fire('Error', 'Something went wrong!', 'error');
                btn.prop('disabled', false).html('Save Item');
            }
        });
    });
});
</script>
