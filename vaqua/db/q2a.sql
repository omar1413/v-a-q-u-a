-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: May 14, 2017 at 05:17 PM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `q2a`
--

-- --------------------------------------------------------

--
-- Table structure for table `qa_blobs`
--

CREATE TABLE IF NOT EXISTS `qa_blobs` (
  `blobid` bigint(20) unsigned NOT NULL,
  `format` varchar(20) CHARACTER SET ascii NOT NULL,
  `content` mediumblob,
  `filename` varchar(255) DEFAULT NULL,
  `userid` int(10) unsigned DEFAULT NULL,
  `cookieid` bigint(20) unsigned DEFAULT NULL,
  `createip` int(10) unsigned DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`blobid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `qa_cache`
--

CREATE TABLE IF NOT EXISTS `qa_cache` (
  `type` char(8) CHARACTER SET ascii NOT NULL,
  `cacheid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `content` mediumblob NOT NULL,
  `created` datetime NOT NULL,
  `lastread` datetime NOT NULL,
  PRIMARY KEY (`type`,`cacheid`),
  KEY `lastread` (`lastread`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `qa_categories`
--

CREATE TABLE IF NOT EXISTS `qa_categories` (
  `categoryid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parentid` int(10) unsigned DEFAULT NULL,
  `title` varchar(80) NOT NULL,
  `tags` varchar(200) NOT NULL,
  `content` varchar(800) NOT NULL DEFAULT '',
  `qcount` int(10) unsigned NOT NULL DEFAULT '0',
  `position` smallint(5) unsigned NOT NULL,
  `backpath` varchar(804) NOT NULL DEFAULT '',
  PRIMARY KEY (`categoryid`),
  UNIQUE KEY `parentid` (`parentid`,`tags`),
  UNIQUE KEY `parentid_2` (`parentid`,`position`),
  KEY `backpath` (`backpath`(200))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `qa_categorymetas`
--

CREATE TABLE IF NOT EXISTS `qa_categorymetas` (
  `categoryid` int(10) unsigned NOT NULL,
  `title` varchar(40) NOT NULL,
  `content` varchar(8000) NOT NULL,
  PRIMARY KEY (`categoryid`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `qa_contentwords`
--

CREATE TABLE IF NOT EXISTS `qa_contentwords` (
  `postid` int(10) unsigned NOT NULL,
  `wordid` int(10) unsigned NOT NULL,
  `count` tinyint(3) unsigned NOT NULL,
  `type` enum('Q','A','C','NOTE') NOT NULL,
  `questionid` int(10) unsigned NOT NULL,
  KEY `postid` (`postid`),
  KEY `wordid` (`wordid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `qa_cookies`
--

CREATE TABLE IF NOT EXISTS `qa_cookies` (
  `cookieid` bigint(20) unsigned NOT NULL,
  `created` datetime NOT NULL,
  `createip` int(10) unsigned NOT NULL,
  `written` datetime DEFAULT NULL,
  `writeip` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`cookieid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `qa_cookies`
--

INSERT INTO `qa_cookies` (`cookieid`, `created`, `createip`, `written`, `writeip`) VALUES
(9922462393222334368, '2017-01-06 17:35:41', 0, '2017-03-29 11:31:07', 0);

-- --------------------------------------------------------

--
-- Table structure for table `qa_interesting`
--

CREATE TABLE IF NOT EXISTS `qa_interesting` (
  `users_id` int(11) NOT NULL,
  `health` tinyint(1) NOT NULL,
  `health_eating` tinyint(1) NOT NULL,
  `medicine` tinyint(1) NOT NULL,
  `exercise` tinyint(1) NOT NULL,
  `history` tinyint(1) NOT NULL,
  `World_history` tinyint(1) NOT NULL,
  `World_War` tinyint(1) NOT NULL,
  `Philosophy` tinyint(1) NOT NULL,
  `Technology` tinyint(1) NOT NULL,
  `Science` tinyint(1) NOT NULL,
  `Physics` tinyint(1) NOT NULL,
  `Computer_science` tinyint(1) NOT NULL,
  `Design` tinyint(1) NOT NULL,
  `Photography` tinyint(1) NOT NULL,
  `Fine_art` tinyint(1) NOT NULL,
  `Web_design` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `qa_interesting`
--

INSERT INTO `qa_interesting` (`users_id`, `health`, `health_eating`, `medicine`, `exercise`, `history`, `World_history`, `World_War`, `Philosophy`, `Technology`, `Science`, `Physics`, `Computer_science`, `Design`, `Photography`, `Fine_art`, `Web_design`) VALUES
(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `qa_iplimits`
--

CREATE TABLE IF NOT EXISTS `qa_iplimits` (
  `ip` int(10) unsigned NOT NULL,
  `action` char(1) CHARACTER SET ascii NOT NULL,
  `period` int(10) unsigned NOT NULL,
  `count` smallint(5) unsigned NOT NULL,
  UNIQUE KEY `ip` (`ip`,`action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `qa_iplimits`
--

INSERT INTO `qa_iplimits` (`ip`, `action`, `period`, `count`) VALUES
(0, 'L', 414541, 1),
(0, 'Q', 414403, 1),
(0, 'R', 414105, 1);

-- --------------------------------------------------------

--
-- Table structure for table `qa_messages`
--

CREATE TABLE IF NOT EXISTS `qa_messages` (
  `messageid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('PUBLIC','PRIVATE') NOT NULL DEFAULT 'PRIVATE',
  `fromuserid` int(10) unsigned NOT NULL,
  `touserid` int(10) unsigned NOT NULL,
  `fromhidden` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `tohidden` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `content` varchar(8000) NOT NULL,
  `format` varchar(20) CHARACTER SET ascii NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`messageid`),
  KEY `type` (`type`,`fromuserid`,`touserid`,`created`),
  KEY `touserid` (`touserid`,`type`,`created`),
  KEY `fromhidden` (`fromhidden`),
  KEY `tohidden` (`tohidden`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `qa_options`
--

CREATE TABLE IF NOT EXISTS `qa_options` (
  `title` varchar(40) NOT NULL,
  `content` varchar(8000) NOT NULL,
  PRIMARY KEY (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `qa_options`
--

INSERT INTO `qa_options` (`title`, `content`) VALUES
('allow_close_questions', '1'),
('allow_login_email_only', ''),
('allow_self_answer', '1'),
('avatar_allow_gravatar', '1'),
('avatar_allow_upload', '1'),
('avatar_default_show', ''),
('avatar_q_list_size', '0'),
('avatar_q_page_q_size', '50'),
('avatar_users_size', '30'),
('block_bad_words', ''),
('block_ips_write', ''),
('cache_flaggedcount', ''),
('cache_qcount', '51'),
('cache_queuedcount', ''),
('cache_tagcount', '0'),
('cache_uapprovecount', '2'),
('cache_unaqcount', '51'),
('cache_unselqcount', '51'),
('cache_unupaqcount', '51'),
('cache_userpointscount', '3'),
('captcha_module', 'reCAPTCHA'),
('captcha_on_anon_post', '1'),
('captcha_on_register', '1'),
('captcha_on_reset_password', '1'),
('captcha_on_unconfirmed', '0'),
('columns_tags', '3'),
('columns_users', '2'),
('comment_on_as', '1'),
('comment_on_qs', '0'),
('confirm_user_emails', '1'),
('confirm_user_required', ''),
('custom_footer', ''),
('custom_header', ''),
('custom_home_content', ''),
('custom_home_heading', ''),
('custom_in_head', ''),
('custom_sidebar', 'Welcome to Localhost Q&amp;A, where you can ask questions and receive answers from other members of the community.'),
('custom_sidepanel', ''),
('db_version', '59'),
('do_ask_check_qs', '0'),
('do_complete_tags', '1'),
('do_count_q_views', '1'),
('do_example_tags', '1'),
('editor_for_as', 'WYSIWYG Editor'),
('editor_for_qs', 'WYSIWYG Editor'),
('event_logger_to_database', ''),
('event_logger_to_files', ''),
('extra_field_active', ''),
('extra_field_el', ''),
('facebook_app_id', ''),
('feedback_email', 'osamaharby95@gmail.com'),
('feedback_enabled', '1'),
('feed_for_hot', ''),
('feed_for_qa', '1'),
('feed_for_questions', '1'),
('feed_for_unanswered', '1'),
('feed_per_category', '1'),
('flagging_hide_after', '5'),
('flagging_of_posts', '1'),
('form_security_salt', 's2a6y9qzmizes13jq9unykbitnx4sd6g'),
('from_email', 'no-reply@example.com'),
('home_description', ''),
('hot_weight_answers', '100'),
('hot_weight_a_age', '100'),
('hot_weight_q_age', '100'),
('hot_weight_views', '100'),
('hot_weight_votes', '100'),
('links_in_new_window', ''),
('logo_height', ''),
('logo_show', '0'),
('logo_url', ''),
('logo_width', ''),
('match_example_tags', '3'),
('max_len_q_title', '120'),
('max_num_q_tags', '5'),
('max_rate_ip_as', '50'),
('max_rate_ip_logins', '20'),
('max_rate_ip_qs', '20'),
('max_rate_ip_registers', '5'),
('max_rate_user_as', '25'),
('max_rate_user_qs', '10'),
('max_store_user_updates', '50'),
('min_len_q_content', '0'),
('min_len_q_title', '12'),
('min_num_q_tags', '0'),
('moderate_anon_post', ''),
('moderate_by_points', ''),
('moderate_unconfirmed', ''),
('moderate_users', ''),
('mouseover_content_on', ''),
('nav_activity', ''),
('nav_ask', '1'),
('nav_categories', ''),
('nav_home', ''),
('nav_hot', ''),
('nav_qa_is_home', ''),
('nav_questions', '1'),
('nav_tags', '1'),
('nav_unanswered', '1'),
('nav_users', '1'),
('neat_urls', '5'),
('notify_admin_q_post', ''),
('notify_users_default', '1'),
('pages_prev_next', '3'),
('page_size_ask_tags', '5'),
('page_size_home', '20'),
('page_size_qs', '20'),
('page_size_q_as', '10'),
('page_size_tags', '30'),
('page_size_una_qs', '20'),
('page_size_users', '30'),
('permit_anon_view_ips', '70'),
('permit_close_q', '70'),
('permit_delete_hidden', '40'),
('permit_edit_q', '70'),
('permit_flag', '110'),
('permit_hide_show', '70'),
('permit_moderate', '100'),
('permit_post_a', '150'),
('permit_post_c', '150'),
('permit_post_q', '150'),
('permit_retag_cat', '70'),
('permit_select_a', '100'),
('permit_view_q_page', '150'),
('permit_view_voters_flaggers', '20'),
('permit_vote_down', '120'),
('permit_vote_q', '120'),
('points_a_selected', '30'),
('points_a_voted_max_gain', '20'),
('points_a_voted_max_loss', '5'),
('points_base', '100'),
('points_multiple', '10'),
('points_per_a_voted', ''),
('points_per_a_voted_down', '2'),
('points_per_a_voted_up', '2'),
('points_per_q_voted', ''),
('points_per_q_voted_down', '1'),
('points_per_q_voted_up', '1'),
('points_post_a', '4'),
('points_post_q', '2'),
('points_q_voted_max_gain', '10'),
('points_q_voted_max_loss', '3'),
('points_select_a', '3'),
('points_to_titles', ''),
('points_vote_down_a', '1'),
('points_vote_down_q', '1'),
('points_vote_on_a', ''),
('points_vote_on_q', ''),
('points_vote_up_a', '1'),
('points_vote_up_q', '1'),
('q_urls_remove_accents', ''),
('q_urls_title_length', '50'),
('recaptcha_private_key', ''),
('recaptcha_public_key', ''),
('register_notify_admin', ''),
('show_a_c_links', '1'),
('show_a_form_immediate', 'if_no_as'),
('show_custom_answer', ''),
('show_custom_ask', ''),
('show_custom_footer', '0'),
('show_custom_header', '0'),
('show_custom_home', '0'),
('show_custom_in_head', '0'),
('show_custom_register', ''),
('show_custom_sidebar', '1'),
('show_custom_sidepanel', '0'),
('show_custom_welcome', '0'),
('show_fewer_cs_from', '10'),
('show_full_date_days', '7'),
('show_home_description', '0'),
('show_notice_visitor', ''),
('show_notice_welcome', ''),
('show_post_update_meta', '1'),
('show_register_terms', '0'),
('show_url_links', '1'),
('show_user_points', '1'),
('show_user_titles', '1'),
('show_view_counts', ''),
('show_view_count_q_page', ''),
('show_when_created', '1'),
('site_language', ''),
('site_maintenance', '0'),
('site_text_direction', 'ltr'),
('site_theme', 'Vaqua'),
('site_theme_mobile', 'Snow'),
('site_title', 'Localhost Q&A'),
('site_url', 'http://localhost/q2a/'),
('smtp_active', ''),
('sort_answers_by', 'created'),
('suspend_register_users', ''),
('tags_or_categories', 'tc'),
('tag_separator_comma', ''),
('votes_separated', ''),
('voting_on_as', '1'),
('voting_on_qs', '1'),
('voting_on_q_page_only', ''),
('wysiwyg_editor_upload_images', '');

-- --------------------------------------------------------

--
-- Table structure for table `qa_pages`
--

CREATE TABLE IF NOT EXISTS `qa_pages` (
  `pageid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(80) NOT NULL,
  `nav` char(1) CHARACTER SET ascii NOT NULL,
  `position` smallint(5) unsigned NOT NULL,
  `flags` tinyint(3) unsigned NOT NULL,
  `permit` tinyint(3) unsigned DEFAULT NULL,
  `tags` varchar(200) NOT NULL,
  `heading` varchar(800) DEFAULT NULL,
  `content` mediumtext,
  PRIMARY KEY (`pageid`),
  UNIQUE KEY `position` (`position`),
  KEY `tags` (`tags`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `qa_postmetas`
--

CREATE TABLE IF NOT EXISTS `qa_postmetas` (
  `postid` int(10) unsigned NOT NULL,
  `title` varchar(40) NOT NULL,
  `content` varchar(8000) NOT NULL,
  PRIMARY KEY (`postid`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `qa_posts`
--

CREATE TABLE IF NOT EXISTS `qa_posts` (
  `postid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('Q','A','C','Q_HIDDEN','A_HIDDEN','C_HIDDEN','Q_QUEUED','A_QUEUED','C_QUEUED','NOTE') NOT NULL,
  `parentid` int(10) unsigned DEFAULT NULL,
  `categoryid` int(10) unsigned DEFAULT NULL,
  `catidpath1` int(10) unsigned DEFAULT NULL,
  `catidpath2` int(10) unsigned DEFAULT NULL,
  `catidpath3` int(10) unsigned DEFAULT NULL,
  `acount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `amaxvote` smallint(5) unsigned NOT NULL DEFAULT '0',
  `selchildid` int(10) unsigned DEFAULT NULL,
  `closedbyid` int(10) unsigned DEFAULT NULL,
  `userid` int(10) unsigned DEFAULT NULL,
  `cookieid` bigint(20) unsigned DEFAULT NULL,
  `createip` int(10) unsigned DEFAULT NULL,
  `lastuserid` int(10) unsigned DEFAULT NULL,
  `lastip` int(10) unsigned DEFAULT NULL,
  `upvotes` smallint(5) unsigned NOT NULL DEFAULT '0',
  `downvotes` smallint(5) unsigned NOT NULL DEFAULT '0',
  `netvotes` smallint(6) NOT NULL DEFAULT '0',
  `lastviewip` int(10) unsigned DEFAULT NULL,
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `hotness` float DEFAULT NULL,
  `flagcount` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `format` varchar(20) CHARACTER SET ascii NOT NULL DEFAULT '',
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  `updatetype` char(1) CHARACTER SET ascii DEFAULT NULL,
  `title` varchar(800) DEFAULT NULL,
  `content` varchar(8000) DEFAULT NULL,
  `tags` varchar(800) DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `notify` varchar(80) DEFAULT NULL,
  `test` text NOT NULL,
  PRIMARY KEY (`postid`),
  KEY `type` (`type`,`created`),
  KEY `type_2` (`type`,`acount`,`created`),
  KEY `type_4` (`type`,`netvotes`,`created`),
  KEY `type_5` (`type`,`views`,`created`),
  KEY `type_6` (`type`,`hotness`),
  KEY `type_7` (`type`,`amaxvote`,`created`),
  KEY `parentid` (`parentid`,`type`),
  KEY `userid` (`userid`,`type`,`created`),
  KEY `selchildid` (`selchildid`,`type`,`created`),
  KEY `closedbyid` (`closedbyid`),
  KEY `catidpath1` (`catidpath1`,`type`,`created`),
  KEY `catidpath2` (`catidpath2`,`type`,`created`),
  KEY `catidpath3` (`catidpath3`,`type`,`created`),
  KEY `categoryid` (`categoryid`,`type`,`created`),
  KEY `createip` (`createip`,`created`),
  KEY `updated` (`updated`,`type`),
  KEY `flagcount` (`flagcount`,`created`,`type`),
  KEY `catidpath1_2` (`catidpath1`,`updated`,`type`),
  KEY `catidpath2_2` (`catidpath2`,`updated`,`type`),
  KEY `catidpath3_2` (`catidpath3`,`updated`,`type`),
  KEY `categoryid_2` (`categoryid`,`updated`,`type`),
  KEY `lastuserid` (`lastuserid`,`updated`,`type`),
  KEY `lastip` (`lastip`,`updated`,`type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=66 ;

--
-- Dumping data for table `qa_posts`
--

INSERT INTO `qa_posts` (`postid`, `type`, `parentid`, `categoryid`, `catidpath1`, `catidpath2`, `catidpath3`, `acount`, `amaxvote`, `selchildid`, `closedbyid`, `userid`, `cookieid`, `createip`, `lastuserid`, `lastip`, `upvotes`, `downvotes`, `netvotes`, `lastviewip`, `views`, `hotness`, `flagcount`, `format`, `created`, `updated`, `updatetype`, `title`, `content`, `tags`, `name`, `notify`, `test`) VALUES
(15, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, 1, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 2, 43756700000, 0, '', '2016-12-07 04:01:10', NULL, NULL, 'how are u kimo?', '', '', NULL, '@', ''),
(16, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, 1, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 2, 43756700000, 0, '', '2016-12-07 04:04:46', NULL, NULL, 'how are u kimo?', '', '', NULL, '@', ''),
(17, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, 1, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 43756300000, 0, '', '2016-12-07 04:06:37', NULL, NULL, 'ahsdbasjkdksjd', '', '', NULL, '@', ''),
(18, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, 1, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 43756300000, 0, '', '2016-12-07 04:07:04', NULL, NULL, 'karam feky osama?', '', '', NULL, '@', ''),
(19, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, 1, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 2, 43764100000, 0, '', '2016-12-07 14:21:36', NULL, NULL, 'how are u shimaaa?', '', '', NULL, '@', ''),
(20, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, 1, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 3, 43764600000, 0, '', '2016-12-07 14:25:53', NULL, NULL, 'ana 3bt y doc ?', '', '', NULL, '@', ''),
(21, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, 1, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 2, 43840300000, 0, '', '2016-12-12 00:15:45', NULL, NULL, 'are you hereeeeeeeeeeeee?', '', '', NULL, '@', 'uploads/for tesr.txt'),
(22, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, 1, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 23, 43849700000, 0, '', '2016-12-12 01:38:32', NULL, NULL, 'iujhxgjdjjdjdkghdyhgddddd???????', '', '', NULL, '@', 'uploads/graph-links.txt'),
(23, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, 1, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 3, 44218100000, 0, '', '2017-01-02 20:24:50', NULL, NULL, 'osamaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa newwwwwwwwwww?', '', '', NULL, '@', 'uploads/OS.txt'),
(24, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, 2, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 3, 44218700000, 0, '', '2017-01-02 21:12:01', NULL, NULL, 'karamaaaaaaaaaaaaaa?', '', '', NULL, '@', 'uploads/mahmoud elfeky.docx'),
(25, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, 2, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 12, 44223700000, 0, '', '2017-01-02 23:08:15', NULL, NULL, 'hello from the other side?', '', '', NULL, '@', 'uploads/Karam Mahmoud(CV).docx'),
(26, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 0, NULL, 0, '', '0000-00-00 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, ''),
(27, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44284400000, 0, '', '2017-01-06 17:35:41', NULL, NULL, 'new question???', '', '', '', NULL, 'uploads/New Text Document.json'),
(28, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44285400000, 0, '', '2017-01-06 18:56:38', NULL, NULL, 'helooooooooooooooooooooaaa??', '', '', '', NULL, 'uploads/New Text Document.txt'),
(29, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44287000000, 0, '', '2017-01-06 21:10:42', NULL, NULL, 'asdasdasdawdqwdedfwd', '', '', '', NULL, 'uploads/New Text Document.txt'),
(30, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44747200000, 0, '', '2017-02-02 12:20:31', NULL, NULL, 'how are you?', '', '', '', NULL, 'uploads/New Text Document.txt'),
(31, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44768200000, 0, '', '2017-02-03 17:31:11', NULL, NULL, 'are uuuuuuuuuuuu here', '', '', '', NULL, 'uploads/New Text Document.txt'),
(32, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44768300000, 0, '', '2017-02-03 17:42:18', NULL, NULL, 'kuyfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff', '', '', '', NULL, 'uploads/coursenotes.pdf'),
(33, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44768400000, 0, '', '2017-02-03 17:46:42', NULL, NULL, 'hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh', '', '', '', NULL, 'uploads/coursenotes.pdf'),
(34, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44768400000, 0, '', '2017-02-03 17:47:38', NULL, NULL, 'wwwwwwwwwwwwwwwwwwwwww', '', '', '', NULL, 'uploads/coursenotes.pdf'),
(35, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44768400000, 0, '', '2017-02-03 17:48:10', NULL, NULL, 'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk', '', '', '', NULL, 'uploads/coursenotes.pdf'),
(36, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44768400000, 0, '', '2017-02-03 17:49:15', NULL, NULL, 'hhhhhhhhhhhhhhhjfstrwtjjjjjjjjjjjjjjjjjjjjjjvgfd', '', '', '', NULL, 'uploads/coursenotes.pdf'),
(37, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44768500000, 0, '', '2017-02-03 17:51:20', NULL, NULL, 'jjjjjjjjjjjjjjjjjjjjjjjjerssssssssssssssssssssssssssssdtrf', '', '', '', NULL, 'uploads/coursenotes.pdf'),
(38, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44768500000, 0, '', '2017-02-03 17:54:28', NULL, NULL, 'jjjjjjjjjjjjjjjjjjjjjaaaaafhcccccccccccccccc', '', '', '', NULL, 'uploads/coursenotes.pdf'),
(39, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44768600000, 0, '', '2017-02-03 18:01:05', NULL, NULL, 'jjjjjjjjjjjjjjjkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk', '', '', '', NULL, 'uploads/hhhcoursenotes.pdf'),
(40, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44768700000, 0, '', '2017-02-03 18:08:02', NULL, NULL, 'sakldllllllllllllllllllllllllllllllllllllllllaaaaaaaaaaaaaaa', '', '', '', NULL, 'uploads/Untitled1.cpp'),
(41, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44768700000, 0, '', '2017-02-03 18:11:07', NULL, NULL, 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', '', '', '', NULL, 'uploads/face.png'),
(42, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44768700000, 0, '', '2017-02-03 18:13:15', NULL, NULL, 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaalllllllllll', '', '', '', NULL, 'uploads/sss/c20091129469.jpg'),
(43, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44768700000, 0, '', '2017-02-03 18:13:35', NULL, NULL, 'hhhhhhhaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', '', '', '', NULL, 'uploads/sss/coursenotes.pdf'),
(44, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44768800000, 0, '', '2017-02-03 18:15:54', NULL, NULL, 'laaaaaaaaassssssssssssssssssssssssssssssssssssssssssssssssssss', '', '', '', NULL, 'uploads/sss/Karam Mahmoud(CV).docx'),
(45, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44768900000, 0, '', '2017-02-03 18:31:30', NULL, NULL, 'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk', '', '', '', NULL, 'uploads/sss/c20091129469.jpg'),
(46, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44769100000, 0, '', '2017-02-03 18:41:05', NULL, NULL, 'jjjjjjjjjjjjjjjjjjjjjjjjhhhhhhhhhhhhhhhhh', '', '', '', NULL, 'uploads/sss/Karam Mahmoud(CV).pdf'),
(47, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44769100000, 0, '', '2017-02-03 18:41:53', NULL, NULL, 'kkkkkkkkkaaaaaaaaaaaaaaaaaaaaaaaaaaaa', '', '', '', NULL, 'uploads/sss/c20091129469.jpg'),
(48, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44769100000, 0, '', '2017-02-03 18:43:02', NULL, NULL, 'kkkkkkkkkkkkkkkkkkkkkkkkk', '', '', '', NULL, 'uploads/sss/c20091129469.jpg'),
(49, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44769100000, 0, '', '2017-02-03 18:43:34', NULL, NULL, 'lllllllllllaaaaaaaaaaaaaaaaajjjjjjjjjjjjjjjjjjjjjjjjjjjj', '', '', '', NULL, 'uploads/sss/face.png'),
(50, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44769100000, 0, '', '2017-02-03 18:44:54', NULL, NULL, 'asaaaaaaaaaaaaaaaaaaaaaaaaaaaa', '', '', '', NULL, 'uploads/sss/coursenotes.pdf'),
(51, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44769100000, 0, '', '2017-02-03 18:46:29', NULL, NULL, 'jjjjjjjjjjjjjjjjjjjjjjjjjjjjjj', '', '', '', NULL, 'uploads/sss/web.BAK'),
(52, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44769100000, 0, '', '2017-02-03 18:47:40', NULL, NULL, 'kkkkkkkkkkkkkkkkkkkkkkkkkkkk', '', '', '', NULL, 'uploads/sss/Karam Mahmoud(CV).docx'),
(53, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44769200000, 0, '', '2017-02-03 18:50:45', NULL, NULL, 'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk', '', '', '', NULL, 'uploads/sss/web.BAK'),
(54, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44769200000, 0, '', '2017-02-03 18:53:06', NULL, NULL, 'jjjjjjjjjjjjjjjhhhhhhhhhhhhhhhhhhhhhhhhhhhhh', '', '', '', NULL, 'uploads/53/web.BAK'),
(55, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 44769200000, 0, '', '2017-02-03 18:53:31', NULL, NULL, 'hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhdcde', '', '', '', NULL, 'uploads/54/Karam Mahmoud(CV).pdf'),
(56, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 45057100000, 0, '', '2017-02-20 10:48:28', NULL, NULL, 'how are yyyyyyyyyyyyyyyyy?', '', '', '', NULL, 'uploads/55/web.BAK'),
(57, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 45580700000, 0, '', '2017-03-22 18:00:02', NULL, NULL, 'thi sis my teeeeeeeeeest', '', '', '', NULL, 'uploads/56/eula.3082.txt'),
(58, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 45581000000, 0, '', '2017-03-22 18:20:36', NULL, NULL, 'it is karam teest', '', '', '', NULL, ''),
(59, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 45581100000, 0, '', '2017-03-22 18:30:59', NULL, NULL, 'this is karam test 2', '', '', '', NULL, 'uploads/59/eula.1036.txt'),
(60, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 45581100000, 0, '', '2017-03-22 18:31:27', NULL, NULL, 'the test from karam 3', '', '', '', NULL, 'uploads/60/eula.1031.txt'),
(61, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 45581100000, 0, '', '2017-03-22 18:32:17', NULL, NULL, 'test karam 4', '', '', '', NULL, 'uploads/61/mine.json'),
(62, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 45633600000, 0, '', '2017-03-25 19:24:19', NULL, NULL, 'karam is make a question', '', '', '', NULL, 'uploads/62/budget.json'),
(63, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 45634100000, 0, '', '2017-03-25 20:11:10', NULL, NULL, 'this is my second trying to up load file', '', '', '', NULL, 'uploads/63/cars.json'),
(64, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, 9922462393222334368, NULL, NULL, NULL, 0, 0, 0, NULL, 1, 45697000000, 0, '', '2017-03-29 11:31:06', NULL, NULL, 'karam asking a new question', '', '', '', NULL, 'uploads/64/barley.json'),
(65, 'Q', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, 2, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, 3, 45912100000, 0, '', '2017-04-10 21:05:46', NULL, NULL, 'how is the task plZZZ?', '', '', NULL, '@', 'uploads/65/barley.json');

-- --------------------------------------------------------

--
-- Table structure for table `qa_posttags`
--

CREATE TABLE IF NOT EXISTS `qa_posttags` (
  `postid` int(10) unsigned NOT NULL,
  `wordid` int(10) unsigned NOT NULL,
  `postcreated` datetime NOT NULL,
  KEY `postid` (`postid`),
  KEY `wordid` (`wordid`,`postcreated`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `qa_sharedevents`
--

CREATE TABLE IF NOT EXISTS `qa_sharedevents` (
  `entitytype` char(1) CHARACTER SET ascii NOT NULL,
  `entityid` int(10) unsigned NOT NULL,
  `questionid` int(10) unsigned NOT NULL,
  `lastpostid` int(10) unsigned NOT NULL,
  `updatetype` char(1) CHARACTER SET ascii DEFAULT NULL,
  `lastuserid` int(10) unsigned DEFAULT NULL,
  `updated` datetime NOT NULL,
  KEY `entitytype` (`entitytype`,`entityid`,`updated`),
  KEY `questionid` (`questionid`,`entitytype`,`entityid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `qa_sharedevents`
--

INSERT INTO `qa_sharedevents` (`entitytype`, `entityid`, `questionid`, `lastpostid`, `updatetype`, `lastuserid`, `updated`) VALUES
('Q', 1, 1, 1, NULL, 1, '2016-12-04 01:03:01'),
('U', 1, 1, 1, NULL, 1, '2016-12-04 01:03:01'),
('Q', 2, 2, 2, NULL, 1, '2016-12-04 01:03:28'),
('U', 1, 2, 2, NULL, 1, '2016-12-04 01:03:28'),
('Q', 3, 3, 3, NULL, 1, '2016-12-04 01:03:46'),
('U', 1, 3, 3, NULL, 1, '2016-12-04 01:03:46'),
('Q', 4, 4, 4, NULL, 1, '2016-12-07 02:03:21'),
('U', 1, 4, 4, NULL, 1, '2016-12-07 02:03:22'),
('Q', 5, 5, 5, NULL, 1, '2016-12-07 02:09:05'),
('U', 1, 5, 5, NULL, 1, '2016-12-07 02:09:05'),
('Q', 6, 6, 6, NULL, 1, '2016-12-07 02:10:53'),
('U', 1, 6, 6, NULL, 1, '2016-12-07 02:10:54'),
('Q', 7, 7, 7, NULL, 1, '2016-12-07 02:21:56'),
('U', 1, 7, 7, NULL, 1, '2016-12-07 02:21:56'),
('Q', 8, 8, 8, NULL, 1, '2016-12-07 02:29:51'),
('U', 1, 8, 8, NULL, 1, '2016-12-07 02:29:51'),
('Q', 9, 9, 9, NULL, 1, '2016-12-07 02:57:48'),
('U', 1, 9, 9, NULL, 1, '2016-12-07 02:57:48'),
('Q', 10, 10, 10, NULL, 1, '2016-12-07 03:44:48'),
('U', 1, 10, 10, NULL, 1, '2016-12-07 03:44:48'),
('Q', 11, 11, 11, NULL, 1, '2016-12-07 03:45:07'),
('U', 1, 11, 11, NULL, 1, '2016-12-07 03:45:07'),
('Q', 12, 12, 12, NULL, 1, '2016-12-07 03:51:27'),
('U', 1, 12, 12, NULL, 1, '2016-12-07 03:51:27'),
('Q', 13, 13, 13, NULL, 1, '2016-12-07 03:53:23'),
('U', 1, 13, 13, NULL, 1, '2016-12-07 03:53:23'),
('Q', 14, 14, 14, NULL, 1, '2016-12-07 03:56:20'),
('U', 1, 14, 14, NULL, 1, '2016-12-07 03:56:20'),
('Q', 15, 15, 15, NULL, 1, '2016-12-07 04:01:10'),
('U', 1, 15, 15, NULL, 1, '2016-12-07 04:01:11'),
('Q', 16, 16, 16, NULL, 1, '2016-12-07 04:04:46'),
('U', 1, 16, 16, NULL, 1, '2016-12-07 04:04:46'),
('Q', 17, 17, 17, NULL, 1, '2016-12-07 04:06:38'),
('U', 1, 17, 17, NULL, 1, '2016-12-07 04:06:38'),
('Q', 18, 18, 18, NULL, 1, '2016-12-07 04:07:05'),
('U', 1, 18, 18, NULL, 1, '2016-12-07 04:07:05'),
('Q', 19, 19, 19, NULL, 1, '2016-12-07 14:21:37'),
('U', 1, 19, 19, NULL, 1, '2016-12-07 14:21:37'),
('Q', 20, 20, 20, NULL, 1, '2016-12-07 14:25:54'),
('U', 1, 20, 20, NULL, 1, '2016-12-07 14:25:54'),
('Q', 21, 21, 21, NULL, 1, '2016-12-12 00:15:45'),
('U', 1, 21, 21, NULL, 1, '2016-12-12 00:15:45'),
('Q', 22, 22, 22, NULL, 1, '2016-12-12 01:38:33'),
('U', 1, 22, 22, NULL, 1, '2016-12-12 01:38:33'),
('Q', 23, 23, 23, NULL, 1, '2017-01-02 20:24:50'),
('U', 1, 23, 23, NULL, 1, '2017-01-02 20:24:50'),
('Q', 24, 24, 24, NULL, 2, '2017-01-02 21:12:02'),
('U', 2, 24, 24, NULL, 2, '2017-01-02 21:12:02'),
('Q', 25, 25, 25, NULL, 2, '2017-01-02 23:08:16'),
('U', 2, 25, 25, NULL, 2, '2017-01-02 23:08:16'),
('Q', 27, 27, 27, NULL, NULL, '2017-01-06 17:35:42'),
('Q', 28, 28, 28, NULL, NULL, '2017-01-06 18:56:39'),
('Q', 29, 29, 29, NULL, NULL, '2017-01-06 21:10:42'),
('Q', 30, 30, 30, NULL, NULL, '2017-02-02 12:20:33'),
('Q', 31, 31, 31, NULL, NULL, '2017-02-03 17:31:11'),
('Q', 32, 32, 32, NULL, NULL, '2017-02-03 17:42:19'),
('Q', 33, 33, 33, NULL, NULL, '2017-02-03 17:46:42'),
('Q', 34, 34, 34, NULL, NULL, '2017-02-03 17:47:38'),
('Q', 35, 35, 35, NULL, NULL, '2017-02-03 17:48:11'),
('Q', 36, 36, 36, NULL, NULL, '2017-02-03 17:49:15'),
('Q', 37, 37, 37, NULL, NULL, '2017-02-03 17:51:20'),
('Q', 38, 38, 38, NULL, NULL, '2017-02-03 17:54:28'),
('Q', 39, 39, 39, NULL, NULL, '2017-02-03 18:01:06'),
('Q', 40, 40, 40, NULL, NULL, '2017-02-03 18:08:03'),
('Q', 41, 41, 41, NULL, NULL, '2017-02-03 18:11:07'),
('Q', 42, 42, 42, NULL, NULL, '2017-02-03 18:13:15'),
('Q', 43, 43, 43, NULL, NULL, '2017-02-03 18:13:36'),
('Q', 44, 44, 44, NULL, NULL, '2017-02-03 18:15:55'),
('Q', 45, 45, 45, NULL, NULL, '2017-02-03 18:31:31'),
('Q', 46, 46, 46, NULL, NULL, '2017-02-03 18:41:06'),
('Q', 47, 47, 47, NULL, NULL, '2017-02-03 18:41:54'),
('Q', 48, 48, 48, NULL, NULL, '2017-02-03 18:43:02'),
('Q', 49, 49, 49, NULL, NULL, '2017-02-03 18:43:34'),
('Q', 50, 50, 50, NULL, NULL, '2017-02-03 18:44:54'),
('Q', 51, 51, 51, NULL, NULL, '2017-02-03 18:46:29'),
('Q', 52, 52, 52, NULL, NULL, '2017-02-03 18:47:40'),
('Q', 53, 53, 53, NULL, NULL, '2017-02-03 18:50:45'),
('Q', 54, 54, 54, NULL, NULL, '2017-02-03 18:53:06'),
('Q', 55, 55, 55, NULL, NULL, '2017-02-03 18:53:32'),
('Q', 56, 56, 56, NULL, NULL, '2017-02-20 10:48:29'),
('Q', 57, 57, 57, NULL, NULL, '2017-03-22 18:00:03'),
('Q', 58, 58, 58, NULL, NULL, '2017-03-22 18:20:37'),
('Q', 59, 59, 59, NULL, NULL, '2017-03-22 18:31:00'),
('Q', 60, 60, 60, NULL, NULL, '2017-03-22 18:31:28'),
('Q', 61, 61, 61, NULL, NULL, '2017-03-22 18:32:17'),
('Q', 62, 62, 62, NULL, NULL, '2017-03-25 19:24:20'),
('Q', 63, 63, 63, NULL, NULL, '2017-03-25 20:11:10'),
('Q', 64, 64, 64, NULL, NULL, '2017-03-29 11:31:07'),
('Q', 65, 65, 65, NULL, 2, '2017-04-10 21:05:47'),
('U', 2, 65, 65, NULL, 2, '2017-04-10 21:05:47');

-- --------------------------------------------------------

--
-- Table structure for table `qa_tagmetas`
--

CREATE TABLE IF NOT EXISTS `qa_tagmetas` (
  `tag` varchar(80) NOT NULL,
  `title` varchar(40) NOT NULL,
  `content` varchar(8000) NOT NULL,
  PRIMARY KEY (`tag`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `qa_tagwords`
--

CREATE TABLE IF NOT EXISTS `qa_tagwords` (
  `postid` int(10) unsigned NOT NULL,
  `wordid` int(10) unsigned NOT NULL,
  KEY `postid` (`postid`),
  KEY `wordid` (`wordid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `qa_titlewords`
--

CREATE TABLE IF NOT EXISTS `qa_titlewords` (
  `postid` int(10) unsigned NOT NULL,
  `wordid` int(10) unsigned NOT NULL,
  KEY `postid` (`postid`),
  KEY `wordid` (`wordid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `qa_titlewords`
--

INSERT INTO `qa_titlewords` (`postid`, `wordid`) VALUES
(15, 12),
(15, 13),
(15, 14),
(15, 24),
(16, 12),
(16, 13),
(16, 14),
(16, 24),
(17, 29),
(18, 30),
(18, 19),
(18, 15),
(19, 12),
(19, 13),
(19, 14),
(19, 31),
(20, 32),
(20, 33),
(20, 34),
(20, 27),
(21, 13),
(21, 22),
(21, 35),
(22, 36),
(23, 37),
(23, 38),
(24, 39),
(25, 40),
(25, 41),
(25, 42),
(25, 43),
(25, 44),
(27, 45),
(27, 46),
(28, 47),
(29, 48),
(30, 12),
(30, 13),
(30, 22),
(31, 13),
(31, 49),
(31, 50),
(32, 51),
(33, 52),
(34, 53),
(35, 54),
(36, 55),
(37, 56),
(38, 57),
(39, 58),
(40, 59),
(41, 60),
(42, 61),
(43, 62),
(44, 63),
(45, 64),
(46, 65),
(47, 66),
(48, 67),
(49, 68),
(50, 69),
(51, 70),
(52, 71),
(53, 72),
(54, 73),
(55, 74),
(56, 12),
(56, 13),
(56, 75),
(57, 76),
(57, 77),
(57, 78),
(57, 79),
(58, 80),
(58, 2),
(58, 30),
(58, 81),
(59, 82),
(59, 2),
(59, 30),
(59, 83),
(59, 84),
(60, 42),
(60, 83),
(60, 41),
(60, 30),
(60, 85),
(61, 83),
(61, 30),
(61, 86),
(62, 30),
(62, 2),
(62, 87),
(62, 88),
(62, 46),
(63, 82),
(63, 2),
(63, 78),
(63, 89),
(63, 90),
(63, 91),
(63, 92),
(63, 93),
(63, 94),
(64, 30),
(64, 95),
(64, 88),
(64, 45),
(64, 46),
(65, 12),
(65, 2),
(65, 42),
(65, 96),
(65, 97);

-- --------------------------------------------------------

--
-- Table structure for table `qa_userevents`
--

CREATE TABLE IF NOT EXISTS `qa_userevents` (
  `userid` int(10) unsigned NOT NULL,
  `entitytype` char(1) CHARACTER SET ascii NOT NULL,
  `entityid` int(10) unsigned NOT NULL,
  `questionid` int(10) unsigned NOT NULL,
  `lastpostid` int(10) unsigned NOT NULL,
  `updatetype` char(1) CHARACTER SET ascii DEFAULT NULL,
  `lastuserid` int(10) unsigned DEFAULT NULL,
  `updated` datetime NOT NULL,
  KEY `userid` (`userid`,`updated`),
  KEY `questionid` (`questionid`,`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `qa_userfavorites`
--

CREATE TABLE IF NOT EXISTS `qa_userfavorites` (
  `userid` int(10) unsigned NOT NULL,
  `entitytype` char(1) CHARACTER SET ascii NOT NULL,
  `entityid` int(10) unsigned NOT NULL,
  `nouserevents` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`userid`,`entitytype`,`entityid`),
  KEY `userid` (`userid`,`nouserevents`),
  KEY `entitytype` (`entitytype`,`entityid`,`nouserevents`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `qa_userfields`
--

CREATE TABLE IF NOT EXISTS `qa_userfields` (
  `fieldid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(40) NOT NULL,
  `content` varchar(40) DEFAULT NULL,
  `position` smallint(5) unsigned NOT NULL,
  `flags` tinyint(3) unsigned NOT NULL,
  `permit` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`fieldid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `qa_userfields`
--

INSERT INTO `qa_userfields` (`fieldid`, `title`, `content`, `position`, `flags`, `permit`) VALUES
(1, 'name', NULL, 1, 0, NULL),
(2, 'location', NULL, 2, 0, NULL),
(3, 'website', NULL, 3, 2, NULL),
(4, 'about', NULL, 4, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `qa_userlevels`
--

CREATE TABLE IF NOT EXISTS `qa_userlevels` (
  `userid` int(10) unsigned NOT NULL,
  `entitytype` char(1) CHARACTER SET ascii NOT NULL,
  `entityid` int(10) unsigned NOT NULL,
  `level` tinyint(3) unsigned DEFAULT NULL,
  UNIQUE KEY `userid` (`userid`,`entitytype`,`entityid`),
  KEY `entitytype` (`entitytype`,`entityid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `qa_userlimits`
--

CREATE TABLE IF NOT EXISTS `qa_userlimits` (
  `userid` int(10) unsigned NOT NULL,
  `action` char(1) CHARACTER SET ascii NOT NULL,
  `period` int(10) unsigned NOT NULL,
  `count` smallint(5) unsigned NOT NULL,
  UNIQUE KEY `userid` (`userid`,`action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `qa_userlimits`
--

INSERT INTO `qa_userlimits` (`userid`, `action`, `period`, `count`) VALUES
(1, 'Q', 412050, 1),
(2, 'Q', 414403, 1);

-- --------------------------------------------------------

--
-- Table structure for table `qa_userlogins`
--

CREATE TABLE IF NOT EXISTS `qa_userlogins` (
  `userid` int(10) unsigned NOT NULL,
  `source` varchar(16) CHARACTER SET ascii NOT NULL,
  `identifier` varbinary(1024) NOT NULL,
  `identifiermd5` binary(16) NOT NULL,
  KEY `source` (`source`,`identifiermd5`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `qa_usermetas`
--

CREATE TABLE IF NOT EXISTS `qa_usermetas` (
  `userid` int(10) unsigned NOT NULL,
  `title` varchar(40) NOT NULL,
  `content` varchar(8000) NOT NULL,
  PRIMARY KEY (`userid`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `qa_usernotices`
--

CREATE TABLE IF NOT EXISTS `qa_usernotices` (
  `noticeid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) unsigned NOT NULL,
  `content` varchar(8000) NOT NULL,
  `format` varchar(20) CHARACTER SET ascii NOT NULL,
  `tags` varchar(200) DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`noticeid`),
  KEY `userid` (`userid`,`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `qa_userpoints`
--

CREATE TABLE IF NOT EXISTS `qa_userpoints` (
  `userid` int(10) unsigned NOT NULL,
  `points` int(11) NOT NULL DEFAULT '0',
  `qposts` mediumint(9) NOT NULL DEFAULT '0',
  `aposts` mediumint(9) NOT NULL DEFAULT '0',
  `cposts` mediumint(9) NOT NULL DEFAULT '0',
  `aselects` mediumint(9) NOT NULL DEFAULT '0',
  `aselecteds` mediumint(9) NOT NULL DEFAULT '0',
  `qupvotes` mediumint(9) NOT NULL DEFAULT '0',
  `qdownvotes` mediumint(9) NOT NULL DEFAULT '0',
  `aupvotes` mediumint(9) NOT NULL DEFAULT '0',
  `adownvotes` mediumint(9) NOT NULL DEFAULT '0',
  `qvoteds` int(11) NOT NULL DEFAULT '0',
  `avoteds` int(11) NOT NULL DEFAULT '0',
  `upvoteds` int(11) NOT NULL DEFAULT '0',
  `downvoteds` int(11) NOT NULL DEFAULT '0',
  `bonus` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userid`),
  KEY `points` (`points`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `qa_userpoints`
--

INSERT INTO `qa_userpoints` (`userid`, `points`, `qposts`, `aposts`, `cposts`, `aselects`, `aselecteds`, `qupvotes`, `qdownvotes`, `aupvotes`, `adownvotes`, `qvoteds`, `avoteds`, `upvoteds`, `downvoteds`, `bonus`) VALUES
(1, 280, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(2, 160, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(3, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `qa_userprofile`
--

CREATE TABLE IF NOT EXISTS `qa_userprofile` (
  `userid` int(10) unsigned NOT NULL,
  `title` varchar(40) NOT NULL,
  `content` varchar(8000) NOT NULL,
  UNIQUE KEY `userid` (`userid`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `qa_users`
--

CREATE TABLE IF NOT EXISTS `qa_users` (
  `userid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL,
  `createip` int(10) unsigned NOT NULL,
  `email` varchar(80) NOT NULL,
  `handle` varchar(20) NOT NULL,
  `avatarblobid` bigint(20) unsigned DEFAULT NULL,
  `avatarwidth` smallint(5) unsigned DEFAULT NULL,
  `avatarheight` smallint(5) unsigned DEFAULT NULL,
  `passsalt` binary(16) DEFAULT NULL,
  `passcheck` binary(20) DEFAULT NULL,
  `level` tinyint(3) unsigned NOT NULL,
  `loggedin` datetime NOT NULL,
  `loginip` int(10) unsigned NOT NULL,
  `written` datetime DEFAULT NULL,
  `writeip` int(10) unsigned DEFAULT NULL,
  `emailcode` char(8) CHARACTER SET ascii NOT NULL DEFAULT '',
  `sessioncode` char(8) CHARACTER SET ascii NOT NULL DEFAULT '',
  `sessionsource` varchar(16) CHARACTER SET ascii DEFAULT '',
  `flags` smallint(5) unsigned NOT NULL DEFAULT '0',
  `wallposts` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userid`),
  KEY `email` (`email`),
  KEY `handle` (`handle`),
  KEY `level` (`level`),
  KEY `created` (`created`,`level`,`flags`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `qa_users`
--

INSERT INTO `qa_users` (`userid`, `created`, `createip`, `email`, `handle`, `avatarblobid`, `avatarwidth`, `avatarheight`, `passsalt`, `passcheck`, `level`, `loggedin`, `loginip`, `written`, `writeip`, `emailcode`, `sessioncode`, `sessionsource`, `flags`, `wallposts`) VALUES
(1, '2016-12-04 00:31:52', 0, 'osamaharby95@gmail.com', 'osama_harby95', NULL, NULL, NULL, 'u18l2xvgjr5j5w0n', ' +)�Wa9����h�_\rM', 120, '2017-03-25 21:00:08', 0, '2017-01-02 20:24:50', 0, '', 'yz9g3muh', NULL, 0, 0),
(2, '2017-01-02 21:11:00', 0, 'karammahmoud77@gmail.com', 'karam', NULL, NULL, NULL, 'dmow6eeyeslnaf1m', 'G�[fϥ���q!�4i�', 0, '2017-04-16 15:48:31', 0, '2017-04-10 21:05:47', 0, '7rxrdd6j', 'xw7nkkst', NULL, 0, 0),
(3, '2017-03-29 11:33:00', 0, 'karammahmoud@gmail.com', 'karamMahmoud', NULL, NULL, NULL, '6kg7v08c52bj11bt', '%��2.��J>�Y�j�.E���', 0, '2017-03-29 11:33:02', 0, NULL, NULL, '92lhfhj7', '0haeqg9h', NULL, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `qa_uservotes`
--

CREATE TABLE IF NOT EXISTS `qa_uservotes` (
  `postid` int(10) unsigned NOT NULL,
  `userid` int(10) unsigned NOT NULL,
  `vote` tinyint(4) NOT NULL,
  `flag` tinyint(4) NOT NULL,
  UNIQUE KEY `userid` (`userid`,`postid`),
  KEY `postid` (`postid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `qa_widgets`
--

CREATE TABLE IF NOT EXISTS `qa_widgets` (
  `widgetid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `place` char(2) CHARACTER SET ascii NOT NULL,
  `position` smallint(5) unsigned NOT NULL,
  `tags` varchar(800) CHARACTER SET ascii NOT NULL,
  `title` varchar(80) NOT NULL,
  PRIMARY KEY (`widgetid`),
  UNIQUE KEY `position` (`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `qa_words`
--

CREATE TABLE IF NOT EXISTS `qa_words` (
  `wordid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `word` varchar(80) NOT NULL,
  `titlecount` int(10) unsigned NOT NULL DEFAULT '0',
  `contentcount` int(10) unsigned NOT NULL DEFAULT '0',
  `tagwordcount` int(10) unsigned NOT NULL DEFAULT '0',
  `tagcount` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`wordid`),
  KEY `word` (`word`),
  KEY `tagcount` (`tagcount`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=98 ;

--
-- Dumping data for table `qa_words`
--

INSERT INTO `qa_words` (`wordid`, `word`, `titlecount`, `contentcount`, `tagwordcount`, `tagcount`) VALUES
(1, 'what', 2, 0, 0, 0),
(2, 'is', 5, 0, 0, 0),
(3, 'your', 2, 0, 0, 0),
(4, 'name', 1, 0, 0, 0),
(5, 'who', 1, 0, 0, 0),
(6, 'friend', 1, 0, 0, 0),
(7, 'where', 1, 0, 0, 0),
(8, 'sld', 1, 0, 0, 0),
(9, 'fknsd', 1, 0, 0, 0),
(10, 'lank', 1, 0, 0, 0),
(11, 'dddfdfdddddddddddd', 1, 0, 0, 0),
(12, 'how', 6, 0, 0, 0),
(13, 'are', 7, 0, 0, 0),
(14, 'u', 3, 0, 0, 0),
(15, 'osama', 1, 0, 0, 0),
(16, 'ya', 1, 0, 0, 0),
(17, 'osaaaaaaaaamaaaaaaaaaaaa', 1, 0, 0, 0),
(18, 'ddffffffffffffffffffffffffffffffffff', 1, 0, 0, 0),
(19, 'feky', 1, 0, 0, 0),
(20, 'and', 1, 0, 0, 0),
(21, 'friends', 1, 0, 0, 0),
(22, 'you', 2, 0, 0, 0),
(23, 'hoow', 1, 0, 0, 0),
(24, 'kimo', 2, 0, 0, 0),
(25, 'kimooooooo', 1, 0, 0, 0),
(26, 'zeft', 1, 0, 0, 0),
(27, 'doc', 1, 0, 0, 0),
(28, 'kaamsssssdasssss', 1, 0, 0, 0),
(29, 'ahsdbasjkdksjd', 1, 0, 0, 0),
(30, 'karam', 7, 0, 0, 0),
(31, 'shimaaa', 1, 0, 0, 0),
(32, 'ana', 1, 0, 0, 0),
(33, '3bt', 1, 0, 0, 0),
(34, 'y', 1, 0, 0, 0),
(35, 'hereeeeeeeeeeeee', 1, 0, 0, 0),
(36, 'iujhxgjdjjdjdkghdyhgddddd', 1, 0, 0, 0),
(37, 'osamaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', 1, 0, 0, 0),
(38, 'newwwwwwwwwww', 1, 0, 0, 0),
(39, 'karamaaaaaaaaaaaaaa', 1, 0, 0, 0),
(40, 'hello', 1, 0, 0, 0),
(41, 'from', 2, 0, 0, 0),
(42, 'the', 3, 0, 0, 0),
(43, 'other', 1, 0, 0, 0),
(44, 'side', 1, 0, 0, 0),
(45, 'new', 2, 0, 0, 0),
(46, 'question', 3, 0, 0, 0),
(47, 'helooooooooooooooooooooaaa', 1, 0, 0, 0),
(48, 'asdasdasdawdqwdedfwd', 1, 0, 0, 0),
(49, 'uuuuuuuuuuuu', 1, 0, 0, 0),
(50, 'here', 1, 0, 0, 0),
(51, 'kuyfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff', 1, 0, 0, 0),
(52, 'hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh', 1, 0, 0, 0),
(53, 'wwwwwwwwwwwwwwwwwwwwww', 1, 0, 0, 0),
(54, 'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk', 1, 0, 0, 0),
(55, 'hhhhhhhhhhhhhhhjfstrwtjjjjjjjjjjjjjjjjjjjjjjvgfd', 1, 0, 0, 0),
(56, 'jjjjjjjjjjjjjjjjjjjjjjjjerssssssssssssssssssssssssssssdtrf', 1, 0, 0, 0),
(57, 'jjjjjjjjjjjjjjjjjjjjjaaaaafhcccccccccccccccc', 1, 0, 0, 0),
(58, 'jjjjjjjjjjjjjjjkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk', 1, 0, 0, 0),
(59, 'sakldllllllllllllllllllllllllllllllllllllllllaaaaaaaaaaaaaaa', 1, 0, 0, 0),
(60, 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', 1, 0, 0, 0),
(61, 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaalllllllllll', 1, 0, 0, 0),
(62, 'hhhhhhhaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', 1, 0, 0, 0),
(63, 'laaaaaaaaassssssssssssssssssssssssssssssssssssssssssssssssssss', 1, 0, 0, 0),
(64, 'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk', 1, 0, 0, 0),
(65, 'jjjjjjjjjjjjjjjjjjjjjjjjhhhhhhhhhhhhhhhhh', 1, 0, 0, 0),
(66, 'kkkkkkkkkaaaaaaaaaaaaaaaaaaaaaaaaaaaa', 1, 0, 0, 0),
(67, 'kkkkkkkkkkkkkkkkkkkkkkkkk', 1, 0, 0, 0),
(68, 'lllllllllllaaaaaaaaaaaaaaaaajjjjjjjjjjjjjjjjjjjjjjjjjjjj', 1, 0, 0, 0),
(69, 'asaaaaaaaaaaaaaaaaaaaaaaaaaaaa', 1, 0, 0, 0),
(70, 'jjjjjjjjjjjjjjjjjjjjjjjjjjjjjj', 1, 0, 0, 0),
(71, 'kkkkkkkkkkkkkkkkkkkkkkkkkkkk', 1, 0, 0, 0),
(72, 'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk', 1, 0, 0, 0),
(73, 'jjjjjjjjjjjjjjjhhhhhhhhhhhhhhhhhhhhhhhhhhhhh', 1, 0, 0, 0),
(74, 'hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhdcde', 1, 0, 0, 0),
(75, 'yyyyyyyyyyyyyyyyy', 1, 0, 0, 0),
(76, 'thi', 1, 0, 0, 0),
(77, 'sis', 1, 0, 0, 0),
(78, 'my', 2, 0, 0, 0),
(79, 'teeeeeeeeeest', 1, 0, 0, 0),
(80, 'it', 1, 0, 0, 0),
(81, 'teest', 1, 0, 0, 0),
(82, 'this', 2, 0, 0, 0),
(83, 'test', 3, 0, 0, 0),
(84, '2', 1, 0, 0, 0),
(85, '3', 1, 0, 0, 0),
(86, '4', 1, 0, 0, 0),
(87, 'make', 1, 0, 0, 0),
(88, 'a', 2, 0, 0, 0),
(89, 'second', 1, 0, 0, 0),
(90, 'trying', 1, 0, 0, 0),
(91, 'to', 1, 0, 0, 0),
(92, 'up', 1, 0, 0, 0),
(93, 'load', 1, 0, 0, 0),
(94, 'file', 1, 0, 0, 0),
(95, 'asking', 1, 0, 0, 0),
(96, 'task', 1, 0, 0, 0),
(97, 'plzzz', 1, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `test_img`
--

CREATE TABLE IF NOT EXISTS `test_img` (
  `fileName` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `fileId` int(11) NOT NULL AUTO_INCREMENT,
  `postId` int(11) NOT NULL,
  PRIMARY KEY (`fileId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=189 ;

--
-- Dumping data for table `test_img`
--

INSERT INTO `test_img` (`fileName`, `fileId`, `postId`) VALUES
('uploads/graph-links.txt', 162, 15),
('uploads/graph-nodes.txt', 164, 16),
('uploads/graph-nodes.txt', 166, 16),
('uploads/graph-nodes.txt', 167, 16),
('uploads/graph-nodes.txt', 168, 16),
('uploads/A K-means-like Algorithm for K-medoids Clustering and Its Performance.pdf', 174, 18),
('uploads/A K-means-like Algorithm for K-medoids Clustering and Its Performance.pdf', 175, 18),
('', 179, 15),
('', 180, 16),
('', 181, 18),
('', 182, 17),
('uploads/k-medoids - Wikipedia.html', 183, 19),
('', 184, 19),
('uploads/for tesr.txt', 185, 20),
('', 186, 20),
('', 187, 20),
('', 188, 15);

-- --------------------------------------------------------

--
-- Table structure for table `vega`
--

CREATE TABLE IF NOT EXISTS `vega` (
  `question_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vega`
--

INSERT INTO `vega` (`question_id`) VALUES
(55);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `qa_categorymetas`
--
ALTER TABLE `qa_categorymetas`
  ADD CONSTRAINT `qa_categorymetas_ibfk_1` FOREIGN KEY (`categoryid`) REFERENCES `qa_categories` (`categoryid`) ON DELETE CASCADE;

--
-- Constraints for table `qa_contentwords`
--
ALTER TABLE `qa_contentwords`
  ADD CONSTRAINT `qa_contentwords_ibfk_1` FOREIGN KEY (`postid`) REFERENCES `qa_posts` (`postid`) ON DELETE CASCADE,
  ADD CONSTRAINT `qa_contentwords_ibfk_2` FOREIGN KEY (`wordid`) REFERENCES `qa_words` (`wordid`);

--
-- Constraints for table `qa_postmetas`
--
ALTER TABLE `qa_postmetas`
  ADD CONSTRAINT `qa_postmetas_ibfk_1` FOREIGN KEY (`postid`) REFERENCES `qa_posts` (`postid`) ON DELETE CASCADE;

--
-- Constraints for table `qa_posts`
--
ALTER TABLE `qa_posts`
  ADD CONSTRAINT `qa_posts_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `qa_users` (`userid`) ON DELETE SET NULL,
  ADD CONSTRAINT `qa_posts_ibfk_2` FOREIGN KEY (`parentid`) REFERENCES `qa_posts` (`postid`),
  ADD CONSTRAINT `qa_posts_ibfk_3` FOREIGN KEY (`categoryid`) REFERENCES `qa_categories` (`categoryid`) ON DELETE SET NULL,
  ADD CONSTRAINT `qa_posts_ibfk_4` FOREIGN KEY (`closedbyid`) REFERENCES `qa_posts` (`postid`);

--
-- Constraints for table `qa_posttags`
--
ALTER TABLE `qa_posttags`
  ADD CONSTRAINT `qa_posttags_ibfk_1` FOREIGN KEY (`postid`) REFERENCES `qa_posts` (`postid`) ON DELETE CASCADE,
  ADD CONSTRAINT `qa_posttags_ibfk_2` FOREIGN KEY (`wordid`) REFERENCES `qa_words` (`wordid`);

--
-- Constraints for table `qa_tagwords`
--
ALTER TABLE `qa_tagwords`
  ADD CONSTRAINT `qa_tagwords_ibfk_1` FOREIGN KEY (`postid`) REFERENCES `qa_posts` (`postid`) ON DELETE CASCADE,
  ADD CONSTRAINT `qa_tagwords_ibfk_2` FOREIGN KEY (`wordid`) REFERENCES `qa_words` (`wordid`);

--
-- Constraints for table `qa_titlewords`
--
ALTER TABLE `qa_titlewords`
  ADD CONSTRAINT `qa_titlewords_ibfk_1` FOREIGN KEY (`postid`) REFERENCES `qa_posts` (`postid`) ON DELETE CASCADE,
  ADD CONSTRAINT `qa_titlewords_ibfk_2` FOREIGN KEY (`wordid`) REFERENCES `qa_words` (`wordid`);

--
-- Constraints for table `qa_userevents`
--
ALTER TABLE `qa_userevents`
  ADD CONSTRAINT `qa_userevents_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `qa_users` (`userid`) ON DELETE CASCADE;

--
-- Constraints for table `qa_userfavorites`
--
ALTER TABLE `qa_userfavorites`
  ADD CONSTRAINT `qa_userfavorites_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `qa_users` (`userid`) ON DELETE CASCADE;

--
-- Constraints for table `qa_userlevels`
--
ALTER TABLE `qa_userlevels`
  ADD CONSTRAINT `qa_userlevels_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `qa_users` (`userid`) ON DELETE CASCADE;

--
-- Constraints for table `qa_userlimits`
--
ALTER TABLE `qa_userlimits`
  ADD CONSTRAINT `qa_userlimits_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `qa_users` (`userid`) ON DELETE CASCADE;

--
-- Constraints for table `qa_userlogins`
--
ALTER TABLE `qa_userlogins`
  ADD CONSTRAINT `qa_userlogins_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `qa_users` (`userid`) ON DELETE CASCADE;

--
-- Constraints for table `qa_usermetas`
--
ALTER TABLE `qa_usermetas`
  ADD CONSTRAINT `qa_usermetas_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `qa_users` (`userid`) ON DELETE CASCADE;

--
-- Constraints for table `qa_usernotices`
--
ALTER TABLE `qa_usernotices`
  ADD CONSTRAINT `qa_usernotices_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `qa_users` (`userid`) ON DELETE CASCADE;

--
-- Constraints for table `qa_userprofile`
--
ALTER TABLE `qa_userprofile`
  ADD CONSTRAINT `qa_userprofile_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `qa_users` (`userid`) ON DELETE CASCADE;

--
-- Constraints for table `qa_uservotes`
--
ALTER TABLE `qa_uservotes`
  ADD CONSTRAINT `qa_uservotes_ibfk_1` FOREIGN KEY (`postid`) REFERENCES `qa_posts` (`postid`) ON DELETE CASCADE,
  ADD CONSTRAINT `qa_uservotes_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `qa_users` (`userid`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
