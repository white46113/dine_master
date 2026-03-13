<div class="max-w-4xl mx-auto">
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
        <div>
            <h2 class="text-2xl font-bold text-gray-800">Bill Preview</h2>
            <p class="text-gray-500 text-sm">Review charges and process payment for <span class="text-blue-600 font-bold">Table <%$order.table_no%></span></p>
        </div>
        <button onclick="window.history.back()" class="text-gray-400 hover:text-gray-600 font-bold text-sm flex items-center gap-2">
            <i class="fa-solid fa-arrow-left"></i> Back to Manage
        </button>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <!-- Receipt (Left) -->
        <div class="lg:col-span-2 space-y-6">
            <div class="bg-white rounded-[2.5rem] shadow-xl border border-gray-100 overflow-hidden relative">
                <!-- Receipt Header Decor -->
                <div class="absolute top-0 left-0 w-full h-2 bg-gradient-to-r from-blue-500 to-blue-600"></div>
                
                <div class="p-10">
                    <div class="flex justify-between items-start mb-10">
                        <div>
                            <h3 class="text-2xl font-black text-gray-800 tracking-tighter">DINE MASTER</h3>
                            <p class="text-xs text-gray-400 font-bold uppercase tracking-widest mt-1">Gourmet Dining Experience</p>
                        </div>
                        <div class="text-right">
                            <div class="text-xs text-gray-400 font-bold uppercase tracking-widest">Order Number</div>
                            <div class="text-lg font-black text-gray-800">#<%$order.order_number%></div>
                        </div>
                    </div>

                    <div class="space-y-6">
                        <table class="w-full">
                            <thead class="text-[10px] font-black text-gray-400 uppercase tracking-widest border-b border-gray-50">
                                <tr>
                                    <th class="text-left pb-4">Item Description</th>
                                    <th class="text-center pb-4">Qty</th>
                                    <th class="text-right pb-4">Price</th>
                                    <th class="text-right pb-4">Total</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-50">
                                <%foreach $items as $item%>
                                <tr>
                                    <td class="py-4 font-bold text-gray-700 text-sm"><%$item.item_name%></td>
                                    <td class="py-4 text-center font-bold text-gray-400 text-sm"><%$item.quantity%></td>
                                    <td class="py-4 text-right font-bold text-gray-400 text-sm">₹<%$item.unit_price%></td>
                                    <td class="py-4 text-right font-black text-gray-800 text-sm">₹<%$item.line_total%></td>
                                </tr>
                                <%/foreach%>
                            </tbody>
                        </table>

                        <div class="pt-6 border-t border-gray-100 space-y-3">
                            <div class="flex justify-between text-sm">
                                <span class="text-gray-400 font-bold uppercase tracking-widest text-[10px]">Subtotal</span>
                                <span class="text-gray-700 font-bold">₹<%$subtotal|number_format:2%></span>
                            </div>
                            <div class="flex justify-between text-sm">
                                <span class="text-gray-400 font-bold uppercase tracking-widest text-[10px]">GST (5%)</span>
                                <span class="text-gray-700 font-bold">₹<%$tax_amount|number_format:2%></span>
                            </div>
                            <div class="flex justify-between items-center bg-blue-50/50 p-4 rounded-3xl mt-4">
                                <span class="text-blue-600 font-black uppercase tracking-widest text-xs">Total Amount</span>
                                <span class="text-2xl font-black text-blue-600 tracking-tighter">₹<%$total_payable|number_format:2%></span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Zigzag edge effect -->
                <div class="flex w-full overflow-hidden opacity-5">
                    <%for $i=1 to 20%>
                    <div class="min-w-[20px] h-3 bg-gray-500 rotate-45 -translate-y-2"></div>
                    <%/for%>
                </div>
            </div>
        </div>

        <!-- Payment Actions (Right) -->
        <div class="space-y-6">
            <div class="bg-gray-800 rounded-[2.5rem] p-8 text-white shadow-2xl shadow-blue-200">
                <h3 class="text-lg font-bold mb-6 flex items-center gap-2">
                    <i class="fa-solid fa-credit-card text-blue-400"></i> Payment Details
                </h3>
                
                <div class="space-y-4 mb-8">
                    <div class="p-4 rounded-3xl bg-white/5 border border-white/10 flex items-center justify-between cursor-pointer hover:bg-white/10 transition-all border-l-4 border-l-blue-500" onclick="selectMethod('CASH', this)">
                        <div class="flex items-center gap-3">
                            <i class="fa-solid fa-money-bill-1-wave text-green-400"></i>
                            <span class="font-bold text-sm">Cash</span>
                        </div>
                        <i class="fa-solid fa-circle-check text-blue-500"></i>
                    </div>
                    <div class="p-4 rounded-3xl bg-white/5 border border-white/10 flex items-center justify-between cursor-pointer hover:bg-white/10 transition-all" onclick="selectMethod('UPI', this)">
                        <div class="flex items-center gap-3">
                            <i class="fa-solid fa-mobile-screen-button text-purple-400"></i>
                            <span class="font-bold text-sm">UPI / QR Scan</span>
                        </div>
                        <i class="fa-solid fa-circle text-white/10"></i>
                    </div>
                    <div class="p-4 rounded-3xl bg-white/5 border border-white/10 flex items-center justify-between cursor-pointer hover:bg-white/10 transition-all" onclick="selectMethod('CARD', this)">
                        <div class="flex items-center gap-3">
                            <i class="fa-solid fa-credit-card text-blue-400"></i>
                            <span class="font-bold text-sm">Credit / Debit Card</span>
                        </div>
                        <i class="fa-solid fa-circle text-white/10"></i>
                    </div>
                </div>

                <input type="hidden" id="selected_method" value="CASH">
                
                <button onclick="processPayment()" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-black py-5 rounded-3xl shadow-xl shadow-blue-500/30 transition-all flex items-center justify-center gap-2">
                    COMPLETE PAYMENT
                </button>
            </div>

            <div class="bg-white rounded-[2rem] p-6 border border-gray-100 flex items-center gap-4">
                <div class="w-12 h-12 rounded-2xl bg-orange-100 text-orange-600 flex items-center justify-center">
                    <i class="fa-solid fa-print"></i>
                </div>
                <div>
                    <div class="font-bold text-gray-800 text-sm">Print Receipt</div>
                    <p class="text-[10px] text-gray-400 font-bold uppercase tracking-widest">Thermal Printer (ESC/POS)</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
function selectMethod(method, el) {
    $('#selected_method').val(method);
    $('.space-y-4 > div').removeClass('border-l-4 border-l-blue-500 bg-white/10').addClass('bg-white/5');
    $('.space-y-4 > div i.fa-solid.fa-circle-check').removeClass('fa-solid fa-circle-check text-blue-500').addClass('fa-solid fa-circle text-white/10');
    
    $(el).addClass('border-l-4 border-l-blue-500 bg-white/10').removeClass('bg-white/5');
    $(el).find('i.fa-circle').removeClass('fa-circle text-white/10').addClass('fa-circle-check text-blue-500');
}

function processPayment() {
    const method = $('#selected_method').val();
    const total = '<%$total_payable%>';
    
    Swal.fire({
        title: 'Confirm Payment',
        text: `Process ₹${parseFloat(total).toFixed(2)} payment via ${method}?`,
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#2563eb',
        confirmButtonText: 'Yes, Confirm'
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: '<%base_url("admin/orders/process_payment")%>',
                type: 'POST',
                data: { 
                    order_id: '<%$order.order_id%>',
                    payment_method: method,
                    amount: total
                },
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        Swal.fire({
                            title: 'Paid Successfully!',
                            text: response.message,
                            icon: 'success',
                            confirmButtonText: 'Back to Tables'
                        }).then(() => {
                            window.location.href = '<%base_url("admin/orders")%>';
                        });
                    }
                }
            });
        }
    });
}
</script>
