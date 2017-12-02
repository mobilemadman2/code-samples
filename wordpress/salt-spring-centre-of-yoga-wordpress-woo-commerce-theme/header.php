<!DOCTYPE html>
<html <?php language_attributes(); ?>>
<head>
<meta charset="<?php bloginfo( 'charset' ); ?>" />
<meta name="viewport" content="width=device-width" />
<title><?php wp_title( ' | ', true, 'right' ); ?></title>
<link rel="stylesheet" type="text/css" href="<?php echo get_stylesheet_uri(); ?>" />
<!--[if lt IE 10]><link rel="stylesheet" type="text/css" href="<?php echo get_stylesheet_directory_uri(); ?>/css/ie.css" /><![endif]-->
<link rel="apple-touch-icon" sizes="57x57" href="/apple-touch-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60" href="/apple-touch-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76" href="/apple-touch-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120" href="/apple-touch-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144" href="/apple-touch-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152" href="/apple-touch-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon-180x180.png">
<link rel="icon" type="image/png" href="/favicon-32x32.png" sizes="32x32">
<link rel="icon" type="image/png" href="/favicon-194x194.png" sizes="194x194">
<link rel="icon" type="image/png" href="/favicon-96x96.png" sizes="96x96">
<link rel="icon" type="image/png" href="/android-chrome-192x192.png" sizes="192x192">
<link rel="icon" type="image/png" href="/favicon-16x16.png" sizes="16x16">
<link rel="manifest" href="/manifest.json">
<link rel="mask-icon" href="/safari-pinned-tab.svg" color="#b59a40">
<meta name="msapplication-TileColor" content="#da532c">
<meta name="msapplication-TileImage" content="/mstile-144x144.png">
<meta name="theme-color" content="#ffffff">
<?php wp_head(); ?>
</head>
<body <?php body_class(); ?>>
    <!--[if lt IE 10]>
      <p class="browsehappy">
        You are using an <strong>outdated</strong> browser.
        Please <a href="http://browsehappy.com/">upgrade your browser</a>
        to improve your experience.
      </p>
    <![endif]-->
    
<div class='wrapper'>
    <header id="header" role="banner">
        <section id="branding">

            <a href="<?php echo esc_url( home_url( '/' ) ); ?>" title="<?php esc_attr_e( get_bloginfo( 'name' ), 'blankslate' ); ?>" rel="home">
            <?php include('images/inline-lotus.svg.php');  ?>
            <div id="site-title"><?php if ( ! is_singular() ) { echo '<h1>'; } ?><?php echo esc_html( get_bloginfo( 'name' ) ); ?><?php if ( ! is_singular() ) { echo '</h1>'; } ?></div>
            </a>
        </section>
        <nav id="main-menu" class="menu" role="navigation">
            <i id="main-menu-toggle" class="icon icon-bars"></i>
            <div class="mb-col-5 left"><?php wp_nav_menu( array( 'theme_location' => 'main-menu-left' ) ); ?></div>
            <div class="mb-col-5 right"><?php wp_nav_menu( array( 'theme_location' => 'main-menu-right' ) ); ?></div>
        </nav>
        <nav id="aside-menu" class="menu" role="navigation">
            <div class="mb-col-12 left">
                <?php wp_nav_menu( array( 'theme_location' => 'aside-menu' ) ); ?>
            </div>
        </nav>
    </header>
</div>
<div id="content-background" class="wrapper-full"></div>
<div id='wrapper'>
<div id="container">