<?php
$sql = file_get_contents('public/database/db_upgrade.sql');
$queries = explode(';', $sql);

$mysqli = new mysqli("localhost", "root", "", "dine_master");

if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
}

foreach ($queries as $query) {
    if (trim($query)) {
        if (!$mysqli->query($query)) {
            echo "Error executing query: " . $mysqli->error . "\n";
        } else {
            echo "Success: Query executed.\n";
        }
    }
}

$mysqli->close();
?>
