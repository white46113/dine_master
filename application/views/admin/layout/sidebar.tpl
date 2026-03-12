<aside class="hidden lg:flex lg:flex-shrink-0 w-64 bg-gray-900 text-white flex-col">
    <div class="p-6 flex items-center space-x-3">
        <div class="w-8 h-8 bg-blue-500 rounded flex items-center justify-center">
            <i class="fa-solid fa-utensils"></i>
        </div>
        <span class="text-xl font-bold tracking-wider uppercase">Dine Master</span>
    </div>

    <nav class="flex-1 px-4 mt-4 space-y-1">
        <a href="<%base_url('admin/dashboard')%>" class="flex items-center px-4 py-3 text-sm font-medium rounded-lg hover:bg-gray-800 <%if $current_module == 'dashboard'%>sidebar-active<%/if%>">
            <i class="fa-solid fa-chart-line w-6"></i>
            Dashboard
        </a>

        <div class="pt-4 pb-2">
            <p class="px-4 text-xs font-semibold text-gray-500 uppercase tracking-widest">Management</p>
        </div>

        <a href="<%base_url('admin/menu')%>" class="flex items-center px-4 py-3 text-sm font-medium rounded-lg hover:bg-gray-800 <%if $current_module == 'menu'%>sidebar-active<%/if%>">
            <i class="fa-solid fa-bowl-food w-6"></i>
            Menu Items
        </a>

        <a href="<%base_url('admin/orders')%>" class="flex items-center px-4 py-3 text-sm font-medium rounded-lg hover:bg-gray-800 <%if $current_module == 'orders'%>sidebar-active<%/if%>">
            <i class="fa-solid fa-receipt w-6"></i>
            Orders
        </a>

        <div class="pt-4 pb-2">
            <p class="px-4 text-xs font-semibold text-gray-500 uppercase tracking-widest">Settings</p>
        </div>

        <a href="<%base_url('admin/restaurant')%>" class="flex items-center px-4 py-3 text-sm font-medium rounded-lg hover:bg-gray-800 <%if $current_module == 'restaurant'%>sidebar-active<%/if%>">
            <i class="fa-solid fa-shop w-6"></i>
            Restaurant Info
        </a>

        <a href="<%base_url('api_docs')%>" target="_blank" class="flex items-center px-4 py-3 text-sm font-medium rounded-lg hover:bg-gray-800">
            <i class="fa-solid fa-code w-6"></i>
            API Documentation
        </a>
    </nav>

    <div class="p-4 border-t border-gray-800">
        <a href="<%base_url('admin/logout')%>" class="flex items-center px-4 py-3 text-sm font-medium text-red-400 rounded-lg hover:bg-red-900 hover:bg-opacity-20 transition-colors">
            <i class="fa-solid fa-right-from-bracket w-6"></i>
            Logout
        </a>
    </div>
</aside>
