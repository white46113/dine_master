<div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
    <div>
        <h2 class="text-2xl font-bold text-gray-800">Order Management</h2>
        <p class="text-gray-500 text-sm">Monitor and manage real-time restaurant orders</p>
    </div>
    <div class="flex items-center gap-3">
        <select id="statusFilter" class="select2-modern">
            <option value="">All Statuses</option>
            <option value="RUNNING" <%if $current_status == 'RUNNING'%>selected<%/if%>>Running</option>
            <option value="COMPLETED" <%if $current_status == 'COMPLETED'%>selected<%/if%>>Completed</option>
        </select>
        <button onclick="reloadTable()" class="bg-white hover:bg-gray-50 text-gray-600 font-bold py-2.5 px-4 rounded-xl border border-gray-200 transition-all shadow-sm flex items-center">
            <i class="fa-solid fa-rotate mr-2 text-sm"></i>
            Refresh
        </button>
    </div>
</div>

<style>
/* Premium Select2 Styling */
.select2-modern + .select2-container--default .select2-selection--single {
    background-color: #fff;
    border: 1px solid #e5e7eb;
    border-radius: 0.75rem;
    height: 42px;
    padding: 6px 12px;
    transition: all 0.2s;
    box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
}

.select2-modern + .select2-container--default.select2-container--focus .select2-selection--single {
    border-color: #3b82f6;
    ring: 4px;
    ring-color: rgba(59, 130, 246, 0.1);
}

.select2-modern + .select2-container--default .select2-selection--single .select2-selection__rendered {
    color: #374151;
    font-size: 0.875rem;
    font-weight: 600;
    line-height: 28px;
}

.select2-modern + .select2-container--default .select2-selection--single .select2-selection__arrow {
    height: 40px;
    right: 10px;
}

.select2-dropdown {
    border: 1px solid #e5e7eb;
    border-radius: 0.75rem !important;
    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
    overflow: hidden;
    margin-top: 4px;
}

.select2-results__option {
    padding: 10px 15px;
    font-size: 0.875rem;
    font-weight: 500;
    color: #4b5563;
}

.select2-container--default .select2-results__option--highlighted[aria-selected] {
    background-color: #3b82f6 !important;
    color: #fff !important;
}

.select2-container--default .select2-results__option[aria-selected=true] {
    background-color: #eff6ff;
    color: #1d4ed8;
    font-weight: 700;
}
</style>

<div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
    <div class="p-6">
        <table id="ordersTable" class="w-full border-collapse">
            <thead class="bg-gray-50 text-gray-500 text-xs uppercase tracking-wider">
                <tr>
                    <th class="px-6 py-4 text-left">Order & Customer</th>
                    <%if isset($is_superadmin) && $is_superadmin%>
                    <th class="px-6 py-4 text-left">Restaurant</th>
                    <%/if%>
                    <th class="px-6 py-4 text-left">Table</th>
                    <th class="px-6 py-4 text-left">Amount</th>
                    <th class="px-6 py-4 text-left">Status</th>
                    <th class="px-6 py-4 text-center">Actions</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-gray-100">
                <!-- DataTables will populate this -->
            </tbody>
        </table>
    </div>
</div>

<script>
let table;
$(document).ready(function() {
    $('#statusFilter').select2({
        minimumResultsForSearch: Infinity, // Hide search box if not needed
        width: '180px'
    });

    table = $('#ordersTable').DataTable({
        "processing": true,
        "serverSide": true,
        "order": [],
        "ajax": {
            "url": "<%base_url('admin/orders/ajax_list')%>",
            "type": "POST",
            "data": function (d) {
                d.status = $('#statusFilter').val();
            }
        },
        "columnDefs": [
            { "targets": "_all", "orderable": true },
            { "targets": [-1], "orderable": false },
            { "targets": [-1], "className": "text-center" }
        ],
        "language": {
            "searchPlaceholder": "Search by ID, name or table...",
            "search": "",
            "lengthMenu": "_MENU_ per page",
        }
    });

    $('#statusFilter').on('change', function() {
        table.ajax.reload();
    });
});

function reloadTable() {
    table.ajax.reload(null, false);
}

function updateOrderStatus(id, status) {
    Swal.fire({
        title: 'Complete Order?',
        text: "Are you sure you want to mark this order as completed?",
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#10b981',
        cancelButtonColor: '#6b7280',
        confirmButtonText: 'Yes, complete it!'
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: '<%base_url("admin/orders/update_status")%>',
                type: 'POST',
                data: { order_id: id, status: status },
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        Swal.fire('Updated!', response.message, 'success');
                        reloadTable();
                    }
                }
            });
        }
    });
}
</script>
