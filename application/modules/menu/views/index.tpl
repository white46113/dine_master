<div class="flex justify-between items-center mb-8">
    <div>
        <h2 class="text-2xl font-bold text-gray-800">Menu Management</h2>
        <p class="text-gray-500 text-sm">Manage your restaurant's dishes and pricing</p>
    </div>
    <a href="<%base_url('admin/menu/add')%>" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2.5 px-6 rounded-xl transition-all shadow-lg shadow-blue-500/30 flex items-center">
        <i class="fa-solid fa-plus mr-2 text-sm"></i>
        Add New Item
    </a>
</div>

<div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
    <div class="p-6">
        <table id="menuTable" class="w-full border-collapse">
            <thead class="bg-gray-50 text-gray-500 text-xs uppercase tracking-wider">
                <tr>
                    <th class="px-6 py-4 text-left">Item</th>
                    <th class="px-6 py-4 text-left">Category</th>
                    <th class="px-6 py-4 text-left">Price</th>
                    <th class="px-6 py-4 text-left">Type</th>
                    <th class="px-6 py-4 text-left">Availability</th>
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
    table = $('#menuTable').DataTable({
        "processing": true,
        "serverSide": true,
        "order": [],
        "ajax": {
            "url": "<%base_url('admin/menu/ajax_list')%>",
            "type": "POST"
        },
        "columnDefs": [
            { "targets": [0, 1, 2, 3, 4, 5], "orderable": true },
            { "targets": [0, 5], "orderable": false },
            { "targets": [5], "className": "text-center" }
        ],
        "language": {
            "searchPlaceholder": "Search by name or category...",
            "search": "",
            "lengthMenu": "_MENU_ per page",
        }
    });
});

function reloadTable() {
    table.ajax.reload(null, false);
}

function deleteItem(id) {
    Swal.fire({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#ef4444',
        cancelButtonColor: '#6b7280',
        confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: '<%base_url("admin/menu/delete/")%>' + id,
                type: 'POST',
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        Swal.fire('Deleted!', response.message, 'success');
                        reloadTable();
                    }
                }
            });
        }
    })
}
</script>
