<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <?php
        echo $data_list;
    ?>
    <table border="1">
        <caption>Images table</caption>
        <tr>
            <th>Name</th>
            <th>Scaled Image</th>
            <th>Upload time</th>
        </tr>
        <?php
            $data_list = json_decode(file_get_contents("/opt/lampp/htdocs/web/lab2/files/imagedatalist.json"),true);
            sort($data_list);
            $names = [];
            foreach ($data_list as $value) {
                $temp = basename($value["scaled_img_path"]);
                if(!in_array($temp,$names)){
                    echo "<tr><td>".basename($value["scaled_img_path"])."</td><td><a href='".$value["upload_file_path"]."'><img src='".$value["scaled_img_path"]."' alt='' /></a></td><td>".$value["created_at"]."</td></tr>";
                    array_push($names,$temp);
                }
            }
        ?>
    </table>
</body>
</html>