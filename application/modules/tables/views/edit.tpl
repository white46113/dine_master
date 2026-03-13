<div class="max-w-4xl mx-auto">
    <div class="flex items-center gap-4 mb-8">
        <a href="<%base_url('admin/tables')%>" class="w-12 h-12 rounded-2xl bg-white border border-gray-100 flex items-center justify-center text-gray-400 hover:text-blue-600 hover:border-blue-100 transition-all shadow-sm">
            <i class="fa-solid fa-arrow-left"></i>
        </a>
        <div>
            <h2 class="text-2xl font-bold text-gray-800">Edit Table</h2>
            <p class="text-gray-500 text-sm">Update information for table <span class="text-blue-600 font-bold"><%$table->code%></span></p>
        </div>
    </div>

    <form action="<%base_url('admin/tables/edit/`$table->table_id`')%>" method="POST" class="bg-white rounded-[2.5rem] p-10 border border-gray-100 shadow-xl space-y-8">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
            <!-- Table Code -->
            <div class="space-y-2">
                <label class="text-[10px] font-black text-gray-400 uppercase tracking-widest ml-1">Table Code</label>
                <div class="relative">
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                        <i class="fa-solid fa-hashtag text-xs"></i>
                    </span>
                    <input type="text" name="code" required value="<%$table->code%>"
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
                    <input type="text" name="name" required value="<%$table->name%>"
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
                        <option value="<%$floor.floor_id%>" <%if $floor.floor_id == $table->floor_id%>selected<%/if%>><%$floor.name%></option>
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
                    <input type="number" name="capacity" required min="1" max="20" value="<%$table->capacity%>"
                           class="w-full pl-10 pr-4 py-4 bg-gray-50 border-none rounded-2xl focus:ring-2 focus:ring-blue-500/20 transition-all font-bold text-gray-700">
                </div>
            </div>

            <!-- Status -->
            <div class="space-y-2">
                <label class="text-[10px] font-black text-gray-400 uppercase tracking-widest ml-1">Current Status</label>
                <div class="relative">
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                        <i class="fa-solid fa-circle-dot text-xs"></i>
                    </span>
                    <select name="status" required 
                            class="w-full pl-10 pr-4 py-4 bg-gray-50 border-none rounded-2xl focus:ring-2 focus:ring-blue-500/20 transition-all font-bold text-gray-700 appearance-none">
                        <option value="FREE" <%if $table->status == 'FREE'%>selected<%/if%>>FREE</option>
                        <option value="OCCUPIED" <%if $table->status == 'OCCUPIED'%>selected<%/if%>>OCCUPIED</option>
                        <option value="RESERVED" <%if $table->status == 'RESERVED'%>selected<%/if%>>RESERVED</option>
                        <option value="BLOCKED" <%if $table->status == 'BLOCKED'%>selected<%/if%>>BLOCKED</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="pt-6">
            <button type="submit" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-black py-5 rounded-2xl shadow-xl shadow-blue-200 transition-all flex items-center justify-center gap-3 tracking-widest uppercase text-sm">
                <i class="fa-solid fa-cloud-arrow-up"></i>
                UPDATE TABLE INFORMATION
            </button>
        </div>
    </form>
</div>
