<div class="flex justify-between items-center mb-8">
    <div>
        <h2 class="text-3xl font-black text-gray-800 tracking-tight">Subscription Plans</h2>
        <p class="text-gray-500 text-sm font-medium mt-1">Choose the perfect plan for your restaurant</p>
    </div>
    <%if $is_super_admin%>
    <a href="<%base_url('admin/subscriptions/add')%>" class="bg-blue-600 hover:bg-blue-700 text-white font-black py-3 px-8 rounded-2xl transition-all shadow-xl shadow-blue-500/30 flex items-center gap-2 group">
        <i class="fa-solid fa-plus text-sm group-hover:rotate-90 transition-transform duration-300"></i>
        Create New Plan
    </a>
    <%/if%>
</div>

<%if $active_sub%>
<div class="mb-10 bg-gradient-to-r from-blue-600 to-indigo-700 rounded-[2.5rem] p-8 text-white shadow-2xl shadow-blue-500/20 relative overflow-hidden group">
    <div class="absolute top-0 right-0 -mt-10 -mr-10 w-64 h-64 bg-white/10 rounded-full blur-3xl group-hover:scale-110 transition-transform duration-1000"></div>
    <div class="relative z-10 flex flex-col md:flex-row md:items-center justify-between gap-6">
        <div class="flex items-center gap-6">
            <div class="w-20 h-20 bg-white/20 backdrop-blur-md rounded-3xl flex items-center justify-center border border-white/30 shadow-inner">
                <i class="fa-solid fa-crown text-3xl text-yellow-300 animate-pulse"></i>
            </div>
            <div>
                <div class="flex items-center gap-3 mb-1">
                    <span class="px-3 py-1 bg-green-400 text-green-900 text-[10px] font-black rounded-lg uppercase tracking-wider shadow-sm">Active Plan</span>
                    <h3 class="text-2xl font-black tracking-tight leading-none"><%$active_sub.plan_name|default:'Premium Member'%></h3>
                </div>
                <p class="text-blue-100 text-sm font-bold opacity-80">Your subscription expires on <span class="text-white underline decoration-blue-400 underline-offset-4"><%$active_sub.expiry_date|date_format:"%d %b, %Y"%></span></p>
            </div>
        </div>
        <div class="flex items-center gap-4">
            <div class="text-right hidden md:block">
                <p class="text-[10px] font-black uppercase tracking-widest text-blue-200 mb-1">Current Status</p>
                <p class="text-lg font-black leading-none">Healthy & Protected</p>
            </div>
            <div class="h-12 w-[1px] bg-white/20 hidden md:block"></div>
            <button class="bg-white/10 hover:bg-white/20 border border-white/20 backdrop-blur-sm py-3 px-6 rounded-2xl font-black text-sm transition-all">
                Manage Billing
            </button>
        </div>
    </div>
</div>
<%/if%>

<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8" id="plans-container">
    <%foreach $plans as $plan%>
    <div class="bg-white rounded-[2.5rem] p-8 border border-gray-100 shadow-sm hover:shadow-2xl hover:-translate-y-2 transition-all duration-500 flex flex-col relative group overflow-hidden <%if $active_sub && $active_sub.plan_id == $plan.id%>ring-4 ring-blue-500/20 border-blue-100<%/if%>">
        
        <%if $active_sub && $active_sub.plan_id == $plan.id%>
        <div class="absolute top-6 right-6 bg-blue-100 text-blue-600 w-10 h-10 rounded-full flex items-center justify-center shadow-sm">
            <i class="fa-solid fa-check text-sm"></i>
        </div>
        <%/if%>

        <div class="mb-8">
            <h4 class="text-xl font-black text-gray-800 mb-2 truncate leading-tight"><%$plan.plan_name%></h4>
            <%if $is_super_admin%>
            <p class="text-[10px] font-black text-blue-500 uppercase tracking-widest mb-4"><i class="fa-solid fa-shop mr-1"></i> <%$plan.restaurant_name%></p>
            <%/if%>
            <div class="flex items-baseline gap-1 mt-4">
                <span class="text-4xl font-black text-gray-900 tracking-tighter">₹<%$plan.price%></span>
                <span class="text-gray-400 text-sm font-bold">/ <%$plan.validity%></span>
            </div>
        </div>

        <div class="flex-1 space-y-4 mb-10">
            <p class="text-[10px] font-black text-gray-400 uppercase tracking-widest border-b border-gray-50 pb-2">What's Included</p>
            <ul class="space-y-3">
                <%assign var="features" value="\n"|explode:$plan.features%>
                <%foreach $features as $feature%>
                <%if $feature|trim%>
                <li class="flex items-start gap-3 text-sm text-gray-600 font-bold group/item">
                    <div class="w-5 h-5 bg-blue-50 rounded-lg flex items-center justify-center flex-shrink-0 group-hover/item:bg-blue-600 transition-colors">
                        <i class="fa-solid fa-check text-[10px] text-blue-600 group-hover/item:text-white"></i>
                    </div>
                    <span class="leading-snug"><%$feature|trim%></span>
                </li>
                <%/if%>
                <%/foreach%>
            </ul>
        </div>

        <div class="space-y-3">
            <%if $active_sub && $active_sub.plan_id == $plan.id%>
            <button disabled class="w-full bg-gray-100 text-gray-400 font-black py-4 rounded-2xl flex items-center justify-center gap-2 cursor-not-allowed">
                <i class="fa-solid fa-circle-check"></i>
                ALREADY ACTIVE
            </button>
            <%else%>
            <button onclick="activateSubscription('<%$plan.id%>', '<%$plan.plan_name%>', '<%$plan.price%>')" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-black py-4 rounded-2xl shadow-lg shadow-blue-500/20 transition-all flex items-center justify-center gap-2 group/btn">
                ACTIVATE PLAN
                <i class="fa-solid fa-arrow-right text-xs group-hover/btn:translate-x-1 transition-transform"></i>
            </button>
            <%/if%>
            
            <%if $is_super_admin%>
            <div class="flex gap-2">
                <a href="<%base_url('admin/subscriptions/edit/')%><%$plan.id%>" class="flex-1 bg-gray-50 hover:bg-gray-100 text-gray-600 font-bold py-3 rounded-xl text-xs flex items-center justify-center gap-2 border border-gray-100 transition-all">
                    <i class="fa-solid fa-pen"></i> Edit
                </a>
                <button onclick="deletePlan('<%$plan.id%>')" class="w-12 bg-red-50 hover:bg-red-100 text-red-500 rounded-xl flex items-center justify-center border border-red-50 border-red-100 transition-all">
                    <i class="fa-solid fa-trash-can text-sm"></i>
                </button>
            </div>
            <%/if%>
        </div>
    </div>
    <%/foreach%>
</div>

<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
<script>
function activateSubscription(planId, planName, price) {
    const razorpayKey = '<%$razorpay_key_id%>';
    
    if (!razorpayKey) {
        Swal.fire('Error', 'Payment configuration missing.', 'error');
        return;
    }

    Swal.fire({
        title: 'Activate ' + planName + '?',
        text: 'Price: ₹' + price,
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#2563eb',
        cancelButtonColor: '#64748b',
        confirmButtonText: 'Proceed to Payment',
        cancelButtonText: 'Cancel'
    }).then((result) => {
        if (result.isConfirmed) {
            const options = {
                "key": razorpayKey,
                "amount": parseFloat(price) * 100, // in paise
                "currency": "INR",
                "name": "Dine Master",
                "description": "Subscription for " + planName,
                "handler": function (response) {
                    verifyAndActivate(planId, response.razorpay_payment_id);
                },
                "prefill": {
                    "name": "<%$admin_user.user_name%>",
                    "email": "<%$admin_user.user_email%>"
                },
                "theme": { "color": "#2563eb" }
            };
            const rzp = new Razorpay(options);
            rzp.open();
        }
    });
}

function verifyAndActivate(planId, paymentId) {
    Swal.fire({
        title: 'Verifying Payment...',
        allowOutsideClick: false,
        didOpen: () => { Swal.showLoading(); }
    });

    $.ajax({
        url: '<%base_url("admin/subscriptions/activate")%>',
        type: 'POST',
        data: { plan_id: planId, payment_id: paymentId },
        dataType: 'json',
        success: function(resp) {
            if (resp.success) {
                Swal.fire('Success', resp.message, 'success').then(() => {
                    location.reload();
                });
            } else {
                let errorMsg = resp.message || JSON.stringify(resp);
                Swal.fire('Error', errorMsg, 'error');
            }
        },
        error: function(xhr) {
            Swal.close();
            console.error("Payment Verification Error:", xhr.responseText);
            let errorMsg = 'Payment verification failed on the server. ';
            let responseContent = xhr.responseText ? xhr.responseText.substring(0, 300) : 'No response from server.';
            
            Swal.fire({
                title: 'Server Error',
                html: '<div class="text-left"><p>' + errorMsg + '</p><pre class="bg-gray-100 p-2 rounded mt-2 text-[10px] overflow-auto max-h-40">' + responseContent + '</pre></div>',
                icon: 'error'
            });
        }
    });
}

function deletePlan(id) {
    Swal.fire({
        title: 'Delete Plan?',
        text: 'This action cannot be undone!',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#ef4444',
        cancelButtonColor: '#64748b',
        confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: '<%base_url("admin/subscriptions/delete/")%>' + id,
                type: 'POST',
                dataType: 'json',
                success: function(resp) {
                    if (resp.success) {
                        Swal.fire('Deleted!', resp.message, 'success').then(() => {
                            window.location.reload();
                        });
                    } else {
                        Swal.fire('Error', resp.message, 'error');
                    }
                }
            });
        }
    });
}
</script>

<style>
.animate-fade-in { animation: fadeIn 0.5s cubic-bezier(0.16, 1, 0.3, 1); }
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}
</style>
