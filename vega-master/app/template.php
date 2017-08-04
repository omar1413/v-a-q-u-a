<link rel="stylesheet" type="text/css" href="./../vaqua/css/vega.css">

<img class="dragIcon" src="./app/pictures/drag.png"/>

<div class="vaqua-editor">
    <div class="mod_spec module">
        <div class="mod_header">
            <div class="mod_ctrls">
              <div style="height: 10px;"> </div>
                <select class="sel_vaqua_spec hide-vl"></select>
                <select id="bar_menus" class="sel_vaqua-lite_spec hide-vg"></select>
                <input type="button" class="btn_vg_parse hide-vl" value="Parse">

            </div>

              <img src="./../vaqua/logo3.png" width="150" height="60" style="margin-top:-6px">
            <div class="mod_title">
                <select class="sel_mode" style="display: none;">
                    <option value="vaqua-lite">Vaqua-lite</option>
                    <option value="vaqua">Vaqua</option>

                </select>
            </div>
        </div>
        <div class="gui_rep">
            <div style="height:12px;"></div>
            <div>
            <div id="attrtitle" class="titleattrb">Select attributes... </div>

          </div>
            <div class="padding"> X:
                <select id="attrselectorx" class="menustyle"></select>

            </div>

            <div class="padding"> Y:
                <select id="attrselectory" class="menustyle"></select>
            </div>


            <div class="padding"> Size:
                <select id="attrselectorsize" class="menustyle">
                </select>
            </div>

            <div class="padding"> Color:
                <select id="attrselectorcolor" class="menustyle">
                </select>
            </div>

            <div class="padding"> Shape:
                <select id="attrselectorshape" class="menustyle">
                </select>
            </div>

            <div class="padding"> Text:
                <select id="attrselectortext" class="menustyle">
                </select>
            </div>
            <div style="height:50px;"> </div>

        </div>

        <div class="vg_pane mod_subheader hide-vg" style="height: 60px;">
            <div class="mod_ctrls">
                <!--input type="button" class="btn_to_vaqua" value="Edit spec"-->
            </div>
            <?php
            session_start();
            if (isset($_SESSION['qid'])) {
                $q_id = $_SESSION['qid'];
                $_SESSION['lqid'] = $_SESSION['qid'];
            } else {
                $q_id = $_SESSION['lqid'];
            }

            if (isset($_SESSION['uid'])) {
                $user_id = $_SESSION['uid'];
                $_SESSION['luid'] = $_SESSION['uid'];
            } else {
                $user_id = $_SESSION['luid'];
            }


            require_once __DIR__ . '/../../vaqua/db/DbHelper.php';
            require_once __DIR__ . '/../../vaqua/db/DB.php';

            $vDB = new \VAQUA\DbHelper();
            $db = new \VAQUA\DB();


            echo '  <div style="height:15px;"></div> <form   name="data" method="post" action="./../vaqua/data/data.php" target="_blank" style="display:inline; margin-left: 15px;">
                  <input style="display:inline; " type = "hidden" name = "id"  value ="' . $q_id . '">
                  <input type="submit" id="other_btns" style=" width:180px; height:35px;" value="Show Data" style="display:inline; margin-left: 0px;" > </form>';
            ?>

            <form name="fileToUpload" id="fileToUpload" action="./app/vaqua/upload.php" method="post"
                  style="display:inline; margin-left: 20px;">
                <input type="file"  style=" color:#295376; font-weight:bold;" name="upload" id="upload" value="upload other file"
                       style="display:inline; margin-left: 50px;"></input>
            </form>

            <span class="click_toggle_vaqua" title="Expand/Collapse Vaqua editor"></span>
        </div>

        <div class="" style="max-width:400px" spellcheck="false"><?php

            ?></div>
    </div>
    <div class="mod_vis module">
        <div class="mod_header">
          <div style="height: 10px;"> </div>
            <div class="mod_ctrls" style="color: #295376 ">
                Renderer <select id="bar_menus" class="sel_render"></select>
                <!--        <input type="button" class="btn_export" value="Export">-->
            </div>

        </div>
        <div class="vis"></div>


        <?php
        //include $_SERVER['DOCUMENT_ROOT'].'/newGP/VaquaVega-master/VaquaVega-master/qa-include/pages/question-view.php';
        //    date_default_timezone_set('Africa/Cairo');
        //    $date = new DateTime();
        //    $result = $date->format('Y-m-d H:i:s');
        //    //$result = "'".$result."'";
        //      $acount = $vDB->getAnswerCount($q_id) + 1;
        //
        //      $content = array(
        //          'content' => 'mahmoud and tarek',
        //          'q_id'=> $q_id,
        //          'type' => 'A',
        //          'date' => $result,
        //          'user_id' => $user_id
        //      );
        //      $db->insertPost($content);
        //
        //      $db->updateAnswerCount($acount, $q_id);

        ?>

        <div class="mod_params"></div>
        <div class="spec_desc"></p>
        </div>

        <div class="textAnswer">
            <textarea id="comment" style="resize: none;"
                      placeholder="your comment here about your visualization"></textarea>
            <div style="height: 65px; background-color:#ffffff;">
            <input type="button" id="other_btns" class="btn_export" value="Add Answer">
          </div>
        </div>
    </div>
