<header class="sticky top-0 z-30 flex items-center justify-between px-6 py-4 bg-white border-b border-gray-200 glass">
    <div class="flex items-center">
        <button id="sidebar-toggle-btn" class="mr-4 text-gray-500 hover:text-blue-600 transition-colors">
            <i class="fa-solid fa-bars-staggered text-xl"></i>
        </button>
        <h1 class="text-xl font-bold text-gray-800"><%$page_title|default:'Admin Dashboard'%></h1>
    </div>

    <div class="flex items-center space-x-4">
        <div class="text-right hidden sm:block">
            <p class="text-sm font-semibold text-gray-700"><%$admin_user.user_name|default:'Admin'%></p>
            <p class="text-xs text-gray-500"><%$admin_user.role_name|default:'Super Admin'%></p>
        </div>
        <div class="w-10 h-10 rounded-full bg-blue-500 flex items-center justify-center text-white font-bold">
            <%$admin_user.user_name|substr:0:1|upper|default:'A'%>
        </div>
    </div>
</header>
