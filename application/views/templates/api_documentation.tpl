<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{$title}</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4f46e5;
            --primary-hover: #4338ca;
            --bg-body: #f9fafb;
            --bg-card: #ffffff;
            --text-main: #111827;
            --text-muted: #6b7280;
            --border-color: #e5e7eb;
            --get-color: #3b82f6;
            --post-color: #10b981;
            --put-color: #f59e0b;
            --delete-color: #ef4444;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-body);
            color: var(--text-main);
            margin: 0;
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar */
        .sidebar {
            width: 260px;
            background-color: #111827;
            color: white;
            padding: 2rem 1rem;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
        }

        .sidebar h2 {
            font-size: 1.25rem;
            margin-bottom: 2rem;
            padding: 0 0.5rem;
            color: #f3f4f6;
        }

        .sidebar-nav ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sidebar-nav li {
            margin-bottom: 0.5rem;
        }

        .sidebar-nav a {
            color: #9ca3af;
            text-decoration: none;
            padding: 0.75rem 1rem;
            display: block;
            border-radius: 0.5rem;
            transition: all 0.2s;
            font-size: 0.925rem;
        }

        .sidebar-nav a:hover {
            background-color: #1f2937;
            color: white;
        }

        /* Main Content */
        .main-content {
            margin-left: 260px;
            flex: 1;
            padding: 2rem 3rem;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 3rem;
            gap: 2rem;
        }

        header h1 {
            font-size: 1.875rem;
            margin: 0;
        }

        .search-container {
            position: relative;
            flex: 1;
            max-width: 500px;
        }

        .search-container input {
            width: 100%;
            padding: 0.75rem 1rem 0.75rem 2.5rem;
            border: 1px solid var(--border-color);
            border-radius: 0.75rem;
            font-size: 1rem;
            outline: none;
            transition: border-color 0.2s;
        }

        .search-container input:focus {
            border-color: var(--primary);
        }

        .search-container svg {
            position: absolute;
            left: 0.75rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            width: 1.25rem;
            height: 1.25rem;
        }

        /* API Card */
        .api-card {
            background-color: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 1rem;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .api-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .method-badge {
            font-weight: 700;
            font-size: 0.75rem;
            padding: 0.25rem 0.625rem;
            border-radius: 0.375rem;
            text-transform: uppercase;
            color: white;
        }

        .method-GET { background-color: var(--get-color); }
        .method-POST { background-color: var(--post-color); }
        .method-PUT { background-color: var(--put-color); }
        .method-DELETE { background-color: var(--delete-color); }

        .api-path {
            font-family: 'Courier New', Courier, monospace;
            font-weight: 600;
            color: #374151;
            font-size: 1.1rem;
        }

        .api-title {
            font-size: 1.25rem;
            font-weight: 700;
            margin: 0;
        }

        .api-description {
            color: var(--text-muted);
            margin-bottom: 1.5rem;
            line-height: 1.5;
        }

        .section-title {
            font-size: 0.875rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: var(--text-muted);
            margin-bottom: 1rem;
            margin-top: 1.5rem;
        }

        /* Table */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 1.5rem;
        }

        table th, table td {
            text-align: left;
            padding: 0.75rem;
            border-bottom: 1px solid var(--border-color);
        }

        table th {
            font-size: 0.875rem;
            color: var(--text-muted);
            font-weight: 600;
        }

        table td {
            font-size: 0.925rem;
        }

        .param-name {
            font-family: monospace;
            font-weight: 600;
            color: var(--primary);
        }

        .param-type {
            color: #9333ea;
            font-size: 0.8rem;
            background: #f3e8ff;
            padding: 0.125rem 0.375rem;
            border-radius: 0.25rem;
        }

        /* JSON Block */
        pre {
            background-color: #1f2937;
            color: #e5e7eb;
            padding: 1.25rem;
            border-radius: 0.75rem;
            overflow-x: auto;
            font-size: 0.875rem;
            line-height: 1.6;
        }

        .category-group {
            margin-bottom: 4rem;
        }

        .category-title {
            font-size: 1.5rem;
            font-weight: 800;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #374151;
        }

        .category-title::before {
            content: '';
            width: 4px;
            height: 1.5rem;
            background-color: var(--primary);
            border-radius: 2px;
        }
    </style>
</head>
<body>

    <aside class="sidebar">
        <h2>Dine Master Docs</h2>
        <nav class="sidebar-nav">
            <ul>
                <li><a href="#category-Auth">Authentication</a></li>
                <li><a href="#category-User">User Management</a></li>
                <li><a href="#category-Restaurant">Restaurant Info</a></li>
                <li><a href="#category-Menu">Menu & Items</a></li>
                <li><a href="#category-Orders">Order Processing</a></li>
            </ul>
        </nav>
    </aside>

    <main class="main-content">
        <header>
            <h1>API Reference</h1>
            <div class="search-container">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                </svg>
                <input type="text" id="apiSearch" placeholder="Search APIs, endpoints, or descriptions...">
            </div>
        </header>

        {assign var="current_cat" value=""}
        {foreach from=$apis item=api}
            {if $current_cat != $api.category}
                {if $current_cat != ""}</div>{/if}
                {assign var="current_cat" value=$api.category}
                <div class="category-group" id="category-{$api.category}">
                    <h2 class="category-title">{$api.category}</h2>
            {/if}

            <div class="api-card" data-search="{$api.name} {$api.url} {$api.description}">
                <div class="api-header">
                    <span class="method-badge method-{$api.method}">{$api.method}</span>
                    <span class="api-path">{$api.url}</span>
                </div>
                <h3 class="api-title">{$api.name}</h3>
                <p class="api-description">{$api.description}</p>

                {if !empty($api.params)}
                    <div class="section-title">Parameters</div>
                    <table>
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Type</th>
                                <th>Description</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach from=$api.params item=param}
                            <tr>
                                <td class="param-name">{$param.name}</td>
                                <td><span class="param-type">{$param.type}</span></td>
                                <td>{$param.description}</td>
                            </tr>
                            {/foreach}
                        </tbody>
                    </table>
                {/if}

                <div class="section-title">Example Response</div>
                <pre><code>{$api.example_response}</code></pre>
            </div>
        {/foreach}
        </div>
    </main>

    <script>
        document.getElementById('apiSearch').addEventListener('input', function(e) {
            const term = e.target.value.toLowerCase();
            const cards = document.querySelectorAll('.api-card');
            
            cards.forEach(card => {
                const searchText = card.getAttribute('data-search').toLowerCase();
                if (searchText.includes(term)) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });

            // Hide empty categories
            document.querySelectorAll('.category-group').forEach(group => {
                const visibleCards = group.querySelectorAll('.api-card[style="display: block;"], .api-card:not([style])');
                if (visibleCards.length === 0) {
                    group.style.display = 'none';
                } else {
                    group.style.display = 'block';
                }
            });
        });
    </script>
</body>
</html>
