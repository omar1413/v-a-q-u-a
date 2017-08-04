<?php
// if(isset($_POST['health'])){
// 	echo $_POST['health'];
// $user_name = $_POST['health'];
//
// // $user_address = $_POST['healthy'];
// // $price = $_POST['medicine'];
// echo $user_name.'<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<';
// $query = "INSERT INTO  `q2a`.`qa_interesting` (
// `history`,
// `health`
// )
// VALUES (
// 			0,0
// 		)";
// 	$con = mysqli_connect("localhost", "root", "", "q2a");
//   $result = mysqli_query($con, $query);
// }
/*
	Question2Answer by Gideon Greenspan and contributors
	http://www.question2answer.org/

	File: qa-include/qa-page-register.php
	Description: Controller for register page


	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	More about this license: http://www.question2answer.org/license.php
*/

	if (!defined('QA_VERSION')) { // don't allow this page to be requested directly from browser
		header('Location: ../');
		exit;
	}

	require_once QA_INCLUDE_DIR.'app/captcha.php';
	require_once QA_INCLUDE_DIR.'db/users.php';


//	Check we're not using single-sign on integration, that we're not logged in, and we're not blocked

	if (QA_FINAL_EXTERNAL_USERS)
		qa_fatal_error('User registration is handled by external code');

	if (qa_is_logged_in())
		qa_redirect('');


//	Get information about possible additional fields

	$show_terms = qa_opt('show_register_terms');

	$userfields = qa_db_select_with_pending(
		qa_db_userfields_selectspec()
	);

	foreach ($userfields as $index => $userfield) {
		if (!($userfield['flags'] & QA_FIELD_FLAGS_ON_REGISTER))
			unset($userfields[$index]);
	}


//	Check we haven't suspended registration, and this IP isn't blocked

	if (qa_opt('suspend_register_users')) {
		$qa_content = qa_content_prepare();
		$qa_content['error'] = qa_lang_html('users/register_suspended');
		return $qa_content;
	}

	if (qa_user_permit_error()) {
		$qa_content = qa_content_prepare();
		$qa_content['error'] = qa_lang_html('users/no_permission');
		return $qa_content;
	}


//	Process submitted form

	if (qa_clicked('doregister')) {
		require_once QA_INCLUDE_DIR.'app/limits.php';

		if (qa_user_limits_remaining(QA_LIMIT_REGISTRATIONS)) {
			require_once QA_INCLUDE_DIR.'app/users-edit.php';

			$inemail = qa_post_text('email');
			$inpassword = qa_post_text('password');
			$inhandle = qa_post_text('handle');
			$interms = (int) qa_post_text('terms');

			$inprofile = array();
			foreach ($userfields as $userfield)
				$inprofile[$userfield['fieldid']] = qa_post_text('field_'.$userfield['fieldid']);

			if (!qa_check_form_security_code('register', qa_post_text('code'))) {
				$pageerror = qa_lang_html('misc/form_security_again');
			}
			else {
				// core validation
				$errors = array_merge(
					qa_handle_email_filter($inhandle, $inemail),
					qa_password_validate($inpassword)
				);

				// T&Cs validation
				if ($show_terms && !$interms)
					$errors['terms'] = qa_lang_html('users/terms_not_accepted');

				// filter module validation
				if (count($inprofile)) {
					$filtermodules = qa_load_modules_with('filter', 'filter_profile');
					foreach ($filtermodules as $filtermodule)
						$filtermodule->filter_profile($inprofile, $errors, null, null);
				}

				if (qa_opt('captcha_on_register'))
					qa_captcha_validate_post($errors);

				if (empty($errors)) {
					// register and redirect
					qa_limits_increment(null, QA_LIMIT_REGISTRATIONS);

					$userid = qa_create_new_user($inemail, $inpassword, $inhandle);

					foreach ($userfields as $userfield)
						qa_db_user_profile_set($userid, $userfield['title'], $inprofile[$userfield['fieldid']]);

					qa_set_logged_in_user($userid, $inhandle);

					$topath = qa_get('to');

					if (isset($topath))
						qa_redirect_raw(qa_path_to_root().$topath); // path already provided as URL fragment
					else
						qa_redirect('');
				}
			}

		}
		else
			$pageerror = qa_lang('users/register_limit');
	}


//	Prepare content for theme

	$qa_content = qa_content_prepare();

	$qa_content['title'] = qa_lang_html('users/register_title');

	$qa_content['error'] = @$pageerror;
// echo "<input type='button'  />";
	$qa_content['form'] = array(
		'tags' => 'method="post" id="mmd" action="'.qa_self_html().'"',

		'style' => 'tall',

		'fields' => array(
			'handle' => array(
				'label' => qa_lang_html('users/handle_label'),
				'tags' => 'name="handle" id="handle" dir="auto"',
				'value' => qa_html(@$inhandle),
				'error' => qa_html(@$errors['handle']),
			),

			'password' => array(
				'type' => 'password',
				'label' => qa_lang_html('users/password_label'),
				'tags' => 'name="password" id="password" dir="auto"',
				'value' => qa_html(@$inpassword),
				'error' => qa_html(@$errors['password']),
			),

			'email' => array(
				'label' => qa_lang_html('users/email_label'),
				'tags' => 'name="email" id="email" dir="auto"',
				'value' => qa_html(@$inemail),
				'note' => qa_opt('email_privacy'),
				'error' => qa_html(@$errors['email']),
			),
			// 'a' => array(
				// 'label' => qa_lang_html('users/hoppy'),
				// 'tags' => 'name="email" id="ch" dir="auto" type="checkbox" style="float:left;width:10px" name="1"',
				// 'value' => qa_html(@$inemail),
				// 'note' => qa_opt('email_privacy'),
				// 'error' => qa_html(@$errors['email']),
			// ),
			// 'b' => array(

				// 'tags' => 'name="email"  dir="auto" type="checkbox" style="float:left;width:10px" name="1"',
				// 'label' => qa_lang_html('users/hoppy'),
				// 'value' => qa_html(@$inemail),
				// 'note' => qa_opt('email_privacy'),
				// 'error' => qa_html(@$errors['email']),
			// ),
			// 'c' => array(
				// 'label' => qa_lang_html('users/hoppy'),
				// 'tags' => 'name="email" dir="auto" type="checkbox" style="float:left;width:10px" name="2"',
				// 'value' => qa_html(@$inemail),
				// 'note' => qa_opt('email_privacy'),
				// 'error' => qa_html(@$errors['email']),
			// ),
			// 'd' => array(
				// 'label' => qa_lang_html('users/hoppy'),
				// 'tags' => 'name="email" dir="auto" type="checkbox" style="float:left;width:10px" name="2"',
				// 'value' => qa_html(@$inemail),
				// 'note' => qa_opt('email_privacy'),
				// 'error' => qa_html(@$errors['email']),
			// ),

		),

		'buttons' => array(
			'register' => array(
				'tags' => 'onclick="qa_show_waiting_after(this, false);" id="regbtn" style="display:none"',
				'label' => qa_lang_html('users/register_button'),
			),
		),

		'hidden' => array(
			'doregister' => '1',
			'code' => qa_get_form_security_code('register'),
		),
	);
	// $con = mysqli_connect("localhost", "root", "", "q2a");
	//
	// $user_query="SELECT `userid` FROM `qa_users` order by `userid` DESC limit 1";
	// 	// echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";
	// $res = mysqli_query($con, $user_query);
	// $num_rows=$res->num_rows;
	// 	if( $num_rows == 0)
	// {
	// 	echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";
	// }
	// else {
	// 	echo ">>>>>>>>>>>>>>";
	// }
	// while($row = $res -> fetch_assoc())
	// {
	// 	$user_id=$row['users_id'];
	// 	echo $user_id;
	// 	if($user_id==null){
	// 		$user_id=1;
	// 	}
	// 	else {
	// 			$user_id=$user_id+1;
	// 	}
	// }
	echo "<!-- Trigger/Open The Modal -->


<!-- The Modal -->
<div id='myModal' class='modal'>

  <!-- Modal content -->
  <div class='modal-content' style='margin: auto;margin-top:-50px;height: 460px;width: 525px' id='sModel'>
    <span class='close'>&times;</span>
    <p style='font-size:14px'>CHOOSE YOUR INTERESTS</p>

		<a href='#'onclick='showReg()' class='button' id='okbtn' style='transform: translateY(490px);
    display: block;
    font-size: 14px;
    width: 130px;
    height: 10px;
     color: #fff;
    '><span style='transform: translateY(-2px);'>submit</span></a>
  </div>

</div>";
// <a href="#" class="button">
//   <span>Hover Me</span>
// </a>
	// <legend style='po.sition: absolute;left: 120px;top: -15px;'>health and medicine</legend>
	// echo "<form action='#' method='post'>
	//
	// <fieldset id='group1' class='form_infoRadio' style='position:absolute; bottom:-40px;border:none' >
	//
	// <input type='checkbox' value='' id='1' name='health' style='margin-left:140px;vertical-align:sub'/>health
	// <input type='checkbox' value='' id='2' name='healthy' style='vertical-align:sub'/>healthy eating
	// <input type='checkbox' value='' id='3' name='medicine' style='vertical-align:sub'/>medicine and healthcare
	// <input type='checkbox' value='' id='4' name='exercise' style='vertical-align:sub'/>exercise
	// </fieldset>";
	// echo "<fieldset id='group2' class='form_infoRadio' style='position:absolute; bottom:17px;border:none' >
	// <input type='checkbox' value='' id='5' name='group2' style='margin-left:140px;vertical-align:sub' />History
	// <input type='checkbox' value='' id='6' name='group2' style='vertical-align:sub'/>World History
	// <input type='checkbox' value='' id='7' name='group2' style='vertical-align:sub'/>World War ||
	// <input type='checkbox' value='' id='8' name='group2' style='vertical-align:sub'/>Philosophy
	// </fieldset>";
	// echo "<fieldset id='group3' class='form_infoRadio' style='position:absolute; bottom:-95px;border:none' >
	// <input type='checkbox' value='' id='9' name='group3' style='margin-left:140px;vertical-align:sub'/>Technology
	// <input type='checkbox' value='' id='10' name='group3' style='vertical-align:sub'/>Science
	// <input type='checkbox' value='' id='11' name='group3' style='vertical-align:sub'/>Physics
	// <input type='checkbox' value='' id='12' name='group3' style='vertical-align:sub'/>Computer science
	// </fieldset>";
	// echo "<fieldset id='group4' class='form_infoRadio' style='position:absolute; bottom:-150px;border:none' >
	// <input type='checkbox' value='' id='13' name='group4' style='margin-left:140px;vertical-align:sub'/>Design
	// <input type='checkbox' value='' id='14' name='group4' style='vertical-align:sub'/>Photography
	// <input type='checkbox' value='' id='15' name='group4' style='vertical-align:sub'/>Fine Art
	// <input type='checkbox' value='' id='16' name='group4' style='vertical-align:sub'/>Wb Design
	// </fieldset>
	// </form>";

	// prepend custom message
	$custom = qa_opt('show_custom_register') ? trim(qa_opt('custom_register')) : '';
	if (strlen($custom)) {
		array_unshift($qa_content['form']['fields'], array(
			'type' => 'custom',
			'note' => $custom,
		));
	}

	foreach ($userfields as $userfield) {
		$value = @$inprofile[$userfield['fieldid']];

		$label = trim(qa_user_userfield_label($userfield), ':');
		if (strlen($label))
			$label .= ':';

		$qa_content['form']['fields'][$userfield['title']] = array(
			'label' => qa_html($label),
			'tags' => 'name="field_'.$userfield['fieldid'].'"',
			'value' => qa_html($value),
			'error' => qa_html(@$errors[$userfield['fieldid']]),
			'rows' => ($userfield['flags'] & QA_FIELD_FLAGS_MULTI_LINE) ? 8 : null,
		);
	}


	if (qa_opt('captcha_on_register'))
		qa_set_up_captcha_field($qa_content, $qa_content['form']['fields'], @$errors);

	// show T&Cs checkbox
	if ($show_terms) {
		$qa_content['form']['fields']['terms'] = array(
			'type' => 'checkbox',
			'label' => trim(qa_opt('register_terms')),
			'tags' => 'name="terms" id="terms"',
			'value' => qa_html(@$interms),
			'error' => qa_html(@$errors['terms']),
		);
	}

	$loginmodules = qa_load_modules_with('login', 'login_html');

	foreach ($loginmodules as $module) {
		ob_start();
		$module->login_html(qa_opt('site_url').qa_get('to'), 'register');
		$html = ob_get_clean();

		if (strlen($html))
			@$qa_content['custom'] .= '<br>'.$html.'<br>';
	}

	// prioritize 'handle' for keyboard focus
	$qa_content['focusid'] = isset($errors['handle']) ? 'handle'
		: (isset($errors['password']) ? 'password'
			: (isset($errors['email']) ? 'email' : 'handle'));


	return $qa_content;



/*
	Omit PHP closing tag to help avoid accidental output
*/
