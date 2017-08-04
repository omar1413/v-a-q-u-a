<?php
/**
 * Created by PhpStorm.
 * User: Mahmoud
 * Date: 4/22/2017
 * Time: 6:27 PM
 */
$json = file_get_contents($_POST['dataPath']);
$json_output = json_decode($json);


function createSelected($obj)
{
    $flag = true;
    for ($i = 0 ; $i<count($_POST['titles']); $i++) {
        if (!($obj->$_POST['titles'][$i]>= $_POST['sdata'][$_POST['titles'][$i]][0] && $obj->$_POST['titles'][$i]
            <= $_POST['sdata'][$_POST['titles'][$i]][1])) {
            $flag = false;
            break;
        }
    }

    if($flag)
        return $obj;
}
$sdata = array_filter($json_output, 'createSelected');

//function createSelected()
//{
//
//}
//$sdata = array();
//
//$titles = $_POST['titles'];
//
//foreach ($_POST['rdata'] as $key=>$val)
//{
//    $flag = true;
//    for ($i = 0 ; $i<count($titles); $i++) {
//        if (!($val[$titles[$i]] >= $_POST['sdata'][$titles[$i]][0] && $val[$titles[$i]] <= $_POST['sdata'][$titles[$i]][1])) {
//            $flag = false;
//            break;
//        }
//    }
//    if ($flag)
//        array_push($sdata, $val);
//}
////if (count($sdata)<=0){
////    echo 'null';
////return;
////}
//print_r($sdata);
$path = '../uploads/temp.json';
$fp = fopen($path, 'w');
fwrite($fp, json_encode( array_values($sdata)));
fclose($fp);


require_once __DIR__ . '/upload.php';
session_start();
moveToQuestionData($_SESSION['qid'],$path);
echo 'temp';