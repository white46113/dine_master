<?php
defined('BASEPATH') or exit('No direct script access allowed');
?>
<div class="max-w-3xl mx-auto bg-white rounded-xl shadow-sm border border-gray-100 p-8">
    <h2 class="text-2xl font-bold text-gray-800 mb-6"><?php echo isset($item) ? 'Edit Floor' : 'Add New Floor'; ?></h2>
    <form id="floorForm" enctype="multipart/form-data" class="space-y-6">
        <?php if (isset($item)) { ?>
            <input type="hidden" name="floor_id" value="<?php echo $item['floor_id']; ?>" />
        <?php } ?>
        <?php if ($admin_user['role_id'] == 1) { ?>
            <div class="space-y-2">
                <label class="block text-sm font-semibold text-gray-700">Restaurant <span class="text-red-500">*</span></label>
                <select name="restaurant_id" id="restaurant_id" required class="w-full select2-restaurant border border-gray-300 rounded-lg px-4 py-2.5 focus:ring-2 focus:ring-blue-100 focus:border-blue-400 outline-none transition-all bg-gray-50 hover:bg-white">
                    <option value="">Select Restaurant</option>
                    <?php foreach ($restaurants as $res) { ?>
                        <option value="<?php echo $res['restaurant_id']; ?>" <?php echo (isset($item) && $item['restaurant_id'] == $res['restaurant_id']) ? 'selected' : ''; ?>>
                            <?php echo $res['name']; ?>
                        </option>
                    <?php } ?>
                </select>
            </div>
        <?php } ?>
        <div class="space-y-2">
            <label class="block text-sm font-semibold text-gray-700">Floor Name <span class="text-red-500">*</span></label>
            <input type="text" name="name" value="<?php echo $item['name'] ?? ''; ?>" required class="w-full border border-gray-300 rounded-lg px-4 py-2.5 focus:ring-2 focus:ring-blue-100 focus:border-blue-400 outline-none transition-all" placeholder="e.g. Ground Floor" />
        </div>
        <div class="space-y-2">
            <label class="block text-sm font-semibold text-gray-700">Description</label>
            <textarea name="description" rows="3" class="w-full border border-gray-300 rounded-lg px-4 py-2.5 focus:ring-2 focus:ring-blue-100 focus:border-blue-400 outline-none transition-all" placeholder="Optional description"></textarea>
        </div>
        <div class="space-y-2">
            <label class="block text-sm font-semibold text-gray-700">Sort Order</label>
            <input type="number" name="sort_order" value="<?php echo $item['sort_order'] ?? ''; ?>" class="w-full border border-gray-300 rounded-lg px-4 py-2.5 focus:ring-2 focus:ring-blue-100 focus:border-blue-400 outline-none transition-all" placeholder="Optional numeric order" />
        </div>
        <div class="flex justify-end">
            <a href="<?php echo base_url('admin/floor_master'); ?>" class="mr-4 text-gray-600 hover:text-gray-900">Cancel</a>
            <button type="submit" id="saveBtn" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-lg transition-all">
                <?php echo isset($item) ? 'Update Floor' : 'Save Floor'; ?>
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
    // Initialize Select2 for restaurant (only visible for Super Admin)
    $('.select2-restaurant').select2({placeholder: 'Select a restaurant...', allowClear: true, width: '100%'});
    // Validation
    $.validator.setDefaults({errorElement: 'p', errorClass: 'text-sm text-red-500 mt-1'});
    $('#floorForm').validate({
        rules: {
            <?php if ($admin_user['role_id'] == 1) { ?>restaurant_id: {required: true},<?php } ?>
            name: {required: true, minlength: 2, maxlength: 100}
        },
        messages: {
            <?php if ($admin_user['role_id'] == 1) { ?>restaurant_id: {required: 'Please select a restaurant'},<?php } ?>
            name: {required: 'Please enter floor name', minlength: 'Floor name must be at least 2 characters', maxlength: 'Floor name cannot exceed 100 characters'}
        },
        submitHandler: function(form, e){
            e.preventDefault();
            var btn = $('#saveBtn');
            var orig = btn.html();
            btn.prop('disabled', true).html('<i class="fa-solid fa-spinner fa-spin mr-2"></i> Saving...');
            $.ajax({
                url: '<?php echo base_url('admin/floor_master/save'); ?>',
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
