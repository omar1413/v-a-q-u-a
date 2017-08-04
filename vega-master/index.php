<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="content-type" content="text/html;charset=utf-8">
    <title>Vega Editor</title>
    <link rel="stylesheet" type="text/css" href="./../vaqua/css/vega.css">
    <link rel="stylesheet" type="text/css" href="app/editor.css"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="lib/jquery-3.1.1.min.js"></script>
    <script src="vendor/topojson.js" charset="utf-8"></script>
    <script src="vendor/d3.min.js" charset="utf-8"></script>
    <script src="vendor/d3.geo.projection.min.js" charset="utf-8"></script>
    <script src="vendor/d3.layout.cloud.js" charset="utf-8"></script>
    <script src="vendor/underscore.js"></script>
    <script src="vendor/ace/ace.js" charset="utf-8"></script>
    <script src="vendor/vega.js" charset="utf-8"></script>
    <script src="vendor/vega-embed.js" charset="utf-8"></script>
    <script src="vendor/vega-lite.js" charset="utf-8"></script>
    <script src="vendor/json3-compactstringify.js" charset="utf-8"></script>
    <script>
        JSON3 = JSON3.noConflict();
    </script>
    <script src="app/vega-specs.js" charset="utf-8"></script>
    <script src="app/vl-specs.js" charset="utf-8"></script>
    <script src="app/editor.js" charset="utf-8"></script>
    <style> body {
            margin: 0px;
            overflow: hidden;
        } </style>
</head>
<body><?php
session_start();
if (isset($_POST["redirect"]) && isset($_POST["userid"])) {
    $_SESSION['qid'] = $_POST["redirect"];
    $_SESSION['uid'] = $_POST["userid"];
}
/*  session_start();
$_SESSION['qid'] = $_POST["redirect"];
 echo $_SESSION['qid'];*/
/*$first_name = 'David';
setcookie('qid',$_POST["redirect"],time() + (86400 * 7)); // 86400 sec = 1 day*/

?>
<script> ved.init('body', 'app/');
    console.log($("#comment")[0]);
    $("#comment").css("width", "320px");
</script>


<script src="./app/vaqua/initVaquaJs.js"></script>

</body>
</html>
