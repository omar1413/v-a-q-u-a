<?php
// requires php5

require_once __DIR__ . '/../vaqua/vaqua_utilities.php';
require_once __DIR__ . '/../vaqua/db/DB.php';
require_once __DIR__ . '/../vaqua/db/DbHelper.php';

if (isset($_POST['img']) && isset($_POST['q_id'])&& isset($_POST['comment'])) {

    session_start();

    $db = new \VAQUA\DB();
    $vDb = new \VAQUA\DbHelper();
    $q_id = $_POST['q_id'];
    $user_id = $_SESSION['uid'];
    $comment = $_POST['comment'];
    $title = $vDb->getPostTitle($q_id);
    $ans_id = $db->getLastAnswerId();

    if(uploadImage($q_id, $ans_id)){
        $start = updateAnswer($db, $vDb, $q_id, $user_id, $comment);

        $res = array("title" => $title,
            "start" => $start);

        echo json_encode($res);
    }

}




function updateAnswer($db, $vDB, $q_id, $user_id, $comment){

    date_default_timezone_set('Africa/Cairo');
    $date = new DateTime();
    $result = $date->format('Y-m-d H:i:s');

    $acount = $vDB->getAnswerCount($q_id) + 1;

    $content = array(
        'content' => $comment,
        'q_id'=> $q_id,
        'type' => 'A',
        'date' => $result,
        'user_id' => $user_id
    );
    if($db->insertPost($content))
    $db->updateAnswerCount($acount, $q_id);

    $start = $acount - ($acount % 10);
    if($acount % 10 == 0){
        $start = $acount - 10;
    }

    return $start;
}

function uploadImage($q_id, $ans_id)
{
    $dir = __DIR__ . '/../uploads/' . $q_id . '/';

    $dir = make_directory($dir . 'ans/');

    define('UPLOAD_DIR', $dir);
    $img = $_POST['img'];
    //print($img);
    $img = str_replace('data:image/png;base64,', '', $img);
    $img = str_replace(' ', '+', $img);
    $data = base64_decode($img);
    $file = UPLOAD_DIR . $ans_id . '.png';
    $success = file_put_contents($file, $data);
    return $success;
}


?>