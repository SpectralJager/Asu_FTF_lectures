<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <form action="./add_student.php" method="post" enctype="multipart/form-data">
        First name: <input type="text" name="fname"> <br>
        Second name: <input type="text" name="sname"> <br>
        Birth day: <input type="date" name="birthday" id="birthday"> <br>
        Group: <select name="group" id="group">
            <?php
                try{
                    ini_set('display_errors', '1');
                    ini_set('display_startup_errors', '1');
                    error_reporting(E_ALL);

                    include 'utils.php';
                    $conn = openDB();
                    // echo "Connected Successfully";
                    $sql = "SELECT * FROM `group`";
                    $result = $conn->query($sql);
                    if ($result->num_rows > 0) {
                        while($row = $result->fetch_assoc()) {
                            echo '<option value="'.$row['id'].'">'.$row['id'].'</option>';
                        }
                    }  
                } catch (mysqli_sql_exception $e) { 
                    // var_dump($e);
                    echo $e;
                    exit; 
                }
            ?>
        </select> <br>
        Select profile img ('.jpg'): <input type="file" name="img" id="img" accept=".jpg"><br>
        <button type="submit">Submit</button>
    </form>
</body>
</html>