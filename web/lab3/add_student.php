<?php
    ini_set('display_errors', '1');
    ini_set('display_startup_errors', '1');
    error_reporting(E_ALL);
    include 'utils.php';
    $conn = openDB();
    list($orig_img, $scaled_img) = scaleImg('./uploads/','./scaled/', $_FILES['img']);
    $sql = "INSERT INTO `students`(`fname`, `sname`, `birthday`, `group_id`, `orig_img`, `scaled_img`) VALUES ('".$_POST['fname']."','".$_POST['sname']."','".$_POST['birthday']."','".$_POST['group']."','".$orig_img."','".$scaled_img."')";
    $conn->query($sql);

    header("Location: ./index.php");
?>