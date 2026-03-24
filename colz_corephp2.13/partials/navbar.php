<?php
if (!defined('DIRECT_ACCESS')) {
    die('Direct Access Not Allowed');
}
require_once('./functions.php');
?>


<nav class="navbar">

    <div class="logo">
        <a style="color: white;text-decoration:none;" href="./index.php">Logo</a>
    </div>

    <div>
        <ul class="menu-items">
            <li><a href="<?php echo baseURL(); ?>">Home</a></li>

            <?php if (isAuth()) { ?>
                <li><a href="<?php echo baseURL() ?>/dashboard.php">Dashboard</a></li>
                <li><a href="<?php echo baseURL() ?>/dashboard.php">User</a></li>
                <li><a href="<?php echo baseURL() ?>/card.index.php">Card</a></li>
                <li><a href="<?php echo baseURL() ?>/logout.php">Logout</a></li>
            <?php } else { ?>
                <li><a href="<?php echo baseURL() ?>/register.php">Register</a></li>
                <li><a href="<?php echo baseURL() ?>/login.php">Login</a></li>
            <?php } ?>




        </ul>
    </div>
</nav>