    <!-- Data Table -->
    <div class="bg-white rounded-3xl shadow-sm border border-gray-100 overflow-hidden mt-6">
        <table class="w-full text-left border-collapse">
            <thead>
                <tr class="bg-gray-50/50">
                    <th class="px-6 py-4 text-xs font-black text-gray-500 uppercase tracking-widest">Table No</th>
                    <th class="px-6 py-4 text-xs font-black text-gray-500 uppercase tracking-widest text-center">Total Orders</th>
                    <th class="px-6 py-4 text-xs font-black text-gray-500 uppercase tracking-widest text-right">Revenue</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-gray-50">
                <%foreach $reports as $report%>
                <tr class="hover:bg-gray-50/50 transition-colors">
                    <td class="px-6 py-4">
                        <div class="flex items-center space-x-3">
                            <div class="w-8 h-8 bg-gray-100 rounded-lg flex items-center justify-center text-gray-500">
                                <i class="fa-solid fa-table"></i>
                            </div>
                            <span class="font-black text-gray-800">Table <%$report.table_no%></span>
                        </div>
                    </td>
                    <td class="px-6 py-4 text-center"><%$report.total_orders%></td>
                    <td class="px-6 py-4 text-right">
                        <span class="font-black text-gray-800 text-lg">₹<%$report.revenue|number_format:0%></span>
                    </td>
                </tr>
                <%foreachelse%>
                <tr>
                    <td colspan="3" class="px-6 py-12 text-center">
                        <div class="flex flex-col items-center">
                            <i class="fa-solid fa-chair text-gray-200 text-5xl mb-4"></i>
                            <p class="text-gray-400 font-bold uppercase tracking-wider text-xs">No table sales data found</p>
                        </div>
                    </td>
                </tr>
                <%/foreach%>
            </tbody>
        </table>
    </div>
