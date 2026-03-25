<div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
    <div class="flex items-center">
        <a href="<%base_url('admin/orders')%>" class="mr-4 text-gray-500 hover:text-gray-900 transition-colors">
            <i class="fa-solid fa-arrow-left text-xl"></i>
        </a>
        <div>
            <h2 class="text-2xl font-bold text-gray-800">Order Details</h2>
            <p class="text-gray-500 text-sm">Reviewing order #<%$order.order_id%> • <%$order.order_type%></p>
        </div>
    </div>
    
    <div class="flex space-x-3">
        <button onclick="window.print()" class="bg-white border border-gray-200 text-gray-700 font-bold py-2.5 px-6 rounded-xl hover:bg-gray-50 transition-all flex items-center shadow-sm">
            <i class="fa-solid fa-print mr-2 text-sm"></i> Print Receipt
        </button>
        <div class="relative">
             <select onchange="updateStatus(<%$order.order_id%>, this.value)" 
                class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2.5 px-6 rounded-xl transition-all shadow-lg shadow-blue-500/30 outline-none cursor-pointer border-none">
                <option value="PLACED" <%if $order.status == 'PLACED'%>selected<%/if%>>Mark PLACED</option>
                <option value="PREPARING" <%if $order.status == 'PREPARING'%>selected<%/if%>>Mark PREPARING</option>
                <option value="READY" <%if $order.status == 'READY'%>selected<%/if%>>Mark READY</option>
                <option value="SERVED" <%if $order.status == 'SERVED'%>selected<%/if%>>Mark SERVED</option>
                <option value="COMPLETED" <%if $order.status == 'COMPLETED'%>selected<%/if%>>Mark COMPLETED</option>
                <option value="CANCELLED" <%if $order.status == 'CANCELLED'%>selected<%/if%>>Mark CANCELLED</option>
            </select>
        </div>
    </div>
</div>

<div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
    <!-- Left Column: Order Items -->
    <div class="lg:col-span-2 space-y-8">
        <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
            <div class="px-6 py-4 border-b border-gray-100">
                <h3 class="font-bold text-gray-800">Order Items</h3>
            </div>
            <div class="p-6">
                <div class="divide-y divide-gray-100">
                    <%foreach from=$items item=item%>
                    <div class="py-4 flex items-center">
                        <div class="w-16 h-16 bg-gray-50 rounded-xl overflow-hidden mr-4 flex-shrink-0">
                            <%if $item.image_url%>
                            <img src="<%$item.image_url%>" onerror="this.src='https://placehold.co/200x200?text=No+Image'" class="w-full h-full object-cover">
                            <%else%>
                            <div class="w-full h-full flex items-center justify-center text-gray-300">
                                <i class="fa-solid fa-image text-xl"></i>
                            </div>
                            <%/if%>
                        </div>
                        <div class="flex-1">
                            <h4 class="font-bold text-gray-800"><%$item.item_name%></h4>
                            <p class="text-xs text-gray-500">Qty: <%$item.quantity%> x ₹<%$item.unit_price|default:0|number_format:2%></p>
                        </div>
                        <div class="text-right">
                            <p class="font-bold text-gray-900">₹<%($item.quantity * $item.unit_price)|default:0|number_format:2%></p>
                        </div>
                    </div>
                    <%/foreach%>
                </div>
            </div>
            <div class="bg-gray-50 p-6 space-y-3">
                <div class="flex justify-between text-sm text-gray-600">
                    <span>Subtotal</span>
                    <span>₹<%$order.subtotal_amount|default:0|number_format:2%></span>
                </div>
                <div class="flex justify-between text-sm text-gray-600">
                    <span>Tax (GST)</span>
                    <span>₹<%$order.tax_amount|default:0|number_format:2%></span>
                </div>
                <div class="flex justify-between text-sm text-gray-600">
                    <span>Service Charge</span>
                    <span>₹<%$order.service_charge_amt|default:0|number_format:2%></span>
                </div>
                <div class="flex justify-between text-lg font-bold text-gray-900 pt-3 border-t border-gray-200">
                    <span>Total Payable</span>
                    <span class="text-blue-600">₹<%$order.total_payable|default:0|number_format:2%></span>
                </div>
            </div>
        </div>
    </div>

    <!-- Right Column: Customer & Details -->
    <div class="space-y-8">
        <!-- Status Card -->
        <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
            <h3 class="font-bold text-gray-800 mb-6">Order Status</h3>
            <div class="flex items-center mb-6">
                <div class="w-2 h-10 bg-blue-600 rounded-full mr-4"></div>
                <div>
                    <p class="text-xs text-gray-400 font-bold uppercase tracking-widest">Current State</p>
                    <p class="text-lg font-bold text-blue-600"><%$order.status%></p>
                </div>
            </div>
            <div class="space-y-4">
                <div class="flex items-center text-sm">
                    <i class="fa-solid fa-clock text-gray-400 w-6"></i>
                    <span class="text-gray-500 mr-2">Placed At:</span>
                    <span class="font-semibold text-gray-700"><%$order.placed_at%></span>
                </div>
                <div class="flex items-center text-sm">
                    <i class="fa-solid fa-credit-card text-gray-400 w-6"></i>
                    <span class="text-gray-500 mr-2">Payment:</span>
                    <span class="px-2 py-0.5 rounded text-[10px] font-bold uppercase <%if $order.payment_status == 'PAID'%>bg-green-100 text-green-700<%else%>bg-red-100 text-red-700<%/if%>">
                        <%$order.payment_status%>
                    </span>
                </div>
            </div>
        </div>

        <!-- Customer Summary -->
        <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
            <h3 class="font-bold text-gray-800 mb-6">Customer Info</h3>
            <div class="flex items-center mb-6">
                <div class="w-12 h-12 bg-gray-100 rounded-full flex items-center justify-center text-gray-400 text-xl mr-4">
                    <i class="fa-solid fa-user"></i>
                </div>
                <div>
                    <p class="font-bold text-gray-800"><%$order.customer_name|default:'Guest Customer'%></p>
                    <p class="text-xs text-gray-500">Table: <%if $order.table_no%>#<%$order.table_no%><%else%>N/A<%/if%></p>
                </div>
            </div>
            <div class="space-y-3 pt-6 border-t border-gray-100">
                <div class="text-sm">
                    <p class="text-gray-400 mb-0.5">Phone</p>
                    <p class="font-semibold text-gray-700 underline underline-offset-2"><%$order.customer_phone|default:'Not provided'%></p>
                </div>
                <div class="text-sm">
                    <p class="text-gray-400 mb-0.5">Email</p>
                    <p class="font-semibold text-gray-700"><%$order.customer_email|default:'Not provided'%></p>
                </div>
            </div>
        </div>

        <%if $order.notes%>
        <div class="bg-orange-50 p-6 rounded-2xl border border-orange-100">
            <h3 class="font-bold text-orange-800 text-sm mb-3">Special Instructions</h3>
            <p class="text-sm text-orange-700 leading-relaxed italic">"<%$order.notes%>"</p>
        </div>
        <%/if%>
    </div>
</div>

<script>
function updateStatus(orderId, newStatus) {
    $.ajax({
        url: '<%base_url("admin/orders/update_status")%>',
        type: 'POST',
        data: { order_id: orderId, status: newStatus },
        dataType: 'json',
        success: function(response) {
            if (response.success) {
                Swal.fire({
                    toast: true,
                    position: 'top-end',
                    icon: 'success',
                    title: response.message,
                    showConfirmButton: false,
                    timer: 2000
                }).then(() => {
                    location.reload();
                });
            }
        }
    });
}
</script>
