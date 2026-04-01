<div class="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-6 gap-5 mb-8">
    <!-- Today's Revenue -->
    <div class="bg-gradient-to-br from-blue-600 to-blue-700 p-5 rounded-2xl shadow-lg shadow-blue-500/20 text-white">
        <div class="flex justify-between items-start mb-4">
            <div class="w-10 h-10 bg-white/20 rounded-xl flex items-center justify-center text-lg backdrop-blur-md">
                <i class="fa-solid fa-indian-rupee-sign"></i>
            </div>
            <span class="text-[10px] font-black uppercase tracking-widest opacity-60">Revenue</span>
        </div>
        <p class="text-[10px] font-bold opacity-80 uppercase tracking-wider mb-1">Today's Total</p>
        <h3 class="text-xl font-black">₹<%$stats.today_revenue|number_format:0%></h3>
    </div>

    <!-- Active Orders -->
    <div class="bg-white p-5 rounded-2xl shadow-sm border border-gray-100 border-b-4 border-b-orange-500">
        <div class="flex justify-between items-start mb-4">
            <div class="w-10 h-10 bg-orange-50 text-orange-600 rounded-xl flex items-center justify-center text-lg">
                <i class="fa-solid fa-fire-burner"></i>
            </div>
            <div class="flex items-center gap-1.5 px-2 py-0.5 rounded-full bg-orange-50 text-orange-600 text-[8px] font-black uppercase tracking-tighter">
                <span class="w-1 h-1 bg-orange-600 rounded-full animate-pulse"></span> LIVE
            </div>
        </div>
        <p class="text-[10px] font-bold text-gray-400 uppercase tracking-wider mb-1">Active Orders</p>
        <h3 class="text-xl font-black text-gray-800"><%$stats.active_orders%></h3>
    </div>

    <!-- Occupied Tables -->
    <div class="bg-white p-5 rounded-2xl shadow-sm border border-gray-100 border-b-4 border-b-red-500">
        <div class="flex justify-between items-start mb-4">
            <div class="w-10 h-10 bg-red-50 text-red-600 rounded-xl flex items-center justify-center text-lg">
                <i class="fa-solid fa-chair"></i>
            </div>
            <span class="text-[8px] font-black text-red-400 uppercase tracking-widest">BUSY</span>
        </div>
        <p class="text-[10px] font-bold text-gray-400 uppercase tracking-wider mb-1">Occupied Tables</p>
        <h3 class="text-xl font-black text-gray-800"><%$stats.occupied_tables%></h3>
    </div>

    <!-- Available Tables -->
    <div class="bg-white p-5 rounded-2xl shadow-sm border border-gray-100 border-b-4 border-b-green-500">
        <div class="flex justify-between items-start mb-4">
            <div class="w-10 h-10 bg-green-50 text-green-600 rounded-xl flex items-center justify-center text-lg">
                <i class="fa-solid fa-check-to-slot"></i>
            </div>
            <span class="text-[8px] font-black text-green-400 uppercase tracking-widest">FREE</span>
        </div>
        <p class="text-[10px] font-bold text-gray-400 uppercase tracking-wider mb-1">Available Tables</p>
        <h3 class="text-xl font-black text-gray-800"><%$stats.available_tables%></h3>
    </div>

    <!-- Total Orders -->
    <div class="bg-white p-5 rounded-2xl shadow-sm border border-gray-100 border-b-4 border-b-blue-400">
        <div class="flex justify-between items-start mb-4">
            <div class="w-10 h-10 bg-blue-50 text-blue-600 rounded-xl flex items-center justify-center text-lg">
                <i class="fa-solid fa-receipt"></i>
            </div>
            <span class="text-[8px] font-black text-blue-300 uppercase tracking-widest">HISTORY</span>
        </div>
        <p class="text-[10px] font-bold text-gray-400 uppercase tracking-wider mb-1">Total Orders</p>
        <h3 class="text-xl font-black text-gray-800"><%$stats.total_orders%></h3>
    </div>

     <!-- Total Tables -->
     <div class="bg-white p-5 rounded-2xl shadow-sm border border-gray-100 border-b-4 border-b-gray-400">
        <div class="flex justify-between items-start mb-4">
            <div class="w-10 h-10 bg-gray-50 text-gray-600 rounded-xl flex items-center justify-center text-lg">
                <i class="fa-solid fa-table"></i>
            </div>
            <span class="text-[8px] font-black text-gray-300 uppercase tracking-widest">ASSETS</span>
        </div>
        <p class="text-[10px] font-bold text-gray-400 uppercase tracking-wider mb-1">Total Tables</p>
        <h3 class="text-xl font-black text-gray-800"><%$stats.total_tables%></h3>
    </div>
</div>

<div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
    <!-- Recent Orders -->
    <div class="lg:col-span-2 bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
        <div class="px-6 py-4 border-b border-gray-100 flex justify-between items-center">
            <h3 class="font-bold text-gray-800">Recent Orders</h3>
            <a href="<%base_url('admin/orders')%>" class="text-blue-600 text-sm font-semibold hover:underline">View All</a>
        </div>
        <div class="overflow-x-auto">
            <table class="w-full text-left">
                <thead class="bg-gray-50 text-gray-500 text-xs uppercase tracking-wider">
                    <tr>
                        <th class="px-6 py-3">Order ID</th>
                        <th class="px-6 py-3">Customer</th>
                        <th class="px-6 py-3">Amount</th>
                        <th class="px-6 py-3">Status</th>
                        <th class="px-6 py-3">Time</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-100">
                    <%foreach from=$recent_orders item=order%>
                    <tr class="hover:bg-gray-50 transition-colors">
                        <td class="px-6 py-4 font-semibold text-gray-700">#<%$order.order_id%></td>
                        <td class="px-6 py-4 text-gray-600"><%$order.customer_name%></td>
                        <td class="px-6 py-4 text-gray-900 font-medium">₹<%$order.total_payable|default:0|number_format:2%></td>
                        <td class="px-6 py-4">
                            <span class="px-2 py-1 text-xs font-bold rounded-full 
                                <%if $order.status == 'COMPLETED'%>bg-green-100 text-green-700
                                <%elseif $order.status == 'PREPARING'%>bg-blue-100 text-blue-700
                                <%elseif $order.status == 'PLACED'%>bg-orange-100 text-orange-700
                                <%else%>bg-gray-100 text-gray-700<%/if%>">
                                <%$order.status%>
                            </span>
                        </td>
                        <td class="px-6 py-4 text-sm text-gray-500"><%$order.placed_at%></td>
                    </tr>
                    <%/foreach%>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Quick Actions / Info -->
    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
        <h3 class="font-bold text-gray-800 mb-6">Quick Actions</h3>
        <div class="space-y-4">
            <a href="<%base_url('admin/menu/add')%>" class="flex items-center p-4 bg-gray-50 rounded-xl hover:bg-blue-50 transition-colors group">
                <div class="w-10 h-10 bg-white rounded-lg flex items-center justify-center mr-4 shadow-sm group-hover:text-blue-600 transition-colors">
                    <i class="fa-solid fa-plus"></i>
                </div>
                <span class="font-semibold text-gray-700 group-hover:text-blue-700">Add New Item</span>
            </a>
            <a href="<%base_url('admin/restaurant')%>" class="flex items-center p-4 bg-gray-50 rounded-xl hover:bg-purple-50 transition-colors group">
                <div class="w-10 h-10 bg-white rounded-lg flex items-center justify-center mr-4 shadow-sm group-hover:text-purple-600 transition-colors">
                    <i class="fa-solid fa-gear"></i>
                </div>
                <span class="font-semibold text-gray-700 group-hover:text-purple-700">Store Settings</span>
            </a>
        </div>

        <div class="mt-8 border-t border-gray-100 pt-8">
            <h4 class="text-sm font-bold text-gray-400 uppercase tracking-widest mb-4">System Status</h4>
            <div class="flex items-center text-sm text-green-500 font-semibold mb-2">
                <span class="w-2 h-2 bg-green-500 rounded-full mr-2"></span>
                API Server Online
            </div>
            <div class="flex items-center text-sm text-green-500 font-semibold">
                <span class="w-2 h-2 bg-green-500 rounded-full mr-2"></span>
                Database Connected
            </div>
        </div>
    </div>
</div>
