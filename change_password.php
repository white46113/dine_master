<?php
$conn = new mysqli('127.0.0.1', 'root', 'Root@123', 'dine_master', 3307);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
$password = password_hash('admin123', PASSWORD_BCRYPT);
$sql = "UPDATE users SET user_password = '$password' WHERE user_id = 2";
if ($conn->query($sql) === TRUE) {
    echo "Password updated successfully to admin123";
} else {
    echo "Error updating password: " . $conn->error;
}
$conn->close();
?>
