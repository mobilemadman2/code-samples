<?php
/*
Plugin Name: Salt Spring Centre of Yoga Custom
Plugin URI: http://bookings.saltspringcentre.com
Description: A site-specific functionality plugin for Salt Spring Centre of Yoga where you can paste your code snippets instead of using the theme's functions.php file
Author: Marianne Butler
Author URI: http://marianne.digital
Version: 2015.11.12
License: GPL
*/


/*
* Scripts and Styles
*/
add_action( 'wp_enqueue_scripts', 'sscy_scripts_styles' );
function sscy_scripts_styles()
{
    	$theme_url = get_template_directory_uri();

    	wp_enqueue_style( 'main-style', $theme_url . '/css/main.css');
    	wp_register_style('googleFonts1', 'https://fonts.googleapis.com/css?family=PT+Serif:400,400italic,700,700italic|PT+Sans:400,400italic,700,700italic');
    	wp_enqueue_style( 'googleFonts1');
	wp_enqueue_script( 'script-name', 'https://use.fonticons.com/5924a475.js');
    	wp_register_script( 'modernizr', $theme_url . '/scripts/modernizr.custom.55167.js', array( 'jquery' ) );
    	wp_register_script( 'match-height', $theme_url . '/scripts/jquery-match-height.js', array( 'jquery', 'modernizr' ) );
    	wp_register_script( 'custom-script', $theme_url . '/scripts/custom.js', array( 'jquery', 'modernizr', 'match-height' ) );
    	wp_localize_script( 'custom-script', 'wp_vars', array( 'theme_url' => $theme_url ) );
    	wp_enqueue_script( 'custom-script' );
}

register_nav_menus(
	array( 'main-menu-left' => __( 'Main Menu Left' ), 'main-menu-right' => __( 'Main Menu Right' ), 'aside-menu' => __( 'Aside Menu' ), 'footer-menu' => __( 'Footer Menu' ) )
);


function create_post_type() {
  $labels = array(
    'name'               => 'Public Offerings',
    'singular_name'      => 'Public Offering',
    'menu_name'          => 'Public Offerings',
    'name_admin_bar'     => 'Public Offering',
    'add_new'            => 'Add New',
    'add_new_item'       => 'Add New Public Offering',
    'new_item'           => 'New Public Offering',
    'edit_item'          => 'Edit Public Offering',
    'view_item'          => 'View Public Offering',
    'all_items'          => 'All Public Offerings',
    'search_items'       => 'Search Public Offerings',
    'parent_item_colon'  => 'Parent Offering',
    'not_found'          => 'No Public Offerings Found',
    'not_found_in_trash' => 'No Public Offerings Found in Trash'
  );

  $args = array(
    'labels'              => $labels,
    'public'              => true,
    'exclude_from_search' => false,
    'publicly_queryable'  => true,
    'show_ui'             => true,
    'show_in_nav_menus'   => true,
    'show_in_menu'        => true,
    'show_in_admin_bar'   => true,
    'menu_position'       => 5,
    'menu_icon'           => 'dashicons-groups',
    'capability_type'     => 'post',
    'hierarchical'        => false,
    'supports'            => array( 'title', 'editor', 'author', 'thumbnail', 'excerpt', 'comments' ),
    'has_archive'         => true,
    'rewrite'             => array( 'slug' => 'public' ),
    'query_var'           => true
  );

  register_post_type( 'sm_class', $args );


$labels2 = array(
    'name'               => 'CSWC Practitioner',
    'singular_name'      => 'Practitioner',
    'menu_name'          => 'Practitioners',
    'name_admin_bar'     => 'Practitioner',
    'add_new'            => 'Add New',
    'add_new_item'       => 'Add New Practitioner',
    'new_item'           => 'New Practitioner',
    'edit_item'          => 'Edit Practitioner',
    'view_item'          => 'View Practitioner',
    'all_items'          => 'All Practitioners',
    'search_items'       => 'Search Practitioners',
    'parent_item_colon'  => 'Parent Practitioner',
    'not_found'          => 'No Practitioners Found',
    'not_found_in_trash' => 'No Practitioners Found in Trash'
  );

  $args2 = array(
    'labels'              => $labels2,
    'public'              => true,
    'exclude_from_search' => false,
    'publicly_queryable'  => true,
    'show_ui'             => true,
    'show_in_nav_menus'   => true,
    'show_in_menu'        => true,
    'show_in_admin_bar'   => true,
    'menu_position'       => 5,
    'menu_icon'           => 'dashicons-heart',
    'capability_type'     => 'post',
    'hierarchical'        => false,
    'supports'            => array( 'title', 'editor', 'author', 'thumbnail', 'excerpt', 'comments' ),
    'has_archive'         => true,
    'rewrite'             => array( 'slug' => '/chikitsa-shala-practitioners' ),
    'query_var'           => true
  );

  register_post_type( 'sm_practitioner', $args2 );
}
add_action( 'init', 'create_post_type' );

function create_custom_taxonomies() {
    register_taxonomy(
        'public_class_type',
        'sm_class',
        array(
            'labels' => array(
                'name' => 'Event Type',
                'add_new_item' => 'Add New Event Type',
                'new_item_name' => "New Event Type"
            ),
            'show_ui' => true,
            'show_tagcloud' => false,
            'hierarchical' => true
        )
    );
register_taxonomy(
        'public_class_teacher',
        'sm_class',
        array(
            'labels' => array(
                'name' => 'Teacher',
                'add_new_item' => 'Add New Teacher',
                'new_item_name' => "New Teacher"
            ),
            'show_ui' => true,
            'show_tagcloud' => false,
            'hierarchical' => true
        )
    );

register_taxonomy(
        'public_class_day',
        'sm_class',
        array(
            'labels' => array(
                'name' => 'Event Day',
                'add_new_item' => 'Add New Event Day',
                'new_item_name' => "New Event Day"
            ),
            'show_ui' => true,
            'show_tagcloud' => false,
            'hierarchical' => true
        )
    );
register_taxonomy(
        'public_class_time',
        'sm_class',
        array(
            'labels' => array(
                'name' => 'Event Time',
                'add_new_item' => 'Add New Event Time',
                'new_item_name' => "New Event Time"
            ),
            'show_ui' => true,
            'show_tagcloud' => false,
            'hierarchical' => true
        )
    );
register_taxonomy(
        'public_class_location',
        'sm_class',
        array(
            'labels' => array(
                'name' => 'Event Location',
                'add_new_item' => 'Add New Event Location',
                'new_item_name' => "New Event Location"
            ),
            'show_ui' => true,
            'show_tagcloud' => false,
            'hierarchical' => true
        )
    );
register_taxonomy(
        'public_class_price',
        'sm_class',
        array(
            'labels' => array(
                'name' => 'Event Price',
                'add_new_item' => 'Add New Event Price',
                'new_item_name' => "New Event Price"
            ),
            'show_ui' => true,
            'show_tagcloud' => false,
            'hierarchical' => true
        )
    );



}
add_action( 'init', 'create_custom_taxonomies', 0 );

/*
* WOOCOMMERCE
*/
add_action( 'after_setup_theme', 'woocommerce_support' );
function woocommerce_support() {
    add_theme_support( 'woocommerce' );
}

function remove_woocommerce_sections(){
	remove_action( 'woocommerce_before_shop_loop_item_title', 'woocommerce_template_loop_product_thumbnail', 10 );
	remove_action( 'woocommerce_before_main_content', 'woocommerce_output_content_wrapper', 10);
	remove_action( 'woocommerce_after_main_content', 'woocommerce_output_content_wrapper_end', 10);
	remove_action( 'woocommerce_before_single_product_summary', 'woocommerce_show_product_images', 20);
	remove_action( 'woocommerce_before_single_product_summary', 'woocommerce_show_product_sale_flash', 10);
	remove_action( 'woocommerce_single_product_summary', 'woocommerce_template_single_title', 5);
	remove_action( 'woocommerce_single_product_summary', 'woocommerce_template_single_rating', 10);
	remove_action( 'woocommerce_single_product_summary', 'woocommerce_template_single_add_to_cart', 30);
	remove_action( 'woocommerce_single_product_summary', 'woocommerce_template_single_meta', 40);
	remove_action( 'woocommerce_single_product_summary', 'woocommerce_template_single_sharing', 50);
	remove_action( 'woocommerce_after_single_product_summary', 'woocommerce_output_product_data_tabs', 10);
	remove_action('woocommerce_after_single_product_summary', 'woocommerce_upsell_display', 15);
	remove_action('woocommerce_after_single_product_summary', 'woocommerce_output_related_products', 20);

}
add_action('init','remove_woocommerce_sections');

function add_woocommerce_sections(){
	add_action('woocommerce_after_shop_loop_item','woocommerce_template_single_excerpt', 5);
	add_action('woocommerce_before_main_content', 'my_theme_wrapper_start', 10);
	add_action('woocommerce_after_main_content', 'my_theme_wrapper_end', 10);
	add_action('woocommerce_single_product_summary', 'woocommerce_upsell_display', 20);
	add_action('woocommerce_before_single_product_summary', 'woocommerce_template_single_title', 10);
	add_action('woocommerce_after_single_product_summary', 'woocommerce_template_single_add_to_cart', 5);
	add_action('woocommerce_before_cart_table', 'mb_wc_cart_wrapper_start', 5);
	add_action('woocommerce_after_cart_table', 'mb_wc_cart_wrapper_end', 10);
	add_action('woocommerce_before_checkout_form', 'mb_wc_checkout_wrapper_start', 5);
	add_action('woocommerce_after_checkout_form', 'mb_wc_checkout_wrapper_end', 10);
	add_action('woocommerce_before_edit_address_form_billing', 'mb_wc_edit_address_wrapper_start', 5);
	add_action('woocommerce_after_edit_address_form_billing', 'mb_wc_edit_address_wrapper_end', 5);
	add_action( 'woocommerce_cart_collaterals', 'mb_wc_collaterals_wrapper_start', 1 );
	add_action( 'woocommerce_cart_collaterals', 'mb_wc_collaterals_wrapper_end', 15 );
	add_action( 'woocommerce_edit_account_form_start', 'mb_wc_edit_account_wrapper_start', 5 );
	add_action( 'woocommerce_edit_account_form_end', 'mb_wc_edit_account_wrapper_end', 5 );
	add_action( 'woocommerce_view_order', 'mb_wc_collaterals_wrapper_start', 1 );
	add_action( 'woocommerce_view_order', 'mb_wc_collaterals_wrapper_end', 15 );
}
add_action('init','add_woocommerce_sections');

function my_theme_wrapper_start() {
  echo '<section id="content" role="main">';
}

function my_theme_wrapper_end() {
  echo '</section>';
}

function mb_wc_cart_wrapper_start() {
  echo '<div class="mb-offset-1"><div class="mb-col-10">';
}

function mb_wc_cart_wrapper_end() {
  echo '</div></div>';
}

function mb_wc_edit_account_wrapper_start() {
  echo '<div class="mb-offset-2"><div class="mb-col-8">';
}

function mb_wc_edit_account_wrapper_end() {
  echo '</div></div>';
}

function mb_wc_collaterals_wrapper_start() {
  echo '<div class="mb-offset-1"><div class="mb-col-10">';
}

function mb_wc_collaterals_wrapper_end() {
  echo '</div></div>';
}

function mb_wc_checkout_wrapper_start() {
  echo '<div class="mb-offset-1"><div class="mb-col-10">';
}

function mb_wc_checkout_wrapper_end() {
  echo '</div></div>';
}

function mb_wc_edit_address_wrapper_start() {
  echo '<div class="mb-offset-1"><div class="mb-col-10">';
}

function mb_wc_edit_address_wrapper_end() {
  echo '</div></div>';
}

/**
* Changes the checkout form fields.
* Our hooked in function - $fields is passed via the filter!
*/
add_filter( 'woocommerce_checkout_fields' , 'custom_override_checkout_fields' );
function custom_override_checkout_fields( $fields ) {
	unset($fields['billing']['billing_company']);
	unset($fields['billing']['billing_address_1']);
	unset($fields['billing']['billing_address_2']);
	unset($fields['billing']['billing_city']);
	unset($fields['billing']['billing_postcode']);
	unset($fields['billing']['billing_country']);
	unset($fields['billing']['billing_state']);

	return $fields;
}

/**
 * Changes the redirect URL for the Return To Shop button in the cart.
 *
 * @return string
 */
function my_woocommerce_shop_redirect( $return_to ) {
	return 'http://bookings.saltspringcentre.com/chikitsa-shala-wellness-centre/treatments/';
}
add_filter( 'woocommerce_continue_shopping_redirect', 'my_woocommerce_shop_redirect', 20 );
add_filter( 'woocommerce_return_to_shop_redirect', 'my_woocommerce_shop_redirect', 20 );

add_filter('gettext', 'translate_text');
add_filter('ngettext', 'translate_text');

function translate_text($translated) {
$translated = str_ireplace('Continue Shopping', 'Add Another Treatment', $translated);
$translated = str_ireplace('Return to Shop', 'View the Treatments', $translated);
$translated = str_ireplace('Your order was cancelled.', 'Payal payment cancelled: your order has not been placed.', $translated);


return $translated;
}
