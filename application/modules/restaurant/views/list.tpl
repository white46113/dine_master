<div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
    <div>
        <h2 class="text-2xl font-bold text-gray-800">Restaurant Management</h2>
        <p class="text-gray-500 text-sm">Manage all restaurants and properties directly</p>
    </div>
    <a href="<%base_url('admin/restaurant/create')%>"
        class="inline-flex items-center gap-2 bg-blue-600 hover:bg-blue-700 text-white font-bold px-5 py-2.5 rounded-xl transition-all shadow-lg shadow-blue-500/30 text-sm">
        <i class="fa-solid fa-plus"></i> Add New Restaurant
    </a>
</div>

<div class="bg-white rounded-[2rem] shadow-sm border border-gray-100 overflow-hidden">
    <div class="p-8">
        <table id="restaurantsTable" class="w-full border-collapse">
            <thead class="bg-gray-50/50 text-gray-400 text-[10px] font-black uppercase tracking-widest border-b border-gray-50">
                <tr>
                    <th class="px-6 py-5 text-left">Property Details</th>
                    <th class="px-6 py-5 text-left">Contact Email</th>
                    <th class="px-6 py-5 text-left">Phone</th>
                    <th class="px-6 py-5 text-left">City</th>
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
    table = $('#restaurantsTable').DataTable({
        "processing": true,
        "serverSide": true,
        "order": [],
        "ajax": {
            "url": "<%base_url('admin/restaurant/ajax_list')%>",
            "type": "POST"
        },
        "columnDefs": [
            { "targets": [0, 1, 2, 3, 4], "orderable": true },
            { "targets": [0, 5], "orderable": false },
            { "targets": [5], "className": "text-center" }
        ],
        "language": {
            "searchPlaceholder": "Search by name, email or city...",
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
