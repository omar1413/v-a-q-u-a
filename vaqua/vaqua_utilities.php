<?php
/**
 * Created by PhpStorm.
 * User: elfeky
 * Date: 07/03/2017
 * Time: 04:46 م
 */


function make_directory($path_to_directory)
{
    if (!file_exists($path_to_directory)) {
        mkdir($path_to_directory, 0777, true);

        return $path_to_directory;
    }

    return $path_to_directory;
}


function get_json_Attributes($file)
{
    $str = file_get_contents($file);
    return json_parse($str);
}

function json_parse($json)
{
    $jsonIterator = new RecursiveIteratorIterator(
        new RecursiveArrayIterator(json_decode($json, TRUE)),
        RecursiveIteratorIterator::SELF_FIRST);

    $attributes = array();
    $flag = false;
    foreach ($jsonIterator as $key => $val) {


        if (!is_array($val)) {
            if (!array_key_exists($key, $attributes))
                $attributes[$key] = '';
            $attributes[$key] = mapToRightType($attributes[$key], getAvailabletype(gettype($val), $val));
        }
    }
    return $attributes;
}

function isDate($value)
{
    if (!$value) {
        return false;
    }

    try {
        new \DateTime($value);
        return true;
    } catch (\Exception $e) {
        return false;
    }
}

function preprocssing($key, $val)
{
    $key = strtolower($key);
    if ($key == 'integer') {
        return isQauntitative($key);
    } else if ($key == 'string') {
        return (isDate($val)) ? 'date' : 'string';
    } else
        return $key;
}

function isQauntitative($val)
{
    $counter = 0;
    while ($val > 0) {
        $val = $val / 10;
        $counter++;
    }
    return ($counter > 6) ? 'double' : 'integer';
}

function getAvailabletype($key, $val)
{

    $res = preprocssing($key, $val);
    $type = array
    (
        'string' => "nominal",
        'integer' => "ordinal",
        'double' => "quantitative",
        'date' => "temporal",
        'null' => 'null',
    );

    return $type[$res];
}

function mapToRightType($oldVal, $newVal)//
{

    $map = array(
        "nominal" => 1,
        "ordinal" => 3,
        "quantitative" => 2,
        "temporal" => 4,
        'null' => 5,
        '' => 10
    );
    if ($map[$oldVal] > $map[$newVal])
        return $newVal;
    else
        return $oldVal;
}

function getTagsAsString($id)
{
    require_once __DIR__ . '/../vaqua/db/DB.php';
    $vDb = new \VAQUA\DB();
    $tags = $vDb->getUserTags($id);
    $cols = array(
        0 => 'health', 1 => 'health_eating', 2 => 'medicine', 3 => 'exercise', 4 => 'history',
        5 => 'World_history', 6 => 'World_War', 7 => 'Philosophy', 8 => 'Technology',
        9 => 'Science', 10 => 'Physics', 11 => 'Computer_science', 12 => 'Design', 13 => 'Photography',
        14 => 'Fine_art', 15 => 'Web_design'
    );

    $regTags = '';
    for ($i = 0; $i < 16; $i++) {
        if ($tags[$i] == 1) {
            $regTags .= $cols[$i].',';
        }
    }
    $regTags = substr($regTags,0,-1);
    return $regTags;
}
function getTagsAsArray($id)
{
    $tags = explode(',',getTagsAsString($id));
    return $tags;
}