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
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400 z-10 pointer-events-none">
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
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400 z-10 pointer-events-none">
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
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400 z-10 pointer-events-none">
                        <i class="fa-solid fa-layer-group text-xs"></i>
                    </span>
                    <select name="floor_id" required 
                            class="w-full pl-10 pr-4 py-4 bg-gray-50 border-none rounded-2xl focus:ring-2 focus:ring-blue-500/20 transition-all font-bold text-gray-700 appearance-none">
                        <%foreach $floors as $floor%>
                        <option value="<%$floor.floor_id%>"><%$floor.name%><%if isset($is_superadmin) && $is_superadmin%> (<%$floor.restaurant_name%>)<%/if%></option>
                        <%/foreach%>
                    </select>
                </div>
            </div>

            <!-- Seating Capacity -->
            <div class="space-y-2">
                <label class="text-[10px] font-black text-gray-400 uppercase tracking-widest ml-1">Seating Capacity</label>
                <div class="relative">
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400 z-10 pointer-events-none">
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

<!-- Select2 Integration -->
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script>
$(document).ready(function() {
    $('select').select2({
        width: '100%',
        minimumResultsForSearch: 5
    });
});
</script>
<style>
/* Select2 Tailwind Integration */
.select2-container--default .select2-selection--single {
    background-color: #f9fafb !important;
    border: none !important;
    border-radius: 1rem !important;
    height: 3.5rem !important;
    padding-left: 2rem !important;
    display: flex;
    align-items: center;
    font-weight: 700;
    color: #374151;
}
.select2-container--default .select2-selection--single .select2-selection__rendered {
    color: #374151 !important;
    font-weight: 700;
}
.select2-container--default .select2-selection--single .select2-selection__arrow {
    height: 3.5rem !important;
    right: 1rem !important;
}
.select2-dropdown {
    border: none !important;
    border-radius: 1rem !important;
    box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1) !important;
    overflow: hidden;
    margin-top: 4px;
}
.select2-search__field {
    border-radius: 0.5rem !important;
    border: 1px solid #e5e7eb !important;
    padding: 0.5rem 0.75rem !important;
    outline: none !important;
}
.select2-search__field:focus {
    border-color: #3b82f6 !important;
    box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.2) !important;
}
.select2-results__option {
    padding: 0.75rem 1.25rem !important;
    font-weight: 600;
    color: #4b5563;
    transition: all 0.2s;
}
.select2-container--default .select2-results__option--highlighted[aria-selected] {
    background-color: #2563eb !important;
    color: white !important;
}
.select2-container--default .select2-results__option[aria-selected=true] {
    background-color: #eff6ff !important;
    color: #2563eb !important;
}
</style>
