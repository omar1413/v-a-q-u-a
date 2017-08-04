<?php
/**
 * Created by PhpStorm.
 * User: Omar
 * Date: 3/29/2017
 * Time: 2:09 PM
 */


if (isset($_FILES["file"])) {
    require_once __DIR__ . '/../../../vaqua/upload.php';
    session_start();

    //die($_SESSION['qid']);
   uploadFile($_FILES["file"],$_SESSION['qid']);
    require_once __DIR__.'/../../../vaqua/db/DbHelper.php';
    $vDb = new \VAQUA\DB();
    $vDb->updateQuestionPath($_SESSION['qid'],'uploads/'.$_SESSION['qid'].'/dataset/'.explode(".",$_FILES['file']['name'])[0].'.json');
    echo explode(".",$_FILES['file']['name'])[0];


}