<!-- Select2 Library -->
<link rel="stylesheet" href="<%base_url('public/plugin/select2/select2.min.css')%>">
<script src="<%base_url('public/plugin/select2/select2.min.js')%>"></script>

<style>
/* Premium Select2 Styling */
.select2-container--default .select2-selection--single {
    background-color: #2563eb !important; /* blue-600 */
    border: none !important;
    border-radius: 0.75rem !important; /* rounded-xl */
    height: 48px !important;
    display: flex !important;
    align-items: center !important;
    transition: all 0.3s ease !important;
    box-shadow: 0 10px 15px -3px rgba(37, 99, 235, 0.3) !important;
}

.select2-container--default .select2-selection--single .select2-selection__rendered {
    color: white !important;
    font-weight: 700 !important;
    padding-left: 1.5rem !important;
    font-size: 0.875rem !important;
}

.select2-container--default .select2-selection--single .select2-selection__arrow {
    height: 48px !important;
    right: 12px !important;
}

.select2-container--default .select2-selection--single .select2-selection__arrow b {
    border-color: white transparent transparent transparent !important;
}

.select2-container--default.select2-container--open .select2-selection__arrow b {
    border-color: transparent transparent white transparent !important;
}

.select2-dropdown {
    border-radius: 1rem !important;
    border: 1px solid #f3f4f6 !important;
    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1) !important;
    padding: 0.5rem !important;
    overflow: hidden !important;
    margin-top: 5px !important;
}

.select2-results__option {
    border-radius: 0.5rem !important;
    padding: 8px 12px !important;
    margin: 2px 0 !important;
    font-size: 0.875rem !important;
}

.select2-results__option--highlighted[aria-selected] {
    background-color: #eff6ff !important;
    color: #2563eb !important;
}

.select2-results__option[aria-selected=true] {
    background-color: #2563eb !important;
    color: white !important;
}
</style>

<div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
    <div class="flex items-center">
        <a href="<%base_url('admin/orders')%>" class="mr-4 text-gray-500 hover:text-gray-900 transition-colors">
            <i class="fa-solid fa-arrow-left text-xl"></i>
        </a>
        <div>
            <h2 class="text-2xl font-bold text-gray-800">Order Details</h2>
            <p class="text-gray-500 text-sm">Reviewing order #<%$order.order_id%> • <%$order.order_type%></p>
        </div>
    </div>
    
    <div class="flex space-x-3">
        <button onclick="printToken()" class="bg-blue-50 text-blue-600 border border-blue-100 font-bold py-2.5 px-6 rounded-xl hover:bg-blue-100 transition-all flex items-center shadow-sm">
            <i class="fa-solid fa-receipt mr-2 text-sm"></i> Print Token
        </button>
        <button onclick="window.print()" class="bg-white border border-gray-200 text-gray-700 font-bold py-2.5 px-6 rounded-xl hover:bg-gray-50 transition-all flex items-center shadow-sm">
            <i class="fa-solid fa-print mr-2 text-sm"></i> Print Receipt
        </button>
        <div class="w-48">
             <select id="statusPicker" onchange="updateStatus(<%$order.order_id%>, this.value)" 
                class="w-full">
                <option value="RUNNING" <%if $order.status != 'COMPLETED' && $order.status != 'CANCELLED'%>selected<%/if%>>Mark RUNNING</option>
                <option value="COMPLETED" <%if $order.status == 'COMPLETED'%>selected<%/if%>>Mark COMPLETED</option>
                <option value="CANCELLED" <%if $order.status == 'CANCELLED'%>selected<%/if%>>Mark CANCELLED</option>
            </select>
        </div>
    </div>
</div>

<div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
    <!-- Left Column: Order Items -->
    <div class="lg:col-span-2 space-y-8">
        <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
            <div class="px-6 py-4 border-b border-gray-100">
                <h3 class="font-bold text-gray-800">Order Items</h3>
            </div>
            <div class="p-6">
                <div class="divide-y divide-gray-100">
                    <%foreach from=$items item=item%>
                    <div class="py-4 flex items-center">
                        <div class="w-16 h-16 bg-gray-50 rounded-xl overflow-hidden mr-4 flex-shrink-0">
                            <%if $item.image_url%>
                            <img src="<%$item.image_url%>" onerror="this.src='https://placehold.co/200x200?text=No+Image'" class="w-full h-full object-cover">
                            <%else%>
                            <div class="w-full h-full flex items-center justify-center text-gray-300">
                                <i class="fa-solid fa-image text-xl"></i>
                            </div>
                            <%/if%>
                        </div>
                        <div class="flex-1">
                            <h4 class="font-bold text-gray-800"><%$item.item_name%></h4>
                            <p class="text-xs text-gray-500">Qty: <%$item.quantity%> x ₹<%$item.unit_price|default:0|number_format:2%></p>
                        </div>
                        <div class="text-right">
                            <p class="font-bold text-gray-900">₹<%($item.quantity * $item.unit_price)|default:0|number_format:2%></p>
                        </div>
                    </div>
                    <%/foreach%>
                </div>
            </div>
            <div class="bg-gray-50 p-6 space-y-3">
                <div class="flex justify-between text-sm text-gray-600">
                    <span>Subtotal</span>
                    <span>₹<%$order.subtotal_amount|default:0|number_format:2%></span>
                </div>
                <div class="flex justify-between text-sm text-gray-600">
                    <span>Tax/GST (<%$order.gst_percentage|default:0|number_format:2%>%)</span>
                    <span>₹<%$order.tax_amount|default:0|number_format:2%></span>
                </div>
                <div class="flex justify-between text-lg font-bold text-gray-900 pt-3 border-t border-gray-200">
                    <span>Total Payable</span>
                    <span class="text-blue-600">₹<%$order.total_payable|default:0|number_format:2%></span>
                </div>
            </div>
        </div>
    </div>

    <!-- Right Column: Customer & Details -->
    <div class="space-y-8">
        <!-- Status Card -->
        <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
            <h3 class="font-bold text-gray-800 mb-6">Order Status</h3>
            <div class="flex items-center mb-6">
                <div class="w-2 h-10 bg-blue-600 rounded-full mr-4"></div>
                <div>
                    <p class="text-xs text-gray-400 font-bold uppercase tracking-widest">Current State</p>
                    <p class="text-lg font-bold text-blue-600">
                        <%if $order.status == 'COMPLETED'%>COMPLETED
                        <%else if $order.status == 'CANCELLED'%>CANCELLED
                        <%else%>RUNNING
                        <%/if%>
                    </p>
                </div>
            </div>
            <div class="space-y-4">
                <div class="flex items-center text-sm">
                    <i class="fa-solid fa-clock text-gray-400 w-6"></i>
                    <span class="text-gray-500 mr-2">Placed At:</span>
                    <span class="font-semibold text-gray-700"><%$order.placed_at%></span>
                </div>
                <div class="flex items-center text-sm">
                    <i class="fa-solid fa-credit-card text-gray-400 w-6"></i>
                    <span class="text-gray-500 mr-2">Payment:</span>
                    <span class="px-2 py-0.5 rounded text-[10px] font-bold uppercase <%if $order.payment_status == 'PAID'%>bg-green-100 text-green-700<%else%>bg-red-100 text-red-700<%/if%>">
                        <%$order.payment_status%>
                    </span>
                </div>
            </div>
        </div>

        <!-- Customer Summary -->
        <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
            <h3 class="font-bold text-gray-800 mb-6">Customer Info</h3>
            <div class="flex items-center mb-6">
                <div class="w-12 h-12 bg-gray-100 rounded-full flex items-center justify-center text-gray-400 text-xl mr-4">
                    <i class="fa-solid fa-user"></i>
                </div>
                <div>
                    <p class="font-bold text-gray-800"><%$order.customer_name|default:'Guest Customer'%></p>
                    <p class="text-xs text-gray-500">Table: <%if $order.table_no%>#<%$order.table_no%><%else%>N/A<%/if%></p>
                </div>
            </div>
            <div class="space-y-3 pt-6 border-t border-gray-100">
                <div class="text-sm">
                    <p class="text-gray-400 mb-0.5">Phone</p>
                    <p class="font-semibold text-gray-700 underline underline-offset-2"><%$order.customer_phone|default:'Not provided'%></p>
                </div>
                <div class="text-sm">
                    <p class="text-gray-400 mb-0.5">Email</p>
                    <p class="font-semibold text-gray-700"><%$order.customer_email|default:'Not provided'%></p>
                </div>
            </div>
        </div>

        <%if $order.notes%>
        <div class="bg-orange-50 p-6 rounded-2xl border border-orange-100">
            <h3 class="font-bold text-orange-800 text-sm mb-3">Special Instructions</h3>
            <p class="text-sm text-orange-700 leading-relaxed italic">"<%$order.notes%>"</p>
        </div>
        <%/if%>
    </div>
</div>

<script>
$(document).ready(function() {
    $('#statusPicker').select2({
        minimumResultsForSearch: Infinity,
        width: '100%'
    });
});

function updateStatus(orderId, newStatus) {
    $.ajax({
        url: '<%base_url("admin/orders/update_status")%>',
        type: 'POST',
        data: { order_id: orderId, status: newStatus },
        dataType: 'json',
        success: function(response) {
            if (response.success) {
                Swal.fire({
                    toast: true,
                    position: 'top-end',
                    icon: 'success',
                    title: response.message,
                    showConfirmButton: false,
                    timer: 2000
                }).then(() => {
                    location.reload();
                });
            }
        }
    });
}
</script>

<!-- QZ Tray for Raw Printing -->
<script src="https://cdn.jsdelivr.net/npm/qz-tray@2.2.3/qz-tray.js"></script>
<script>
const printerName = "POS-58"; 
let isQzConnected = false;

qz.security.setCertificatePromise((resolve, reject) => {
    resolve("-----BEGIN CERTIFICATE-----\n" +
            "MIIBljCCAT2gAwIBAgIUev69y7K3u9v9v9v9v9v9v9v9v9swCgYIKoZIzj0EAwIw\n" +
            "RTELMAkGA1UEBhMCVVMxEzARBgNVBAgMCldhc2hpbmd0b24xEDAOBgNVBAcMB1Nl\n" +
            "YXR0bGUxETAPBgNVBAoMCFFaIEluZHVzdHJpZXMwHhcNMjQwMTAxMDAwMDAwWhcN\n" +
            "MzQwMTAxMDAwMDAwWjBFMQswCQYDVQQGEwJVUzETMBEGA1UECAwKV2FzaGluZ3Rv\n" +
            "bjEQMA4GA1UEBwwHU2VhdHRsZTEUMBIGA1UECgwLUFJJVkFURUtFWS4wWTATBgcq\n" +
            "hkjOPQIBBggqhkjOPQMBBwNCAAR5v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9\n" +
            "v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9owCgYIKoZIzj0EAwID\n" +
            "SAAwRQIhAKv9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9AiBv9v9v9v9v\n" +
            "9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v9v\n" +
            "-----END CERTIFICATE-----");
});

qz.security.setSignaturePromise((toSign) => {
    return (resolve, reject) => {
        resolve(""); 
    };
});

function connectQZ() {
    qz.websocket.disconnect().finally(() => {
        qz.websocket.connect().then(() => {
            isQzConnected = true;
            return qz.printers.find(printerName);
        }).catch((err) => {
            if (isQzConnected) {
                qz.printers.find("POS").catch(() => {
                    qz.printers.find("58").catch(() => {
                        isQzConnected = false;
                    });
                });
            } else {
                isQzConnected = false;
            }
        });
    });
}

function pad(left, right, width = 32) {
    const spaceCount = width - (left.length + right.length);
    return left + " ".repeat(Math.max(0, spaceCount)) + right;
}

function getRawTokenData() {
    const orderNo = '<%$order.order_number%>';
    const tableNo = '<%$order.table_no|default:"N/A"%>';
    const placedAt = new Date('<%$order.placed_at%>');
    
    const formattedDate = placedAt.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' });
    const formattedTime = placedAt.toLocaleTimeString('en-GB', { hour: '2-digit', minute: '2-digit', hour12: true }).toUpperCase();

    let data = [
        '\x1B\x61\x01', // Center align
        '\x1B\x45\x01', // Bold on
        'KITCHEN ORDER TOKEN\n',
        '\x1B\x45\x00', // Bold off
        '\x1B\x61\x00', // Left align
        '-'.repeat(32) + '\n',
        'Order ID : ' + orderNo + '\n',
        'Table    : ' + tableNo + '\n',
        'Date     : ' + formattedDate + '\n',
        'Time     : ' + formattedTime + '\n',
        '-'.repeat(32) + '\n',
        '\x1B\x45\x01', // Bold on
        pad('Item', 'Qty', 32) + '\n',
        '\x1B\x45\x00', // Bold off
    ];

    <%foreach $items as $item%>
    data.push(pad('<%$item.item_name|replace:"'":"\\'"%>'.substring(0, 26), '<%$item.quantity%>', 32) + '\n');
    <%/foreach%>

    data.push('-'.repeat(32) + '\n');
    data.push('\n\n\n\n'); // Carriage returns
    data.push('\x1B\x69'); // Cut paper
    
    return data;
}

function printToken() {
    if (isQzConnected) {
        const config = qz.configs.create(printerName); 
        const data = getRawTokenData();
        
        qz.print(config, data).then(() => {
            Swal.fire({
                title: 'Printed!',
                text: 'Token sent to kitchen printer.',
                icon: 'success',
                timer: 1500,
                showConfirmButton: false
            });
        }).catch((err) => {
            Swal.fire('Printer Error', 'Could not print directly. Check QZ Tray.', 'error');
        });
    } else {
        Swal.fire({
            title: 'Printer Service Offline',
            text: 'Please start QZ Tray and make sure a POS-58 printer is connected.',
            icon: 'warning',
            confirmButtonColor: '#2563eb'
        });
    }
}

$(document).ready(() => {
    connectQZ();
});
</script>
