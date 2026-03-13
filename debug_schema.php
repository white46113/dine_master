<?php
$mysqli = new mysqli("localhost", "root", "", "dine_master");

if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
}

echo "--- PAYMENTS TABLE STRUCTURE ---\n";
$res = $mysqli->query("DESCRIBE payments");
if ($res) {
    while ($row = $res->fetch_assoc()) {
        print_r($row);
    }
} else {
    echo "Table 'payments' does not exist or error: " . $mysqli->error . "\n";
}

$mysqli->close();
?>
