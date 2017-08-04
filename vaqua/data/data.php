<?php
$id= $_POST["id"];
require_once __DIR__.'/../db/DbHelper.php';
$vDB = new \VAQUA\DbHelper($id);
$path= $vDB->getPostPath($id);
?>

<html>
<head>
  <!-- Latest compiled and minified CSS -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

  <!-- jQuery library -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

  <!-- Latest compiled JavaScript -->
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" type="text/css" href="style.css"/>
      <title>data</title>
  </head>

<!-- 
  <table class="table">
    <thead class="thead-default">
      <tr>
        <th>#</th>
        <th>First Name</th>
        <th>Last Name</th>
        <th>Username</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <th scope="row">1</th>
        <td>Mark</td>
        <td>Otto</td>
        <td>@mdo</td>
      </tr>
      <tr>
        <th scope="row">2</th>
        <td>Jacob</td>
        <td>Thornton</td>
        <td>@fat</td>
      </tr>
      <tr>
        <th scope="row">3</th>
        <td>Larry</td>
        <td>the Bird</td>
        <td>@twitter</td>
      </tr>
    </tbody>
  </table> -->
<body>
<div id = "qa-header" class="data"  style="background: white" > <a href="./../../index.php"><img src="../logo3.png" width="150" height="50"> </a></div>
<div id= "data" ></div>
<script src="/../vaqua/vega-master/lib/jquery-3.1.1.min.js"></script>
<script >
    // notice the quotes around the ?php tag
    var htmlString="<?php echo $path; ?>";
    window.id = htmlString;
</script>
<script src="data.js"></script>
<script src="parse/data_parser.js"></script>
</body>
</html>
