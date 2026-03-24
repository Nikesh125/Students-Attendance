<?php
session_start();
require_once('./database.php');
$sql = "SELECT * FROM users";
$result = $conn->query($sql);
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
                <li><a href="./dashboard.php">User</a></li>
                <li><a href="./card.index.php">Card</a></li>
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

            <table>
                <caption>List Users</caption>
                <tr>
                    <th>#</th>
                    <th>First Name</th>
                    <th>Username</th>
                    <th>Action</th>
                </tr>
                <?php $serialId = 1;
                while ($row = $result->fetch_assoc()) { ?>
                    <tr>
                        <td><?php echo $serialId; ?></td>
                        <td><?php echo $row['name']; ?></td>
                        <td><?php echo $row['username']; ?></td>
                        <td>
                            <a href="./user.edit.php?id=<?php echo $row['id']; ?>">Edit</a>
                            |
                            <a onclick="return confirm('Are you sure to del?') " style="color: red;" href="./user.delete.php?id=<?php echo $row['id']; ?>">Del</a>
                        </td>
                    </tr>
                <?php $serialId++;
                } ?>
            </table>
        </div>
    </main>


    <footer class="footer">
        <p>Copyright &copy; 2026. All Rights Reserved</p>
    </footer>


</body>

</html>

<?php
$_SESSION['error'] = [];
$_SESSION['success'] = [];
?>