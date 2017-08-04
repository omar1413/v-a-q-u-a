<?php

class qa_tag_descriptions_edit_page {

    function match_request($request)
    {
        $parts=explode('/', $request);

        return $parts[0]=='tag-edit';
    }

    function process_request($request)
{
    $parts=explode('/', $request);
    $tag=$parts[0];
    $qa_content=qa_content_prepare();
    $qa_content['title']='upload file '.qa_html($tag);
      
       
        require_once QA_INCLUDE_DIR.'qa-db-metas.php';

        if (qa_clicked('dosave')) {
    require_once QA_INCLUDE_DIR.'qa-util-string.php';

    $taglc=qa_strtolower($tag);
    qa_db_tagmeta_set($taglc, 'description', qa_post_text('tagdesc'));
    qa_redirect('tag/'.$tag);
}


$qa_content['form']= array(
    'style' => 'tall', // or 'wide'
    'title' => 'My File Form', // <h2>My File Form</h2>
    'tags' => 'NAME="myform" METHOD=POST ENCTYPE="multipart/form-data" ACTION = "upload.php"',
	/*   <input type="file" name="fileToUpload">
    <input type="submit" value="Upload Image" name="submit" >*/
    'fields' => array(
        array(
            'type' => 'static',
            'value' => '<INPUT TYPE="FILE" NAME="fileToUpload"  ID="fileToUpload">',
        ),
         array(
            'type' => 'static',
            'value' => '<INPUT TYPE="submit" NAME="submit" value = "Upload">',
        ),
		
    )
);
    /*array(
    'tags' => 'METHOD="POST" ACTION="'.qa_self_html().'"',

    'style' => 'tall', // could be 'wide'

    /*'fields' => array(
        array(
            'type' => 'text',
            'rows' => 4,
            'tags' => 'NAME="tagdesc" ID="tagdesc"',
            'value' => qa_html(qa_db_tagmeta_get($tag, 'description')),
        ),
    ),

    'buttons' => array(
        array(
            
            'tags' => 'NAME="save" type = "file"',
            'label' => 'Save Description',
        ),
    ),
);*/
//  echo $qa_content['form'];
$qa_content['focusid']='tagdesc';
    return $qa_content;
}
    
}