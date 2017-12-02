<?php
/*
Plugin Name: Natasha Samson Yoga
Plugin URI: http://marianne.digital
Description: A site-specific functionality plugin for Natasha Samson Yoga where you can paste your code snippets instead of using the theme's functions.php file
Author: Marianne Butler
Author URI:
Version: 2016.03.24
License: GPL
*/
/* Setup */
add_action( 'wp_enqueue_scripts', 'natasha_setup' );
function natasha_setup() {
    wp_enqueue_style( 'fa-style', get_template_directory_uri() . '/css/font-awesome/css/font-awesome.min.css');
    wp_enqueue_style( 'main-style', get_template_directory_uri() . '/css/main.css');
    wp_enqueue_style( 'holding-page-style', get_template_directory_uri() . '/css/holding-page.css');
    wp_register_style('googleFonts1', 'https://fonts.googleapis.com/css?family=Lato:400,300,300italic,400italic');
    wp_register_style('googleFonts2', 'https://fonts.googleapis.com/css?family=Playfair+Display:400,400italic,900,900italic');
    wp_enqueue_style( 'googleFonts1');
    wp_enqueue_style( 'googleFonts2');
}


// Classes
function theme_post_classes($classes) {
    global $post;
    $classes[] = "col-content";
    return $classes;
}
add_filter('post_class', 'theme_post_classes');


function theme_body_classes($classes) {
  if (is_page(130) || is_page(223)) $classes[] = "archive";
  if (is_page(21) || is_archive() )  $classes[] = "no-banner";
  return $classes;
}

add_filter('body_class', 'theme_body_classes');

/*
* Social menu
*/
function list_social_icons($ListClass) {
	$walker = new Social_Menu;
	$email_link = '<li><a class="fa fa-envelope" href="mailto:' . get_option( 'admin_email' ) . '" title="email Natasha"></a></li>';
	/*$phone_link = '<li><a class="fa fa-phone" href="mailto:' . 'tel:123123123' . '" title="call Natasha"></a></li>'; */
	wp_nav_menu( array( 'theme_location' => 'social-menu', 'walker' => $walker, 'container' => false, 'items_wrap' => '<ul id="%1$s" class="' . $ListClass . '">' . $email_link . '%3$s</ul>' ) );
}

/*
* Custom walker class for the social menu
**/
class Social_Menu extends Walker_Nav_Menu {

	function start_el( &$output, $item, $depth = 0, $args = array(), $id = 0 ) {
		$indent = ( $depth ) ? str_repeat( "\t", $depth ) : '';

		$output .= $indent . '<li>';

		$atts = array();
		$atts['title']  = ! empty( $item->attr_title ) ? $item->attr_title : $item->title;
		$atts['target'] = ! empty( $item->target )     ? $item->target     : '';
		$atts['rel']    = ! empty( $item->xfn )        ? $item->xfn        : '';
		$atts['href']   = ! empty( $item->url )        ? $item->url        : '';

		$atts = apply_filters( 'nav_menu_link_attributes', $atts, $item, $args );

		$attributes = '';
		foreach ( $atts as $attr => $value ) {
			if ( ! empty( $value ) ) {
				$value = ( 'href' === $attr ) ? esc_url( $value ) : esc_attr( $value );
				$attributes .= ' ' . $attr . '="' . $value . '"';
			}
		}

		$class = 'fa fa-' . $atts['title'];
		$item_output .= '<a class="' . $class . '"' . $attributes .'></a>';

		$output .= apply_filters( 'walker_nav_menu_start_el', $item_output, $item, $depth, $args );
		$item_output .= '</li>';
	}
}


function has_children() {
	global $post;
	$children = get_pages( array( 'child_of' => $post->ID ) );
	return ( count( $children ) > 0 );
}


/*
* Child menus - e.g. 'classes'
*/
function list_children($ID) {
    $walker = new Boxy_Child_Menu;
    echo '<ul>';
    wp_list_pages( array( 'depth' => 1, 'child_of' => $ID, 'echo'  => 1, 'title_li' => '', 'walker' => $walker ) );
    echo '</ul>';
}

/*
* Custom walker class
**/
class Boxy_Child_Menu extends Walker_Page {
	function start_el( &$output, $page, $depth = 0, $args = array(), $current_page = 0 ) {

$thumb = (has_post_thumbnail( $page->ID )) ? get_the_post_thumbnail( $page->ID, $size = 'square-thumbnail' ) : '<img src="http://placehold.it/500x500/?text=placeholder+image" />';

		$teaser = get_field( 'teaser', $page->ID);
		if ( empty( $teaser ) ) $teaser = 'placeholder text';

		$output .= $indent . '<li class="mb-col-4"><a href="' . get_permalink($page->ID) . '" title="' . $page->post_title . '" class="col-content"><div class="img-container">' . $thumb . '</div>' . '<div class="text-container"><h2>' . apply_filters( 'the_title', $page->post_title, $page->ID ) . '</h2><span class="teaser">' . $teaser . '</span>' . '<span class="more">read more' . get_svg('arrow-right') .'</span></div></a>';

	}

	function end_el( &$output, $page, $depth = 0, $args = array() ) {
		$output .= "</li>\n";
	}
}


/*
* Features menu
*/
function list_features() {
	$walker = new Boxy_Menu;
	wp_nav_menu( array( 'theme_location' => 'home-features', 'walker' => $walker, 'container' => false, 'items_wrap' => '<ul id="%1$s">%3$s</ul>' ) );
}
/*
* Custom walker class for the parent page menus
**/
class Boxy_Menu extends Walker_Nav_Menu {

	function start_el( &$output, $item, $depth = 0, $args = array(), $id = 0 ) {
		$indent = ( $depth ) ? str_repeat( "\t", $depth ) : '';

		$output .= $indent . '<li class="mb-col-4">';

		$atts = array();
		$atts['title'] = ! empty( $item->attr_title ) ? $item->attr_title : $item->title;
		$atts['target'] = ! empty( $item->target ) ? $item->target : '';
		$atts['rel'] = ! empty( $item->xfn ) ? $item->xfn : '';
		$atts['href'] = ! empty( $item->url ) ? $item->url : '';
		$atts['class'] = 'col-content';

		$atts = apply_filters( 'nav_menu_link_attributes', $atts, $item, $args );
		$attributes = '';
		foreach ( $atts as $attr => $value ) {
			if ( ! empty( $value ) ) {
				$value = ( 'href' === $attr ) ? esc_url( $value ) : esc_attr( $value );
				$attributes .= ' ' . $attr . '="' . $value . '"';
			}
		}

		$thumb = (has_post_thumbnail( $item->object_id )) ? get_the_post_thumbnail( $item->object_id, $size = 'square-thumbnail' ) : '<img src="http://placehold.it/500x500/?text=placeholder+image" />';

		$teaser = get_field( 'teaser', $item->object_id);
		if ( empty( $teaser ) ) $teaser = 'placeholder text';

		$item_output .= '<a'. $attributes .'><div class="img-container">' . $thumb . '</div><div class="text-container"><h2>'. apply_filters( 'the_title', $item->title, $item->ID ) .'</h2><span class="teaser">' . $teaser . '</span><span class="more">read more' . get_svg('arrow-right') .'</span><div></a>';
		$output .= apply_filters( 'walker_nav_menu_start_el', $item_output, $item, $depth, $args );
	}

	function end_el( &$output, $item, $depth = 0, $args = array() ) {
		$output .= "</li>\n";
	}
}

function get_svg( $id ) {
	$svg;
	switch( $id ) {
		case 'arrow-right':
			$svg = '<svg version="1.1" id="arrow-right" class="icon" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 28.692 18" xml:space="preserve">
	<path d="M0.822,18H0c2.256-4.864,4.864-7.543,8.718-9C4.864,7.566,2.256,4.864,0,0h0.822
		c2.209,4.864,5.382,7.661,9.964,9C6.204,10.363,3.031,13.135,0.822,18z M18.729,0c2.209,4.864,5.382,7.661,9.964,9
		c-4.582,1.363-7.755,4.135-9.964,9h-0.822c1.316-2.843,1.998-5.663,2.068-8.6h-6.063c-3.924,1.48-6.72,4.16-8.765,8.6H4.348
		c2.256-4.864,4.841-7.543,8.694-9C9.188,7.566,6.604,4.864,4.348,0h0.799c2.045,4.441,4.864,7.167,8.836,8.624h5.992
		C19.928,5.687,19.246,2.867,17.906,0H18.729z"/>';
        	break;
		default:
		$svg = '';
	}
	return $svg;
}
