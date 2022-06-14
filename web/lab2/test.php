<?php
ini_set('display_errors', '1');
ini_set('display_startup_errors', '1');
error_reporting(E_ALL);

include 'imageController.php';

$controller = new ImageController('./uploads/', './scaled/');
$controller->transformImage($_FILES['image'], $_POST);

$_POST = array();
$_FILES = array();

// $controller->printScaledImage();
header('Location: ./list.php');
?>

