<?php
/**
 * Created by PhpStorm.
 * User: elfeky
 * Date: 07/03/2017
 * Time: 05:56 م
 */

namespace VAQUA;


class DbHelper
{

    function __construct()
    {
        require_once __DIR__ . '/DB.php';
        $this->db = new DB();
    }

    function getPostPath($post_id){
        return $this->db->getPost($post_id)['test'];
    }

    function getAnswerCount($post_id){
        return $this->db->getPost($post_id)['acount'];

    }

    function getPostTitle($post_id){
        return $this->db->getPost($post_id)['title'];
    }

}