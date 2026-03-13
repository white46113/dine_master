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

<div class="space-y-12">
    <%foreach $floors as $floor%>
    <div class="animate-fade-in-up">
        <div class="flex items-center gap-6 mb-8">
            <div class="px-6 py-2 bg-gray-900 text-white rounded-2xl text-[10px] font-black uppercase tracking-[0.3em] flex items-center gap-3 shadow-xl">
                <i class="fa-solid fa-layer-group text-blue-400"></i>
                <%$floor.name%>
            </div>
            <div class="h-px flex-1 bg-gradient-to-r from-gray-100 to-transparent"></div>
        </div>
        
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-10">
            <%foreach $floor_tables[$floor.floor_id] as $table%>
            <div class="group relative">
                <a href="<%if $table.status == 'FREE'%><%base_url("admin/orders/create?table_id=`$table.table_id`")%><%else%><%base_url("admin/orders/manage/`$table.current_order_id`")%><%/if%>" 
                   class="block relative p-7 rounded-[2.5rem] border-2 transition-all duration-700 hover:shadow-2xl hover:-translate-y-2 overflow-hidden
                   <%if $table.status == 'FREE'%>
                        bg-white border-white shadow-xl shadow-gray-100/40 hover:border-blue-100
                   <%elseif $table.status == 'OCCUPIED'%>
                        bg-gradient-to-br from-red-50 to-white border-red-50 shadow-xl shadow-red-500/10
                   <%elseif $table.status == 'RESERVED'%>
                        bg-gradient-to-br from-orange-50 to-white border-orange-50 shadow-xl shadow-orange-500/10
                   <%elseif $table.status == 'CLEANING'%>
                        bg-gray-100 border-gray-200
                   <%/if%>">
                    
                    <!-- Medium Background Watermark -->
                    <div class="absolute -right-6 -bottom-6 text-[8rem] font-black opacity-[0.02] select-none group-hover:scale-110 transition-all duration-1000 leading-none">
                        <%$table.table_no%>
                    </div>

                    <div class="flex justify-between items-start mb-6 relative z-10">
                        <div class="w-14 h-14 rounded-2xl flex items-center justify-center font-black text-xl shadow-xl transition-all group-hover:rotate-6
                            <%if $table.status == 'FREE'%>
                                bg-blue-600 text-white shadow-blue-500/20
                            <%elseif $table.status == 'OCCUPIED'%>
                                bg-red-600 text-white shadow-red-500/20
                            <%elseif $table.status == 'RESERVED'%>
                                bg-orange-600 text-white shadow-orange-500/20
                            <%elseif $table.status == 'CLEANING'%>
                                bg-gray-600 text-white shadow-gray-500/20
                            <%/if%>">
                            <%$table.table_no%>
                        </div>
                        
                        <div class="flex items-center gap-2 px-3.5 py-1.5 rounded-xl bg-white/95 backdrop-blur-xl border border-white/50 shadow-sm">
                            <div class="w-2.5 h-2.5 rounded-full
                                <%if $table.status == 'FREE'%>
                                    bg-green-500
                                <%elseif $table.status == 'OCCUPIED'%>
                                    bg-red-500
                                <%elseif $table.status == 'RESERVED'%>
                                    bg-yellow-500
                                <%elseif $table.status == 'CLEANING'%>
                                    bg-gray-500
                                <%/if%>"></div>
                            <span class="text-[9px] font-black uppercase tracking-widest text-gray-800"><%$table.status%></span>
                        </div>
                    </div>

                    <div class="relative z-10 mb-6">
                        <div class="font-black text-gray-900 text-xl tracking-tight mb-2 group-hover:text-blue-600 transition-colors"><%$table.name%></div>
                        <div class="flex items-center gap-3">
                            <div class="flex items-center gap-1.5 px-2 py-1 bg-gray-50 rounded-lg text-gray-400 text-[10px] font-bold border border-gray-100/50">
                                <i class="fa-solid fa-users text-[8px]"></i>
                                <span><%$table.capacity%> Seats</span>
                            </div>
                            <div class="flex items-center gap-1.5 px-2 py-1 bg-gray-50 rounded-lg text-gray-400 text-[10px] font-bold border border-gray-100/50">
                                <i class="fa-solid fa-layer-group text-[8px]"></i>
                                <span><%$floor.name%></span>
                            </div>
                        </div>
                    </div>

                    <%if $table.status == 'OCCUPIED'%>
                    <div class="mt-6 pt-5 border-t border-red-50 relative z-10">
                        <div class="grid grid-cols-2 gap-4">
                             <div class="bg-white p-3 rounded-xl border border-red-50 shadow-sm">
                                <span class="block text-[8px] font-black text-red-300 uppercase tracking-widest mb-1">LIVE ORDER</span>
                                <span class="block text-xs font-black text-red-600"><%$table.order_number|default:"#`$table.current_order_id`"%></span>
                            </div>
                            <div class="bg-red-600 p-3 rounded-xl shadow-lg shadow-red-100 flex flex-col justify-center">
                                <span class="block text-[8px] font-black text-red-100 uppercase tracking-widest mb-1">STATUS</span>
                                <span class="block text-[9px] font-black text-white italic tracking-wide uppercase"><%$table.order_status%></span>
                            </div>
                        </div>
                    </div>
                    <%/if%>

                    <%if $table.status == 'FREE'%>
                    <div class="mt-6 opacity-0 group-hover:opacity-100 transition-all duration-500 transform translate-y-2 group-hover:translate-y-0 relative z-10">
                        <div class="flex items-center justify-center py-3.5 bg-blue-600 text-white rounded-2xl gap-3 font-black text-[10px] tracking-[0.25em] shadow-xl shadow-blue-500/30 uppercase ring-4 ring-blue-50">
                            NEW ORDER <i class="fa-solid fa-plus text-[8px]"></i>
                        </div>
                    </div>
                    <%else if $table.status == 'OCCUPIED'%>
                    <div class="mt-6 opacity-0 group-hover:opacity-100 transition-all duration-500 transform translate-y-2 group-hover:translate-y-0 relative z-10">
                        <div class="flex items-center justify-center py-3.5 bg-gray-900 text-white rounded-2xl gap-3 font-black text-[10px] tracking-[0.25em] shadow-xl shadow-gray-500/30 uppercase">
                            MANAGE <i class="fa-solid fa-arrow-right text-[8px]"></i>
                        </div>
                    </div>
                    <%/if%>

                    <%if $table.status == 'CLEANING'%>
                    <div class="mt-6 relative z-10 text-center">
                        <button onclick="event.preventDefault(); releaseTable(<%$table.table_id%>)" class="w-full py-4 bg-white hover:bg-gray-900 border border-gray-100 hover:text-white rounded-2xl text-[9px] font-black uppercase tracking-widest transition-all shadow-lg shadow-gray-100">
                            MARK AS FREE
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
