<div class="max-w-4xl mx-auto">
    <div class="flex justify-between items-center mb-8">
        <div>
            <h2 class="text-2xl font-bold text-gray-800">Edit Table</h2>
            <p class="text-gray-500 text-sm">Update information for table <span class="text-blue-600 font-bold"><%$table->code%></span></p>
        </div>
        <a href="<%base_url('admin/tables')%>"
            class="w-12 h-12 rounded-2xl bg-white border border-gray-100 flex items-center justify-center text-gray-400 hover:text-blue-600 hover:border-blue-100 transition-all shadow-sm">
            <i class="fa-solid fa-arrow-left"></i>
        </a>
    </div>

    <form id="tableForm" action="<%base_url('admin/tables/edit/')%><%$table->table_id%>" method="POST" class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
        <div class="p-8 space-y-8">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <!-- Table Code -->
            <div class="space-y-2">
                <label class="text-sm font-bold text-gray-700">Table Code <span class="text-red-500">*</span></label>
                <input type="text" name="code" required value="<%$table->code%>"
                       class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
            </div>

            <!-- Table Name -->
            <div class="space-y-2">
                <label class="text-sm font-bold text-gray-700">Display Name <span class="text-red-500">*</span></label>
                <input type="text" name="name" required value="<%$table->name%>"
                       class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
            </div>

            <!-- Floor Selection -->
            <div class="space-y-2">
                <label class="text-sm font-bold text-gray-700">Location (Floor) <span class="text-red-500">*</span></label>
                <select name="floor_id" required 
                        class="w-full select2-floor px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                    <option value="">Select Location</option>
                    <%foreach $floors as $floor%>
                    <option value="<%$floor.floor_id%>" <%if $floor.floor_id == $table->floor_id%>selected<%/if%>><%$floor.name%><%if isset($is_superadmin) && $is_superadmin%> (<%$floor.restaurant_name%>)<%/if%></option>
                    <%/foreach%>
                </select>
            </div>

            <!-- Seating Capacity -->
            <div class="space-y-2">
                <label class="text-sm font-bold text-gray-700">Seating Capacity <span class="text-red-500">*</span></label>
                <input type="number" name="capacity" required min="1" max="20" value="<%$table->capacity%>"
                       class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
            </div>

            <!-- Status -->
            <div class="space-y-2">
                <label class="text-sm font-bold text-gray-700">Current Status <span class="text-red-500">*</span></label>
                <select name="status" required 
                        class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                    <option value="FREE" <%if $table->status == 'FREE'%>selected<%/if%>>FREE</option>
                    <option value="OCCUPIED" <%if $table->status == 'OCCUPIED'%>selected<%/if%>>OCCUPIED</option>
                    <option value="RESERVED" <%if $table->status == 'RESERVED'%>selected<%/if%>>RESERVED</option>
                    <option value="BLOCKED" <%if $table->status == 'BLOCKED'%>selected<%/if%>>BLOCKED</option>
                </select>
            </div>
        </div>
        </div>

        <div class="bg-gray-50 px-8 py-5 flex justify-end space-x-3">
            <a href="<%base_url('admin/tables')%>"
                class="bg-white hover:bg-gray-100 text-gray-700 font-bold py-2.5 px-6 rounded-xl transition-all border border-gray-200 ml-auto">Cancel</a>
            <button type="submit"
                class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2.5 px-8 rounded-xl transition-all shadow-lg shadow-blue-500/30">
                Update Table
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

    $('select').on('change', function() {
        $(this).valid();
    });

    // Custom styling for jQuery validation errors
    $.validator.setDefaults({
        errorElement: 'p',
        errorClass: 'text-sm text-red-500 mt-1',
        errorPlacement: function (error, element) {
            if (element.hasClass('select2-hidden-accessible') || element.prop('tagName') === 'SELECT') {
                error.insertAfter(element.next('.select2-container'));
            } else {
                error.insertAfter(element);
            }
        },
        highlight: function(element) {
            $(element).addClass('border-red-500 focus:ring-red-100 focus:border-red-500');
            $(element).removeClass('border-gray-200 focus:ring-blue-100 focus:border-blue-400');
        },
        unhighlight: function(element) {
            $(element).removeClass('border-red-500 focus:ring-red-100 focus:border-red-500');
            $(element).addClass('border-gray-200 focus:ring-blue-100 focus:border-blue-400');
        }
    });

    $('#tableForm').validate({
        rules: {
            code: "required",
            name: "required",
            floor_id: "required",
            capacity: "required",
            status: "required"
        },
        messages: {
            code: "Please enter Table Code",
            name: "Please enter Display Name",
            floor_id: "Please select Location",
            capacity: "Please enter Seating Capacity",
            status: "Please select Status"
        },
        submitHandler: function(form) {
            $.ajax({
                url: $(form).attr('action'),
                type: 'POST',
                data: $(form).serialize(),
                dataType: 'json',
                success: function(res) {
                    if (res.success) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Success',
                            text: res.message,
                            timer: 2000
                        }).then(() => {
                            window.location.href = res.redirect;
                        });
                    } else {
                        Swal.fire('Error', res.message || 'Something went wrong.', 'error');
                    }
                },
                error: function(xhr) {
                    var resp = xhr.responseJSON || {};
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: resp.message || 'Something went wrong.'
                    });
                }
            });
            return false;
        }
    });
});
</script>
<style>
/* Select2 styled to match input fields */
.select2-container .select2-selection--single {
    background-color: #ffffff !important;
    border: 1px solid #e5e7eb !important;
    border-radius: 0.75rem !important;
    height: 48px !important;
    padding-left: 0.75rem !important;
    display: flex;
    align-items: center;
    transition: all 0.2s;
}
.select2-container .select2-selection--single .select2-selection__rendered {
    color: #374151 !important;
    font-weight: 400;
    padding-left: 0.25rem;
    line-height: 48px !important;
}
.select2-container .select2-selection--single .select2-selection__placeholder {
    color: #9ca3af !important;
}
.select2-container .select2-selection--single .select2-selection__arrow {
    height: 48px !important;
    right: 8px !important;
}
.select2-container--default.select2-container--focus .select2-selection--single,
.select2-container--default.select2-container--open .select2-selection--single {
    border-color: #3b82f6 !important;
    box-shadow: 0 0 0 2px rgba(59,130,246,0.2) !important;
}
.select2-dropdown {
    border: 1px solid #e5e7eb !important;
    border-radius: 0.75rem !important;
    box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -2px rgba(0,0,0,0.1) !important;
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
    box-shadow: 0 0 0 2px rgba(59,130,246,0.2) !important;
}
.select2-results__option {
    padding: 0.625rem 1rem !important;
    font-weight: 400;
    color: #374151;
    transition: all 0.15s;
}
.select2-container--default .select2-results__option--highlighted[aria-selected] {
    background-color: #3b82f6 !important;
    color: white !important;
}
.select2-container--default .select2-results__option[aria-selected=true] {
    background-color: #eff6ff !important;
    color: #3b82f6 !important;
}
</style>
