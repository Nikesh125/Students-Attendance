<?php
session_start();

// load functions
require_once('./functions.php');

require_once('./database.php');


$cardId = $_GET['id'];
$sql = "SELECT * FROM cards WHERE id = $cardId;";
$result = $conn->query($sql);

// Card exist or not
if ($conn->affected_rows > 0) {

    $sql = "DELETE FROM cards WHERE id = $cardId;";
    $conn->query($sql);
    if ($conn->affected_rows == 1) {

        // Image file exist or not
        $row = $result->fetch_assoc();
        $fileName = $row['image'];
        deleteUploadedFileIfExists($fileName);

        $_SESSION['success']['message'] = "Card deleted successfully";
    } else {
        $_SESSION['error']['message'] = "Card unable to delete";
    }

    header('location:./card.index.php');
} else {
    $_SESSION['error']['message'] = "Card not found";
    header('location:./card.index.php');
}
