<?php

function printer($x){
    echo '<pre>';
    print_r($x);
    echo '</pre>';
}

if(isset($_POST['login']) && !empty($_POST['login'])){
    $logusername = $_POST['username'];
    $logpassword = $_POST['password'];

    $error = [];
    if (empty($logusername)) {
        $error['username'] = "Username field is empty";
    }

    if (empty($logpassword)) {
        $error['password'] = "Password field is empty";
    }

    if(count($error) == 0){
        $connect = new mysqli('localhost', 'root', '@Nikesh125', 'core');

        $validate = "SELECT * FROM registration WHERE username = '$logusername' AND password = '$logpassword';";
        $result = $connect->query($validate);
        

        if($result->num_rows > 0){
            $success = 'Logged in Successfully!';
        }
        else{
            $error['message'] = 'Credentials are incorrect!';
        }
    }
}

?>

<!DOCTYPE html>
<html>

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
        }

        form {
            border: 3px solid #f1f1f1;
        }

        .error {
            color: red;
        }

        .success {
            color: green;
        }

        .form-group {
            margin-top: 5px;
            padding-top: 12px;
        }

        input[type=text],
        input[type=password] {
            width: 100%;
            padding: 12px 10px;
            display: inline-block;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        input[type=submit] {
            background-color: #04AA6D;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            cursor: pointer;
            width: 100%;
        }

        button:hover {
            opacity: 0.8;
        }

        .alreadyRegister {
            /* width: auto; */
            padding: 10px 18px;
            /* background-color: #f44336; */
        }

        .imgcontainer {
            text-align: center;
            margin: 24px 0 12px 0;
        }

        img.avatar {
            width: 8%;
            border-radius: 50%;
        }

        .container {
            padding: 16px;
        }

        span.psw {
            float: right;

        }

        /* Change styles for span and cancel button on extra small screens */
        @media screen and (max-width: 300px) {
            span.psw {
                display: block;
                float: none;
            }

            .cancelbtn {
                width: 100%;
            }
        }
    </style>
</head>

<body>

    <h2>Login Form</h2>

    <form action="login.php" method="POST">
        <div class="imgcontainer">
            <img src="assets/images/sunrise.jpg" alt="Avatar" class="avatar">
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
                <input type="submit" name="login" value="Login">
            </div>
        </div>

        <div class="container" style="background-color:#f1f1f1">
            <span class="alreadyRegister">New? <a href="register.php" target="_blank">Register Now</a></span>
            <span class="psw">Forgot <a href="#">password?</a></span>
        </div>
    </form>

</body>

</html>