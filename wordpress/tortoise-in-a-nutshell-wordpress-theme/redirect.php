<?php
/**
 * Template Name: temporary redirect page
 *
 * @package WordPress
 * @subpackage Nutshell
 */
?>


<html>

<head>
	<meta charset="<?php bloginfo( 'charset' ); ?>">
	<meta name="viewport" content="width=device-width">
	<title><?php wp_title( '|', true, 'right' ); ?></title>
	<link rel="profile" href="http://gmpg.org/xfn/11">
	<link rel="pingback" href="<?php bloginfo( 'pingback_url' ); ?>">
	<link rel="shortcut icon" href="/favicon.ico"></link>
	<!--[if lt IE 9]>
	<script src="<?php echo get_template_directory_uri(); ?>/js/html5.js"></script>
	<![endif]-->
	<?php wp_head(); ?>
</head>

<body <?php body_class(); ?>>
	<div id="page" class="hfeed site">
		<header id="masthead" class="site-header inner" role="banner">
			<a class="home-link inner small" href="<?php echo esc_url( home_url( '/' ) ); ?>" title="<?php echo esc_attr( get_bloginfo( 'name', 'display' ) ); ?>" rel="home">
				<img src='<?php echo get_stylesheet_directory_uri() ?>/images/tian_logo.jpg' alt='Tortoise in a Nutshell' />
			</a>
			<div class='inner center'>
			
			<header id='feral-head'>
			<a href ="https://www.edfringe.com/whats-on/theatre/feral"><h1>Current Production: Feral</h1>
			<img id="feral" src="https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-frc3/1150175_619838084722591_275335733_n.jpg" alt ="Feral" />
			</a>
			</header>
			<h3>Tortoise in a Nutshell in co-production with Cumbernauld Theatre</h3>
			
			<div id="event-details">
				<a href ="https://www.edfringe.com/whats-on/theatre/feral" title="booking"><img src="https://www.edfringe.com/theme/images/logo_pink.gif?2013" alt ="Edinburgh Fringe 2013" /></a>
				<p>
				Venue: Summerhall<br />
				Date: 8-25 August<br />
				Time: 20:00<br />
				Duration: 50 min
				</p>
				
				<a href ="https://www.edfringe.com/whats-on/theatre/feral" title="booking">Book here</a>
			</div>	
			
			
		<h4>New website coming soon!</h4>
			
			<?php get_template_part('social');?>

<a href="/welcome"><br/>View our old website</a>
			
			</div>
		</header><!-- #masthead -->
	</div>

</body>