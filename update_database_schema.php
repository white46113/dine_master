<?php
$mysqli = new mysqli("localhost", "root", "", "dine_master");

if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
}

// Add reset_token and token_expiry if they don't exist
$check_query = "SHOW COLUMNS FROM users LIKE 'reset_token'";
$result = $mysqli->query($check_query);

if ($result->num_rows == 0) {
    $alter_query = "ALTER TABLE users 
                    ADD COLUMN reset_token VARCHAR(255) DEFAULT NULL,
                    ADD COLUMN token_expiry DATETIME DEFAULT NULL";
    if ($mysqli->query($alter_query)) {
        echo "Successfully added reset_token and token_expiry columns to users table.\n";
    } else {
        echo "Error adding columns: " . $mysqli->error . "\n";
    }
} else {
    echo "Columns already exist.\n";
}

$mysqli->close();
?>
