<?php
/**
 * Created by PhpStorm.
 * User: elfeky
 * Date: 07/03/2017
 * Time: 05:16 م
 */

namespace VAQUA;


class DB
{

    function __construct()
    {
        require_once __DIR__ . '/../../qa-config.php';
        $this->con = mysqli_connect(QA_MYSQL_HOSTNAME, QA_MYSQL_USERNAME, QA_MYSQL_PASSWORD, QA_MYSQL_DATABASE);
    }


    function getLastAnswerId()
    {
        $post_id = 0;
        $query = "SELECT postid FROM qa_posts ORDER BY postid DESC LIMIT 1";
        $res = mysqli_query($this->con, $query);

        if ($res) {
            while ($row = $res->fetch_assoc()) {
                $post_id = $row['postid'];
            }
        }
        else
        {
            die( mysqli_error($this->con));
        }

        return $post_id + 1;
    }

    function getPost($post_id){

        $query="SELECT * FROM qa_posts WHERE postid={$post_id}";
        $res=mysqli_query($this->con,$query);
        if($res){
            while ($row=mysqli_fetch_array($res)) {
                return $row;
            }
        }

       return -1;

    }

    function insertPost($content){
        $query = "INSERT INTO qa_posts(content,parentid,type,created,userid) VALUES ('{$content['content']}','{$content['q_id']}','{$content['type']}','{$content['date']}','{$content['user_id']}')";
        $res=mysqli_query($this->con,$query);
        if($res) {

            return 1;
        }
        else
        {
            echo mysqli_error();
        }
            return -1;
    }

    function updateAnswerCount($acount, $q_id){
        $query="UPDATE qa_posts SET acount = $acount WHERE postid= $q_id ";
        $res=mysqli_query($this->con,$query);
    }


    function __destruct()
    {
        mysqli_close($this->con);
    }

    //get  last inserted id in posts
    function v_get_last_inserted_id (){
        $query = "SELECT postid from qa_posts order by postid DESC limit 1";

        $result = mysqli_query($this->con,$query);
        if($result){
            while ($row=mysqli_fetch_array($result)) {
                return $row["postid"] + 1;
            }
        } else {
            return 1;
        }

        return 1;
    }

    function updateQuestionPath($id, $path){
        $query = "UPDATE qa_posts set test='$path' where postid='$id'";
        $result = mysqli_query($this->con,$query);
        if(mysqli_error($this->con)){
            die(mysqli_error($this->con));
        }
        if ($result){
            return true;
        }
        else{
            return false;
        }
    }
    function getUserTags($userId)
    {
        $cols = "health , health_eating , medicine , exercise , history , World_history , World_War , Philosophy , Technology , 
        Science , Physics , Computer_science , Design , Photography , Fine_art , Web_design";
        $query="SELECT ".$cols." FROM qa_interesting WHERE users_id={$userId} ";
        $res=mysqli_query($this->con,$query);
        if($res){
            while ($row=mysqli_fetch_array($res)) {
                return $row;
            }
        }

        return -1;
    }
}