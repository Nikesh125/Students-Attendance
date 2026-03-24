<?php
define('DIRECT_ACCESS', true);

// load the functions
require_once('./functions.php');
if (isAuth()) {
    header('location:./dashboard.php');
}

// database connection
require_once('./database.php');

// user submit the button
if (isset($_POST['submit']) && !empty($_POST['submit'])) {
    $username = $_POST['username'];
    $password = $_POST['password'];

    // validate the input data
    $error = [];

    if (empty($username)) {
        setError('username', 'Username field is empty');
    }

    if (empty($password)) {
        setError('password', "Password field is empty");
    }

    // Validate whether form field is empty or not
    if (count($error) == 0) {

        // check user existence
        $sql = "SELECT * FROM users WHERE username = '$username'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            // hash password matched
            $isMatched = password_verify($password, $row['password']);
            if ($isMatched) {
                session_start();
                $_SESSION['username'] = $username;
                header('location:./dashboard.php');
            }
        } else {
            $error['message'] = "Authentication Failed";
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

    <h2>Login Form</h2>

    <form action="./login.php" method="POST">
        <div class="imgcontainer">
            <img src="./assets/images/avatar.png" alt="Avatar" class="avatar">
        </div>

        <div class="container">

            <div class="form-group">
                <label for="uname"><b>Username</b></label>
                <input type="text" placeholder="Enter Username" name="username">
                <small class="error"><?php if (isset($error['username'])) echo $error['username']; ?></small>
            </div>

            <div class="form-group">
                <label for="psw"><b>Password</b></label>
                <input type="password" placeholder="Enter Password" name="password">
                <small class="error"><?php if (isset($error['password'])) echo $error['password']; ?></small>
            </div>

            <div class="form-group">
                <small class="success"><?php if (isset($success)) echo $success; ?></small>
                <small class="error"><?php if (isset($error['message'])) echo $error['message']; ?></small>
                <input type="submit" name="submit">
            </div>
        </div>

        <div class="container" style="background-color:#f1f1f1">
            <span class="alreadyRegister">Not <a href="./register.php">registered yet?</a></span>
            <span class="psw">Forgot <a href="forgot.php">password?</a></span>
        </div>
    </form>

</body>

</html>