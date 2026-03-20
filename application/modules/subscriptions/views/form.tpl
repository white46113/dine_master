<div class="max-w-4xl mx-auto">
    <div class="flex items-center gap-4 mb-8">
        <a href="<%base_url('admin/subscriptions')%>" class="w-12 h-12 bg-white rounded-2xl flex items-center justify-center text-gray-400 hover:text-blue-600 hover:shadow-lg transition-all border border-gray-100">
            <i class="fa-solid fa-arrow-left"></i>
        </a>
        <div>
            <h2 class="text-3xl font-black text-gray-800 tracking-tight"><%if isset($plan)%>Edit Plan<%else%>Create New Plan<%/if%></h2>
            <p class="text-gray-500 text-sm font-medium mt-1">Define membership benefits and pricing</p>
        </div>
    </div>

    <div class="bg-white rounded-[2.5rem] shadow-xl shadow-gray-200/50 border border-gray-100 overflow-hidden">
        <form id="planForm" class="p-10">
            <input type="hidden" name="id" value="<%$plan.id|default:''%>">
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-8 mb-10">
                <div class="space-y-2">
                    <label class="block text-xs font-black text-gray-400 uppercase tracking-[0.2em] ml-2">Assigned Restaurant</label>
                    <div class="relative group">
                        <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none text-gray-300 group-focus-within:text-blue-400 transition-colors">
                            <i class="fa-solid fa-shop text-sm"></i>
                        </div>
                        <select name="restaurant_id" required class="w-full pl-12 pr-4 py-4 bg-gray-50 border-2 border-gray-50 rounded-2xl focus:bg-white focus:border-blue-400 focus:ring-4 focus:ring-blue-500/10 outline-none transition-all font-bold text-gray-700 appearance-none">
                            <option value="">Select Restaurant</option>
                            <%foreach $restaurants as $res%>
                            <option value="<%$res.restaurant_id%>" <%if isset($plan) && $plan.restaurant_id == $res.restaurant_id%>selected<%/if%>><%$res.name%></option>
                            <%/foreach%>
                        </select>
                        <div class="absolute inset-y-0 right-0 pr-4 flex items-center pointer-events-none text-gray-400">
                            <i class="fa-solid fa-chevron-down text-xs"></i>
                        </div>
                    </div>
                </div>

                <div class="space-y-2">
                    <label class="block text-xs font-black text-gray-400 uppercase tracking-[0.2em] ml-2">Plan Name</label>
                    <div class="relative group">
                        <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none text-gray-300 group-focus-within:text-blue-400 transition-colors">
                            <i class="fa-solid fa-crown text-sm"></i>
                        </div>
                        <input type="text" name="plan_name" value="<%$plan.plan_name|default:''%>" placeholder="E.g. Premium Membership" required 
                               class="w-full pl-12 pr-4 py-4 bg-gray-50 border-2 border-gray-50 rounded-2xl focus:bg-white focus:border-blue-400 focus:ring-4 focus:ring-blue-500/10 outline-none transition-all font-bold text-gray-700 placeholder:text-gray-300">
                    </div>
                </div>

                <div class="space-y-2">
                    <label class="block text-xs font-black text-gray-400 uppercase tracking-[0.2em] ml-2">Price (INR)</label>
                    <div class="relative group">
                        <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none text-gray-300 group-focus-within:text-blue-400 transition-colors">
                            <i class="fa-solid fa-indian-rupee-sign text-sm"></i>
                        </div>
                        <input type="number" step="0.01" name="price" value="<%$plan.price|default:''%>" placeholder="0.00" required
                               class="w-full pl-12 pr-4 py-4 bg-gray-50 border-2 border-gray-50 rounded-2xl focus:bg-white focus:border-blue-400 focus:ring-4 focus:ring-blue-500/10 outline-none transition-all font-bold text-gray-700 placeholder:text-gray-300">
                    </div>
                </div>

                <div class="space-y-2">
                    <label class="block text-xs font-black text-gray-400 uppercase tracking-[0.2em] ml-2">Validity</label>
                    <div class="relative group">
                        <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none text-gray-300 group-focus-within:text-blue-400 transition-colors">
                            <i class="fa-solid fa-calendar-days text-sm"></i>
                        </div>
                        <input type="text" name="validity" value="<%$plan.validity|default:'30 Days'%>" placeholder="E.g. 30 Days" required
                               class="w-full pl-12 pr-4 py-4 bg-gray-50 border-2 border-gray-50 rounded-2xl focus:bg-white focus:border-blue-400 focus:ring-4 focus:ring-blue-500/10 outline-none transition-all font-bold text-gray-700 placeholder:text-gray-300">
                    </div>
                </div>
            </div>

            <div class="mb-10 space-y-2">
                <label class="block text-xs font-black text-gray-400 uppercase tracking-[0.2em] ml-2">Plan Features (One per line)</label>
                <div class="relative group">
                    <div class="absolute top-4 left-4 text-gray-300 group-focus-within:text-blue-400 transition-colors">
                        <i class="fa-solid fa-list-check text-sm"></i>
                    </div>
                    <textarea name="features" rows="6" placeholder="Priority Table Reservation&#10;10% Discount on Beverages&#10;Complimentary Welcome Drink"
                              class="w-full pl-12 pr-4 py-4 bg-gray-50 border-2 border-gray-50 rounded-3xl focus:bg-white focus:border-blue-400 focus:ring-4 focus:ring-blue-500/10 outline-none transition-all font-bold text-gray-700 placeholder:text-gray-300 resize-none"><%$plan.features|default:''%></textarea>
                </div>
            </div>

            <div class="flex items-center justify-between p-6 bg-gray-50 rounded-3xl border border-gray-100">
                <div class="flex items-center gap-4">
                    <div class="flex items-center cursor-pointer group">
                        <input type="checkbox" name="is_active" class="hidden peer" id="status-toggle" <%if !isset($plan) || $plan.is_active == 1%>checked<%/if%>>
                        <div class="w-14 h-8 bg-gray-200 rounded-full p-1 transition-all peer-checked:bg-green-400 flex items-center relative shadow-inner">
                            <div class="w-6 h-6 bg-white rounded-full transition-all peer-checked:translate-x-6 shadow-md border border-gray-100"></div>
                        </div>
                        <label for="status-toggle" class="ml-3 text-sm font-black text-gray-500 cursor-pointer peer-checked:text-green-600">ACTIVE PLAN</label>
                    </div>
                </div>
                
                <div class="flex items-center gap-4">
                    <a href="<%base_url('admin/subscriptions')%>" class="px-8 py-4 text-sm font-black text-gray-400 hover:text-gray-600 transition-all">Cancel</a>
                    <button type="submit" id="submitBtn" class="bg-blue-600 hover:bg-blue-700 text-white font-black py-4 px-12 rounded-2xl shadow-xl shadow-blue-500/30 transition-all flex items-center gap-2 group/btn">
                        SAVE PLAN
                        <i class="fa-solid fa-arrow-right text-xs group-hover/btn:translate-x-1 transition-transform"></i>
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
$(document).ready(function() {
    $('#planForm').on('submit', function(e) {
        e.preventDefault();
        const btn = $('#submitBtn');
        const originalContent = btn.html();
        
        btn.prop('disabled', true).html('<i class="fa-solid fa-circle-notch fa-spin mr-2"></i> SAVING...');

        $.ajax({
            url: '<%base_url("admin/subscriptions/save")%>',
            type: 'POST',
            data: $(this).serialize(),
            dataType: 'json',
            success: function(resp) {
                if (resp.success) {
                    Swal.fire({
                        title: 'Success!',
                        text: resp.message,
                        icon: 'success',
                        timer: 1500,
                        showConfirmButton: false
                    }).then(() => {
                        window.location.href = '<%base_url("admin/subscriptions")%>';
                    });
                } else {
                    Swal.fire('Error', resp.message, 'error');
                    btn.prop('disabled', false).html(originalContent);
                }
            },
            error: function() {
                Swal.fire('Error', 'Something went wrong!', 'error');
                btn.prop('disabled', false).html(originalContent);
            }
        });
    });

    // Custom toggle label update helper
    $('#status-toggle').on('change', function() {
        const label = $('label[for="status-toggle"]');
        if (this.checked) {
            label.text('ACTIVE PLAN').addClass('text-green-600').removeClass('text-gray-500');
        } else {
            label.text('INACTIVE PLAN').removeClass('text-green-600').addClass('text-gray-500');
        }
    });
});
</script>
