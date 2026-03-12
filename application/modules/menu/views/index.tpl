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
        <table class="w-full datatable border-collapse">
            <thead class="bg-gray-50 text-gray-500 text-xs uppercase tracking-wider">
                <tr>
                    <th class="px-6 py-4 border-b border-gray-100 text-left">Item</th>
                    <th class="px-6 py-4 border-b border-gray-100 text-left">Category</th>
                    <th class="px-6 py-4 border-b border-gray-100 text-left">Price</th>
                    <th class="px-6 py-4 border-b border-gray-100 text-left">Type</th>
                    <th class="px-6 py-4 border-b border-gray-100 text-left">Availability</th>
                    <th class="px-6 py-4 border-b border-gray-100 text-center">Actions</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-gray-100">
                <%foreach from=$items item=item%>
                <tr class="hover:bg-gray-50 transition-colors">
                    <td class="px-6 py-4">
                        <div class="flex items-center">
                            <div class="w-12 h-12 flex-shrink-0 rounded-lg overflow-hidden bg-gray-100 mr-4">
                                <%if $item.image_url%>
                                <img src="<%$item.image_url%>" class="w-full h-full object-cover">
                                <%else%>
                                <div class="w-full h-full flex items-center justify-center text-gray-400">
                                    <i class="fa-solid fa-image text-xl"></i>
                                </div>
                                <%/if%>
                            </div>
                            <div>
                                <div class="font-bold text-gray-800"><%$item.name%></div>
                                <div class="text-xs text-gray-400">#<%$item.item_id%></div>
                            </div>
                        </div>
                    </td>
                    <td class="px-6 py-4">
                        <span class="px-3 py-1 bg-gray-100 text-gray-600 text-xs font-semibold rounded-full">
                            <%$item.category_name|default:'Uncategorized'%>
                        </span>
                    </td>
                    <td class="px-6 py-4 font-bold text-gray-900">₹<%$item.base_price|default:0|number_format:2%></td>
                    <td class="px-6 py-4">
                        <%if $item.veg_type == 'VEG'%>
                        <span class="flex items-center text-green-600 text-xs font-bold">
                            <i class="fa-solid fa-leaf mr-1"></i> VEG
                        </span>
                        <%elseif $item.veg_type == 'NON_VEG'%>
                        <span class="flex items-center text-red-600 text-xs font-bold">
                            <i class="fa-solid fa-meat mr-1"></i> NON-VEG
                        </span>
                        <%else%>
                        <span class="flex items-center text-orange-600 text-xs font-bold">
                            <i class="fa-solid fa-egg mr-1"></i> EGG
                        </span>
                        <%/if%>
                    </td>
                    <td class="px-6 py-4">
                        <div class="flex items-center">
                            <%if $item.is_available%>
                            <span class="w-2 h-2 bg-green-500 rounded-full mr-2"></span>
                            <span class="text-xs text-green-700 font-semibold">Available</span>
                            <%else%>
                            <span class="w-2 h-2 bg-red-500 rounded-full mr-2"></span>
                            <span class="text-xs text-red-700 font-semibold">Sold Out</span>
                            <%/if%>
                        </div>
                    </td>
                    <td class="px-6 py-4 text-center">
                        <div class="flex justify-center space-x-2">
                            <a href="<%base_url('admin/menu/edit/')%><%$item.item_id%>" class="w-9 h-9 flex items-center justify-center bg-blue-50 text-blue-600 rounded-lg hover:bg-blue-600 hover:text-white transition-all cursor-pointer">
                                <i class="fa-solid fa-pen-to-square"></i>
                            </a>
                            <button onclick="deleteItem(<%$item.item_id%>)" class="w-9 h-9 flex items-center justify-center bg-red-50 text-red-600 rounded-lg hover:bg-red-600 hover:text-white transition-all">
                                <i class="fa-solid fa-trash"></i>
                            </button>
                        </div>
                    </td>
                </tr>
                <%/foreach%>
            </tbody>
        </table>
    </div>
</div>

<script>
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
                        Swal.fire('Deleted!', response.message, 'success').then(() => {
                            location.reload();
                        });
                    }
                }
            });
        }
    })
}
</script>
