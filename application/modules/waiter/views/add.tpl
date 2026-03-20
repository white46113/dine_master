<div class="max-w-4xl mx-auto">
    <div class="flex items-center gap-4 mb-8">
        <a href="<%base_url('admin/waiter')%>" class="w-12 h-12 rounded-2xl bg-white border border-gray-100 flex items-center justify-center text-gray-400 hover:text-blue-600 hover:border-blue-100 transition-all shadow-sm">
            <i class="fa-solid fa-arrow-left"></i>
        </a>
        <div>
            <h2 class="text-2xl font-bold text-gray-800">Add New Waiter</h2>
            <p class="text-gray-500 text-sm">Create a new waiter account</p>
        </div>
    </div>

    <form action="<%base_url('admin/waiter/add')%>" method="POST" class="bg-white rounded-[2.5rem] p-10 border border-gray-100 shadow-xl space-y-8">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
            <!-- Name -->
            <div class="space-y-2">
                <label class="text-[10px] font-black text-gray-400 uppercase tracking-widest ml-1">Full Name</label>
                <div class="relative">
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                        <i class="fa-solid fa-user text-xs"></i>
                    </span>
                    <input type="text" name="user_name" required placeholder="John Doe"
                           class="w-full pl-10 pr-4 py-4 bg-gray-50 border-none rounded-2xl focus:ring-2 focus:ring-blue-500/20 transition-all font-bold text-gray-700">
                </div>
            </div>

            <!-- Email -->
            <div class="space-y-2">
                <label class="text-[10px] font-black text-gray-400 uppercase tracking-widest ml-1">Email Address</label>
                <div class="relative">
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                        <i class="fa-solid fa-envelope text-xs"></i>
                    </span>
                    <input type="email" name="user_email" required placeholder="john@example.com"
                           class="w-full pl-10 pr-4 py-4 bg-gray-50 border-none rounded-2xl focus:ring-2 focus:ring-blue-500/20 transition-all font-bold text-gray-700">
                </div>
            </div>

            <!-- Phone -->
            <div class="space-y-2">
                <label class="text-[10px] font-black text-gray-400 uppercase tracking-widest ml-1">Phone Number</label>
                <div class="relative">
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                        <i class="fa-solid fa-phone text-xs"></i>
                    </span>
                    <input type="text" name="phone" placeholder="e.g. 555-1234"
                           class="w-full pl-10 pr-4 py-4 bg-gray-50 border-none rounded-2xl focus:ring-2 focus:ring-blue-500/20 transition-all font-bold text-gray-700">
                </div>
            </div>

            <!-- Password -->
            <div class="space-y-2">
                <label class="text-[10px] font-black text-gray-400 uppercase tracking-widest ml-1">Password</label>
                <div class="relative">
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                        <i class="fa-solid fa-lock text-xs"></i>
                    </span>
                    <input type="password" name="password" required placeholder="Enter password"
                           class="w-full pl-10 pr-4 py-4 bg-gray-50 border-none rounded-2xl focus:ring-2 focus:ring-blue-500/20 transition-all font-bold text-gray-700">
                </div>
            </div>

            <!-- Restaurant Selection (Super Admin only) -->
            <%if $is_superadmin%>
            <div class="space-y-2">
                <label class="text-[10px] font-black text-gray-400 uppercase tracking-widest ml-1">Assign to Restaurant</label>
                <div class="relative">
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                        <i class="fa-solid fa-shop text-xs"></i>
                    </span>
                    <select name="restaurant_id" required 
                            class="w-full pl-10 pr-4 py-4 bg-gray-50 border-none rounded-2xl focus:ring-2 focus:ring-blue-500/20 transition-all font-bold text-gray-700 appearance-none">
                        <%foreach $restaurants as $res%>
                        <option value="<%$res.restaurant_id%>"><%$res.name%></option>
                        <%/foreach%>
                    </select>
                </div>
            </div>
            <%/if%>

            <!-- Active Status -->
            <div class="space-y-2 flex items-center pt-8">
                <label class="text-sm font-bold text-gray-700 mr-4">Active Account</label>
                <label class="relative inline-flex items-center cursor-pointer">
                    <input type="checkbox" name="status" value="1" class="sr-only peer" checked>
                    <div class="w-11 h-6 bg-gray-200 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-blue-600"></div>
                </label>
            </div>
        </div>

        <div class="pt-6">
            <button type="submit" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-black py-5 rounded-2xl shadow-xl shadow-blue-200 transition-all flex items-center justify-center gap-3 tracking-widest uppercase text-sm">
                <i class="fa-solid fa-circle-check"></i>
                SAVE WAITER ACCOUNT
            </button>
        </div>
    </form>
</div>
