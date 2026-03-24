<?php
define('DIRECT_ACCESS',true);
require_once('functions.php');
validateAuthPage();

require_once('./database.php');
$sql = "SELECT * FROM cards";
$result = $conn->query($sql);
?>



<?php
require_once('./partials/header.php');
require_once('./partials/navbar.php');
?>



    <main class="content">
        <div class="container">
            welcome <?php echo $_SESSION['username']; ?>

            <a href="./card.create.php" style="float:right">Create Card</a>
        </div>
        <div style="width:80%; margin:auto;">
            <small class="error"><?php if (isset($_SESSION['error']['message'])) echo $_SESSION['error']['message']; ?></small>
            <small class="success"><?php if (isset($_SESSION['success']['message'])) echo $_SESSION['success']['message']; ?></small>

            <table>
                <caption>List Cards</caption>
                <tr>
                    <th>#</th>
                    <th>Name</th>
                    <th>Profession</th>
                    <th>Image</th>
                    <th>Action</th>
                </tr>
                <?php $serialId = 1;
                while ($row = $result->fetch_assoc()) { ?>
                    <tr>
                        <td><?php echo $serialId; ?></td>
                        <td><?php echo $row['name']; ?></td>
                        <td><?php echo $row['profession']; ?></td>
                        <td>
                            <?php if ($row['image']) { ?>
                                <img style="height: 70px;" src="./uploads/<?php echo $row['image']; ?>">
                            <?php } else echo '-'; ?>
                        <td>
                            <a href="./card.edit.php?id=<?php echo $row['id']; ?>">Edit</a>
                            |
                            <a onclick="return confirm('Are you sure to del?') " style="color: red;" href="./card.delete.php?id=<?php echo $row['id']; ?>">Del</a>
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