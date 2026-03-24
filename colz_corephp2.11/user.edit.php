<?php
session_start();
require_once('./database.php');
$userId = $_GET['id'];
$sql = "SELECT * FROM users WHERE id = $userId;";
$result = $conn->query($sql);
if ($conn->affected_rows > 0) {
    $row = $result->fetch_assoc();
    echo $row['username'];
    echo $_SESSION['username'];
    if ($row['username'] === $_SESSION['username']) {
        $username = $row['username'];
        $name = $row['name'];
    } else {
        echo $_SESSION['error']['message'] = "You can not edit the data other than yours";
        header('location:./dashboard.php');
    }
} else {
    $_SESSION['error']['message'] = "User not found";
    header('location:./dashboard.php');
}
?>



<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu</title>
    <link rel="stylesheet" href="./assets/css/style.css">
</head>

<body>

    <header class="info">
        <img src="./assets/images/logo.png">
        <div class="offer">
            <p class="offer-title">Winter Sale Sale Sale</p>
            <p class="offer-content">50% Dicount on Any Service</p>
        </div>

    </header>

    <nav class="navbar">

        <div class="logo">
            Logo
        </div>

        <div>
            <ul class="menu-items">
                <li><a href="./index.php">Home</a></li>

                <li><a href="./register.php">Register</a></li>
                <li><a href="./login.php">Login</a></li>
                <li><a href="./dashboard.php">Dashboard</a></li>
                <li><a href="./user/user.index.php">User</a></li>
                <li><a href="./card/card.index.php">Card</a></li>
                <li><a href="./logout.php">Logout</a></li>

            </ul>
        </div>
    </nav>

    <main class="content">
        <div class="container">
            welcome <?php echo $_SESSION['username']; ?>

            <a href="#" style="float:right">Create User</a>
        </div>
        <div style="width:80%; margin:auto;">
            <small class="error"><?php if (isset($_SESSION['error']['message'])) echo $_SESSION['error']['message']; ?></small>
            <small class="success"><?php if (isset($_SESSION['success']['message'])) echo $_SESSION['success']['message']; ?></small>

            <h2>Edit User</h2>

            <form action="./user.update.php" method="POST">
                <div class="imgcontainer">
                    <img src="./assets/images/avatar.png" alt="Avatar" class="avatar">
                </div>

                <!-- <input type="text" name="username" value="<?php echo $username; ?>"> -->

                <div class="container">
                    <div class="form-group">
                        <label for="psw"><b>Name</b></label>
                        <input type="text" placeholder="Enter Full Name" name="name" value="<?php echo $name; ?>">
                        <small class="error"><?php if (isset($_SESSION['error']['name'])) echo $_SESSION['error']['name']; ?></small>
                        <!-- <small class="error"><?php if (isset($_SESSION['error']['name'])) echo $_SESSION['error']['name']; ?></small> -->
                    </div>

                    <div class="form-group">
                        <label for="uname"><b>Username</b></label>
                        <input readonly type="text" placeholder="Enter Username" name="username" value="<?php echo $username; ?>">
                        <small class="error"><?php if (isset($_SESSION['error']['username'])) echo $_SESSION['error']['username']; ?></small>

                    </div>

                    <div class="form-group">
                        <small class="success"><?php if (isset($success)) echo $success; ?></small>
                        <small class="error"><?php if (isset($error['message'])) echo $error['message']; ?></small>
                        <input type="submit" name="submit">
                    </div>
                </div>

            </form>
        </div>
    </main>


    <footer class="footer">
        <p>Copyright &copy; 2026. All Rights Reserved</p>
    </footer>


</body>

</html>

<?php
// $_SESSION['error'] = [];
// $_SESSION['success'] = [];
?>