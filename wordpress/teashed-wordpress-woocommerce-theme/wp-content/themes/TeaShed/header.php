<!DOCTYPE html>
<html <?php language_attributes(); ?>>
<head>
<meta charset="<?php bloginfo( 'charset' ); ?>" />
<meta name="viewport" content="width=device-width" />
<title><?php wp_title( ' | ', true, 'right' ); ?></title>
<link rel="stylesheet" type="text/css" href="<?php echo get_stylesheet_uri(); ?>" />

    
    <?php wp_head(); ?>
    
    

    
</head>
<body <?php body_class(); ?>>
<div id="wrapper" class="hfeed">
<header id="header" role="banner">

<nav id="menu" role="navigation">
    <div id="search"><?php get_search_form(); ?></div>
    <?php wp_nav_menu( array( 'theme_location' => 'main-menu' ) ); ?>
    
    <div id="social" class="col-6">
        <ul class="col-content">
            <li><a class="tw" href="#"></a></li>
            <li><a class="fb" href="#"></a></li>
            <li><a class="pin" href="#"></a></li>
            <li><a class="in" href="#"></a></li>
        </ul>
    </div>
</nav>

    
    <section id="branding" class="fluid-row">    
        <div id="site-title" class="col-12"><?php if ( ! is_singular() ) { echo '<h1 class="col-content">'; } ?><a href="<?php echo esc_url( home_url( '/' ) ); ?>" title="<?php esc_attr_e( get_bloginfo( 'name' ), 'blankslate' ); ?>" rel="home"><span class="screen-reader-text"><?php echo esc_html( get_bloginfo( 'name' ) ); ?></span>
            <img src="<?php echo get_template_directory_uri(); ?>/images/logo.jpg" alt="<?php esc_attr_e( get_bloginfo( 'name' ), 'blankslate' ); ?>" />
            </a><?php if ( ! is_singular() ) { echo '</h1>'; } ?>
        </div>

        <div id="site-description" class='col-3'>
            <h2 class="col-content"><?php bloginfo( 'description' ); ?></h2>
            <a href="<?php echo esc_url( home_url( '/shop' ) ); ?>" title="Shop!" id="shop-link" class="col-content"><span>Order now!</span></a>
        </div>
    
    </section>
    
    <section id="shop" class="col-3">
        <div id="account" class="col-content">
            <?php if ( is_user_logged_in() ) { ?>
 	          <a href="<?php echo get_permalink( get_option('woocommerce_myaccount_page_id') ); ?>" title="<?php _e('My Account','woothemes'); ?>"><?php _e('My Account','woothemes'); ?></a>
            <?php } 
            else { ?>
 	          <a href="<?php echo get_permalink( get_option('woocommerce_myaccount_page_id') ); ?>" title="<?php _e('Login / Register','woothemes'); ?>"><?php _e('Login / Register','woothemes'); ?></a>
            <?php } ?>
            
            <?php global $woocommerce; ?>
 
<a id="cart" class="cart-contents" href="<?php echo $woocommerce->cart->get_cart_url(); ?>" title="<?php _e('View your shopping cart', 'woothemes'); ?>"><?php echo sprintf(_n('%d item', '%d items', $woocommerce->cart->cart_contents_count, 'woothemes'), $woocommerce->cart->cart_contents_count);?> - <?php echo $woocommerce->cart->get_cart_total(); ?></a>
                        
        </div>
        
        
        <h3 class="col-content">Free delivery on orders over &pound;35</h3>
    </section>
    
    </header>
    
     <?php list_products(); ?>
    
<div id="container">