<?php
require_once __DIR__ . '/db/DB.php';
require_once __DIR__ . '/vaqua_utilities.php';

function make_conf_file($file_name, $attributes, $q_id)
{
    $base_path = getBasePath($q_id);

    $url = $base_path . $file_name;

    $encoArray = array();

    $i = 0;
    $fields = ["x", "y","color","size","text"];
    //assing x and y fields
    assignBasicAxis($attributes, $i, $encoArray, $fields);

    //assing text if there
    assignTextParam($attributes, $encoArray, $fields);

    //assign color
    assingColorParam($attributes, $encoArray, $fields);

    $url = explode("..",$url)[1];

    $jsonObj = array(
        "data" => array("url" => "../../$url"),
        "mark" => "bar",
        "encoding" => $encoArray,
        "attr" => $attributes
    );


    $name = explode(".", basename($file_name))[0] . '_conf.json';
    $fp = fopen($base_path . '/' . $name, 'w');
    fwrite($fp, json_encode($jsonObj));
    fclose($fp);
}

/**
 * @param $attributes
 * @param $encoArray
 * @param $fields
 */
function assingColorParam($attributes, &$encoArray, $fields)
{
    foreach ($attributes as $key => $type) {

        $val = array("field" => $key, "type" => $type);
        if ($type == 'nominal') {
            $encoArray[$fields[2]] = $val;
            break;
        }
    }
    if(!array_key_exists($fields[2],$encoArray))
        $encoArray[$fields[2]]=$encoArray[$fields[1]];
}

/**
 * @param $attributes
 * @param $i
 * @param $encoArray
 * @param $fields
 */
function assignBasicAxis($attributes, $i, &$encoArray, $fields)
{
    foreach ($attributes as $key => $type) {
        if ($i > 1) {
            break;
        }
        $val = array("field" => $key, "type" => $type);
        $encoArray[$fields[$i++]] = $val;
    }
}

/**
 * @param $attributes
 * @param $encoArray
 * @param $fields
 */
function assignTextParam($attributes, &$encoArray, $fields)
{
    foreach ($attributes as $key => $type) {
        $val = array("field" => $key, "type" => $type);
        if ($type == 'nominal') {
            $encoArray[$fields[4]] = $val;
            break;
        }
    }
    if(!array_key_exists($fields[4],$encoArray))
        $encoArray[$fields[4]]=$encoArray[$fields[0]];
}


function getBasePath($questionid)
{
    $post_id = $questionid; /// return last post id for posts

    $path = __DIR__ . '/../uploads/';
    $base_path = make_directory($path . $post_id . "/dataset/");
    return $base_path;
}

function uploadFile($filename, $questionid)
{
    $target_file = getBasePath($questionid) . basename($filename['name']);
    $uploadOk = 1;
// Check file size
    if ($filename["size"] > 8388608) {
        $uploadOk = 0;
    }
// Check if $uploadOk is set to 0 by an error
    if ($uploadOk == 0) {
        return false;
// if everything is ok, try to upload file
    } else {
        if (move_uploaded_file($filename["tmp_name"], $target_file)) {
            $attributes = get_json_Attributes($target_file);
            make_conf_file(basename($filename['name']), $attributes, $questionid);
//            echo basename($filename['name']);
        } else {
            return false;
        }
    }
    return $target_file;
}
function moveToQuestionData($questionid,$oldDir)
{
    $filename = explode('/',$oldDir);
    $filename = $filename[count($filename)-1];

//    echo  $filename;
    $target_file = getBasePath($questionid) . basename($filename);
    copy($oldDir,$target_file);
    $attributes = get_json_Attributes($target_file);
    make_conf_file($filename, $attributes, $questionid);
}

?>
