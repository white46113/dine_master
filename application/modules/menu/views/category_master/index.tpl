<!-- Table Section -->
<div class="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
    <div class="p-6 border-b border-gray-100 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
        <div>
            <h2 class="text-lg font-bold text-gray-800"><%$page_title%></h2>
            <p class="text-sm text-gray-500 mt-1">Manage your menu categories</p>
        </div>
        <div class="flex gap-3">
            <%if $role_id == 1%>
            <div class="w-48">
                <select id="restaurantFilter" class="w-full text-sm border-gray-300 rounded-lg focus:ring-blue-500 focus:border-blue-500">
                    <option value="">All Restaurants</option>
                </select>
            </div>
            <%/if%>
            <a href="<%base_url('admin/category_master/add')%>" class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg text-sm font-semibold transition-colors flex items-center">
                <i class="fa-solid fa-plus mr-2"></i> Add Category
            </a>
        </div>
    </div>

    <div class="p-0">
        <table id="categoryTable" class="w-full text-left text-sm text-gray-600">
            <thead class="bg-gray-50 text-gray-700 text-xs uppercase font-semibold">
                <tr>
                    <th class="px-6 py-4 rounded-tl-lg">No</th>
                    <th class="px-6 py-4">Name & Description</th>
                    <%if $role_id == 1%>
                    <th class="px-6 py-4">Restaurant</th>
                    <%/if%>
                    <th class="px-6 py-4 text-center rounded-tr-lg">Actions</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-gray-100">
                <!-- DataTables will populate this -->
            </tbody>
        </table>
    </div>
</div>

<script>
    $(document).ready(function() {
        <%if $role_id == 1%>
        // Load restaurants for filter
        $.get('<%base_url("admin/restaurant/ajax_get_all")%>', function(response) {
            let res = JSON.parse(response);
            if(res.success) {
                res.data.forEach(function(restaurant) {
                    $('#restaurantFilter').append(`<option value="${restaurant.restaurant_id}">${restaurant.name}</option>`);
                });
            }
        });
        <%/if%>

        var table = $('#categoryTable').DataTable({
            "processing": true,
            "serverSide": true,
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
                search: "",
                searchPlaceholder: "Search categories...",
                lengthMenu: "Show _MENU_ entries",
                info: "Showing _START_ to _END_ of _TOTAL_ entries",
                paginate: {
                    first: '<i class="fa-solid fa-angles-left"></i>',
                    previous: '<i class="fa-solid fa-angle-left"></i>',
                    next: '<i class="fa-solid fa-angle-right"></i>',
                    last: '<i class="fa-solid fa-angles-right"></i>'
                }
            },
            "dom": '<"flex flex-col sm:flex-row justify-between items-center p-4 border-b border-gray-100"lf>rt<"flex flex-col sm:flex-row justify-between items-center p-4 border-t border-gray-100"ip>',
            "drawCallback": function() {
                $('.dataTables_filter input').addClass('border border-gray-300 rounded-lg px-4 py-2 focus:ring-2 focus:ring-blue-100 focus:border-blue-400 outline-none transition-all w-64');
                $('.dataTables_length select').addClass('border border-gray-300 rounded-lg px-3 py-1.5 focus:ring-2 focus:ring-blue-100 focus:border-blue-400 outline-none cursor-pointer mx-2');
                $('.paginate_button').addClass('px-3 py-1 border border-gray-200 rounded-md mx-1 hover:bg-gray-50 cursor-pointer transition-colors');
                $('.paginate_button.current').addClass('bg-blue-50 text-blue-600 border-blue-200 font-medium');
            }
        });

        $('#restaurantFilter').on('change', function() {
            table.draw();
        });
    });

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
                    url: '<%base_url("admin/category_master/delete/")%>' + id,
                    type: 'POST',
                    success: function(response) {
                        let res = JSON.parse(response);
                        if(res.success) {
                            Swal.fire(
                                'Deleted!',
                                res.message,
                                'success'
                            );
                            $('#categoryTable').DataTable().ajax.reload();
                        } else {
                            Swal.fire(
                                'Error!',
                                res.message || 'Something went wrong',
                                'error'
                            );
                        }
                    }
                });
            }
        });
    }
</script>
