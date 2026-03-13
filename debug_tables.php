<?php
$mysqli = new mysqli("localhost", "root", "", "dine_master");

if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
}

echo "--- FLOORS ---\n";
$res = $mysqli->query("SELECT * FROM floors");
while ($row = $res->fetch_assoc()) {
    print_r($row);
}

echo "\n--- DINING TABLES ---\n";
$res = $mysqli->query("SELECT * FROM dining_tables");
while ($row = $res->fetch_assoc()) {
    print_r($row);
}

echo "\n--- ACTIVE ORDERS ---\n";
$res = $mysqli->query("SELECT order_id, order_number, table_id, status FROM orders WHERE status = 'RUNNING'");
while ($row = $res->fetch_assoc()) {
    print_r($row);
}

$mysqli->close();
?>
