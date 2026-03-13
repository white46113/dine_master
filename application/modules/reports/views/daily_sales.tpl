<div class="space-y-6">
    <!-- Filter Card -->
    <div class="bg-white p-6 rounded-3xl shadow-sm border border-gray-100 flex flex-wrap items-center justify-between gap-4">
        <div>
            <h3 class="text-xl font-black text-gray-800"><%$page_title%></h3>
            <p class="text-xs text-gray-400 font-bold uppercase tracking-widest mt-1">Order Performance by Date</p>
        </div>
        <form method="GET" class="flex items-center gap-3">
            <div class="flex items-center bg-gray-50 px-4 py-2 rounded-xl border border-gray-100 focus-within:border-blue-500 transition-all">
                <i class="fa-solid fa-calendar text-gray-400 mr-3"></i>
                <input type="date" name="start_date" value="<%$start_date%>" class="bg-transparent border-none outline-none text-sm font-bold text-gray-700">
                <span class="mx-2 text-gray-300">to</span>
                <input type="date" name="end_date" value="<%$end_date%>" class="bg-transparent border-none outline-none text-sm font-bold text-gray-700">
            </div>
            <button type="submit" class="p-3 bg-blue-600 text-white rounded-xl shadow-lg shadow-blue-500/20 hover:bg-blue-700 transition-all">
                <i class="fa-solid fa-filter"></i>
            </button>
        </form>
    </div>

    <!-- Stats Summary -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div class="bg-white p-6 rounded-3xl shadow-sm border border-gray-100 border-b-4 border-b-blue-600">
            <p class="text-xs font-bold text-gray-400 uppercase tracking-widest mb-1">Total Orders</p>
            <h3 class="text-3xl font-black text-gray-800"><%$reports|@count%> Days</h3>
        </div>
        <div class="bg-white p-6 rounded-3xl shadow-sm border border-gray-100 border-b-4 border-b-green-600">
            <p class="text-xs font-bold text-gray-400 uppercase tracking-widest mb-1">Total Revenue</p>
            <h3 class="text-3xl font-black text-gray-800">
                <%assign var="total_rev" value=0%>
                <%foreach $reports as $r%><%assign var="total_rev" value=$total_rev + $r.revenue%><%/foreach%>
                ₹<%$total_rev|number_format:0%>
            </h3>
        </div>
        <div class="bg-white p-6 rounded-3xl shadow-sm border border-gray-100 border-b-4 border-b-purple-600">
            <p class="text-xs font-bold text-gray-400 uppercase tracking-widest mb-1">Avg. Daily Revenue</p>
            <h3 class="text-3xl font-black text-gray-800">
                <%if $reports|@count > 0%>
                    ₹<%(($total_rev / ($reports|@count)))|number_format:0%>
                <%else%>
                    ₹0
                <%/if%>
            </h3>
        </div>
    </div>

    <!-- Data Table -->
    <div class="bg-white rounded-3xl shadow-sm border border-gray-100 overflow-hidden">
        <table class="w-full text-left border-collapse">
            <thead>
                <tr class="bg-gray-50/50">
                    <th class="px-6 py-4 text-xs font-black text-gray-500 uppercase tracking-widest">Date</th>
                    <th class="px-6 py-4 text-xs font-black text-gray-500 uppercase tracking-widest text-center">Total Orders</th>
                    <th class="px-6 py-4 text-xs font-black text-gray-500 uppercase tracking-widest text-right">Revenue</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-gray-50">
                <%foreach $reports as $report%>
                <tr class="hover:bg-gray-50/50 transition-colors">
                    <td class="px-6 py-4">
                        <span class="font-bold text-gray-700"><%$report.date|date_format:"%d %b, %Y"%></span>
                    </td>
                    <td class="px-6 py-4 text-center">
                        <span class="px-3 py-1 bg-blue-50 text-blue-600 rounded-full text-xs font-black"><%$report.total_orders%></span>
                    </td>
                    <td class="px-6 py-4 text-right">
                        <span class="font-black text-gray-800 text-lg">₹<%$report.revenue|number_format:0%></span>
                    </td>
                </tr>
                <%foreachelse%>
                <tr>
                    <td colspan="3" class="px-6 py-12 text-center">
                        <div class="flex flex-col items-center">
                            <i class="fa-solid fa-folder-open text-gray-200 text-5xl mb-4"></i>
                            <p class="text-gray-400 font-bold uppercase tracking-wider text-xs">No sales data found for this period</p>
                        </div>
                    </td>
                </tr>
                <%/foreach%>
            </tbody>
        </table>
    </div>
</div>
