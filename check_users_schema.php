<?php
$mysqli = new mysqli("localhost", "root", "", "dine_master");

if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
}

$res = $mysqli->query("DESCRIBE users");
while ($row = $res->fetch_assoc()) {
    print_r($row);
}

$mysqli->close();
?>
