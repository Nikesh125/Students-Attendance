<?php
define('DIRECT_ACCESS', true);

// load the functions
require_once('./functions.php');
if (isAuth()) {
    header('location:./dashboard.php');
}

// set variables
$_SESSION['error'] = [];

// Database Connection
require_once './database.php';

// user submit the button
if (isset($_POST['submit']) && !empty($_POST['submit'])) {
    // Get values from FORM
    getFormValue('name');
    getFormValue('username');
    getFormValue('password');
    getFormValue('confirmed_password');

    // validate the input data
    validateForm('name', 'The Name field is required');
    validateForm('username', 'The Username field is required');
    validateForm('password', 'The Password field is required');
    validateForm('confirmed_password', 'The Confirm Password field is required');
    // echo "'{$_SESSION['form']['name']}'";
    // die;
    // Validate whether form field is empty or not
    if (count($_SESSION['error']) == 0) {
        // check the password matched or not
        if ($_SESSION['form']['password'] === $_SESSION['form']['confirmed_password']) {

            // check user existence
            $sql = "SELECT * FROM users WHERE username = '$username';";
            $result = $conn->query($sql);

            if ($result->num_rows > 0) {
                $_SESSION['error']['message'] = "User already exist";
            } else {
                // hash the password
                $hashedPassword = password_hash($_POST['password'], PASSWORD_DEFAULT);

                // Register the user
                $sql = "INSERT INTO users(name, username, password) VALUES ('{$_SESSION['form']['name']}','{$_SESSION['form']['username']}', '$hashedPassword');";
                $result = $conn->query($sql);

                // data inserted or not
                if ($conn->affected_rows > 0) {
                    $success = "User Registered Successfully";
                } else {
                    $_SESSION['error']['message'] = "Unable to insert";
                }
            }
        } else {
            $_SESSION['error']['password'] = 'Password do not matched';
        }
    }
}
?>

<!DOCTYPE html>
<html>

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="./assets/css/style.css" rel="stylesheet">
    <style>

    </style>
</head>

<body>

    <h2>Registration Form</h2>

    <form action="./register.php" method="POST">
        <div class="imgcontainer">
            <img src="./assets/images/avatar.png" alt="Avatar" class="avatar">
        </div>

        <div class="container">
            <div class="form-group">
                <label for="psw"><b>Name</b></label>
                <input type="text" placeholder="Enter Full Name" name="name">
                <small class="error"><?php if (isset($_SESSION['error']['name'])) echo $_SESSION['error']['name']; ?></small>
                <!-- <small class="error"><?php if (isset($_SESSION['error']['name'])) echo $_SESSION['error']['name']; ?></small> -->
            </div>

            <div class="form-group">
                <label for="uname"><b>Username</b></label>
                <input type="text" placeholder="Enter Username" name="username">
                <small class="error"><?php if (isset($_SESSION['error']['username'])) echo $_SESSION['error']['username']; ?></small>

            </div>

            <div class="form-group">
                <label for="psw"><b>Password</b></label>
                <input type="password" placeholder="Enter Password" name="password">
                <small class="error"><?php if (isset($_SESSION['error']['password'])) echo $_SESSION['error']['password']; ?></small>

            </div>

            <div class="form-group">
                <label for="psw"><b>Confirm Password</b></label>
                <input type="password" placeholder="Enter Confirmed Password" name="confirmed_password">
                <small class="error"><?php if (isset($_SESSION['error']['confirmed_password'])) echo $_SESSION['error']['confirmed_password']; ?></small>


            </div>

            <div class="form-group">
                <small class="success"><?php if (isset($success)) echo $success; ?></small>
                <small class="error"><?php if (isset($error['message'])) echo $error['message']; ?></small>
                <input type="submit" name="submit">
            </div>
        </div>

        <div class="container" style="background-color:#f1f1f1">
            <span class="alreadyRegister">Already <a href="./login.php">registered?</a></span>
            <span class="psw">Forgot <a href="./forgot.php">password?</a></span>
        </div>
    </form>

</body>

</html>