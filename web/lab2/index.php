<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h3>Upload image</h3>
    <form enctype="multipart/form-data" action="./test.php" method="POST">
        Enter subname: <input type="text" name="subname"> <br>
        Select Image extension: input: <select name="extension" id="select_extension">
            <option value=".jpg">JPG</option>
            <option value=".png">PNG</option>
            <option value=".gif">GIF</option>
        </select> <br>
        <!-- New width: <input type="text" name="new_width" value="100">, new height: <input type="text" name="new_height" value="100"> <br> -->
        Percent: <input type="number" name="percent" id="percent"> <br>
        Select Image: <input type="file" name="image" id="input_image" accept=".jpg, .png, .gif"> <br>
        <button type="submit">Submit</button>
    </form>
</body>
</html>