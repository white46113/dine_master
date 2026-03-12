<?php
$dir = __DIR__ . '/application/views/templates_c/';
$files = glob($dir . '*');
$deleted = 0;
$failed = 0;
foreach($files as $file) {
    if(is_file($file) && basename($file) != '.gitignore') {
        if (unlink($file)) {
            $deleted++;
        } else {
            $failed++;
            echo "Failed to delete: " . basename($file) . "<br>";
        }
    }
}
echo "Deleted: $deleted, Failed: $failed";
