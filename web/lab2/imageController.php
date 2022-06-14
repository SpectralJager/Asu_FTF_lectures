<?php
class ImageController {
    private $upload_dir;
    private $scale_dir;
    private $current_img;
    private $stat_file_path = "/opt/lampp/htdocs/web/lab2/files/imagedatalist.json";

    public function __construct($upload_dir, $scale_dir){
        $this->upload_dir = $upload_dir; 
        $this->scale_dir = $scale_dir; 
    }

    public function transformImage($image, $post){
        $this->current_img = array();

        # upload file into the server
        $uploadFilePath = $this->upload_dir.$image['name'];
        move_uploaded_file($image['tmp_name'],$uploadFilePath);
        $this->current_img['image_name'] = $image['name'];
        $this->current_img['upload_file_path'] = $uploadFilePath;

        #cacl new size image
        list($width, $height) = getimagesize($uploadFilePath);
        $new_width = $width * (intval($post['percent']) / 100);
        $new_height = $height * (intval($post['percent']) / 100);

        #transform image
        $new_img = imagecreatetruecolor($new_width, $new_height);
        switch ($post['extension']) {
            case '.jpg':
                $origin_img = imagecreatefromjpeg($uploadFilePath);
                break;
            case '.png':
                $origin_img = imagecreatefrompng($uploadFilePath);
                break;
            case '.gif':
                $origin_img = imagecreatefromgif($uploadFilePath);
                break;
            
        }
        imagecopyresampled($new_img, $origin_img, 0, 0, 0, 0, $new_width, $new_height, $width, $height);

        // save scaled img
        $new_img_path = $this->scale_dir.$post['subname'].$post['extension'];
        imagejpeg($new_img, $new_img_path, 100);
        switch ($post['extension']) {
            case '.jpg':
                imagejpeg($new_img, $new_img_path, 100);
                break;
            case '.png':
                imagepng($new_img, $new_img_path, 0);
                break;
            case '.gif':
                imagegif($new_img, $new_img_path);
                break;
        }
        $this->current_img['scaled_img_path'] = $new_img_path;
        date_default_timezone_set('Asia/Krasnoyarsk');
        $this->current_img['created_at'] = date('m/d/Y h:i:s a', time());
       
        # save record
        $data_list = json_decode(file_get_contents($this->stat_file_path));
        if($data_list == null){
            $data_list = [];
        }
        array_push($data_list, $this->current_img);
        file_put_contents($this->stat_file_path, json_encode($data_list));
    }

    function printScaledImage(){
        header('Location: '.$this->current_img['scaled_img_path']);
    }
    function getImagesList(){
        return json_decode(file_get_contents($this->stat_file_path),true);
    }
}
?>