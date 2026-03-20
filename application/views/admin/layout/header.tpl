<header class="sticky top-0 z-30 flex items-center justify-between px-6 py-4 bg-white border-b border-gray-200 glass">
    <div class="flex items-center">
        <button id="sidebar-toggle-btn" class="mr-4 text-gray-500 hover:text-blue-600 transition-colors">
            <i class="fa-solid fa-bars-staggered text-xl"></i>
        </button>
        <h1 class="text-xl font-bold text-gray-800"><%$page_title|default:'Admin Dashboard'%></h1>
        
        <%if isset($active_sub) && $admin_user.role_id != 1%>
        <div class="ml-6 hidden md:flex items-center bg-blue-50 border border-blue-100 rounded-xl px-4 py-2 shadow-sm">
            <div class="flex items-center gap-2">
                <i class="fa-solid fa-crown text-blue-600 text-xs"></i>
                <span class="text-[10px] font-black text-blue-900 uppercase tracking-widest leading-none">Plan Active</span>
            </div>
            <div class="mx-3 w-px h-3 bg-blue-200"></div>
            <span class="text-[10px] font-bold text-gray-600 uppercase tracking-widest leading-none">Expires: <span class="text-gray-900"><%$active_sub.expiry_date|date_format:"%d %b %Y"%></span></span>
        </div>
        <%/if%>
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
