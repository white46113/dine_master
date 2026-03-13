<div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
    <div>
        <h2 class="text-2xl font-bold text-gray-800">Kitchen Display</h2>
        <p class="text-gray-500 text-sm">Real-time KOT tracking and status management</p>
    </div>
    <div class="flex items-center gap-3">
        <button onclick="window.location.reload()" class="bg-white hover:bg-gray-50 text-gray-600 font-bold py-2.5 px-4 rounded-xl border border-gray-200 transition-all shadow-sm flex items-center">
            <i class="fa-solid fa-rotate mr-2 text-sm"></i>
            Refresh
        </button>
    </div>
</div>

<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
    <%foreach $kots as $kot%>
    <div class="bg-white rounded-[2rem] border border-gray-100 shadow-xl overflow-hidden flex flex-col h-fit animate-fade-in">
        <div class="p-5 bg-gray-50/50 border-b border-gray-100">
            <div class="flex justify-between items-start mb-2">
                <div>
                    <div class="flex items-center gap-2">
                        <span class="w-10 h-10 rounded-2xl bg-blue-600 text-white flex items-center justify-center font-black text-lg shadow-lg shadow-blue-200">
                            <%$kot.table_no%>
                        </span>
                        <div>
                            <div class="font-black text-gray-800 text-sm">#<%$kot.order_number%></div>
                            <div class="text-[10px] font-bold text-gray-400 uppercase tracking-widest"><%date('h:i A', strtotime($kot.added_date))%></div>
                        </div>
                    </div>
                </div>
                <button onclick="completeKot(<%$kot.kot_id%>)" class="text-gray-400 hover:text-green-600 transition-colors">
                    <i class="fa-solid fa-circle-check text-xl"></i>
                </button>
            </div>
        </div>

        <div class="p-5 space-y-4 flex-1">
            <%foreach $kot.items as $item%>
            <div class="flex items-start justify-between border-b border-dashed border-gray-100 pb-3 last:border-0 last:pb-0">
                <div class="flex-1 pr-3">
                    <div class="flex items-center gap-2">
                        <%if $item.veg_type == 'VEG'%>
                        <div class="w-2.5 h-2.5 rounded-full bg-green-500"></div>
                        <%else%>
                        <div class="w-2.5 h-2.5 rounded-full bg-red-500"></div>
                        <%/if%>
                        <span class="font-bold text-gray-800 text-sm"><%$item.quantity%> x <%$item.item_name%></span>
                    </div>
                    <%if $item.notes%>
                    <p class="text-[10px] text-orange-500 font-bold bg-orange-50 px-2 py-0.5 rounded-md mt-1 inline-block">Note: <%$item.notes%></p>
                    <%/if%>
                </div>
                
                <div class="flex flex-col items-end gap-2">
                    <button onclick="updateItemStatus(<%$item.order_item_id%>, '<%if $item.status == 'PENDING'%>PREPARING<%elseif $item.status == 'PREPARING'%>READY<%else%>SERVED<%/if%>')" 
                            class="px-3 py-1 rounded-lg text-[10px] font-black uppercase tracking-wider transition-all
                            <%if $item.status == 'PENDING'%>
                                bg-orange-100 text-orange-600 hover:bg-orange-600 hover:text-white
                            <%elseif $item.status == 'PREPARING'%>
                                bg-blue-100 text-blue-600 hover:bg-blue-600 hover:text-white
                            <%elseif $item.status == 'READY'%>
                                bg-green-100 text-green-600 hover:bg-green-600 hover:text-white
                            <%else%>
                                bg-gray-100 text-gray-600
                            <%/if%>">
                        <%$item.status%>
                    </button>
                </div>
            </div>
            <%/foreach%>
        </div>

        <div class="p-4 bg-gray-50/50 text-[10px] font-bold text-gray-400 text-center uppercase tracking-tighter">
            KOT ID: <%$kot.kot_id%> | <%count($kot.items)%> Items
        </div>
    </div>
    <%/foreach%>
</div>

<script>
function updateItemStatus(itemId, nextStatus) {
    $.ajax({
        url: '<%base_url("admin/kitchen/update_item_status")%>',
        type: 'POST',
        data: { order_item_id: itemId, status: nextStatus },
        dataType: 'json',
        success: function(response) {
            if (response.success) {
                window.location.reload();
            }
        }
    });
}

function completeKot(kotId) {
    Swal.fire({
        title: 'Complete KOT?',
        text: 'Are you sure all items are prepared?',
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#10b981',
        confirmButtonText: 'Yes, complete'
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: '<%base_url("admin/kitchen/complete_kot")%>',
                type: 'POST',
                data: { kot_id: kotId },
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
.animate-fade-in {
    animation: fadeIn 0.4s ease-out;
}
@keyframes fadeIn {
    from { opacity: 0; scale: 0.95; }
    to { opacity: 1; scale: 1; }
}
</style>
