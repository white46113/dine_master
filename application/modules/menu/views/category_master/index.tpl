<div class="flex justify-between items-center mb-8">
    <div>
        <h2 class="text-2xl font-bold text-gray-800"><%$page_title%></h2>
        <p class="text-gray-500 text-sm">Manage your menu categories</p>
    </div>
    <div class="flex gap-3">
        <%if $role_id == 1%>
        <select id="restaurantFilter" class="text-sm border-gray-300 rounded-xl px-4 py-2.5 focus:ring-blue-500 focus:border-blue-500">
            <option value="">All Restaurants</option>
        </select>
        <%/if%>
        <a href="<%base_url('admin/category_master/add')%>" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2.5 px-6 rounded-xl transition-all shadow-lg shadow-blue-500/30 flex items-center">
            <i class="fa-solid fa-plus mr-2 text-sm"></i>
            Add Category
        </a>
    </div>
</div>

<div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
    <div class="p-6">
        <table id="categoryTable" class="w-full border-collapse">
            <thead class="bg-gray-50 text-gray-500 text-xs uppercase tracking-wider">
                <tr>
                    <th class="px-6 py-4 text-left">No</th>
                    <th class="px-6 py-4 text-left">Name & Description</th>
                    <%if $role_id == 1%>
                    <th class="px-6 py-4 text-left">Restaurant</th>
                    <%/if%>
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
    <%if $role_id == 1%>
    // Load restaurants for filter
    $.get('<%base_url("admin/restaurant/ajax_get_all")%>', function(response) {
        let res = JSON.parse(response);
        if (res.success) {
            res.data.forEach(function(restaurant) {
                $('#restaurantFilter').append(`<option value="${restaurant.restaurant_id}">${restaurant.name}</option>`);
            });
        }
    });
    <%/if%>

    table = $('#categoryTable').DataTable({
        "processing": true,
        "serverSide": true,
        "order": [],
        "ajax": {
            "url": "<%base_url('admin/category_master/ajax_list')%>",
            "type": "POST",
            "data": function(d) {
                d.restaurant_id = $('#restaurantFilter').val();
            }
        },
        "columns": [
            { "data": 0, "orderable": false },
            { "data": 1 },
            <%if $role_id == 1%>
            { "data": 2 },
            { "data": 3, "orderable": false, "className": "text-center" }
            <%else%>
            { "data": 2, "orderable": false, "className": "text-center" }
            <%/if%>
        ],
        "language": {
            "searchPlaceholder": "Search categories...",
            "search": "",
            "lengthMenu": "_MENU_ per page",
            "infoFiltered": ""
        }
    });

    $('#restaurantFilter').on('change', function() {
        table.draw();
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
            Swal.fire({
                title: 'Deleting...',
                allowOutsideClick: false,
                didOpen: () => {
                    Swal.showLoading();
                }
            });

            $.ajax({
                url: '<%base_url("admin/category_master/delete/")%>' + id,
                type: 'POST',
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        Swal.fire('Deleted!', response.message, 'success');
                        reloadTable();
                    } else {
                        Swal.fire('Error', response.message || 'Failed to delete', 'error');
                    }
                },
                error: function() {
                    Swal.fire('Error', 'Something went wrong!', 'error');
                }
            });
        }
    });
}
</script>