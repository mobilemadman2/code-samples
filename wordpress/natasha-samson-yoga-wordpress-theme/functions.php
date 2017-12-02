<?php
add_action( 'after_setup_theme', 'blankslate_setup' );
function blankslate_setup()
{
	load_theme_textdomain( 'blankslate', get_template_directory() . '/languages' );
	add_theme_support( 'automatic-feed-links' );
	add_theme_support( 'post-thumbnails' );
	add_image_size( 'square-thumbnail', 500, 500, TRUE );
	register_nav_menus(array( 'main-menu' => 'Main Menu', 'footer-menu' => 'Footer Menu', 'social-menu' => 'Social Menu', 'home-features' => 'Homepage Features' ));
	global $content_width;
	if ( ! isset( $content_width ) ) $content_width = 640;
}

add_action( 'wp_enqueue_scripts', 'blankslate_load_scripts' );
function blankslate_load_scripts()
{
    $theme_url = get_template_directory_uri();

    wp_register_script( 'modernizr', $theme_url . '/scripts/modernizr.custom.js', array( 'jquery' ) );
    wp_register_script( 'custom-script', $theme_url . '/scripts/custom.js', array( 'jquery', 'modernizr' ) );

    wp_localize_script( 'custom-script', 'wp_vars', array( 'theme_url' => $theme_url ) );
    wp_enqueue_script( 'custom-script' );
}
add_action( 'comment_form_before', 'blankslate_enqueue_comment_reply_script' );
function blankslate_enqueue_comment_reply_script()
{
if ( get_option( 'thread_comments' ) ) { wp_enqueue_script( 'comment-reply' ); }
}
add_filter( 'the_title', 'blankslate_title' );
function blankslate_title( $title ) {
if ( $title == '' ) {
return '&rarr;';
} else {
return $title;
}
}
add_filter( 'wp_title', 'blankslate_filter_wp_title' );
function blankslate_filter_wp_title( $title )
{
return $title . esc_attr( get_bloginfo( 'name' ) );
}
add_action( 'widgets_init', 'blankslate_widgets_init' );
function blankslate_widgets_init()
{
register_sidebar( array (
'name' => __( 'Main Widget Area', 'blankslate' ),
'id' => 'primary-widget-area',
'before_widget' => '<li id="%1$s" class="widget-container %2$s">',
'after_widget' => "</li>",
'before_title' => '<h3 class="widget-title">',
'after_title' => '</h3>',
) );
}
