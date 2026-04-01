<div class="bg-gray-100 min-h-screen py-10 px-4">
    <!-- Header / Nav -->
    <div class="max-w-5xl mx-auto mb-8 flex flex-col md:flex-row justify-between items-center gap-4">
        <div>
            <h2 class="text-3xl font-bold text-gray-800 tracking-tight">System Manual</h2>
            <p class="text-gray-500 text-sm mt-1 uppercase tracking-widest font-semibold"><i
                    class="fa-solid fa-lock text-red-400 mr-2"></i> Super Admin Clearance</p>
        </div>

        <!-- Document Tabs Navigation -->
        <div class="inline-flex bg-white p-1 rounded-lg shadow-sm">
            <button onclick="switchDoc('adminDoc')" id="btn-adminDoc"
                class="doc-tab-btn active-doc px-6 py-2.5 text-sm font-bold uppercase tracking-wide rounded-md transition-all text-blue-700 bg-blue-50 shadow-sm border border-blue-100">
                <i class="fa-solid fa-server mr-2"></i>Admin Panel
            </button>
            <button onclick="switchDoc('androidDoc')" id="btn-androidDoc"
                class="doc-tab-btn px-6 py-2.5 text-sm font-bold uppercase tracking-wide rounded-md transition-all text-gray-500 hover:text-gray-700">
                <i class="fa-brands fa-android mr-2 text-green-500"></i>Android App
            </button>
        </div>
    </div>

    <!-- Admin Panel Document (A4 Style) -->
    <div id="adminDoc" class="document-page animate-fade-in max-w-4xl mx-auto bg-white shadow-2xl rounded-sm">
        <div class="h-2 w-full bg-blue-900"></div>
        <div class="p-8 md:p-14 lg:px-20 font-serif text-gray-800 leading-relaxed md:text-[17px]">

            <!-- Document Title Page Header -->
            <div class="text-center mb-12 border-b-2 border-gray-800 pb-8">
                <h2 class="text-2xl font-bold text-gray-900">Dine Master – Restaurant Management System
                    (Admin Panel)</h2>
            </div>

            <!-- Content -->
            <h3 class="text-2xl font-bold mb-4 text-gray-900 border-b border-gray-300 pb-2">1. Objective</h3>
            <p class="mb-8 text-justify">
                The objective of the Dine Master Admin Panel is to develop a centralized web-based system that enables
                efficient management of restaurant operations. It is designed to simplify administrative tasks such as
                menu management, order tracking, user control, and system configuration while ensuring accuracy,
                scalability, and ease of use.
            </p>

            <h3 class="text-2xl font-bold mb-4 text-gray-900 border-b border-gray-300 pb-2">2. Project Overview</h3>
            <p class="mb-4 text-justify">
                The Dine Master Admin Panel is the core backend system of the application that allows Super Admins and
                authorized users to monitor and control all activities within the platform.
            </p>
            <p class="mb-4 text-justify">
                It provides a structured interface to manage restaurants, users, orders, and reports while maintaining
                real-time synchronization with the Android application.
            </p>
            <p class="mb-8 text-justify">
                The system is designed with a focus on usability, performance, and security, ensuring smooth day-to-day
                operations for restaurant businesses.
            </p>

            <h3 class="text-2xl font-bold mb-4 text-gray-900 border-b border-gray-300 pb-2">3. Scope of the Project</h3>
            <p class="mb-4">The Admin Panel covers the following functional areas:</p>
            <ul class="list-disc pl-8 mb-8 space-y-2">
                <li>Centralized system management</li>
                <li>Multi-user role-based access control</li>
                <li>Restaurant and branch management</li>
                <li>Menu and category configuration</li>
                <li>Order processing and tracking</li>
                <li>Payment and billing management</li>
                <li>Reporting and analytics</li>
                <li>System settings and customization</li>
            </ul>

            <h3 class="text-2xl font-bold mb-4 text-gray-900 border-b border-gray-300 pb-2">4. Technology Stack</h3>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8 mt-6">
                <div class="bg-gray-50 p-4 border border-gray-200">
                    <h4 class="font-bold font-sans text-gray-900 border-b border-gray-300 pb-1 mb-3">Frontend:</h4>
                    <ul class="list-disc pl-5 mt-2 space-y-1">
                        <li>HTML5</li>
                        <li>CSS3 / Tailwind CSS</li>
                        <li>Bootstrap 5</li>
                        <li>JavaScript</li>
                    </ul>
                </div>
                <div class="bg-gray-50 p-4 border border-gray-200">
                    <h4 class="font-bold font-sans text-gray-900 border-b border-gray-300 pb-1 mb-3">Backend:</h4>
                    <ul class="list-disc pl-5 mt-2 space-y-1">
                        <li>PHP / CodeIgniter 3</li>
                    </ul>
                </div>
                <div class="bg-gray-50 p-4 border border-gray-200">
                    <h4 class="font-bold font-sans text-gray-900 border-b border-gray-300 pb-1 mb-3">Database:</h4>
                    <ul class="list-disc pl-5 mt-2 space-y-1">
                        <li>MySQL</li>
                    </ul>
                </div>

            </div>

            <h3 class="text-2xl font-bold mb-4 text-gray-900 border-b border-gray-300 pb-2">5. System Architecture</h3>
            <p class="mb-4">The system follows a client-server architecture:</p>
            <ul class="list-none space-y-3 mb-6 bg-blue-50/50 p-6 border border-blue-100 font-sans">
                <li><strong class="text-gray-900">Admin Panel (Web):</strong> Handles all administrative operations</li>
                <li><strong class="text-gray-900">Backend Server:</strong> Processes business logic and APIs</li>
                <li><strong class="text-gray-900">Database (MySQL):</strong> Stores all application data</li>
                <li><strong class="text-gray-900">Android Application:</strong> Interacts with backend APIs</li>
            </ul>
            <p class="mb-10 text-justify font-bold italic text-blue-800">
                All modules communicate through secure APIs to ensure real-time data synchronization.
            </p>

            <h3 class="text-2xl font-bold mb-4 text-gray-900 border-b border-gray-300 pb-2">6. Key Features Implemented
            </h3>
            <ul class="list-disc pl-8 mb-10 space-y-2">
                <li>Secure login and authentication system</li>
                <li>Role-based access (Super Admin, Admin, etc.)</li>
                <li>Dashboard with system insights</li>
                <li>Restaurant and branch management</li>
                <li>Menu and item configuration</li>
                <li>Order management system</li>
                <li>Payment tracking and billing</li>
                <li>Reports and analytics</li>
                <li>System settings management</li>
                <li>Integration with Android application</li>
            </ul>

            <h3 class="text-2xl font-bold mb-4 text-gray-900 border-b border-gray-300 pb-2">7. Workflow</h3>
            
            <p class="mb-4">The core operational flow of the system is executed sequentially as follows:</p>
            <ol class="list-decimal pl-8 mb-10 space-y-2 font-sans bg-gray-50 p-6 border border-gray-200">
                <li><strong class="text-gray-800">Admin Login:</strong> Admin logs into the system securely.</li>
                <li><strong class="text-gray-800">Master Configuration:</strong> Admin configures restaurant settings, adds Menu items/categories, and creates Table mappings.</li>
                <li><strong class="text-gray-800">Waiter Execution:</strong> Waiters log into the Android app and select available tables.</li>
                <li><strong class="text-gray-800">Order Management:</strong> Waiters can create a new order directly for a table, or update a running order by adding/editing menu items.</li>
                <li><strong class="text-gray-800">Admin Monitoring:</strong> Orders are instantly received and managed in real-time within the Admin Panel.</li>
                <li><strong class="text-gray-800">Token Generation:</strong> Admin generates and prints order tokens (KOT) for kitchen coordination and receipts for billing.</li>
                <li><strong class="text-gray-800">Order Completion:</strong> Admin monitors, processes, and completes the active orders, finalizing the transaction.</li>
                <li><strong class="text-gray-800">Analytics:</strong> Reports and analytics are generated automatically for business insights.</li>
            </ol>

            <h4 class="text-xl font-bold mb-4 mt-2 text-gray-800 border-b border-gray-200 pb-2">Visual Flow Diagram</h4>
            
            <div class="flex flex-col items-center mt-6 mb-12 w-full font-sans">
                
                <!-- Step 1 (Admin) -->
                <div class="w-full max-w-lg bg-white border-l-4 border-blue-500 shadow-sm rounded-lg p-5 flex items-center z-10 hover:shadow-md transition-shadow">
                    <div class="bg-blue-100 text-blue-800 rounded-full w-12 h-12 flex items-center justify-center font-bold text-lg mr-5 shrink-0"><i class="fa-solid fa-lock"></i></div>
                    <div>
                        <h5 class="font-bold text-gray-900 text-lg">1. System Login</h5>
                        <p class="text-sm text-gray-600 mt-1">Admin logs into the secure backend</p>
                    </div>
                </div>
                
                <div class="h-8 border-l-2 border-dashed border-gray-300"></div>
                <div class="text-gray-400 -mt-3 mb-1"><i class="fa-solid fa-chevron-down"></i></div>

                <!-- Step 2 (Admin) -->
                <div class="w-full max-w-lg bg-white border-l-4 border-blue-500 shadow-sm rounded-lg p-5 flex items-center z-10 hover:shadow-md transition-shadow">
                    <div class="bg-blue-100 text-blue-800 rounded-full w-12 h-12 flex items-center justify-center font-bold text-lg mr-5 shrink-0"><i class="fa-solid fa-cogs"></i></div>
                    <div>
                        <h5 class="font-bold text-gray-900 text-lg">2. System Configuration</h5>
                        <p class="text-sm text-gray-600 mt-1">Admin assigns Tables, adds Menu categories, and configures Items.</p>
                    </div>
                </div>

                <div class="h-8 border-l-2 border-dashed border-gray-300"></div>
                <div class="text-gray-400 -mt-3 mb-1"><i class="fa-solid fa-chevron-down"></i></div>

                <!-- Step 3 (Waiter / Android) -->
                <div class="w-full max-w-lg bg-green-50 border-l-4 border-green-500 shadow-sm rounded-lg p-5 flex items-center z-10 hover:shadow-md transition-shadow">
                    <div class="bg-green-100 text-green-800 rounded-full w-12 h-12 flex items-center justify-center font-bold text-lg mr-5 shrink-0"><i class="fa-brands fa-android"></i></div>
                    <div>
                        <h5 class="font-bold text-gray-900 text-lg">3. Waiter Mobile Execution</h5>
                        <p class="text-sm text-gray-600 mt-1">Waiters map to tables via app. They can <b>create new orders</b> or selectively <b>update running orders</b> using the live menu.</p>
                    </div>
                </div>

                <div class="h-8 border-l-2 border-dashed border-gray-300"></div>
                <div class="text-gray-400 -mt-3 mb-1"><i class="fa-solid fa-chevron-down"></i></div>

                <!-- Step 4 (Sync/Admin) -->
                <div class="w-full max-w-lg bg-white border-l-4 border-blue-500 shadow-sm rounded-lg p-5 flex items-center z-10 hover:shadow-md transition-shadow">
                    <div class="bg-orange-100 text-orange-800 rounded-full w-12 h-12 flex items-center justify-center font-bold text-lg mr-5 shrink-0"><i class="fa-solid fa-desktop"></i></div>
                    <div>
                        <h5 class="font-bold text-gray-900 text-lg">4. Panel Order Processing</h5>
                        <p class="text-sm text-gray-600 mt-1">Orders sync securely to Admin Panel. Admin monitors progress, applies billing, and completes orders.</p>
                    </div>
                </div>

                <div class="h-8 border-l-2 border-dashed border-gray-300"></div>
                <div class="text-gray-400 -mt-3 mb-1"><i class="fa-solid fa-chevron-down"></i></div>

                <!-- Step 5 (Token Printing) -->
                <div class="w-full max-w-lg bg-white border-l-4 border-blue-500 shadow-sm rounded-lg p-5 flex items-center z-10 hover:shadow-md transition-shadow">
                    <div class="bg-purple-100 text-purple-800 rounded-full w-12 h-12 flex items-center justify-center font-bold text-lg mr-5 shrink-0"><i class="fa-solid fa-print"></i></div>
                    <div>
                        <h5 class="font-bold text-gray-900 text-lg">5. Token & Receipt Printing</h5>
                        <p class="text-sm text-gray-600 mt-1">System prints Kitchen Order Tokens (KOT) for kitchen staff and receipts for customers.</p>
                    </div>
                </div>

                <div class="h-8 border-l-2 border-dashed border-gray-300"></div>
                <div class="text-gray-400 -mt-3 mb-1"><i class="fa-solid fa-chevron-down"></i></div>

                <!-- Step 6 -->
                <div class="w-full max-w-lg bg-indigo-50 border-l-4 border-indigo-500 shadow-sm rounded-lg p-5 flex items-center z-10 hover:shadow-md transition-shadow relative overflow-hidden">
                    <div class="absolute -right-4 -top-4 opacity-10 text-indigo-700 text-6xl"><i class="fa-solid fa-chart-pie"></i></div>
                    <div class="bg-indigo-600 text-white rounded-full w-12 h-12 flex items-center justify-center font-bold text-lg mr-5 shrink-0 shadow-sm"><i class="fa-solid fa-chart-line"></i></div>
                    <div>
                        <h5 class="font-bold text-indigo-900 text-lg">6. Data & Insights</h5>
                        <p class="text-sm text-indigo-700 mt-1">Post-completion, system generates daily sales reports and item-wise ROI analytics.</p>
                    </div>
                </div>

            </div>

            <h3 class="text-2xl font-bold mb-4 text-gray-900 border-b border-gray-300 pb-2">8. Security Features</h3>
            <ul class="list-disc pl-8 mb-10 space-y-2">
                <li>Authentication and authorization</li>
                <li>Role-based access control</li>
                <li>Secure API communication</li>
                <li>Data validation and error handling</li>
            </ul>

            <h3 class="text-2xl font-bold mb-4 text-gray-900 border-b border-gray-300 pb-2">9. Conclusion</h3>
            <p class="mb-4 text-justify">
                The Dine Master Admin Panel successfully provides a complete solution for managing restaurant operations
                in a centralized and efficient manner.
            </p>
            <p class="mb-4 text-justify">
                It ensures smooth coordination between backend systems and mobile applications while maintaining high
                performance, scalability, and usability.
            </p>
            <p class="mb-8 text-justify">
                The system meets the required objectives and can be further enhanced to support larger-scale operations
                in the future.
            </p>

            <!-- Document Footer -->
            <div
                class="mt-20 pt-8 border-t border-dashed border-gray-400 text-center font-sans text-xs text-gray-400 uppercase tracking-widest">
                <p>— End of Admin Panel Specification —</p>
            </div>
        </div>
    </div>

    <!-- Android App Document (A4 Style) -->
    <div id="androidDoc" class="document-page hidden animate-fade-in max-w-4xl mx-auto bg-white shadow-2xl rounded-sm">
        <div class="h-2 w-full bg-green-600"></div>
        <div class="p-8 md:p-14 lg:px-20 font-serif text-gray-800 leading-relaxed md:text-[17px]">

            <!-- Document Title Page Header -->
            <div class="text-center mb-12 border-b-2 border-gray-800 pb-8">
                <h2 class="text-2xl font-bold text-gray-900 leading-tight">Dine Master – Android Application
                    for Restaurant Employees (Waiters)</h2>
            </div>

            <!-- Content -->
            <h3 class="text-2xl font-bold mb-4 text-gray-900 border-b border-gray-300 pb-2">1. Objective</h3>
            <p class="mb-8 text-justify">
                The objective of the Dine Master Android Application is to provide restaurant employees, specifically
                waiters, with a mobile platform to efficiently manage customer orders. The application simplifies order
                taking, ensures accuracy, and synchronizes data with the backend Admin Panel in real-time, improving
                overall operational efficiency.
            </p>

            <h3 class="text-2xl font-bold mb-4 text-gray-900 border-b border-gray-300 pb-2">2. Project Overview</h3>
            <p class="mb-4 text-justify">
                The Android App for waiters serves as a digital order management system for restaurant staff. Waiters
                can add, update, and track orders directly from the app.
            </p>
            <p class="mb-4 text-justify">
                This system eliminates manual paper-based ordering, reduces errors, and ensures that all orders are
                transmitted immediately to the kitchen and backend Admin Panel for processing.
            </p>
            <p class="mb-8 text-justify">
                The application is designed with a simple, intuitive interface to minimize training time for staff while
                ensuring smooth operation during peak hours.
            </p>

            <h3 class="text-2xl font-bold mb-4 text-gray-900 border-b border-gray-300 pb-2">3. Scope of the Project</h3>
            <p class="mb-4">The app covers the following functionalities for restaurant employees:</p>
            <ul class="list-disc pl-8 mb-8 space-y-2">
                <li>User login for employees (waiters)</li>
                <li>Table management and assignment</li>
                <li>Adding and modifying customer orders</li>
                <li>Sending orders to the backend Admin Panel in real-time</li>
                <li>Viewing active and completed orders</li>
                <li>Notifications for order updates and kitchen status</li>
                <li>Easy navigation and minimal input for fast operation</li>
            </ul>

            <h3 class="text-2xl font-bold mb-4 text-gray-900 border-b border-gray-300 pb-2">4. Technology Stack</h3>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8 mt-6">
                <div class="bg-gray-50 p-4 border border-gray-200">
                    <h4 class="font-bold font-sans text-gray-900 border-b border-gray-300 pb-1 mb-3">Frontend (Mobile
                        App):</h4>
                    <ul class="list-disc pl-5 mt-2 space-y-1">
                        <li>Android (Java / Kotlin)</li>
                    </ul>
                </div>
                <div class="bg-gray-50 p-4 border border-gray-200">
                    <h4 class="font-bold font-sans text-gray-900 border-b border-gray-300 pb-1 mb-3">Backend
                        Integration:</h4>
                    <ul class="list-disc pl-5 mt-2 space-y-1">
                        <li>REST APIs (connected to Admin Panel)</li>
                    </ul>
                </div>
                <div class="bg-gray-50 p-4 border border-gray-200">
                    <h4 class="font-bold font-sans text-gray-900 border-b border-gray-300 pb-1 mb-3">Database:</h4>
                    <ul class="list-disc pl-5 mt-2 space-y-1">
                        <li>MySQL (via backend)</li>
                    </ul>
                </div>
                <div class="bg-gray-50 p-4 border border-gray-200">
                    <h4 class="font-bold font-sans text-gray-900 border-b border-gray-300 pb-1 mb-3">Tools:</h4>
                    <ul class="list-disc pl-5 mt-2 space-y-1">
                        <li>Android Studio</li>
                        <li>Gradle</li>
                    </ul>
                </div>
            </div>

            <h3 class="text-2xl font-bold mb-4 text-gray-900 border-b border-gray-300 pb-2">5. System Architecture</h3>
            <p class="mb-4">The Android application uses a client-server architecture:</p>
            <ul class="list-none space-y-3 mb-6 bg-green-50/50 p-6 border border-green-100 font-sans">
                <li><strong class="text-gray-900">Android App (Waiter):</strong> User interface for employees to take
                    and manage orders</li>
                <li><strong class="text-gray-900">Backend Server:</strong> Processes orders and updates Admin Panel</li>
                <li><strong class="text-gray-900">Database:</strong> Stores orders, menu items, and table details</li>
            </ul>
            <p class="mb-10 text-justify font-bold italic text-green-800">
                The app communicates securely with the backend via APIs to ensure real-time order management.
            </p>

            <h3 class="text-2xl font-bold mb-4 text-gray-900 border-b border-gray-300 pb-2">6. Key Features Implemented
            </h3>
            <ul class="list-disc pl-8 mb-10 space-y-2">
                <li>Employee login and authentication</li>
                <li>Table selection and assignment</li>
                <li>Adding new orders with menu item selection</li>
                <li>Modifying existing orders (before processing)</li>
                <li>Real-time order submission to Admin Panel</li>
                <li>Tracking order status (pending, in progress, completed)</li>
                <li>Notifications for updates from the kitchen</li>
                <li>Intuitive interface designed for fast input and minimal errors</li>
            </ul>

            <h3 class="text-2xl font-bold mb-4 text-gray-900 border-b border-gray-300 pb-2">7. Workflow</h3>
            
            <p class="mb-4">The operational process from the Waiter's perspective operates as follows:</p>
            <ol class="list-decimal pl-8 mb-10 space-y-2 font-sans bg-gray-50 p-6 border border-gray-200">
                <li><strong class="text-gray-800">Authentication:</strong> Waiter logs in to the application using assigned credentials.</li>
                <li><strong class="text-gray-800">Table Mapping:</strong> Waiter selects an available table for the customer.</li>
                <li><strong class="text-gray-800">Order Construction:</strong> Staff adds items to the order from the synced menu.</li>
                <li><strong class="text-gray-800">Token Issuance:</strong> Waiter triggers token generation (KOT) seamlessly via the app.</li>
                <li><strong class="text-gray-800">Transmission:</strong> Real-time syncing sends the order payload to the backend Admin Panel.</li>
                <li><strong class="text-gray-800">Live Status:</strong> Waiter monitors the order status (in-progress, ready, completed).</li>
                <li><strong class="text-gray-800">Amendments:</strong> Waiter updates or modifies the running order if required by the customer.</li>
                <li><strong class="text-gray-800">Synchronization:</strong> Order completion is finalized and immediately reflected in Admin Panel reports.</li>
            </ol>

            <h4 class="text-xl font-bold mb-4 mt-2 text-gray-800 border-b border-gray-200 pb-2">Mobile Interaction Flow</h4>

            <div class="flex flex-col items-center mt-6 mb-12 w-full font-sans">
                
                <!-- Step 1 (Android) -->
                <div class="w-full max-w-lg bg-white border-l-4 border-green-500 shadow-sm rounded-lg p-5 flex items-center z-10 hover:shadow-md transition-shadow">
                    <div class="bg-green-100 text-green-800 rounded-full w-12 h-12 flex items-center justify-center font-bold text-lg mr-5 shrink-0"><i class="fa-solid fa-mobile-screen"></i></div>
                    <div>
                        <h5 class="font-bold text-gray-900 text-lg">1. Waiter Authentication</h5>
                        <p class="text-sm text-gray-600 mt-1">Employee logs into the mobile app securely</p>
                    </div>
                </div>
                
                <div class="h-8 border-l-2 border-dashed border-gray-300"></div>
                <div class="text-gray-400 -mt-3 mb-1"><i class="fa-solid fa-chevron-down"></i></div>

                <!-- Step 2 (Android) -->
                <div class="w-full max-w-lg bg-white border-l-4 border-green-500 shadow-sm rounded-lg p-5 flex items-center z-10 hover:shadow-md transition-shadow">
                    <div class="bg-green-100 text-green-800 rounded-full w-12 h-12 flex items-center justify-center font-bold text-lg mr-5 shrink-0"><i class="fa-solid fa-chair"></i></div>
                    <div>
                        <h5 class="font-bold text-gray-900 text-lg">2. Table Assignment</h5>
                        <p class="text-sm text-gray-600 mt-1">Waiter selects an active table from the floor mapping</p>
                    </div>
                </div>

                <div class="h-8 border-l-2 border-dashed border-gray-300"></div>
                <div class="text-gray-400 -mt-3 mb-1"><i class="fa-solid fa-chevron-down"></i></div>

                <!-- Step 3 (Android) -->
                <div class="w-full max-w-lg bg-green-50 border-l-4 border-green-600 shadow-sm rounded-lg p-5 flex items-center z-10 hover:shadow-md transition-shadow">
                    <div class="bg-green-600 text-white rounded-full w-12 h-12 flex items-center justify-center font-bold text-lg mr-5 shrink-0 shadow-sm"><i class="fa-solid fa-utensils"></i></div>
                    <div>
                        <h5 class="font-bold text-green-900 text-lg">3. Order Construction</h5>
                        <p class="text-sm text-green-800 mt-1">Compiles the cart via the digital menu or updates an existing running order</p>
                    </div>
                </div>

                <div class="h-8 border-l-2 border-dashed border-gray-300"></div>
                <div class="text-gray-400 -mt-3 mb-1"><i class="fa-solid fa-chevron-down"></i></div>

                <!-- Step 4 (Token Printing) -->
                <div class="w-full max-w-lg bg-white border-l-4 border-green-500 shadow-sm rounded-lg p-5 flex items-center z-10 hover:shadow-md transition-shadow">
                    <div class="bg-purple-100 text-purple-800 rounded-full w-12 h-12 flex items-center justify-center font-bold text-lg mr-5 shrink-0"><i class="fa-solid fa-print"></i></div>
                    <div>
                        <h5 class="font-bold text-gray-900 text-lg">4. Token Generation</h5>
                        <p class="text-sm text-gray-600 mt-1">App triggers instant token printing for the kitchen directly from the mapped table.</p>
                    </div>
                </div>

                <!-- Arrow pointing to external Admin Panel -->
                <div class="h-16 border-l-2 border-dashed border-gray-300 relative">
                     <div class="absolute left-8 top-4 text-xs font-semibold text-blue-700 bg-blue-50 px-3 py-1.5 rounded-full border border-blue-200 shadow-sm flex items-center w-max">
                          <i class="fa-solid fa-cloud-arrow-up text-blue-500 mr-2 text-base"></i> Real-time Sync to Admin Server
                     </div>
                </div>
                <div class="text-gray-400 -mt-3 mb-1"><i class="fa-solid fa-chevron-down"></i></div>

                <!-- Step 5 (Android Tracking) -->
                <div class="w-full max-w-lg bg-white border-l-4 border-green-500 shadow-sm rounded-lg p-5 flex items-center z-10 hover:shadow-md transition-shadow">
                    <div class="bg-orange-100 text-orange-800 rounded-full w-12 h-12 flex items-center justify-center font-bold text-lg mr-5 shrink-0"><i class="fa-solid fa-clock-rotate-left"></i></div>
                    <div>
                        <h5 class="font-bold text-gray-900 text-lg">5. Status Tracking</h5>
                        <p class="text-sm text-gray-600 mt-1">App polls for remote status updates (In-progress, Ready, Served)</p>
                    </div>
                </div>

                <div class="h-8 border-l-2 border-dashed border-gray-300"></div>
                <div class="text-gray-400 -mt-3 mb-1"><i class="fa-solid fa-chevron-down"></i></div>

                <!-- Step 6 -->
                <div class="w-full max-w-lg bg-gray-50 border-l-4 border-gray-800 shadow-sm rounded-lg p-5 flex items-center z-10 hover:shadow-md transition-shadow relative overflow-hidden">
                    <div class="absolute -right-4 -top-4 opacity-5 text-gray-800 text-6xl"><i class="fa-solid fa-check-double"></i></div>
                    <div class="bg-gray-800 text-white rounded-full w-12 h-12 flex items-center justify-center font-bold text-lg mr-5 shrink-0 shadow-sm"><i class="fa-solid fa-check"></i></div>
                    <div>
                        <h5 class="font-bold text-gray-900 text-lg">6. Order Finalization</h5>
                        <p class="text-sm text-gray-700 mt-1">Transaction is marked complete and local state resets for next table</p>
                    </div>
                </div>

            </div>

            <h3 class="text-2xl font-bold mb-4 text-gray-900 border-b border-gray-300 pb-2">8. UI/UX Design</h3>
            <p class="mb-4">The app interface is optimized for restaurant operations:</p>
            <ul class="list-disc pl-8 mb-10 space-y-2">
                <li>Simple table selection screen</li>
                <li>Quick-add menu item interface</li>
                <li>Real-time order list for each table</li>
                <li>Status indicators (pending, cooking, served)</li>
                <li>Notifications for updates</li>
                <li>Minimal steps to add or modify orders</li>
            </ul>

            <h3 class="text-2xl font-bold mb-4 text-gray-900 border-b border-gray-300 pb-2">9. Security Features</h3>
            <ul class="list-disc pl-8 mb-10 space-y-2">
                <li>Employee login authentication</li>
                <li>Role-based access (waiter only for this app)</li>
                <li>Secure API communication</li>
                <li>Data validation to prevent incorrect orders</li>
            </ul>

            <h3 class="text-2xl font-bold mb-4 text-gray-900 border-b border-gray-300 pb-2">10. Conclusion</h3>
            <p class="mb-4 text-justify">
                The Dine Master Android Application for waiters provides a complete digital solution for order
                management in restaurants.
            </p>
            <p class="mb-4 text-justify">
                It improves operational efficiency, reduces errors, and ensures seamless communication between waiters
                and the backend Admin Panel.
            </p>
            <p class="mb-8 text-justify">
                The app meets the project objectives and provides a scalable solution that can be enhanced for future
                features.
            </p>

            <!-- Document Footer -->
            <div
                class="mt-20 pt-8 border-t border-dashed border-gray-400 text-center font-sans text-xs text-gray-400 uppercase tracking-widest">
                <p>— End of Android Application Specification —</p>
            </div>
        </div>
    </div>

</div>

<style>
    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(10px);
        }

        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .animate-fade-in {
        animation: fadeIn 0.4s ease-out forwards;
    }
</style>

<script>
    function switchDoc(docId) {
        // Hide documents
        document.querySelectorAll('.document-page').forEach(el => {
            el.classList.add('hidden');
        });

        // Reset tabs
        document.querySelectorAll('.doc-tab-btn').forEach(el => {
            el.classList.remove('active-doc', 'text-blue-700', 'bg-blue-50', 'shadow-sm', 'border-blue-100', 'border');
            el.classList.add('text-gray-500');

            // Manage standard state without removing the hover logic which is built into standard tailwind
        });

        // Show active document
        document.getElementById(docId).classList.remove('hidden');

        // Active button styles
        const activeBtn = document.getElementById('btn-' + docId);
        activeBtn.classList.remove('text-gray-500');
        activeBtn.classList.add('active-doc', 'text-blue-700', 'bg-blue-50', 'shadow-sm', 'border', 'border-blue-100');
    }
</script>