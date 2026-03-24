<?php
define('DIRECT_ACCESS',true);
require_once('database.php');

$sql = "SELECT * FROM cards;";
$result = $conn->query($sql);

?>

<?php
require_once('./partials/header.php');
require_once('./partials/navbar.php');
?>

<main class="content">
    <div class="container-card">

        <?php while ($row = $result->fetch_assoc()) { ?>
            <div class="card">
                <?php if ($row['image']) { ?>
                    <img src="./uploads/<?php echo $row['image']; ?>" alt="Avatar" />
                <?php } else { ?>
                    <img src="./assets/images//user6.jpg" alt="Avatar" />
                <?php }  ?>
                <div class="card-container">
                    <h4><b><?php echo $row['name']; ?></b></h4>
                    <p><?php echo $row['profession']; ?></p>
                </div>
            </div>
        <?php } ?>

    </div>
</main>

<?php
require_once('./partials/footer.php');
?>


</body>

</html>