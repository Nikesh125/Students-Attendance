<?php
define('DIRECT_ACCESS',true);

// set variables
$_SESSION['error'] = [];

// load functions
require_once('./functions.php');


// Database Connection
require_once './database.php';

// user submit the button
if (isset($_POST['submit']) && !empty($_POST['submit'])) {

    // Get values from FORM
    getFormValue('name');
    getFormValue('profession');

    // validate the input data
    validateForm('name', 'The Name field is required');
    validateForm('profession', 'The Profession field is required');

    // Validate whether form field is empty or not
    if (count($_SESSION['error']) == 0) {

        // Get Image Details
        $imageFile = uploadImageIfExists('image');

        // Register the card
        $sql = "INSERT INTO cards(name, profession, image) VALUES ('{$_SESSION['form']['name']}','{$_SESSION['form']['profession']}', '$imageFile');";
        $result = $conn->query($sql);

        // data inserted or not
        if ($conn->affected_rows > 0) {
            $success['message'] = "Card Registered Successfully";
        } else {
            $_SESSION['error']['message'] = "Unable to insert";
        }
    }
}
?>


<?php
require_once('./partials/header.php');
require_once('./partials/navbar.php');
?>


    <main class="content">
        <div class="container">
            welcome <?php echo $_SESSION['username']; ?>

            <a href="#" style="float:right">Create Card</a>
        </div>
        <div style="width:80%; margin:auto;">
            <small class="error"><?php if (isset($_SESSION['error']['message'])) echo $_SESSION['error']['message']; ?></small>
            <small class="success"><?php if (isset($_SESSION['success']['message'])) echo $_SESSION['success']['message']; ?></small>

            <h2>Create Card</h2>

            <form action="./card.create.php" method="POST" enctype="multipart/form-data">
                <div class="imgcontainer">
                    <img src="./assets/images/avatar.png" alt="Avatar" class="avatar">
                </div>


                <div class="container">
                    <div class="form-group">
                        <label for="psw"><b>Person Name</b></label>
                        <input type="text" placeholder="Enter Name" name="name">
                        <small class="error"><?php if (isset($_SESSION['error']['name'])) echo $_SESSION['error']['name']; ?></small>
                    </div>

                    <div class="form-group">
                        <label for="uname"><b>Profession</b></label>
                        <input type="text" placeholder="Enter Profession" name="profession">
                        <small class="error"><?php if (isset($_SESSION['error']['profession'])) echo $_SESSION['error']['profession']; ?></small>
                    </div>

                    <div class="form-group">
                        <label for="uname"><b>Image</b></label>
                        <input type="file" name="image">
                        <small class="error"><?php if (isset($_SESSION['error']['image'])) echo $_SESSION['error']['image']; ?></small>
                    </div>

                    <div class="form-group">
                        <small class="success"><?php if (isset($success['message'])) echo $success['message']; ?></small>
                        <small class="error"><?php if (isset($error['message'])) echo $error['message']; ?></small>
                        <input type="submit" name="submit" value="Create">
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