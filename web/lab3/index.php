<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h3><a href="./form.php">Add student</a></h3>
    <?php
        ini_set('display_errors', '1');
        ini_set('display_startup_errors', '1');
        error_reporting(E_ALL);
        date_default_timezone_set('UTC');

        include 'utils.php';

        $conn = openDB();
        $sort_params = '';
        $options = array(
            'expires' => time() + 60 * 60 * 24 * 1,
            'path' => ini_get('session.cookie_path'),
            'domain' => $_SERVER['HTTP_HOST'],
            'secure' => 0,
            'httponly' => 0,
            'SameSite' => 'None'
        );
        if($_COOKIE['sort'] == null){
            setcookie('sort','',$options);
        } else {
            $sort_params = $_COOKIE['sort'];
        }
        echo $_COOKIE['sort'];

        $sql = "SELECT * FROM `students`".$sort_params;
        $result = $conn->query($sql);
    ?>
    <table border="1">
        <caption>Students table</caption>
        <tr>
            <th onclick="stsort(1)" id='group'>Group</th>
            <th>FirtsName</th>
            <th onclick="stsort(2)" id='sname'>SecondName</th>
            <th onclick="stsort(3)" id='birth'>Birthday</th>
            <th>Profile img</th>
        </tr>
        <?php
            if ($result->num_rows > 0) {
                while($row = $result->fetch_assoc()) {
                    echo "<tr><td>".$row['group_id']."</td><td>".$row['fname']."</td><td>".$row['sname']."</td><td>".$row['birthday']."</td><td><a href='".$row['orig_img']."'><img src='".$row['scaled_img']."' alt='' /></a></td></tr>";
                }
            }  
        ?>
    </table>
    <script>
        function stsort(num){
            var group = document.getElementById('group');
            var sname = document.getElementById('sname');
            var btd = document.getElementById('birth');
            var query = document.cookie.split(';').find(function(str,i,arr){
                if(str.search('sort') != -1){
                    return true;
                }
                return false;
            });
            // alert(query);
            if(num == 1){
                sname.style.color = 'black';
                sname.innerHTML = sname.textContent.split(' ')[0]; 
                btd.style.color = 'black';
                btd.innerHTML = btd.textContent.split(' ')[0]; 
                group.style.color = 'red';
                if(group.textContent.search('\u2193') != -1){
                    group.innerHTML = group.textContent.split(' ')[0] + ' \u2191'; 
                    document.cookie = 'sort=ORDER BY `group_id` DESC'
                } else {
                    group.innerHTML = group.textContent.split(' ')[0] + ' \u2193'; 
                    document.cookie = 'sort=ORDER BY `group_id` ASC'
                }
            } else if (num == 2){
                btd.style.color = 'black';
                btd.innerHTML = btd.textContent.split(' ')[0]; 
                group.style.color = 'black';
                group.innerHTML = group.textContent.split(' ')[0]; 
                sname.style.color = 'red';
                if(sname.textContent.search('\u2193') != -1){
                    sname.innerHTML = sname.textContent.split(' ')[0] + ' \u2191'; 
                    document.cookie = 'sort=ORDER BY `sname` DESC'
                } else {
                    sname.innerHTML = sname.textContent.split(' ')[0] + ' \u2193'; 
                    document.cookie = 'sort=ORDER BY `sname` ASC'
                }
            } else if (num == 3){
                sname.style.color = 'black';
                sname.innerHTML = sname.textContent.split(' ')[0]; 
                group.style.color = 'black';
                group.innerHTML = group.textContent.split(' ')[0]; 
                btd.style.color = 'red';
                if(btd.textContent.search('\u2193') != -1){
                    btd.innerHTML = btd.textContent.split(' ')[0] + ' \u2191'; 
                    document.cookie = 'sort=ORDER BY `birthday` DESC'
                } else {
                    btd.innerHTML = btd.textContent.split(' ')[0] + ' \u2193'; 
                    document.cookie = 'sort=ORDER BY `birthday` ASC'
                }
            }
            location.reload();
        }
        var group = document.getElementById('group');
        var sname = document.getElementById('sname');
        var btd = document.getElementById('birth');
        var query = document.cookie.split(';').find(function(str,i,arr){
            if(str.search('sort') != -1){
                return true;
            }
            return false;
        });
        // alert(query);
        if(query.search('group_id') != -1){
            group.style.color = 'red';
            if(query.search('DESC') != -1){
                group.innerHTML = group.textContent.split(' ')[0] + ' \u2191'; 
            } else {
                group.innerHTML = group.textContent.split(' ')[0] + ' \u2193'; 
            }
        } else if (query.search('sname') != -1){
            sname.style.color = 'red';
            if(query.search('DESC') != -1){
                sname.innerHTML = sname.textContent.split(' ')[0] + ' \u2191'; 
            } else {
                sname.innerHTML = sname.textContent.split(' ')[0] + ' \u2193'; 
            }
        } else if (query.search('birthday') != -1){
            btd.style.color = 'red';
            if(query.search('DESC') != -1){
                btd.innerHTML = btd.textContent.split(' ')[0] + ' \u2191'; 
            } else {
                btd.innerHTML = btd.textContent.split(' ')[0] + ' \u2193'; 
            }
        }
    </script>
</body>
</html>