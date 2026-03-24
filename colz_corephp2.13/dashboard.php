<?php
define('DIRECT_ACCESS',true);
require_once('functions.php');
validateAuthPage();

require_once('./database.php');
$sql = "SELECT * FROM users";
$result = $conn->query($sql);
?>



<?php
require_once('./partials/header.php');
require_once('./partials/navbar.php');
?>



<main class="content">
    <div class="container">
        welcome <?php echo $_SESSION['username']; ?>

        <!-- <a href="#" style="float:right">Create User</a> -->
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


<?php
require_once('./partials/footer.php');
?>


</body>

</html>

<?php
$_SESSION['error'] = [];
$_SESSION['success'] = [];
?>