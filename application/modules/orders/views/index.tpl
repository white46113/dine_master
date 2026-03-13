<div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
    <div>
        <h2 class="text-2xl font-bold text-gray-800">Order Management</h2>
        <p class="text-gray-500 text-sm">Monitor and manage real-time restaurant orders</p>
    </div>
    <div class="flex items-center gap-3">
        <select id="statusFilter" class="bg-white border border-gray-200 text-gray-700 text-sm rounded-xl px-4 py-2.5 outline-none focus:ring-2 focus:ring-blue-500 transition-all font-semibold shadow-sm">
            <option value="">All Statuses</option>
            <option value="PLACED" <%if $current_status == 'PLACED'%>selected<%/if%>>Placed</option>
            <option value="PREPARING" <%if $current_status == 'PREPARING'%>selected<%/if%>>Preparing</option>
            <option value="READY" <%if $current_status == 'READY'%>selected<%/if%>>Ready</option>
            <option value="SERVED" <%if $current_status == 'SERVED'%>selected<%/if%>>Served</option>
            <option value="COMPLETED" <%if $current_status == 'COMPLETED'%>selected<%/if%>>Completed</option>
            <option value="CANCELLED" <%if $current_status == 'CANCELLED'%>selected<%/if%>>Cancelled</option>
        </select>
        <button onclick="reloadTable()" class="bg-white hover:bg-gray-50 text-gray-600 font-bold py-2.5 px-4 rounded-xl border border-gray-200 transition-all shadow-sm flex items-center">
            <i class="fa-solid fa-rotate mr-2 text-sm"></i>
            Refresh
        </button>
    </div>
</div>

<div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
    <div class="p-6">
        <table id="ordersTable" class="w-full border-collapse">
            <thead class="bg-gray-50 text-gray-500 text-xs uppercase tracking-wider">
                <tr>
                    <th class="px-6 py-4 text-left">Order & Customer</th>
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
            { "targets": [0, 1, 2, 3, 4], "orderable": true },
            { "targets": [4], "orderable": false },
            { "targets": [4], "className": "text-center" }
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
