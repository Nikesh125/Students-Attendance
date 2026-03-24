<?php

session_start();
require_once './database.php';

if(isset($_POST['enter']) && !empty($_POST['enter'])){
    $name = $_POST['name'];
    $profession = $_POST['profession'];

    $error = [];
    if (empty($name)) {
        $error['name'] = "Name field is empty";
    }

    if (empty($profession)) {
        $error['profession'] = "Profession field is empty";
    }

    if(count($error) == 0){
        $sql = "SELECT * FROM cards WHERE name = '$name';";
        $result = $conn->query($sql);
            
        if ($result->num_rows > 0) {
            $error['message'] = "User already exist";
        } else {
                // Register the user
                $sql = "INSERT INTO cards(name, profession) VALUES ('$name','$profession');";
                $result = $conn->query($sql);

                // data inserted or not
                if ($conn->affected_rows > 0) {
                    $success = "User Registered Successfully";
                } else {
                    $error['message'] = "Unable to insert";
                }
            }
    }
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create</title>

    <link rel="stylesheet" href="./assets/css/style.css">
</head>
<body>
    <h2>Enter Details</h2>
    <div class="form-group">
        <form action="#" method="POST">
            <label for="fname">Full name: </label>
            <input type="text" name="name" required>
            <!-- <small class="fname"><?php if(isset($error['name'])) echo $error['name']; ?></small> -->

            <label for="pname">Profession: </label>
            <input type="text" name="profession">

            <input type="submit" value="Enter" name="enter" required>
        </form>
    </div>
    <!-- <div class="confirm"><small><?php if($conn->affected_rows > 0){ echo $success;} else{echo $error['message'];}?></small></div> -->

    <!-- <div class="container-card">
        <div class="card">
            <img src="./assets/images/user1.jpg" alt="Avatar" />
            <div class="card-container">
                <h4><b><?php echo $name; ?></b></h4>
                <p><?php echo $profession; ?></p>
            </div>
        </div>
    </div> -->
</body>
</html>