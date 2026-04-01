<aside class="hidden lg:flex lg:flex-shrink-0 w-64 h-screen overflow-hidden bg-gray-900 text-white flex-col transition-all duration-300">
    <div class="p-6 flex items-center space-x-3 overflow-hidden whitespace-nowrap">
        <div class="w-8 h-8 bg-blue-500 rounded flex-shrink-0 flex items-center justify-center">
            <i class="fa-solid fa-utensils text-white"></i>
        </div>
        <span class="sidebar-label text-xl font-bold tracking-wider uppercase transition-all duration-300">Dine Master</span>
    </div>

    <nav class="flex-1 px-4 mt-4 space-y-1 overflow-y-auto">
        <a href="<%base_url('admin/dashboard')%>" class="flex items-center px-4 py-3 text-sm font-medium rounded-lg hover:bg-gray-800 transition-all duration-300 <%if $current_module == 'dashboard'%>sidebar-active<%/if%>" title="Dashboard">
            <i class="fa-solid fa-chart-line w-6 text-center"></i>
            <span class="sidebar-label ml-3 transition-opacity duration-300">Dashboard</span>
        </a>

        <div class="pt-4 pb-2">
            <p class="px-4 text-xs font-semibold text-gray-500 uppercase tracking-widest">Management</p>
        </div>

        <a href="<%base_url('admin/menu')%>" class="flex items-center px-4 py-3 text-sm font-medium rounded-lg hover:bg-gray-800 transition-all duration-300 <%if $current_module == 'menu'%>sidebar-active<%/if%>" title="Menu Items">
            <i class="fa-solid fa-bowl-food w-6 text-center"></i>
            <span class="sidebar-label ml-3 transition-opacity duration-300">Menu Items</span>
        </a>

        <a href="<%base_url('admin/orders')%>" class="flex items-center px-4 py-3 text-sm font-medium rounded-lg hover:bg-gray-800 transition-all duration-300 <%if $current_module == 'orders'%>sidebar-active<%/if%>" title="Orders">
            <i class="fa-solid fa-receipt w-6 text-center"></i>
            <span class="sidebar-label ml-3 transition-opacity duration-300">Orders</span>
        </a>

        <a href="<%base_url('admin/tables')%>" class="flex items-center px-4 py-3 text-sm font-medium rounded-lg hover:bg-gray-800 transition-all duration-300 <%if $current_module == 'tables'%>sidebar-active<%/if%>" title="Tables">
            <i class="fa-solid fa-table w-6 text-center"></i>
            <span class="sidebar-label ml-3 transition-opacity duration-300">Tables</span>
        </a>

        <a href="<%base_url('admin/waiter')%>" class="flex items-center px-4 py-3 text-sm font-medium rounded-lg hover:bg-gray-800 transition-all duration-300 <%if $current_module == 'waiter'%>sidebar-active<%/if%>" title="Waiters">
            <i class="fa-solid fa-user-tie w-6 text-center"></i>
            <span class="sidebar-label ml-3 transition-opacity duration-300">Waiters</span>
        </a>

        <a href="<%base_url('admin/subscriptions')%>" class="flex items-center px-4 py-3 text-sm font-medium rounded-lg hover:bg-gray-800 transition-all duration-300 <%if $current_module == 'subscriptions'%>sidebar-active<%/if%>" title="Subscriptions">
            <i class="fa-solid fa-crown w-6 text-center text-yellow-400"></i>
            <span class="sidebar-label ml-3 transition-opacity duration-300">Subscriptions</span>
        </a>

        <div class="pt-4 pb-2">
            <p class="px-4 text-xs font-semibold text-gray-500 uppercase tracking-widest">Reports</p>
        </div>

        <a href="<%base_url('admin/reports/daily_sales')%>" class="flex items-center px-4 py-3 text-sm font-medium rounded-lg hover:bg-gray-800 transition-all duration-300 <%if $current_module == 'reports' && $current_method == 'daily_sales'%>sidebar-active<%/if%>" title="Daily Sales">
            <i class="fa-solid fa-calendar-day w-6 text-center text-blue-400"></i>
            <span class="sidebar-label ml-3 transition-opacity duration-300">Daily Sales</span>
        </a>

        <a href="<%base_url('admin/reports/item_wise')%>" class="flex items-center px-4 py-3 text-sm font-medium rounded-lg hover:bg-gray-800 transition-all duration-300 <%if $current_module == 'reports' && $current_method == 'item_wise'%>sidebar-active<%/if%>" title="Item Wise Sales">
            <i class="fa-solid fa-list-check w-6 text-center text-orange-400"></i>
            <span class="sidebar-label ml-3 transition-opacity duration-300">Item Wise Sales</span>
        </a>

        <a href="<%base_url('admin/reports/table_wise')%>" class="flex items-center px-4 py-3 text-sm font-medium rounded-lg hover:bg-gray-800 transition-all duration-300 <%if $current_module == 'reports' && $current_method == 'table_wise'%>sidebar-active<%/if%>" title="Table Wise Sales">
            <i class="fa-solid fa-table-cells w-6 text-center text-green-400"></i>
            <span class="sidebar-label ml-3 transition-opacity duration-300">Table Wise Sales</span>
        </a>

        <a href="<%base_url('admin/reports/waiter_performance')%>" class="flex items-center px-4 py-3 text-sm font-medium rounded-lg hover:bg-gray-800 transition-all duration-300 <%if $current_module == 'reports' && $current_method == 'waiter_performance'%>sidebar-active<%/if%>" title="Waiter Performance">
            <i class="fa-solid fa-user-check w-6 text-center text-purple-400"></i>
            <span class="sidebar-label ml-3 transition-opacity duration-300">Waiter Performance</span>
        </a>

        <div class="pt-4 pb-2">
            <p class="px-4 text-xs font-semibold text-gray-500 uppercase tracking-widest">Settings</p>
        </div>

        <a href="<%base_url('admin/restaurant')%>" class="flex items-center px-4 py-3 text-sm font-medium rounded-lg hover:bg-gray-800 transition-all duration-300 <%if $current_module == 'restaurant'%>sidebar-active<%/if%>" title="Restaurant Info">
            <i class="fa-solid fa-shop w-6 text-center"></i>
            <span class="sidebar-label ml-3 transition-opacity duration-300">Restaurant Info</span>
        </a>

        <%if isset($admin_user) && ($admin_user.role_id == 1 || $admin_user.user_role == 1)%>
        <a href="<%base_url('admin/documentation')%>" class="flex items-center px-4 py-3 text-sm font-medium rounded-lg hover:bg-gray-800 transition-all duration-300 <%if $current_module == 'documentation'%>sidebar-active<%/if%>" title="Manual">
            <i class="fa-solid fa-book w-6 text-center text-teal-400"></i>
            <span class="sidebar-label ml-3 transition-opacity duration-300">Manual</span>
        </a>

        <a href="<%base_url('api_docs')%>" target="_blank" class="flex items-center px-4 py-3 text-sm font-medium rounded-lg hover:bg-gray-800 transition-all duration-300" title="API Documentation">
            <i class="fa-solid fa-code w-6 text-center"></i>
            <span class="sidebar-label ml-3 transition-opacity duration-300">API Documentation</span>
        </a>
        <%/if%>

        <a href="<%base_url('admin_auth/profile')%>" class="flex items-center px-4 py-3 text-sm font-medium rounded-lg hover:bg-gray-800 transition-all duration-300 <%if $current_module == 'admin_auth' && $current_controller == 'profile'%>sidebar-active<%/if%>" title="My Profile">
            <i class="fa-solid fa-user-gear w-6 text-center"></i>
            <span class="sidebar-label ml-3 transition-opacity duration-300">My Profile</span>
        </a>
    </nav>

    <div class="p-4 border-t border-gray-800">
        <a href="<%base_url('admin/logout')%>" class="flex items-center px-4 py-3 text-sm font-medium text-red-400 rounded-lg hover:bg-red-900 hover:bg-opacity-20 transition-all duration-300" title="Logout">
            <i class="fa-solid fa-right-from-bracket w-6 text-center"></i>
            <span class="sidebar-label ml-3 transition-opacity duration-300">Logout</span>
        </a>
    </div>
</aside>

<style>
/* Custom Scrollbar for Sidebar */
aside nav::-webkit-scrollbar {
    width: 6px;
}
aside nav::-webkit-scrollbar-track {
    background: transparent;
}
aside nav::-webkit-scrollbar-thumb {
    background: #374151;
    border-radius: 10px;
}
aside nav::-webkit-scrollbar-thumb:hover {
    background: #4b5563;
}
</style>
