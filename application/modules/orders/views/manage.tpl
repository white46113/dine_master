<div class="flex flex-col gap-6">
    <!-- View Header -->
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
        <div>
            <h2 class="text-2xl font-bold text-gray-800">Menu Items</h2>
            <p class="text-gray-500 text-sm">Table: <span class="text-blue-600 font-bold"><%$order.table_no%></span> | Order: <span class="font-bold">#<%$order.order_number%></span></p>
        </div>
        <div class="flex flex-col md:flex-row items-center gap-4 w-full md:w-auto">
            <div class="relative w-full md:w-64">
                <i class="fa-solid fa-magnifying-glass absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 text-xs"></i>
                <input type="text" id="item-search" placeholder="Search items..." 
                       class="w-full pl-10 pr-4 py-2.5 rounded-2xl bg-white border border-gray-100 focus:border-blue-500 focus:ring-4 focus:ring-blue-50 outline-none transition-all text-sm font-bold shadow-sm"
                       onkeyup="searchItems()">
            </div>
            <div class="flex items-center gap-2 overflow-x-auto flex-1 md:flex-initial">
                <button onclick="filterCategory(null)" class="cat-btn px-4 py-2 rounded-xl bg-blue-600 text-white text-sm font-bold shadow-md transition-all">All</button>
                <%foreach $categories as $cat%>
                <button onclick="filterCategory('<%$cat.category_id%>')" class="cat-btn px-4 py-2 rounded-xl bg-white text-gray-600 text-sm font-bold border border-gray-100 hover:bg-gray-50 transition-all whitespace-nowrap"><%$cat.name%></button>
                <%/foreach%>
            </div>
            <a href="<%base_url('admin/orders')%>" class="flex items-center gap-2 px-6 py-2.5 rounded-2xl bg-white border border-gray-100 text-gray-400 hover:text-red-600 hover:border-red-100 transition-all shadow-sm font-bold text-sm">
                <i class="fa-solid fa-arrow-left"></i> BACK
            </a>
        </div>
    </div>

    <!-- Menu Grid -->
    <div class="bg-white/30 backdrop-blur-sm rounded-[2.5rem] p-8 border border-white/40 shadow-xl overflow-y-auto max-h-[60vh]">
        <div class="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-6 gap-6" id="menu-grid">
            <%foreach $items as $item%>
            <div class="menu-item bg-white rounded-3xl p-4 border border-gray-100 shadow-sm hover:shadow-xl transition-all cursor-pointer group relative" 
                 data-cat="<%$item.category_id%>"
                 data-item='<%$item|json_encode|escape:"html"%>'>
                <div class="item-badge absolute -top-2 -right-2 w-8 h-8 bg-blue-600 text-white rounded-full flex items-center justify-center font-black text-xs shadow-lg scale-0 transition-transform z-20 hidden" id="badge-<%$item.item_id%>">0</div>
                <div class="relative w-full aspect-square rounded-2xl overflow-hidden mb-3 bg-gray-50">
                    <img src="<%$item.image_url|default:base_url('public/img/food-placeholder.svg')%>" 
                         class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500"
                         onerror="this.src='<%base_url('public/img/food-placeholder.svg')%>'; this.classList.add('opacity-50'); this.classList.add('p-4');">
                    
                    <!-- Quantity Controls Overlay -->
                    <div class="absolute inset-0 bg-black/40 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity quantity-controls-overlay z-10">
                         <div class="flex items-center bg-white rounded-2xl p-1 gap-2 shadow-2xl scale-75 group-hover:scale-100 transition-transform">
                            <button onclick="event.stopPropagation(); updateQty(<%$item.item_id%>, -1)" class="w-10 h-10 rounded-xl hover:bg-red-50 text-gray-400 hover:text-red-500 transition-colors flex items-center justify-center">
                                <i class="fa-solid fa-minus"></i>
                            </button>
                            <span class="font-black text-gray-800 w-6 text-center item-qty-display" id="qty-display-<%$item.item_id%>">0</span>
                            <button onclick="event.stopPropagation(); addToCart(<%$item|json_encode|escape:'html'|default:'{}'%>, true)" class="w-10 h-10 rounded-xl hover:bg-green-50 text-gray-400 hover:text-green-500 transition-colors flex items-center justify-center">
                                <i class="fa-solid fa-plus"></i>
                            </button>
                         </div>
                    </div>

                    <%if $item.veg_type == 'VEG'%>
                    <div class="absolute top-2 right-2 w-5 h-5 bg-white rounded border border-green-500 flex items-center justify-center z-10">
                        <div class="w-2.5 h-2.5 bg-green-500 rounded-full"></div>
                    </div>
                    <%else%>
                    <div class="absolute top-2 right-2 w-5 h-5 bg-white rounded border border-red-500 flex items-center justify-center z-10">
                        <div class="w-2.5 h-2.5 bg-red-500 rounded-full"></div>
                    </div>
                    <%/if%>
                </div>
                <h4 class="font-bold text-gray-800 text-sm mb-1 truncate"><%$item.name%></h4>
                <p class="text-blue-600 font-black text-sm">₹<%$item.base_price%></p>
            </div>
            <%/foreach%>
        </div>
    </div>

    <!-- Current Order Card (Bottom) -->
    <div class="bg-white rounded-[2.5rem] border border-gray-100 shadow-2xl overflow-hidden animate-fade-in-up">
        <div class="p-8 border-b border-gray-50 flex justify-between items-center bg-gray-50/30">
            <div class="flex items-center gap-4">
                <div class="w-12 h-12 rounded-2xl bg-blue-100 text-blue-600 flex items-center justify-center text-xl">
                    <i class="fa-solid fa-receipt"></i>
                </div>
                <div>
                    <h3 class="text-xl font-bold text-gray-800">Current Order</h3>
                    <p class="text-xs text-gray-400 font-bold uppercase tracking-wider">Review and send items to kitchen</p>
                </div>
            </div>
            <div class="flex items-center gap-3">
                <span class="px-4 py-2 bg-blue-50 text-blue-600 text-xs font-black rounded-xl uppercase tracking-widest border border-blue-100"><%$order.status%></span>
                <div class="h-10 w-px bg-gray-100 mx-2"></div>
                <div class="text-right">
                    <p class="text-[10px] text-gray-400 font-black uppercase tracking-widest">Grand Total</p>
                    <p class="text-2xl font-black text-gray-800" id="cart-subtotal">₹0.00</p>
                </div>
            </div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 p-8" id="cart-items">
            <!-- Items injected here -->
        </div>

        <!-- Ordered Items Section -->
        <%if $order_items%>
        <div class="px-8 pb-8">
            <h4 class="text-[10px] font-black text-gray-300 uppercase tracking-[0.2em] mb-4 flex items-center gap-4">
                ALREADY ORDERED
                <div class="h-px flex-1 bg-gray-50"></div>
            </h4>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                <%foreach $order_items as $oi%>
                <div class="bg-gray-50/50 p-4 rounded-3xl border border-gray-100 flex justify-between items-center group hover:bg-white hover:shadow-lg transition-all animate-fade-in
                     <%if $oi.status == 'CANCELLED'%>opacity-50 grayscale<%/if%>">
                    <div class="min-w-0">
                        <div class="font-bold text-gray-700 text-sm truncate <%if $oi.status == 'CANCELLED'%>line-through<%/if%>"><%$oi.item_name%></div>
                        <div class="text-[10px] text-gray-400 font-bold uppercase tracking-widest mt-1">
                             Qty: <%$oi.quantity%> | <span class="<%if $oi.status == 'CANCELLED'%>bg-gray-200 text-gray-500<%else%>bg-blue-100 text-blue-600<%/if%> px-2 py-0.5 rounded-lg"><%$oi.status%></span>
                        </div>
                    </div>
                    <div class="flex items-center gap-3">
                        <div class="text-sm font-black text-gray-900">₹<%$oi.line_total%></div>
                        <div class="flex items-center gap-2">
                            <%if $oi.status != 'CANCELLED'%>
                            <button onclick="cancelItem('<%$oi.order_item_id%>', '<%$oi.item_name%>')" class="w-8 h-8 rounded-xl bg-white border border-red-50 flex items-center justify-center text-red-300 hover:bg-red-600 hover:text-white transition-all shadow-sm tooltip" title="Cancel Item">
                                <i class="fa-solid fa-ban text-[10px]"></i>
                            </button>
                            <button onclick='addToCart(<%$oi|json_encode|escape:"html"%>, true)' class="w-10 h-10 rounded-2xl bg-white border border-gray-100 flex items-center justify-center text-blue-600 hover:bg-blue-600 hover:text-white transition-all shadow-sm">
                                <i class="fa-solid fa-plus text-xs"></i>
                            </button>
                            <%/if%>
                        </div>
                    </div>
                </div>
                <%/foreach%>
            </div>
        </div>
        <%/if%>

        <div class="p-8 bg-gray-50 border-t border-gray-100 flex flex-col md:flex-row gap-4 items-center justify-end">
             <button onclick="generateBill()" class="w-full md:w-auto px-10 py-4 bg-white hover:bg-gray-100 text-gray-800 font-black rounded-2xl border border-gray-200 transition-all flex items-center justify-center gap-3 shadow-sm text-sm">
                <i class="fa-solid fa-file-invoice-dollar text-gray-400"></i>
                PREVIEW BILL
            </button>
            <button onclick="sendToKitchen()" class="w-full md:w-auto px-12 py-5 bg-blue-600 hover:bg-blue-700 text-white font-black rounded-2xl shadow-xl shadow-blue-200 transition-all flex items-center justify-center gap-3 text-sm tracking-wide">
                <i class="fa-solid fa-fire-burner"></i>
                SEND TO KITCHEN (KOT)
            </button>
        </div>
    </div>
</div>

<script>
let cart = [];

function searchItems() {
    const query = $('#item-search').val().toLowerCase();
    const activeCat = $('.cat-btn.bg-blue-600').data('id');

    $('.menu-item').each(function() {
        const name = $(this).find('h4').text().toLowerCase();
        const cat = $(this).attr('data-cat');
        
        let matchesSearch = name.includes(query);
        let matchesCat = activeCat === undefined || cat == activeCat;
        
        if (matchesSearch && matchesCat) $(this).show();
        else $(this).hide();
    });
}

function filterCategory(catId) {
    $('.cat-btn').removeClass('bg-blue-600 text-white shadow-md').addClass('bg-white text-gray-600 border-gray-100').removeData('id');
    const query = $('#item-search').val().toLowerCase();

    if (catId === null) {
        $('.cat-btn').first().addClass('bg-blue-600 text-white shadow-md').removeClass('bg-white text-gray-600 border-gray-100');
    } else {
        $(event.target).addClass('bg-blue-600 text-white shadow-md').removeClass('bg-white text-gray-600 border-gray-100').data('id', catId);
    }
    searchItems();
}

$(document).on('click', '.menu-item', function() {
    const item = $(this).data('item');
    addToCart(item);
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
            <div class="bg-white p-4 rounded-2xl border border-gray-50 shadow-sm animate-fade-in">
                <div class="flex justify-between items-start mb-2 text-sm">
                    <div class="font-bold text-gray-800 leading-tight">${item.name}</div>
                    <div class="font-black text-gray-900 ml-2">₹${total.toFixed(2)}</div>
                </div>
                <div class="flex items-center justify-between mt-3">
                    <div class="flex items-center bg-gray-100 rounded-xl p-1">
                        <button data-id="${item.item_id}" data-delta="-1" class="cart-qty-btn w-7 h-7 flex items-center justify-center text-gray-500 hover:text-red-500"><i class="fa-solid fa-minus text-[10px]"></i></button>
                        <span class="w-8 text-center font-bold text-xs uppercase">${item.qty}</span>
                        <button data-id="${item.item_id}" data-delta="1" class="cart-qty-btn w-7 h-7 flex items-center justify-center text-gray-500 hover:text-green-500"><i class="fa-solid fa-plus text-[10px]"></i></button>
                    </div>
                    <div class="flex-1 ml-3">
                        <input type="text" placeholder="Add note..." value="${item.note}" 
                               data-id="${item.item_id}"
                               class="cart-note-input w-full text-[10px] bg-transparent border-b border-dashed border-gray-200 outline-none focus:border-blue-500 transition-all text-gray-400 font-medium">
                    </div>
                </div>
            </div>
        `);
    });

    $('#cart-subtotal').text('₹' + subtotal.toFixed(2));
    
    // Sync Badges on Menu Cards
    $('.item-badge').addClass('hidden scale-0').text('0');
    $('.item-qty-display').text('0');
    cart.forEach(item => {
        const badge = $(`#badge-${item.item_id}`);
        const qtyDisplay = $(`#qty-display-${item.item_id}`);
        if(badge.length) {
            badge.text(item.qty).removeClass('hidden').addClass('scale-100');
        }
        if(qtyDisplay.length) {
            qtyDisplay.text(item.qty);
        }
    });
}

function sendToKitchen() {
    if (cart.length === 0) {
        Swal.fire('Empty Cart', 'Please add items before sending to kitchen', 'warning');
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
                    title: 'Kitchen Request Sent!',
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
                            text: 'Item has been removed from the active order.',
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
</script>

<style>
.animate-fade-in {
    animation: fadeIn 0.3s ease-out;
}
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
}
@keyframes fadeInUp {
    from { opacity: 0; transform: translateY(40px); }
    to { opacity: 1; transform: translateY(0); }
}
.animate-fade-in-up {
    animation: fadeInUp 0.5s cubic-bezier(0.16, 1, 0.3, 1);
}
</style>
