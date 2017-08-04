<?php

class qa_retrieve_test_widget {

    function allow_template($template)
    {
        //return ($template=='tag');
        return true;
    }
    function allow_region($region)
{
    return true;
}

function output_widget($region, $place, $themeobject, $template, $request, $qa_content)
{
	echo'<form method = "post" action ="./vega-master/index.php?id='.$GLOBALS['qid'].'" 
        <input type = "hidden" name = "subject" value = "Feedback Form"> 
        <input type = "hidden" name = "redirect" value = "'. $GLOBALS['qid'].'">
        <input type = "submit" value = "Add Visualization">
    </form>';

}


}

?>