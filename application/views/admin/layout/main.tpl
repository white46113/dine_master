<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%$title|default:'Dine Master Admin'%></title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts: Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- DataTables -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css">
    
    <style>
        body { font-family: 'Inter', sans-serif; }
        .glass { background: rgba(255, 255, 255, 0.7); backdrop-filter: blur(10px); }
        .sidebar-active { background: #3b82f6; color: white; }

        /* Modern DataTable Overrides */
        .dataTables_wrapper .dataTables_length select {
            border: 1px solid #e5e7eb;
            border-radius: 0.75rem;
            padding: 0.4rem 2rem 0.4rem 0.8rem;
            outline: none;
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 0.5rem center;
            background-size: 1.5em 1.5em;
        }
        .dataTables_wrapper .dataTables_filter input {
            border: 1px solid #e5e7eb;
            border-radius: 0.75rem;
            padding: 0.5rem 1rem;
            outline: none;
            transition: all 0.2s;
            background: #f9fafb;
        }
        .dataTables_wrapper .dataTables_filter input:focus {
            border-color: #3b82f6;
            background: white;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
        }
        .dataTables_wrapper .dataTables_paginate .paginate_button {
            border: 1px solid #e5e7eb !important;
            border-radius: 0.75rem !important;
            margin-left: 4px !important;
            background: white !important;
            color: #374151 !important;
            padding: 0.5rem 1rem !important;
            transition: all 0.2s !important;
        }
        .dataTables_wrapper .dataTables_paginate .paginate_button.current {
            background: #3b82f6 !important;
            color: white !important;
            border-color: #3b82f6 !important;
        }
        .dataTables_wrapper .dataTables_paginate .paginate_button:hover:not(.current) {
            background: #f3f4f6 !important;
            color: #111827 !important;
        }
        .dataTables_wrapper .dataTables_info {
            color: #6b7280 !important;
            font-size: 0.875rem !important;
            margin-top: 1rem !important;
        }
        table.dataTable thead th {
            border-bottom: 1px solid #f3f4f6 !important;
            padding: 1rem 1.5rem !important;
            font-weight: 600 !important;
            color: #374151 !important;
            background: #f9fafb !important;
        }
        table.dataTable td {
            padding: 1rem 1.5rem !important;
            border-bottom: 1px solid #f3f4f6 !important;
        }
        .dataTables_wrapper .dataTables_length, .dataTables_wrapper .dataTables_filter {
            margin-bottom: 1.5rem !important;
        }

        /* Sidebar Collapse Styles */
        #main-sidebar {
            transition: width 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .sidebar-collapsed #main-sidebar {
            width: 5rem; /* w-20 */
        }
        .sidebar-collapsed .sidebar-label {
            opacity: 0;
            width: 0;
            display: none;
        }
        .sidebar-collapsed aside nav p {
            display: none;
        }
        .sidebar-collapsed #main-sidebar aside {
            width: 5rem;
        }
    </style>

    <!-- Essential Scripts (Loaded in Head to support inline scripts in views) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body class="bg-gray-50 text-gray-900">

    <div class="flex h-screen overflow-hidden">
        <!-- Sidebar -->
        <div id="main-sidebar" class="h-full flex flex-col flex-shrink-0">
            <%$sidebar%>
        </div>

        <div class="relative flex flex-col flex-1 overflow-y-auto overflow-x-hidden">
            <!-- Header -->
            <%$header%>

            <!-- Main Content -->
            <main class="p-6">
                <%$content%>
            </main>

            <!-- Footer -->
            <%$footer%>
        </div>
    </div>

    <!-- Custom Scripts -->

    <script>
        $(document).ready(function() {
            // Sidebar Toggle Logic
            const body = $('body');
            const sidebarBtn = $('#sidebar-toggle-btn');
            
            // Check saved state
            if (localStorage.getItem('sidebar-collapsed') === 'true') {
                body.addClass('sidebar-collapsed');
            }

            sidebarBtn.on('click', function() {
                body.toggleClass('sidebar-collapsed');
                localStorage.setItem('sidebar-collapsed', body.hasClass('sidebar-collapsed'));
            });

            // Initialize DataTables
            $('.datatable').DataTable({
                responsive: true,
                language: {
                    searchPlaceholder: "Search records...",
                    search: ""
                }
            });
        });
    </script>
</body>
</html>
