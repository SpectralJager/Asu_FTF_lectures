<?php
function openDB(){
    $host= "localhost";
    $user= "root";
    $pass= "";
    $db = "web_lab3";
    // Create connection
    $conn = new mysqli($host, $user, $pass,$db) or die("Connect failed: %s\n". $conn -> error);
    return $conn;
}

function scaleImg($upload_dir, $scale_dir, $image){
    # upload file into the server
    $uploadFilePath = $upload_dir.basename($image['tmp_name']).'.jpg';
    move_uploaded_file($image['tmp_name'],$uploadFilePath);
    #cacl new size image
    list($width, $height) = getimagesize($uploadFilePath);
    $new_width = 80;
    $new_height = 80;
    #transform image
    $new_img = imagecreatetruecolor($new_width, $new_height);
    $origin_img = imagecreatefromjpeg($uploadFilePath);
    imagecopyresampled($new_img, $origin_img, 0, 0, 0, 0, $new_width, $new_height, $width, $height);
    // save scaled img
    $new_img_path = $scale_dir.basename($image['tmp_name']).'.jpg';
    imagejpeg($new_img, $new_img_path, 100);
    return array($uploadFilePath, $new_img_path);
}
?>