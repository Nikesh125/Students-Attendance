<?php

define('DIRECT_ACCESS',true);

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

<?php
require_once('./partials/header.php');
require_once('./partials/navbar.php');
?>

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

<?php
require_once('./partials/footer.php');
?>


</body>

</html>

<?php
// $_SESSION['error'] = [];
// $_SESSION['success'] = [];
?>