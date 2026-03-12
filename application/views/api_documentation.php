<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo $title; ?></title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Inter', sans-serif; background: #0f1117; color: #e1e4e8; min-height: 100vh; }
        .container { max-width: 1100px; margin: 0 auto; padding: 40px 20px; }
        h1 { font-size: 2rem; font-weight: 700; color: #fff; margin-bottom: 8px; }
        .subtitle { color: #8b949e; font-size: 0.95rem; margin-bottom: 32px; }
        .search-box { width: 100%; padding: 12px 16px; border-radius: 8px; border: 1px solid #30363d; background: #161b22; color: #e1e4e8; font-size: 0.95rem; margin-bottom: 32px; outline: none; transition: border-color .2s; }
        .search-box:focus { border-color: #58a6ff; }
        .category-title { font-size: 1.1rem; font-weight: 600; color: #58a6ff; margin: 28px 0 12px; text-transform: uppercase; letter-spacing: .5px; }
        .api-card { background: #161b22; border: 1px solid #30363d; border-radius: 10px; padding: 20px 24px; margin-bottom: 16px; transition: border-color .2s; }
        .api-card:hover { border-color: #58a6ff; }
        .api-header { display: flex; align-items: center; gap: 12px; flex-wrap: wrap; margin-bottom: 10px; }
        .api-name { font-weight: 600; font-size: 1.05rem; color: #fff; }
        .badge { display: inline-block; padding: 3px 10px; border-radius: 4px; font-size: .75rem; font-weight: 700; text-transform: uppercase; letter-spacing: .3px; }
        .badge-get { background: rgba(56,139,253,.15); color: #58a6ff; }
        .badge-post { background: rgba(63,185,80,.15); color: #3fb950; }
        .badge-put { background: rgba(210,153,34,.15); color: #d29922; }
        .badge-delete { background: rgba(248,81,73,.15); color: #f85149; }
        .api-url { font-family: 'SFMono-Regular','Consolas','Liberation Mono',monospace; font-size: .85rem; color: #8b949e; background: #0d1117; padding: 4px 10px; border-radius: 4px; }
        .api-desc { color: #8b949e; font-size: .9rem; margin-bottom: 14px; line-height: 1.5; }
        .section-label { font-weight: 600; font-size: .8rem; color: #58a6ff; text-transform: uppercase; letter-spacing: .5px; margin-bottom: 6px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 14px; }
        th { text-align: left; padding: 8px 10px; font-size: .78rem; color: #8b949e; background: #0d1117; border-bottom: 1px solid #21262d; font-weight: 500; text-transform: uppercase; letter-spacing: .3px; }
        td { padding: 8px 10px; font-size: .85rem; color: #c9d1d9; border-bottom: 1px solid #21262d; }
        pre { background: #0d1117; border: 1px solid #21262d; border-radius: 6px; padding: 14px; overflow-x: auto; font-size: .82rem; color: #3fb950; line-height: 1.5; }
        .toggle-btn { background: none; border: none; color: #58a6ff; font-size: .85rem; cursor: pointer; padding: 4px 0; font-weight: 500; }
        .toggle-btn:hover { text-decoration: underline; }
        .response-block { display: none; margin-top: 8px; }
        .response-block.open { display: block; }
        .no-results { text-align: center; color: #484f58; padding: 40px; font-size: .95rem; }
    </style>
</head>
<body>
    <div class="container">
        <h1><?php echo $title; ?></h1>
        <p class="subtitle">Complete reference for all available API endpoints.</p>
        <input type="text" class="search-box" id="searchBox" placeholder="Search APIs by name, URL, method, or category...">
        
        <?php
        $categories = [];
        foreach ($apis as $api) {
            $categories[$api['category']][] = $api;
        }
        $cardIndex = 0;
        foreach ($categories as $cat => $items): ?>
            <div class="category-group" data-category="<?php echo strtolower($cat); ?>">
                <div class="category-title"><?php echo htmlspecialchars($cat); ?></div>
                <?php foreach ($items as $api): ?>
                    <div class="api-card" data-search="<?php echo strtolower($api['name'] . ' ' . $api['url'] . ' ' . $api['method'] . ' ' . $api['category']); ?>">
                        <div class="api-header">
                            <span class="badge badge-<?php echo strtolower($api['method']); ?>"><?php echo $api['method']; ?></span>
                            <span class="api-name"><?php echo htmlspecialchars($api['name']); ?></span>
                            <span class="api-url"><?php echo htmlspecialchars($api['url']); ?></span>
                        </div>
                        <p class="api-desc"><?php echo htmlspecialchars($api['description']); ?></p>
                        
                        <?php if (!empty($api['params'])): ?>
                            <div class="section-label">Parameters</div>
                            <table>
                                <tr><th>Name</th><th>Type</th><th>Description</th></tr>
                                <?php foreach ($api['params'] as $p): ?>
                                    <tr>
                                        <td><code><?php echo htmlspecialchars($p['name']); ?></code></td>
                                        <td><?php echo htmlspecialchars($p['type']); ?></td>
                                        <td><?php echo htmlspecialchars($p['description']); ?></td>
                                    </tr>
                                <?php endforeach; ?>
                            </table>
                        <?php endif; ?>
                        
                        <?php if (!empty($api['example_response'])): ?>
                            <button class="toggle-btn" onclick="toggleResponse(this)">▸ Show Response</button>
                            <div class="response-block">
                                <pre><?php echo htmlspecialchars($api['example_response']); ?></pre>
                            </div>
                        <?php endif; ?>
                    </div>
                <?php $cardIndex++; endforeach; ?>
            </div>
        <?php endforeach; ?>
        
        <div class="no-results" id="noResults" style="display:none;">No APIs match your search.</div>
    </div>

    <script>
        function toggleResponse(btn) {
            const block = btn.nextElementSibling;
            block.classList.toggle('open');
            btn.textContent = block.classList.contains('open') ? '▾ Hide Response' : '▸ Show Response';
        }

        document.getElementById('searchBox').addEventListener('input', function() {
            const q = this.value.toLowerCase().trim();
            const cards = document.querySelectorAll('.api-card');
            const groups = document.querySelectorAll('.category-group');
            let anyVisible = false;

            cards.forEach(c => {
                const match = !q || c.dataset.search.includes(q);
                c.style.display = match ? '' : 'none';
                if (match) anyVisible = true;
            });

            groups.forEach(g => {
                const visibleCards = g.querySelectorAll('.api-card[style=""],.api-card:not([style])');
                let hasVisible = false;
                visibleCards.forEach(c => { if (c.style.display !== 'none') hasVisible = true; });
                g.style.display = hasVisible ? '' : 'none';
            });

            document.getElementById('noResults').style.display = anyVisible ? 'none' : '';
        });
    </script>
</body>
</html>
