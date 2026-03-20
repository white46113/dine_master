<div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
    <div>
        <h2 class="text-2xl font-bold text-gray-800">Waiter Management</h2>
        <p class="text-gray-500 text-sm">Manage restaurant service staff</p>
    </div>
    <a href="<%base_url('admin/waiter/add')%>" class="w-full md:w-auto bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-8 rounded-2xl transition-all shadow-lg shadow-blue-500/20 flex items-center justify-center gap-2">
        <i class="fa-solid fa-plus text-xs"></i>
        ADD NEW WAITER
    </a>
</div>

<div class="bg-white rounded-[2rem] shadow-sm border border-gray-100 overflow-hidden">
    <div class="p-8">
        <table id="waitersTable" class="w-full border-collapse">
            <thead class="bg-gray-50/50 text-gray-400 text-[10px] font-black uppercase tracking-widest border-b border-gray-50">
                <tr>
                    <th class="px-6 py-5 text-left">Waiter Info</th>
                    <th class="px-6 py-5 text-left">Phone</th>
                    <%if $is_superadmin%>
                    <th class="px-6 py-5 text-left">Restaurant</th>
                    <%/if%>
                    <th class="px-6 py-5 text-left">Status</th>
                    <th class="px-6 py-5 text-center">Actions</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-gray-50">
            </tbody>
        </table>
    </div>
</div>

<script>
let table;
$(document).ready(function() {
    table = $('#waitersTable').DataTable({
        "processing": true,
        "serverSide": true,
        "order": [],
        "ajax": {
            "url": "<%base_url('admin/waiter/ajax_list')%>",
            "type": "POST"
        },
        "columnDefs": [
            <%if $is_superadmin%>
            { "targets": [1, 2, 3], "orderable": true },
            { "targets": [0, 4], "orderable": false },
            { "targets": [4], "className": "text-center" }
            <%else%>
            { "targets": [1, 2], "orderable": true },
            { "targets": [0, 3], "orderable": false },
            { "targets": [3], "className": "text-center" }
            <%/if%>
        ],
        "language": {
            "searchPlaceholder": "Search name, email, phone...",
            "search": "",
            "lengthMenu": "_MENU_ per page",
        },
        "drawCallback": function() {
            $('.dataTables_paginate .paginate_button').addClass('rounded-xl border-none font-bold text-xs mx-1');
            $('.dataTables_filter input').addClass('bg-gray-50 border-none rounded-xl px-4 py-2 text-sm focus:ring-2 focus:ring-blue-500/20 transition-all');
            $('.dataTables_length select').addClass('bg-gray-50 border-none rounded-xl px-2 py-1 text-sm');
        }
    });
});

function reloadTable() {
    table.ajax.reload(null, false);
}

function deleteWaiter(id) {
    Swal.fire({
        title: 'Delete this waiter?',
        text: "This action cannot be undone.",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#ef4444',
        cancelButtonColor: '#6b7280',
        confirmButtonText: 'Yes, delete',
        cancelButtonText: 'Cancel',
        background: '#fff',
        customClass: {
            title: 'font-bold text-gray-800',
            popup: 'rounded-[2rem] p-8',
            confirmButton: 'rounded-xl px-6 py-3 font-bold',
            cancelButton: 'rounded-xl px-6 py-3 font-bold'
        }
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: '<%base_url("admin/waiter/delete/")%>' + id,
                type: 'POST',
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        Swal.fire({
                            title: 'Deleted!',
                            text: response.message,
                            icon: 'success',
                            customClass: {
                                popup: 'rounded-[2rem] p-8',
                                confirmButton: 'rounded-xl px-6 py-3 font-bold bg-blue-600'
                            }
                        });
                        reloadTable();
                    }
                }
            });
        }
    })
}
</script>

<style>
.dataTables_wrapper .dataTables_length, 
.dataTables_wrapper .dataTables_filter {
    padding-bottom: 2rem;
}
.dataTables_wrapper .dataTables_info {
    padding-top: 2rem;
    font-size: 12px;
    color: #9ca3af;
    font-weight: 500;
}
.dataTables_wrapper .dataTables_paginate {
    padding-top: 2rem;
}
.paginate_button.current {
    background: #2563eb !important;
    color: white !important;
}
</style>
