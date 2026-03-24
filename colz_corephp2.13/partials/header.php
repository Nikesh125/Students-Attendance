<?php
require_once('./functions.php');

if (basename($_SERVER['PHP_SELF']) == basename(__FILE__)) {
    return die('Direct access not permitted');
}


?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu</title>
    <link rel="stylesheet" href="<?php echo baseURL() ?>/assets/css/style.css">
</head>

<body>

    <header class="info">
        <img src="<?php echo baseURL() ?>/assets/images/logo.png">
        <div class="offer">
            <p class="offer-title">Winter Sale Sale Sale</p>
            <p class="offer-content">50% Dicount on Any Service</p>
        </div>

    </header>