<?php
require_once('functions.php');
validateAuthPage();

session_start();
session_unset();

header('location:./login.php');