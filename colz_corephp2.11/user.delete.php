<?php
session_start();
require_once('./database.php');
$userId = $_GET['id'];
$sql = "SELECT * FROM users WHERE id = $userId;";
$result = $conn->query($sql);

// I should not delete myself - verify

if ($conn->affected_rows > 0) {
    $row = $result->fetch_assoc();
    if ($row['username'] == $_SESSION['username']) {
        $_SESSION['error']['message'] = "You can not delete yourself";
    } else {
        $sql = "DELETE FROM users WHERE id = $userId;";
        $conn->query($sql);
        if ($conn->affected_rows == 1) {
            $_SESSION['success']['message'] = "User deleted successfully";
        } else {
            $_SESSION['error']['message'] = "User unable to delete";
        }
    }
    header('location:./dashboard.php');
} else {
    $_SESSION['error']['message'] = "User not found";
    header('location:./dashboard.php');
}
