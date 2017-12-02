<!DOCTYPE html>
<html <?php language_attributes(); ?> class="no-js">
<head>
<meta charset="<?php bloginfo( 'charset' ); ?>" />
<meta name="viewport" content="width=device-width" />
<title><?php wp_title( ' | ', true, 'right' ); ?></title>
<link rel="stylesheet" type="text/css" href="<?php echo get_stylesheet_uri(); ?>" />
<link rel="shortcut icon" href="<?php echo get_stylesheet_directory_uri(); ?>/favicon.ico" />

<?php wp_head(); ?>
</head>

<body <?php body_class(); ?>>

<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.6";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>

<?php $bBanner = page_has_banner(); ?>
<header id="header" role="banner" class="<?php if(!$bBanner) { echo 'sticky'; } else { echo 'banner'; } ?>">
  <section id="branding" class="mb-col-9 large-left">
    <div class="col-content">
      <a id="logo" href="<?php echo esc_url( home_url( '/' ) ); ?>" title="home" rel="home">
        <?php echo esc_html( get_bloginfo( 'name' ) ); ?> | <?php echo esc_html( get_bloginfo( 'description' ) ); ?>
      </a>
    </div>
  </section>
  <?php if($bBanner) { include('includes/banner.php'); } ?>
  <nav id="nav" role="navigation" class="mb-col-12">
    <?php wp_nav_menu( array( 'theme_location' => 'main-menu', 'menu_class' => 'col-content center' ) ); ?>
    <section id="connect" class="mb-col-3 large-right small-hide">
      <?php list_social_icons('col-content large-right'); ?>
    </section>
  </nav>
</header>

<div id="wrapper">
<div id="page" class="container">
