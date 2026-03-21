<div class="max-w-5xl mx-auto">
    <div class="flex items-center gap-4 mb-8">
        <%if $admin_user.user_role == 1 || $admin_user.role_id == 1%>
        <a href="<%base_url('admin/restaurant')%>" class="w-12 h-12 rounded-2xl bg-white border border-gray-100 flex items-center justify-center text-gray-400 hover:text-blue-600 hover:border-blue-100 transition-all shadow-sm">
            <i class="fa-solid fa-arrow-left"></i>
        </a>
        <%/if%>
        <div>
            <h2 class="text-2xl font-bold text-gray-800">Restaurant Information</h2>
            <p class="text-gray-500 text-sm">Manage your restaurant's public profile, branding, and contact settings</p>
        </div>
    </div>

    <form id="restaurantForm" class="space-y-8" enctype="multipart/form-data">
        <input type="hidden" name="restaurant_id" value="<%$restaurant.restaurant_id%>">
        
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
            <!-- Left: Branding & Logo -->
            <div class="lg:col-span-1 space-y-6">
                <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
                    <h3 class="font-bold text-gray-800 mb-6 text-sm uppercase tracking-wider">Branding</h3>
                    
                    <div class="flex flex-col items-center">
                        <div id="logo-preview" class="w-40 h-40 bg-gray-50 rounded-2xl border-2 border-dashed border-gray-200 flex items-center justify-center overflow-hidden mb-4 relative group">
                            <%if $restaurant.logo_url%>
                            <img src="<%$restaurant.logo_url%>" class="w-full h-full object-contain p-2">
                            <%else%>
                            <i class="fa-solid fa-store text-gray-200 text-5xl"></i>
                            <%/if%>
                            <div class="absolute inset-0 bg-black bg-opacity-40 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center">
                                <button type="button" onclick="document.getElementById('logoInput').click()" class="bg-white text-gray-900 px-3 py-1.5 rounded-lg text-xs font-bold shadow-lg">Change Logo</button>
                            </div>
                        </div>
                        <input type="file" name="logo" id="logoInput" class="hidden" accept="image/*">
                        <p class="text-xs text-center text-gray-400 italic">Square logo recommended (PNG/JPG)</p>
                    </div>

                    <div class="mt-8 space-y-4">
                        <div class="space-y-1.5">
                            <label class="text-xs font-bold text-gray-500 uppercase">Display Name</label>
                            <input type="text" name="name" value="<%$restaurant.name%>" required
                                class="w-full px-4 py-2.5 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all font-semibold">
                        </div>
                        <div class="space-y-1.5">
                            <label class="text-xs font-bold text-gray-500 uppercase">Legal Entity Name</label>
                            <input type="text" name="legal_name" value="<%$restaurant.legal_name%>"
                                class="w-full px-4 py-2.5 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all text-sm">
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right: Contact & Location details -->
            <div class="lg:col-span-2 space-y-6">
                <div class="bg-white p-8 rounded-2xl shadow-sm border border-gray-100">
                    <h3 class="font-bold text-gray-800 mb-8 text-sm uppercase tracking-wider">Contact & Location</h3>
                    
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
                        <div class="space-y-1.5">
                            <label class="text-xs font-bold text-gray-500 uppercase">Support Email</label>
                            <input type="email" name="contact_email" value="<%$restaurant.contact_email%>" required
                                class="w-full px-4 py-2.5 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                        </div>
                        <div class="space-y-1.5">
                            <label class="text-xs font-bold text-gray-500 uppercase">Support Phone</label>
                            <input type="text" name="contact_phone" value="<%$restaurant.contact_phone%>" required
                                class="w-full px-4 py-2.5 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                        </div>
                    </div>

                    <div class="space-y-6 border-t border-gray-50 pt-8">
                        <div class="space-y-1.5">
                            <label class="text-xs font-bold text-gray-500 uppercase">Street Address</label>
                            <input type="text" name="address_line1" value="<%$restaurant.address_line1%>" placeholder="Building, Street name"
                                class="w-full px-4 py-2.5 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all mb-2">
                            <input type="text" name="address_line2" value="<%$restaurant.address_line2%>" placeholder="Area, Landmark (Optional)"
                                class="w-full px-4 py-2.5 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                        </div>

                        <div class="grid grid-cols-2 md:grid-cols-3 gap-6">
                            <div class="space-y-1.5">
                                <label class="text-xs font-bold text-gray-500 uppercase">City</label>
                                <input type="text" name="city" value="<%$restaurant.city%>"
                                    class="w-full px-4 py-2.5 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                            </div>
                            <div class="space-y-1.5">
                                <label class="text-xs font-bold text-gray-500 uppercase">State</label>
                                <input type="text" name="state" value="<%$restaurant.state%>"
                                    class="w-full px-4 py-2.5 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                            </div>
                            <div class="col-span-2 md:col-span-1 space-y-1.5">
                                <label class="text-xs font-bold text-gray-500 uppercase">ZIP / Postal Code</label>
                                <input type="text" name="postal_code" value="<%$restaurant.postal_code%>"
                                    class="w-full px-4 py-2.5 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                            </div>
                        </div>
                    </div>

                    <!-- GST Configuration -->
                    <div class="bg-white p-8 rounded-2xl shadow-sm border border-gray-100">
                        <h3 class="font-bold text-gray-800 mb-6 text-sm uppercase tracking-wider">GST Configuration</h3>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="space-y-1.5">
                                <label class="text-xs font-bold text-gray-500 uppercase">GST Applicable</label>
                                <div class="flex gap-3 mt-2">
                                    <label class="flex items-center gap-2 cursor-pointer">
                                        <input type="radio" name="gst_applicable" id="gst_yes" value="yes" <%if isset($restaurant.gst_applicable) && $restaurant.gst_applicable == 'yes'%>checked<%/if%> class="accent-green-600">
                                        <span class="text-sm font-semibold text-gray-700">Yes</span>
                                    </label>
                                    <label class="flex items-center gap-2 cursor-pointer">
                                        <input type="radio" name="gst_applicable" id="gst_no" value="no" <%if !isset($restaurant.gst_applicable) || $restaurant.gst_applicable != 'yes'%>checked<%/if%> class="accent-red-500">
                                        <span class="text-sm font-semibold text-gray-700">No</span>
                                    </label>
                                </div>
                            </div>

                            <div class="space-y-1.5" id="gst_percentage_wrapper" <%if !isset($restaurant.gst_applicable) || $restaurant.gst_applicable != 'yes'%>style="display:none"<%/if%>>
                                <label class="text-xs font-bold text-gray-500 uppercase">GST Percentage (%)</label>
                                <input type="number" name="gst_percentage" id="gst_percentage"
                                    value="<%if isset($restaurant.gst_percentage)%><%$restaurant.gst_percentage%><%else%>0<%/if%>"
                                    min="0" max="100" step="0.01" placeholder="e.g. 18"
                                    class="w-full px-4 py-2.5 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                                <p class="text-xs text-gray-400">Enter GST rate between 0–100</p>
                            </div>
                        </div>
                    </div>

                    <div class="mt-6 flex justify-end">
                        <button type="submit" id="saveBtn" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-10 rounded-xl transition-all shadow-lg shadow-blue-500/30">
                            Save Changes
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<script>
$(document).ready(function() {
    // Logo Preview
    $('#logoInput').on('change', function() {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                $('#logo-preview').html(`<img src="${e.target.result}" class="w-full h-full object-contain p-2">`);
            }
            reader.readAsDataURL(file);
        }
    });

    // jQuery Validation
    $("#restaurantForm").validate({
        rules: {
            name: { required: true, minlength: 2 },
            contact_email: { required: true, email: true },
            contact_phone: { required: true, minlength: 10 },
            address_line1: { required: true }
        },
        messages: {
            name: { required: "Please enter restaurant name" },
            contact_email: { required: "Email is required", email: "Enter a valid email" },
            contact_phone: { required: "Phone number is required" },
            address_line1: { required: "Street address is required" }
        },
        errorElement: 'span',
        errorClass: 'text-red-500 text-xs mt-1 block',
        highlight: function(element) {
            $(element).addClass('border-red-500').removeClass('border-gray-200');
        },
        unhighlight: function(element) {
            $(element).removeClass('border-red-500').addClass('border-gray-200');
        },
        submitHandler: function(form) {
            const btn = $('#saveBtn');
            const formData = new FormData(form);
            
            btn.prop('disabled', true).html('<i class="fa-solid fa-circle-notch fa-spin mr-2"></i> Saving...');

            $.ajax({
                url: '<%if isset($mode) && $mode == "create"%><%base_url("admin/restaurant/create")%><%else%><%base_url("admin/restaurant/save")%><%/if%>',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Updated!',
                            text: response.message,
                            timer: 2000,
                            showConfirmButton: false
                        }).then(() => {
                            location.reload();
                        });
                    } else {
                        Swal.fire('Error', response.message, 'error');
                        btn.prop('disabled', false).html('Save Changes');
                    }
                },
                error: function() {
                    Swal.fire('Error', 'An unexpected error occurred.', 'error');
                    btn.prop('disabled', false).html('Save Changes');
                }
            });
        }
    });

    // GST toggle show/hide
    $('input[name="gst_applicable"]').on('change', function() {
        if ($(this).val() === 'yes') {
            $('#gst_percentage_wrapper').slideDown(200);
        } else {
            $('#gst_percentage_wrapper').slideUp(200);
        }
    });

    <%if isset($mode) && $mode == 'view'%>
    // Read-only View Mode Setup
    $('#restaurantForm input, #restaurantForm select, #restaurantForm textarea').prop('disabled', true).addClass('bg-gray-50/50 cursor-not-allowed opacity-80 border-gray-100');
    $('#saveBtn').hide();
    $('.group-hover\\:opacity-100').removeClass('group-hover:opacity-100').addClass('hidden'); // Hide logo upload overlay capability
    <%/if%>
});
</script>
