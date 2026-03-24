<?php
session_start();

// set variables
$_SESSION['error'] = [];

// load function
require_once('./functions.php');


// Database Connection
require_once './database.php';

// user submit the button
if (isset($_POST['submit']) && !empty($_POST['submit'])) {
    // Get values from FORM
    getFormValue('name');
    getFormValue('profession');
    getFormValue('id');

    // validate the input data
    validateForm('name', 'The Name field is required');
    validateForm('profession', 'The Profession field is required');

    // Validate whether form field is empty or not
    if (count($_SESSION['error']) == 0) {

        // Validate the card exist or not
        $sql = "SELECT * FROM cards WHERE id = '{$_SESSION['form']['id']}';";
        $result = $conn->query($sql);
        if ($conn->affected_rows > 0) {   // card exist
            $row = $result->fetch_assoc();
            $oldImageFile = $row['image'];          // old image file

            // delete old image if exist
            deleteUploadedFileIfExists($oldImageFile);

            // upload new image if exist
            $newFileName = uploadImageIfExists('image');
            //    die;

            // Update the user
            $sql = "UPDATE cards SET name = '{$_SESSION['form']['name']}', profession = '{$_SESSION['form']['profession']}', image = '$newFileName'  WHERE id = '{$_SESSION['form']['id']}';";
            $result = $conn->query($sql);

            // data updated or not
            if ($conn->affected_rows > 0) {
                $_SESSION['success']['message'] = "Card updated Successfully";
                header('location:./card.index.php');
            } else {
                $_SESSION['error']['message'] = "Remains unchanged";
                header('location:./card.index.php');
            }
        }
    } else {
        $_SESSION['error']['message'] = "Field(s) are missing";
        header('location:./card.index.php');
    }
}
