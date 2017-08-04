<?php
/*
  Plugin Name: Tag Descriptions Tutorial
  Plugin URI:
  Plugin Description: Allows tag descriptions to be displayed as tooltips
  Plugin Version: 1.0
  Plugin Date: 2016-01-02
  Plugin Author:
  Plugin Author URI:
  Plugin License: GPLv2
  Plugin Minimum Question2Answer Version: 1.5
  Plugin Update Check URI:
*/

if (!defined('QA_VERSION')) { // don't allow this page to be requested directly from browser
  header('Location: ../../');
  exit;
}
qa_register_plugin_module(
  'widget', // type of module
  'qa-upload-test-widget.php', // PHP file containing module class
  'qa_upload_test_widget', // module class name in that PHP file
  'upload' // human-readable name of module
);



