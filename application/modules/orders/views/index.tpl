<div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 space-y-4 md:space-y-0">
    <div>
        <h2 class="text-2xl font-bold text-gray-800">Order Management</h2>
        <p class="text-gray-500 text-sm">Track and manage customer orders in real-time</p>
    </div>
    
    <div class="flex bg-white p-1 rounded-xl border border-gray-200 shadow-sm">
        <a href="<%base_url('admin/orders')%>" class="px-4 py-2 text-sm font-bold rounded-lg transition-all <%if $current_status == ''%>bg-blue-600 text-white shadow-md shadow-blue-500/20<%else%>text-gray-500 hover:text-gray-800<%/if%>">All</a>
        <a href="<%base_url('admin/orders?status=PLACED')%>" class="px-4 py-2 text-sm font-bold rounded-lg transition-all <%if $current_status == 'PLACED'%>bg-blue-600 text-white shadow-md shadow-blue-500/20<%else%>text-gray-500 hover:text-gray-800<%/if%>">Pending</a>
        <a href="<%base_url('admin/orders?status=PREPARING')%>" class="px-4 py-2 text-sm font-bold rounded-lg transition-all <%if $current_status == 'PREPARING'%>bg-blue-600 text-white shadow-md shadow-blue-500/20<%else%>text-gray-500 hover:text-gray-800<%/if%>">Preparing</a>
        <a href="<%base_url('admin/orders?status=COMPLETED')%>" class="px-4 py-2 text-sm font-bold rounded-lg transition-all <%if $current_status == 'COMPLETED'%>bg-blue-600 text-white shadow-md shadow-blue-500/20<%else%>text-gray-500 hover:text-gray-800<%/if%>">Completed</a>
    </div>
</div>

<div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
    <div class="p-6">
        <table class="w-full datatable border-collapse">
            <thead class="bg-gray-50 text-gray-500 text-xs uppercase tracking-wider">
                <tr>
                    <th class="px-6 py-4 border-b border-gray-100 text-left">Order info</th>
                    <th class="px-6 py-4 border-b border-gray-100 text-left">Customer / Table</th>
                    <th class="px-6 py-4 border-b border-gray-100 text-left">Amount</th>
                    <th class="px-6 py-4 border-b border-gray-100 text-left">Status</th>
                    <th class="px-6 py-4 border-b border-gray-100 text-left">Placed At</th>
                    <th class="px-6 py-4 border-b border-gray-100 text-center">Actions</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-gray-100">
                <%foreach from=$orders item=order%>
                <tr class="hover:bg-gray-50 transition-colors">
                    <td class="px-6 py-4">
                        <div class="font-bold text-gray-800">#<%$order.order_id%></div>
                        <div class="text-xs text-blue-600 font-semibold uppercase"><%$order.order_type%></div>
                    </td>
                    <td class="px-6 py-4">
                        <div class="text-sm font-semibold text-gray-700"><%$order.customer_name|default:'Guest'%></div>
                        <div class="text-xs text-gray-400">Table: <%if $order.table_no%>#<%$order.table_no%><%else%>N/A<%/if%></div>
                    </td>
                    <td class="px-6 py-4">
                        <div class="font-bold text-gray-900">₹<%$order.total_payable|default:0|number_format:2%></div>
                        <div class="text-[10px] text-gray-400 uppercase tracking-tighter"><%$order.payment_status%></div>
                    </td>
                    <td class="px-6 py-4">
                        <select onchange="updateStatus(<%$order.order_id%>, this.value)" 
                            class="text-xs font-bold rounded-lg border-0 px-3 py-1.5 focus:ring-0 cursor-pointer
                            <%if $order.status == 'COMPLETED'%>bg-green-100 text-green-700
                            <%elseif $order.status == 'PREPARING'%>bg-blue-100 text-blue-700
                            <%elseif $order.status == 'PLACED'%>bg-orange-100 text-orange-700
                            <%elseif $order.status == 'CANCELLED'%>bg-red-100 text-red-700
                            <%else%>bg-gray-100 text-gray-700<%/if%>">
                            <option value="PLACED" <%if $order.status == 'PLACED'%>selected<%/if%>>PLACED</option>
                            <option value="PREPARING" <%if $order.status == 'PREPARING'%>selected<%/if%>>PREPARING</option>
                            <option value="READY" <%if $order.status == 'READY'%>selected<%/if%>>READY</option>
                            <option value="SERVED" <%if $order.status == 'SERVED'%>selected<%/if%>>SERVED</option>
                            <option value="COMPLETED" <%if $order.status == 'COMPLETED'%>selected<%/if%>>COMPLETED</option>
                            <option value="CANCELLED" <%if $order.status == 'CANCELLED'%>selected<%/if%>>CANCELLED</option>
                        </select>
                    </td>
                    <td class="px-6 py-4 text-xs text-gray-500 font-medium whitespace-nowrap">
                        <%$order.placed_at|date_format:"%b %d, %H:%M"%>
                    </td>
                    <td class="px-6 py-4 text-center">
                        <a href="<%base_url('admin/orders/details/')%><%$order.order_id%>" class="inline-flex items-center justify-center bg-gray-50 text-gray-600 px-4 py-2 rounded-lg hover:bg-gray-900 hover:text-white transition-all text-xs font-bold">
                            View Details
                        </a>
                    </td>
                </tr>
                <%/foreach%>
                <%if empty($orders)%>
                <tr>
                    <td colspan="6" class="px-6 py-12 text-center text-gray-400 italic">No orders found.</td>
                </tr>
                <%/if%>
            </tbody>
        </table>
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
                const Toast = Swal.mixin({
                    toast: true,
                    position: 'top-end',
                    showConfirmButton: false,
                    timer: 2000,
                    timerProgressBar: true
                });
                Toast.fire({
                    icon: 'success',
                    title: response.message
                });
                // Reload after a delay to update colors if needed
                setTimeout(() => location.reload(), 1000);
            }
        }
    });
}
</script>
