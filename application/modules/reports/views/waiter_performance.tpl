<div class="space-y-6">
    <!-- Filter Card -->
    <div class="bg-white p-6 rounded-3xl shadow-sm border border-gray-100 flex flex-wrap items-center justify-between gap-4">
        <div>
            <h3 class="text-xl font-black text-gray-800"><%$page_title%></h3>
            <p class="text-xs text-gray-400 font-bold uppercase tracking-widest mt-1">Staff Sales Performance</p>
        </div>
        <form id="filterForm" class="flex items-center gap-3">
            <div class="flex items-center space-x-2">
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                        <i class="fa-regular fa-calendar text-gray-400"></i>
                    </div>
                    <input type="text" name="start_date" value="<%$start_date%>" class="datepicker bg-white border border-gray-200 text-gray-700 text-sm font-semibold rounded-xl focus:ring-2 focus:ring-blue-100 focus:border-blue-400 block w-36 pl-10 pr-4 py-2.5 transition-all outline-none shadow-sm cursor-pointer" placeholder="Start Date">
                </div>
                
                <span class="text-gray-400 font-medium px-1 text-sm">to</span>
                
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                        <i class="fa-regular fa-calendar text-gray-400"></i>
                    </div>
                    <input type="text" name="end_date" value="<%$end_date%>" class="datepicker bg-white border border-gray-200 text-gray-700 text-sm font-semibold rounded-xl focus:ring-2 focus:ring-blue-100 focus:border-blue-400 block w-36 pl-10 pr-4 py-2.5 transition-all outline-none shadow-sm cursor-pointer" placeholder="End Date">
                </div>
            </div>

            <button type="submit" class="px-5 py-2.5 bg-blue-600 text-white text-sm font-bold rounded-xl shadow-lg shadow-blue-500/30 hover:bg-blue-700 hover:shadow-blue-600/40 transition-all flex items-center gap-2">
                <i class="fa-solid fa-filter text-xs"></i>
                Filter
            </button>
        </form>
    </div>

    <div id="reportContainer">
        <%include file="waiter_performance_partial.tpl"%>
    </div>
</div>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script>
$(document).ready(function() {
    let endDatePicker;
    const startDatePicker = flatpickr('input[name="start_date"]', {
        dateFormat: "Y-m-d",
        onChange: function(selectedDates, dateStr, instance) {
            if(endDatePicker) {
                endDatePicker.set('minDate', dateStr);
                let endInput = document.querySelector('input[name="end_date"]');
                if(endInput.value && endInput.value < dateStr) {
                    endDatePicker.setDate(dateStr);
                }
            }
        }
    });
    endDatePicker = flatpickr('input[name="end_date"]', {
        dateFormat: "Y-m-d",
        minDate: document.querySelector('input[name="start_date"]').value
    });

    $('#filterForm').on('submit', function(e) {
        e.preventDefault();
        let start = document.querySelector('input[name="start_date"]').value;
        let end = document.querySelector('input[name="end_date"]').value;
        if(!start || !end) {
            Swal.fire('Validation Error', 'Please select both start and end dates.', 'warning');
            return;
        }
        if(end < start) {
            Swal.fire('Validation Error', 'End Date cannot be less than Start Date.', 'warning');
            return;
        }
        
        let btn = $(this).find('button[type="submit"]');
        let origHtml = btn.html();
        btn.prop('disabled', true).html('<i class="fa-solid fa-spinner fa-spin"></i> Filter');
        
        $.ajax({
            url: '<%base_url("admin/reports/waiter_performance")%>',
            type: 'GET',
            data: $(this).serialize(),
            dataType: 'json',
            success: function(res) {
                if(res.success) {
                    $('#reportContainer').html(res.html);
                } else {
                    Swal.fire('Error', 'Failed to load report data', 'error');
                }
                btn.prop('disabled', false).html(origHtml);
            },
            error: function() {
                Swal.fire('Error', 'Server error occurred', 'error');
                btn.prop('disabled', false).html(origHtml);
            }
        });
    });
});
</script>
