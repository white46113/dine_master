<div class="max-w-4xl mx-auto">
    <div class="flex items-center gap-4 mb-8">
        <a href="<%base_url('admin/tables')%>" class="w-12 h-12 rounded-2xl bg-white border border-gray-100 flex items-center justify-center text-gray-400 hover:text-blue-600 hover:border-blue-100 transition-all shadow-sm">
            <i class="fa-solid fa-arrow-left"></i>
        </a>
        <div>
            <h2 class="text-2xl font-bold text-gray-800">Add New Table</h2>
            <p class="text-gray-500 text-sm">Create a new dining table for your restaurant</p>
        </div>
    </div>

    <form action="<%base_url('admin/tables/add')%>" method="POST" class="bg-white rounded-[2.5rem] p-10 border border-gray-100 shadow-xl space-y-8">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
            <!-- Table Code -->
            <div class="space-y-2">
                <label class="text-[10px] font-black text-gray-400 uppercase tracking-widest ml-1">Table Code</label>
                <div class="relative">
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                        <i class="fa-solid fa-hashtag text-xs"></i>
                    </span>
                    <input type="text" name="code" required placeholder="e.g. T101"
                           class="w-full pl-10 pr-4 py-4 bg-gray-50 border-none rounded-2xl focus:ring-2 focus:ring-blue-500/20 transition-all font-bold text-gray-700">
                </div>
            </div>

            <!-- Table Name -->
            <div class="space-y-2">
                <label class="text-[10px] font-black text-gray-400 uppercase tracking-widest ml-1">Display Name</label>
                <div class="relative">
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                        <i class="fa-solid fa-signature text-xs"></i>
                    </span>
                    <input type="text" name="name" required placeholder="e.g. Window Side 4"
                           class="w-full pl-10 pr-4 py-4 bg-gray-50 border-none rounded-2xl focus:ring-2 focus:ring-blue-500/20 transition-all font-bold text-gray-700">
                </div>
            </div>

            <!-- Floor Selection -->
            <div class="space-y-2">
                <label class="text-[10px] font-black text-gray-400 uppercase tracking-widest ml-1">Location (Floor)</label>
                <div class="relative">
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                        <i class="fa-solid fa-layer-group text-xs"></i>
                    </span>
                    <select name="floor_id" required 
                            class="w-full pl-10 pr-4 py-4 bg-gray-50 border-none rounded-2xl focus:ring-2 focus:ring-blue-500/20 transition-all font-bold text-gray-700 appearance-none">
                        <%foreach $floors as $floor%>
                        <option value="<%$floor.floor_id%>"><%$floor.name%></option>
                        <%/foreach%>
                    </select>
                </div>
            </div>

            <!-- Seating Capacity -->
            <div class="space-y-2">
                <label class="text-[10px] font-black text-gray-400 uppercase tracking-widest ml-1">Seating Capacity</label>
                <div class="relative">
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                        <i class="fa-solid fa-users text-xs"></i>
                    </span>
                    <input type="number" name="capacity" required min="1" max="20" value="4"
                           class="w-full pl-10 pr-4 py-4 bg-gray-50 border-none rounded-2xl focus:ring-2 focus:ring-blue-500/20 transition-all font-bold text-gray-700">
                </div>
            </div>
        </div>

        <div class="pt-6">
            <button type="submit" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-black py-5 rounded-2xl shadow-xl shadow-blue-200 transition-all flex items-center justify-center gap-3 tracking-widest uppercase text-sm">
                <i class="fa-solid fa-circle-check"></i>
                SAVE TABLE RECORD
            </button>
        </div>
    </form>
</div>
