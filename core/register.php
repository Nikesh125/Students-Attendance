<?php
function printer($arr)
{
    echo '<pre>';
    print_r($arr);
    echo '</pre>';
}

// user submit the button
if (isset($_POST['submit']) && !empty($_POST['submit'])) {
    $name = $_POST['name'];
    $username = $_POST['username'];
    $password = $_POST['password'];
    $confirmed_password = $_POST['confirmed_password'];

    // validate the input data
    $error = [];
    if (empty($name)) {
        $error['name'] = "Name field is empty";
    }

    if (empty($username)) {
        $error['username'] = "Username field is empty";
    }

    if (empty($password)) {
        $error['password'] = "Password field is empty";
    }

    if (empty($confirmed_password)) {
        $error['confirmed_password'] = "Confirm Password field is empty";
    }


    // Validate whether form field is empty or not
    if (count($error) == 0) {
        // check the password matched or not
        if ($password === $confirmed_password) {
            // Database Connection
            $conn = new mysqli('localhost', 'root', '@Nikesh125', 'core');

            // check user existence
            $sql = "SELECT * FROM registration WHERE username = '$username';";
            $result = $conn->query($sql);
            // printer($result);
            if ($result->num_rows > 0) {
                $error['message'] = "User already exist";
            } else {
                // Register the user
                $sql = "INSERT INTO registration(name, username, password) VALUES ('$name','$username','$password');";
                $result = $conn->query($sql);

                // data inserted or not
                if ($conn->affected_rows > 0) {
                    $success = "User Registered Successfully";
                } else {
                    $error['message'] = "Unable to insert";
                }
            }
        } else {
            $error['password'] = 'Password do not matched';
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

    <h2>Registration Form</h2>

    <form action="./register.php" method="POST">
        <div class="imgcontainer">
            <img src="./assets/images/avatar.png" alt="Avatar" class="avatar">
        </div>

        <div class="container">
            <div class="form-group">
                <label for="psw"><b>Name</b></label>
                <input type="text" placeholder="Enter Full Name" name="name">
                <small class="error"><?php if (isset($error['name'])) echo $error['name']; ?></small>
            </div>

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
                <label for="psw"><b>Confirm Password</b></label>
                <input type="password" placeholder="Enter Confirmed Password" name="confirmed_password">
                <small class="error"><?php if (isset($error['password'])) echo $error['password']; ?></small>

            </div>

            <div class="form-group">
                <small class="success"><?php if (isset($success)) echo $success; ?></small>
                <small class="error"><?php if (isset($error['message'])) echo $error['message']; ?></small>
                <input type="submit" name="submit">
            </div>
        </div>

        <div class="container" style="background-color:#f1f1f1">
            <span class="alreadyRegister">Already <a href="login.php" target="blank">registered?</a></span>
            <span class="psw">Forgot <a href="#">password?</a></span>
        </div>
    </form>

</body>

</html>