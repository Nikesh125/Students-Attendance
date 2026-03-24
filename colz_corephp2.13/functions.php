<?php
session_start();

function setError($key, $value)
{
    global $error;
    $error[$key] = $value;
}

function printer($arr)
{
    echo '<pre>';
    print_r($arr);
    echo '</pre>';
}

function validateForm($field, $message)
{
    if (empty($_SESSION['form'][$field])) {
        $_SESSION['error'][$field] = $message;
    }
}

function getFormValue($field)
{
    $_SESSION['form'][$field] = $_POST[$field];
}

function uploadImageIfExists($field, $size = null)
{
    $files = $_FILES[$field];
    if ($files['error'] == 0) {
        // if($size && $files['size']<=$size){

        // }
        $rand = rand(1000, 10000) . time();
        $originalFileName = $rand . '_' . $files['name'];
        $tempFile = $files['tmp_name'];
        $x = move_uploaded_file($tempFile, './uploads/' . $originalFileName);
        if ($x) {
            return $originalFileName;
        } else {
            return null;
        }
    }
}

function deleteUploadedFileIfExists($fileName)
{
    $fileLocation = './uploads/' . $fileName;
    if ($fileName && file_exists($fileLocation)) {
        unlink($fileLocation);  // Always returns 1 if deleted
    }
}

function isAuth()
{
    if (isset($_SESSION['username'])) {
        return true;
    } else {
        return false;
    }
}

function validateAuthPage()
{
    if (!isset($_SESSION['username'])) {
        header('location:index.php');
    }
}


function baseURL()
{
    // echo '<pre>';
    // print_r($_SERVER);
    // echo '</pre>';
    $base_url = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on') ? 'https://' : 'http://';  //=> http://   
    // die;
    $base_url .= $_SERVER['HTTP_HOST'];
    return $base_url . '/colz_corephp';
}
