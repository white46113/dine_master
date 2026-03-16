<div class="max-w-[1600px] mx-auto">
    <div class="flex flex-col lg:flex-row gap-8 items-start">
        
        <!-- Main Content: Menu & Filters (Left) -->
        <div class="flex-1 w-full lg:w-2/3 space-y-6">
            
            <!-- Enhanced Header -->
            <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-6 bg-white/50 backdrop-blur-md p-6 rounded-[2rem] border border-white shadow-sm">
                <div>
                    <h2 class="text-3xl font-black text-gray-800 tracking-tighter">Menu Items</h2>
                    <div class="flex items-center gap-3 mt-1">
                        <span class="px-2 py-0.5 bg-blue-50 text-blue-600 text-[10px] font-black rounded-lg uppercase">Table <%$order.table_no%></span>
                        <span class="text-gray-300">•</span>
                        <span class="text-gray-400 text-[10px] font-bold uppercase tracking-widest">Order #<%$order.order_number%></span>
                    </div>
                </div>
                
                <div class="flex flex-1 max-w-md relative group">
                    <i class="fa-solid fa-magnifying-glass absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-blue-500 transition-colors"></i>
                    <input type="text" id="item-search" placeholder="Search delicious food..." 
                           class="w-full pl-12 pr-4 py-3.5 rounded-2xl bg-white border border-gray-100 focus:border-blue-500 focus:ring-8 focus:ring-blue-50/50 outline-none transition-all text-sm font-bold shadow-sm"
                           onkeyup="searchItems()">
                </div>

                <a href="<%base_url('admin/orders')%>" class="px-6 py-3.5 rounded-2xl bg-white border border-gray-100 text-gray-400 hover:text-red-500 hover:border-red-100 transition-all shadow-sm font-black text-xs tracking-widest flex items-center gap-2">
                    <i class="fa-solid fa-arrow-left"></i> BACK
                </a>
            </div>

            <!-- Filters Bar -->
            <div class="flex flex-wrap items-center justify-between gap-4">
                <!-- Categories -->
                <div class="flex items-center gap-2 overflow-x-auto pb-2 no-scrollbar">
                    <button onclick="filterCategory(null)" class="cat-btn px-6 py-3 rounded-2xl bg-blue-600 text-white text-xs font-black shadow-xl shadow-blue-500/20 transition-all whitespace-nowrap">All Items</button>
                    <%foreach $categories as $cat%>
                    <button onclick="filterCategory('<%$cat.category_id%>')" class="cat-btn px-6 py-3 rounded-2xl bg-white text-gray-500 text-xs font-black border border-gray-100 hover:bg-gray-50 transition-all whitespace-nowrap shadow-sm"><%$cat.name%></button>
                    <%/foreach%>
                </div>

                <!-- Diet Filter (Veg/Non-veg) -->
                <div class="bg-white p-1.5 rounded-2xl border border-gray-100 shadow-sm flex items-center gap-1">
                    <button onclick="filterDiet(null)" class="diet-btn px-4 py-2 rounded-xl bg-gray-900 text-white text-[10px] font-black uppercase tracking-widest transition-all">All</button>
                    <button onclick="filterDiet('VEG')" class="diet-btn px-4 py-2 rounded-xl text-gray-400 hover:bg-gray-50 text-[10px] font-black uppercase tracking-widest transition-all flex items-center gap-2">
                        <div class="w-2 h-2 rounded-full bg-green-500"></div> Veg
                    </button>
                    <button onclick="filterDiet('NON-VEG')" class="diet-btn px-4 py-2 rounded-xl text-gray-400 hover:bg-gray-50 text-[10px] font-black uppercase tracking-widest transition-all flex items-center gap-2">
                        <div class="w-2 h-2 rounded-full bg-red-500"></div> Non-Veg
                    </button>
                </div>
            </div>

            <!-- Scrollable Menu Grid -->
            <div class="custom-scrollbar pr-2 overflow-y-auto" style="height: calc(100vh - 350px);">
                <div class="grid grid-cols-2 md:grid-cols-3 xl:grid-cols-4 2xl:grid-cols-5 gap-6" id="menu-grid">
                    <%foreach $items as $item%>
                    <div class="menu-item bg-white rounded-[2rem] p-4 border border-gray-100 shadow-sm hover:shadow-2xl hover:-translate-y-1 transition-all cursor-pointer group relative" 
                         data-cat="<%$item.category_id%>"
                         data-diet="<%$item.veg_type%>"
                         data-item='<%$item|json_encode|escape:"html"%>'>
                        
                        <div class="item-badge absolute -top-2 -right-2 w-8 h-8 bg-blue-600 text-white rounded-full flex items-center justify-center font-black text-xs shadow-lg scale-0 transition-all z-20" id="badge-<%$item.item_id%>">0</div>
                        
                        <div class="relative w-full aspect-square rounded-2xl overflow-hidden mb-4 bg-gray-50">
                            <img src="<%$item.image_url|default:base_url('public/img/food-placeholder.svg')%>" 
                                 class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-700"
                                 onerror="this.src='<%base_url('public/img/food-placeholder.svg')%>'; this.classList.add('opacity-50'); this.classList.add('p-4');">
                            
                            <!-- Diet Icon -->
                            <div class="absolute top-3 right-3 w-6 h-6 bg-white/90 backdrop-blur-sm rounded-lg flex items-center justify-center shadow-sm z-10 border border-gray-100">
                                <div class="w-2.5 h-2.5 rounded-full <%if $item.veg_type == 'VEG'%>bg-green-500<%else%>bg-red-50<%/if%> <%if $item.veg_type != 'VEG'%>border-2 border-red-500 bg-transparent<%/if%>"></div>
                            </div>

                            <!-- Click to Add Overlay -->
                            <div class="absolute inset-0 bg-blue-600/10 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center">
                                <div class="bg-blue-600 text-white p-3 rounded-2xl shadow-xl translate-y-4 group-hover:translate-y-0 transition-transform">
                                    <i class="fa-solid fa-plus"></i>
                                </div>
                            </div>
                        </div>

                        <div class="px-1">
                            <h4 class="font-bold text-gray-800 text-sm mb-1 truncate leading-tight"><%$item.name%></h4>
                            <p class="text-blue-600 font-black text-base">₹<%$item.base_price%></p>
                        </div>
                    </div>
                    <%/foreach%>
                </div>
            </div>
        </div>

        <!-- Sidebar: Cart & Order (Right) -->
        <div class="w-full lg:w-[380px] space-y-6 lg:sticky lg:top-6">
            <div class="bg-white rounded-[2.5rem] border border-gray-100 shadow-2xl flex flex-col h-[calc(100vh-100px)]">
                <!-- Sidebar Header -->
                <div class="p-8 border-b border-gray-50">
                    <div class="flex justify-between items-center mb-6">
                        <div class="flex items-center gap-3">
                            <div class="w-10 h-10 rounded-xl bg-orange-100 text-orange-600 flex items-center justify-center">
                                <i class="fa-solid fa-fire-burner"></i>
                            </div>
                            <h3 class="text-xl font-black text-gray-800 tracking-tighter">New Order</h3>
                        </div>
                        <span class="px-3 py-1 bg-blue-50 text-blue-600 text-[10px] font-black rounded-lg uppercase border border-blue-100 tracking-wider">Kitchen</span>
                    </div>
                    <div class="bg-gray-900 rounded-3xl p-6 text-white shadow-xl shadow-gray-200">
                        <p class="text-[10px] text-white/50 font-black uppercase tracking-[0.2em] mb-1">Total Payable</p>
                        <p class="text-3xl font-black tracking-tighter" id="cart-subtotal">₹0.00</p>
                    </div>
                </div>

                <!-- Scrollable Order List -->
                <div class="flex-1 overflow-y-auto p-6 space-y-4 custom-scrollbar" id="cart-items">
                    <div id="empty-cart-msg" class="flex flex-col items-center justify-center h-full text-center p-8 opacity-40">
                         <i class="fa-solid fa-basket-shopping text-5xl mb-4"></i>
                         <p class="text-sm font-bold text-gray-400 uppercase tracking-widest leading-loose">Hungry?<br>Start adding items</p>
                    </div>
                </div>

                <!-- Already Ordered Section (If exists) -->
                <%if $order_items%>
                <div class="px-6 py-4 border-t border-gray-50 bg-gray-50/50">
                    <button onclick="$('#ordered-list').slideToggle()" class="w-full flex justify-between items-center text-[10px] font-black text-gray-400 uppercase tracking-widest">
                        Ordered Items (<%count($order_items)%>)
                        <i class="fa-solid fa-chevron-down"></i>
                    </button>
                    <div id="ordered-list" class="mt-4 space-y-2 hidden">
                        <%foreach $order_items as $oi%>
                        <div class="flex items-center justify-between p-3 bg-white rounded-2xl border border-gray-100 <%if $oi.status == 'CANCELLED'%>opacity-50 grayscale<%/if%>">
                            <div class="min-w-0 flex-1">
                                <p class="text-xs font-bold text-gray-700 truncate leading-tight"><%$oi.item_name%></p>
                                <p class="text-[9px] text-gray-400 font-bold">Qty: <%$oi.quantity%> | <%$oi.status%></p>
                            </div>
                            <div class="flex items-center gap-2">
                                <span class="text-xs font-black text-gray-900 mx-2">₹<%$oi.line_total%></span>
                                <%if $oi.status != 'CANCELLED'%>
                                <button onclick="cancelItem('<%$oi.order_item_id%>', '<%$oi.item_name%>')" class="w-7 h-7 rounded-lg text-red-300 hover:text-red-600 transition-colors">
                                    <i class="fa-solid fa-trash-can text-[10px]"></i>
                                </button>
                                <%/if%>
                            </div>
                        </div>
                        <%/foreach%>
                    </div>
                </div>
                <%/if%>

                <!-- Actions Footer -->
                <div class="p-6 space-y-3 bg-gray-50/50 border-t border-gray-50">
                    <button onclick="sendToKitchen()" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-black py-4 rounded-2xl shadow-xl shadow-blue-500/30 transition-all flex items-center justify-center gap-2 text-sm tracking-wide group">
                         KITCHEN (KOT)
                         <i class="fa-solid fa-arrow-right text-[10px] group-hover:translate-x-1 transition-transform"></i>
                    </button>
                    <button onclick="generateBill()" class="w-full bg-white hover:bg-gray-100 text-gray-800 font-bold py-3.5 rounded-2xl border border-gray-200 transition-all text-sm">
                        Preview Bill
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
let cart = [];
let activeDiet = null;

function searchItems() {
    const query = $('#item-search').val().toLowerCase();
    const activeCat = $('.cat-btn.bg-blue-600').data('id');

    $('.menu-item').each(function() {
        const name = $(this).find('h4').text().toLowerCase();
        const cat = $(this).attr('data-cat');
        const diet = $(this).attr('data-diet');
        
        let matchesSearch = name.includes(query);
        let matchesCat = activeCat === undefined || cat == activeCat;
        let matchesDiet = activeDiet === null || diet == activeDiet;
        
        if (matchesSearch && matchesCat && matchesDiet) $(this).fadeIn(200);
        else $(this).hide();
    });
}

function filterCategory(catId) {
    $('.cat-btn').removeClass('bg-blue-600 text-white shadow-xl shadow-blue-500/20 translate-y-[-2px]').addClass('bg-white text-gray-500 border-gray-100 shadow-sm').removeData('id');
    
    if (catId === null) {
        $('.cat-btn').first().addClass('bg-blue-600 text-white shadow-xl shadow-blue-500/20 translate-y-[-2px]').removeClass('bg-white text-gray-500 border-gray-100 shadow-sm');
    } else {
        $(event.target).addClass('bg-blue-600 text-white shadow-xl shadow-blue-500/20 translate-y-[-2px]').removeClass('bg-white text-gray-500 border-gray-100 shadow-sm').data('id', catId);
    }
    searchItems();
}

function filterDiet(diet) {
    activeDiet = diet;
    $('.diet-btn').removeClass('bg-gray-900 text-white shadow-lg').addClass('text-gray-400 hover:bg-gray-50');
    
    if (diet === null) {
        $('.diet-btn').eq(0).addClass('bg-gray-900 text-white shadow-lg').removeClass('text-gray-400 hover:bg-gray-50');
    } else if (diet === 'VEG') {
        $('.diet-btn').eq(1).addClass('bg-gray-900 text-white shadow-lg').removeClass('text-gray-400 hover:bg-gray-50');
    } else if (diet === 'NON-VEG') {
        $('.diet-btn').eq(2).addClass('bg-gray-900 text-white shadow-lg').removeClass('text-gray-400 hover:bg-gray-50');
    }
    searchItems();
}

$(document).on('click', '.menu-item', function() {
    const item = $(this).data('item');
    addToCart(item);
    
    // Smooth Animation for badge
    const badge = $(`#badge-${item.item_id || item.id}`);
    badge.addClass('scale-125');
    setTimeout(() => badge.removeClass('scale-125'), 200);
});

$(document).on('click', '.cart-qty-btn', function() {
    const id = $(this).data('id');
    const delta = parseInt($(this).data('delta'));
    updateQty(id, delta);
});

$(document).on('change', '.cart-note-input', function() {
    const id = $(this).data('id');
    updateNote(id, $(this).val());
});

function addToCart(item, skipEvent = false) {
    if (typeof item === 'string') item = JSON.parse(item);
    
    // Normalize properties
    item.item_id = item.item_id || item.id;
    item.name = item.name || item.item_name;
    item.base_price = item.base_price || item.unit_price;

    const existing = cart.find(i => i.item_id == item.item_id);
    if (existing) {
        existing.qty++;
    } else {
        cart.push({ ...item, qty: 1, note: '' });
    }
    renderCart();
}

function updateQty(itemId, delta) {
    const item = cart.find(i => i.item_id == itemId);
    if (item) {
        item.qty += delta;
        if (item.qty <= 0) {
            cart = cart.filter(i => i.item_id != itemId);
        }
    }
    renderCart();
}

function updateNote(itemId, note) {
    const item = cart.find(i => i.item_id == itemId);
    if (item) item.note = note;
}

function renderCart() {
    const $container = $('#cart-items');
    const $emptyMsg = $('#empty-cart-msg');
    
    if (cart.length === 0) {
        $container.html('').append($emptyMsg);
        $('#cart-subtotal').text('₹0.00');
        return;
    }

    $emptyMsg.detach();
    $container.html('');

    let subtotal = 0;
    cart.forEach(item => {
        const total = item.base_price * item.qty;
        subtotal += total;
        
        $container.append(`
            <div class="bg-white p-4 rounded-[2rem] border border-gray-50 shadow-sm animate-fade-in group hover:border-blue-100 transition-all">
                <div class="flex justify-between items-start mb-3">
                    <div class="flex-1 pr-4">
                        <div class="font-bold text-gray-800 text-xs leading-tight mb-1">${item.name}</div>
                        <div class="text-[10px] font-black text-blue-600 tracking-tight">₹${item.base_price}</div>
                    </div>
                    <div class="text-xs font-black text-gray-900">₹${total.toFixed(0)}</div>
                </div>
                <div class="flex items-center justify-between">
                    <div class="flex items-center bg-gray-50 rounded-xl p-0.5 border border-gray-100">
                        <button data-id="${item.item_id}" data-delta="-1" class="cart-qty-btn w-7 h-7 flex items-center justify-center text-gray-400 hover:text-red-500 transition-colors"><i class="fa-solid fa-minus text-[8px]"></i></button>
                        <span class="w-7 text-center font-black text-xs text-gray-800">${item.qty}</span>
                        <button data-id="${item.item_id}" data-delta="1" class="cart-qty-btn w-7 h-7 flex items-center justify-center text-gray-400 hover:text-green-500 transition-colors"><i class="fa-solid fa-plus text-[8px]"></i></button>
                    </div>
                    <div class="flex-1 ml-4">
                        <input type="text" placeholder="Note (E.g. No spicy)" value="${item.note}" 
                               data-id="${item.item_id}"
                               class="cart-note-input w-full text-[9px] bg-transparent border-none outline-none focus:text-blue-500 transition-all text-gray-400 font-bold placeholder:text-gray-200">
                    </div>
                </div>
            </div>
        `);
    });

    $('#cart-subtotal').text('₹' + subtotal.toFixed(2));
    
    // Sync Badges on Menu Cards
    $('.item-badge').addClass('hidden scale-0').text('0');
    cart.forEach(item => {
        const badge = $(`#badge-${item.item_id}`);
        if(badge.length) {
            badge.text(item.qty).removeClass('hidden').addClass('scale-100');
        }
    });
}

function sendToKitchen() {
    if (cart.length === 0) {
        Swal.fire({
            title: 'Empty Cart',
            text: 'Why wait? Add some items and send to kitchen!',
            icon: 'info',
            confirmButtonColor: '#2563eb'
        });
        return;
    }

    $.ajax({
        url: '<%base_url("admin/orders/send_to_kitchen")%>',
        type: 'POST',
        data: { 
            order_id: '<%$order.order_id%>',
            items: cart
        },
        dataType: 'json',
        success: function(response) {
            if (response.success) {
                Swal.fire({
                    title: 'Orders Sizzling!',
                    text: 'KOT has been generated successfully',
                    icon: 'success',
                    timer: 1000,
                    showConfirmButton: false
                }).then(() => {
                    window.location.reload();
                });
            }
        }
    });
}

function generateBill() {
     window.location.href = '<%base_url("admin/orders/bill/`$order.order_id`")%>';
}

function cancelItem(orderItemId, itemName) {
    Swal.fire({
        title: 'Cancel Item?',
        text: `Are you sure you want to cancel ${itemName}?`,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonColor: '#3085d6',
        confirmButtonText: 'Yes, cancel it!',
        cancelButtonText: 'No, keep it'
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: '<%base_url("admin/orders/cancel_item")%>',
                type: 'POST',
                data: { order_item_id: orderItemId },
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        Swal.fire({
                            title: 'Cancelled!',
                            text: 'Item has been removed.',
                            icon: 'success',
                            timer: 1000,
                            showConfirmButton: false
                        }).then(() => {
                            window.location.reload();
                        });
                    } else {
                        Swal.fire('Error', response.message || 'Failed to cancel item', 'error');
                    }
                }
            });
        }
    });
}

// Initialize tooltips or other UI components if needed
$(document).ready(function() {
    // Add any init code
});
</script>

<style>
.no-scrollbar::-webkit-scrollbar { display: none; }
.no-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }

.custom-scrollbar::-webkit-scrollbar { width: 5px; }
.custom-scrollbar::-webkit-scrollbar-track { background: transparent; }
.custom-scrollbar::-webkit-scrollbar-thumb { background: #E5E7EB; border-radius: 20px; }
.custom-scrollbar::-webkit-scrollbar-thumb:hover { background: #D1D5DB; }

.animate-fade-in { animation: fadeIn 0.4s cubic-bezier(0.16, 1, 0.3, 1); }
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(15px); }
    to { opacity: 1; transform: translateY(0); }
}

.item-badge { transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1); }

@media (max-width: 1024px) {
    .h-\[calc\(100vh-100px\)\] { height: auto; }
}
</style>
