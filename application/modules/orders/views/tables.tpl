<div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
    <div>
        <h2 class="text-2xl font-bold text-gray-800">Table Selection</h2>
        <p class="text-gray-500 text-sm italic">Monitor real-time table occupancy and manage guest seating</p>
    </div>
    <div class="flex items-center gap-3">
        <a href="<%base_url('admin/orders/all')%>" class="px-6 py-3 bg-white hover:bg-gray-50 text-gray-600 font-black text-xs uppercase tracking-widest rounded-2xl border border-gray-100 transition-all shadow-sm flex items-center gap-2">
            <i class="fa-solid fa-clock-rotate-left text-gray-400"></i>
            Order History
        </a>
    </div>
</div>

<!-- Stats Dashboard -->
<div class="grid grid-cols-2 md:grid-cols-4 gap-6 mb-12">
    <div class="bg-white p-6 rounded-[2rem] border border-gray-100 shadow-sm flex items-center gap-4">
        <div class="w-12 h-12 rounded-2xl bg-blue-50 text-blue-600 flex items-center justify-center text-xl shadow-inner uppercase font-black">
            <i class="fa-solid fa-chair"></i>
        </div>
        <div>
            <p class="text-[10px] font-black text-gray-400 uppercase tracking-widest">Total Tables</p>
            <p class="text-xl font-black text-gray-800"><%$stats.total%></p>
        </div>
    </div>
    <div class="bg-white p-6 rounded-[2rem] border border-gray-100 shadow-sm flex items-center gap-4">
        <div class="w-12 h-12 rounded-2xl bg-green-50 text-green-600 flex items-center justify-center text-xl shadow-inner">
            <i class="fa-solid fa-circle-check"></i>
        </div>
        <div>
            <p class="text-[10px] font-black text-gray-400 uppercase tracking-widest">Available</p>
            <p class="text-xl font-black text-gray-800"><%$stats.free%></p>
        </div>
    </div>
    <div class="bg-white p-6 rounded-[2rem] border border-gray-100 shadow-sm flex items-center gap-4">
        <div class="w-12 h-12 rounded-2xl bg-red-50 text-red-600 flex items-center justify-center text-xl shadow-inner">
            <i class="fa-solid fa-user-group"></i>
        </div>
        <div>
            <p class="text-[10px] font-black text-gray-400 uppercase tracking-widest">Occupied</p>
            <p class="text-xl font-black text-gray-800"><%$stats.occupied%></p>
        </div>
    </div>
    <div class="bg-white p-6 rounded-[2rem] border border-gray-100 shadow-sm flex items-center gap-4">
        <div class="w-12 h-12 rounded-2xl bg-orange-50 text-orange-600 flex items-center justify-center text-xl shadow-inner">
            <i class="fa-solid fa-bookmark"></i>
        </div>
        <div>
            <p class="text-[10px] font-black text-gray-400 uppercase tracking-widest">Reserved</p>
            <p class="text-xl font-black text-gray-800"><%$stats.reserved%></p>
        </div>
    </div>
</div>

<div class="space-y-16">
    <%foreach $restaurants as $restaurant%>
        <%if $is_superadmin%>
        <div class="mb-6">
            <div class="flex items-center gap-4 mb-4">
                <div class="w-14 h-14 rounded-[1.25rem] bg-gradient-to-br from-gray-900 to-gray-800 text-white flex items-center justify-center shadow-lg shadow-gray-200">
                    <i class="fa-solid fa-store text-xl"></i>
                </div>
                <div>
                    <h3 class="text-2xl font-black text-gray-900 tracking-tight"><%$restaurant.restaurant_name%></h3>
                    <p class="text-[10px] font-bold text-gray-400 uppercase tracking-widest mt-0.5">Restaurant Location</p>
                </div>
            </div>
            <div class="h-1.5 w-full bg-gray-100 rounded-full overflow-hidden">
                <div class="h-full bg-gray-900 w-24 rounded-full"></div>
            </div>
        </div>
        <%/if%>
        
        <div class="space-y-12 <%if $is_superadmin%>pl-0 md:pl-6 border-l-2 border-dashed border-gray-200<%/if%>">
            <%foreach $restaurant.floors as $floor%>
                <div class="animate-fade-in-up">
                    <div class="flex items-center gap-4 mb-6 <%if $is_superadmin%>-ml-[35px]<%/if%>">
                        <%if $is_superadmin%>
                        <div class="w-4 h-4 rounded-full bg-white border-4 border-blue-500 shadow-sm hidden md:block mt-1"></div>
                        <%/if%>
                        <div class="px-5 py-2.5 bg-blue-50/80 text-blue-700 rounded-xl text-xs font-black uppercase tracking-widest flex items-center gap-3 border border-blue-100 backdrop-blur-sm">
                            <i class="fa-solid fa-layer-group text-blue-500"></i>
                            <%$floor.name%>
                        </div>
                    </div>
                    
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6 <%if $is_superadmin%>ml-0 md:ml-4<%/if%>">
                        <%foreach $floor.tables as $table%>
                        <div class="group relative">
                            <a href="<%if $table.status == 'FREE'%><%base_url("admin/orders/create?table_id=`$table.table_id`")%><%else%><%base_url("admin/orders/manage/`$table.current_order_id`")%><%/if%>" 
                               class="block relative bg-white rounded-[2rem] p-6 border-2 transition-all duration-300 hover:shadow-[0_20px_40px_-15px_rgba(0,0,0,0.08)] hover:-translate-y-1 overflow-hidden group
                               <%if $table.status == 'FREE'%>
                                    border-gray-100 hover:border-blue-400
                               <%elseif $table.status == 'OCCUPIED'%>
                                    border-red-100 bg-gradient-to-b from-white to-red-50/50 hover:border-red-300
                               <%elseif $table.status == 'RESERVED'%>
                                    border-orange-100 bg-gradient-to-b from-white to-orange-50/50 hover:border-orange-300
                               <%elseif $table.status == 'CLEANING'%>
                                    border-gray-200 bg-gray-50
                               <%/if%>">

                                <!-- Top Row: Table No & Status -->
                                <div class="flex justify-between items-start mb-5">
                                    <div class="w-14 h-14 rounded-[1.25rem] flex items-center justify-center font-black text-xl transition-transform duration-300 group-hover:scale-110
                                        <%if $table.status == 'FREE'%>
                                            bg-blue-50 text-blue-600
                                        <%elseif $table.status == 'OCCUPIED'%>
                                            bg-red-500 text-white shadow-lg shadow-red-500/30
                                        <%elseif $table.status == 'RESERVED'%>
                                            bg-orange-500 text-white shadow-lg shadow-orange-500/30
                                        <%elseif $table.status == 'CLEANING'%>
                                            bg-gray-400 text-white
                                        <%/if%>">
                                        <%$table.table_no%>
                                    </div>
                                    
                                    <div class="px-3.5 py-1.5 rounded-full text-[10px] font-black tracking-widest uppercase flex items-center gap-1.5 shadow-sm
                                        <%if $table.status == 'FREE'%>
                                            bg-white border border-green-100 text-green-600
                                        <%elseif $table.status == 'OCCUPIED'%>
                                            bg-white border border-red-100 text-red-600
                                        <%elseif $table.status == 'RESERVED'%>
                                            bg-white border border-orange-100 text-orange-600
                                        <%elseif $table.status == 'CLEANING'%>
                                            bg-white border border-gray-200 text-gray-700
                                        <%/if%>">
                                        <div class="w-1.5 h-1.5 rounded-full bg-current animate-pulse"></div>
                                        <%$table.status%>
                                    </div>
                                </div>

                                <!-- Middle: Name & Seats -->
                                <div class="space-y-1 mb-5">
                                    <h4 class="font-bold text-gray-900 text-lg truncate"><%$table.name%></h4>
                                    <div class="flex items-center text-gray-400 text-xs font-semibold gap-2">
                                        <i class="fa-solid fa-users"></i>
                                        <span><%$table.capacity%> Seats</span>
                                    </div>
                                </div>

                                <!-- Bottom: Actions/Live Order -->
                                <%if $table.status == 'OCCUPIED'%>
                                    <div class="pt-4 border-t border-red-100">
                                        <div class="flex justify-between items-center">
                                            <div>
                                                <span class="block text-[9px] font-bold text-red-400 uppercase tracking-wider mb-0.5">Active Order</span>
                                                <span class="block text-sm font-black text-red-600"><%$table.order_number|default:"#`$table.current_order_id`"%></span>
                                            </div>
                                            <div class="w-10 h-10 rounded-xl bg-red-100 text-red-600 flex items-center justify-center group-hover:bg-red-600 group-hover:text-white transition-colors shadow-sm">
                                                <i class="fa-solid fa-arrow-right text-sm"></i>
                                            </div>
                                        </div>
                                    </div>
                                <%elseif $table.status == 'FREE'%>
                                    <div class="pt-4 border-t border-gray-100 flex items-center justify-between opacity-0 translate-y-2 group-hover:opacity-100 group-hover:translate-y-0 transition-all duration-300">
                                        <span class="text-[11px] font-black uppercase tracking-widest text-blue-600">Start Order</span>
                                        <div class="w-10 h-10 rounded-xl bg-blue-50 text-blue-600 flex items-center justify-center group-hover:bg-blue-600 group-hover:text-white transition-colors shadow-sm">
                                            <i class="fa-solid fa-plus text-sm"></i>
                                        </div>
                                    </div>
                                <%elseif $table.status == 'CLEANING'%>
                                     <div class="pt-4 border-t border-gray-200">
                                        <button onclick="event.preventDefault(); releaseTable(<%$table.table_id%>)" class="w-full py-3 bg-white border border-gray-200 hover:border-gray-900 hover:bg-gray-900 hover:text-white rounded-xl text-[10px] font-black uppercase tracking-widest transition-all shadow-sm">
                                            Mark as Free
                                        </button>
                                    </div>
                                <%/if%>
                            </a>
                        </div>
                        <%/foreach%>
                    </div>
                </div>
            <%/foreach%>
        </div>
    <%/foreach%>
</div>

<script>
function releaseTable(id) {
    Swal.fire({
        title: 'Table Cleaned?',
        text: "Mark this table as available for new guests?",
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#10b981',
        confirmButtonText: 'Yes, available'
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: '<%base_url("admin/orders/release_table")%>',
                type: 'POST',
                data: { table_id: id },
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        window.location.reload();
                    }
                }
            });
        }
    });
}
</script>

<style>
@keyframes pulse {
    0%, 100% { opacity: 1; transform: scale(1); }
    50% { opacity: .7; transform: scale(1.1); }
}
@keyframes fadeInUp {
    from { opacity: 0; transform: translateY(30px); }
    to { opacity: 1; transform: translateY(0); }
}
.animate-pulse {
    animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
}
.animate-fade-in-up {
    animation: fadeInUp 0.6s cubic-bezier(0.16, 1, 0.3, 1) both;
}
</style>
