<?php
define('DIRECT_ACCESS',true);
require_once('./database.php');
$cardId = $_GET['id'];
$sql = "SELECT * FROM cards WHERE id = $cardId;";
$result = $conn->query($sql);

// Check card existence
if ($conn->affected_rows > 0) {
    // Card exist so HTML doc will show the following form
    $row = $result->fetch_assoc();
    $cardId = $row['id'];
    $name = $row['name'];
    $profession = $row['profession'];
    $image = $row['image'];
} else {
    $_SESSION['error']['message'] = "Card not found";
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

            <h2>Edit Card</h2>

            <form action="./card.update.php" method="POST" enctype="multipart/form-data">
                <div class="imgcontainer">
                    <img src="./assets/images/avatar.png" alt="Avatar" class="avatar">
                </div>

                <input type="hidden" name="id" value="<?php echo $cardId; ?>">

                <div class="container">
                    <div class="form-group">
                        <label for="psw"><b>Name</b></label>
                        <input type="text" placeholder="Enter Full Name" name="name" value="<?php echo $name; ?>">
                        <small class="error"><?php if (isset($_SESSION['error']['name'])) echo $_SESSION['error']['name']; ?></small>
                        <!-- <small class="error"><?php if (isset($_SESSION['error']['name'])) echo $_SESSION['error']['name']; ?></small> -->
                    </div>

                    <div class="form-group">
                        <label for="uname"><b>Profession</b></label>
                        <input type="text" placeholder="Enter Profession" name="profession" value="<?php echo $profession; ?>">
                        <small class="error"><?php if (isset($_SESSION['error']['username'])) echo $_SESSION['error']['username']; ?></small>
                    </div>

                    <div class="form-group">
                        <?php if($image){ ?>
                        <label>Old Image</label><br>
                        <img style="height: 150px;" src="./uploads/<?php echo $image; ?>" ><br>
                        <?php } ?>
                        <label for="uname"><b>Image</b></label>
                        <input type="file" name="image">
                        <small class="error"><?php if (isset($_SESSION['error']['image'])) echo $_SESSION['error']['image']; ?></small>
                    </div>

                    <div class="form-group">
                        <small class="success"><?php if (isset($success)) echo $success; ?></small>
                        <small class="error"><?php if (isset($error['message'])) echo $error['message']; ?></small>
                        <input type="submit" name="submit" value="Update">
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