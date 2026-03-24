<?php
session_start();

// set variables
$_SESSION['error'] = [];

function printer($arr)
{
    echo '<pre>';
    print_r($arr);
    echo '</pre>';
}

function setError($key, $value)
{
    // $_SESSION['error'][$key] = $value;
}

function validateForm($field, $message)
{
    if (empty($_SESSION['form'][$field])) {
        $_SESSION['error'][$field] = $message;
    }
}

function getFormValue($field)
{
    $_SESSION['form'][$field] = $_POST[$field];
}


// Database Connection
require_once './database.php';

// user submit the button
if (isset($_POST['submit']) && !empty($_POST['submit'])) {
    // Get values from FORM
    getFormValue('name');
    getFormValue('username');

    // validate the input data
    validateForm('name', 'The Name field is required');


    // Validate whether form field is empty or not
    if (count($_SESSION['error']) == 0) {

        // Update the user
        echo $sql = "UPDATE users SET name = '{$_SESSION['form']['name']}' WHERE username = '{$_SESSION['form']['username']}';";
        $result = $conn->query($sql);

        // data inserted or not
        if ($conn->affected_rows > 0) {
            $_SESSION['success']['message'] = "User updated Successfully";
            header('location:./dashboard.php');
        } else {
            $_SESSION['error']['message'] = "Remains unchanged";
            header('location:./dashboard.php');

        }
    }else{
        $_SESSION['error']['message'] = "Field field(s) are missing";
            header('location:./dashboard.php');
    }
}
