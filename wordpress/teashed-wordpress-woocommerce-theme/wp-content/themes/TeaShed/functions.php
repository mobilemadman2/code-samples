<?php
add_action( 'after_setup_theme', 'blankslate_setup' );
function blankslate_setup()
{
load_theme_textdomain( 'blankslate', get_template_directory() . '/languages' );
add_theme_support( 'automatic-feed-links' );
add_theme_support( 'post-thumbnails' );
global $content_width;
if ( ! isset( $content_width ) ) $content_width = 640;
register_nav_menus(
array( 'main-menu' => __( 'Main Menu', 'blankslate' ),
     'products-menu' => __( 'Products Menu' ),
     'footer-menu' => __( 'Footer Menu' )
     )
);
}
add_action( 'wp_enqueue_scripts', 'blankslate_load_scripts' );
function blankslate_load_scripts()
{
wp_enqueue_script( 'jquery' );
wp_enqueue_script( 'custom-script', get_template_directory_uri() . '/scripts/custom.js', array( 'jquery' ));

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
'name' => __( 'Sidebar Widget Area', 'blankslate' ),
'id' => 'primary-widget-area',
'before_widget' => '<li id="%1$s" class="widget-container %2$s">',
'after_widget' => "</li>",
'before_title' => '<h3 class="widget-title">',
'after_title' => '</h3>',
) );
}

if ( function_exists('register_sidebar') ) {
register_sidebar(array(
'name' => 'Homepage Sidebar',
'id' => 'homepage-sidebar',
'description' => 'Appears as the sidebar on the custom homepage',
'before_widget' => '',
'after_widget' => '',
'before_title' => '',
'after_title' => '',
));
    
register_sidebar(array(
'name' => 'Twitter Sidebar',
'id' => 'twitter-sidebar',
'description' => 'Appears as the sidebar on the custom homepage',
'before_widget' => '',
'after_widget' => '',
'before_title' => '',
'after_title' => '',
));    
}


function blankslate_custom_pings( $comment )
{
$GLOBALS['comment'] = $comment;
?>
<li <?php comment_class(); ?> id="li-comment-<?php comment_ID(); ?>"><?php echo comment_author_link(); ?></li>
<?php 
}
add_filter( 'get_comments_number', 'blankslate_comments_number' );
function blankslate_comments_number( $count )
{
if ( !is_admin() ) {
global $id;
$comments_by_type = &separate_comments( get_comments( 'status=approve&post_id=' . $id ) );
return count( $comments_by_type['comment'] );
} else {
return $count;
}
}

add_action( 'wp_enqueue_scripts', 'load_styles' );
function load_styles()
{
    wp_enqueue_style( 'main-style', get_template_directory_uri() . '/css/main.css');
    wp_register_style('googleFonts', 'http://fonts.googleapis.com/css?family=Pacifico');
    wp_enqueue_style( 'googleFonts');
}


/**
 * html5_shiv function.
 * 
 * @access public
 * @return void
 */
function html5_shiv() {
        ?>
        <!-- IE Fix for HTML5 Tags -->
        <!--[if lt IE 9]>
        <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
        <?php
}
if(!is_admin()) {
        add_action('wp_head','html5_shiv');
}


/*
* Products Tabs (homepage)
*/
function list_products() {
	$walker = new Products_Menu;
	wp_nav_menu( array( 'theme_location' => 'products-menu', 'walker' => $walker, 'container' => false, 'items_wrap' => '<ul id="%1$s" class="fluid-row"><li class="col-2"><span class="header col-content">&nbsp; Products</span></li>%3$s</ul><div class="col-12"><span class="tab-after col-content"></span></div>' ) );
}
/*
* Custom walker class for the products menu
**/
class Products_Menu extends Walker_Nav_Menu {

	function start_el( &$output, $item, $depth = 0, $args = array(), $id = 0 ) {
		$indent = ( $depth ) ? str_repeat( "\t", $depth ) : '';

		$output .= $indent . '<li class="col-2">';

		$atts = array();
		$atts['class']  = 'col-content';
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
		
		$item_output .= '<a' . $attributes .'>';
		$item_output .= apply_filters( 'the_title', $item->title, $item->ID );
		$item_output .= '</a>';

		$output .= apply_filters( 'walker_nav_menu_start_el', $item_output, $item, $depth, $args );
	}

	function end_el( &$output, $item, $depth = 0, $args = array() ) {
		$output .= "</li>\n";
	}
}


function custom_excerpt_length( $length ) {
	return 20;
}
add_filter( 'excerpt_length', 'custom_excerpt_length', 999 );




/* 
* Woo Commerce Hooks
*/

add_filter('woocommerce_before_main_content', 'woo_container_before');
function woo_container_before( $variable ) {
    echo "<div class='col-12'><div class='col-content'>";
return $variable;
}

add_filter('woocommerce_after_main_content', 'woo_container_after');
function woo_container_after( $variable ) {
    echo "</div></div>";
return $variable;
}

add_filter( 'woocommerce_product_tabs', 'woo_new_product_tab' );
function woo_new_product_tab( $tabs ) {
	
	// Adds the new tab
	
	$tabs['ingredient_tab'] = array(
		'title' 	=> __( 'Ingredients', 'woocommerce' ),
		'priority' 	=> 50,
		'callback' 	=> 'ingredients_tab_content'
	);
    
    $tabs['brewing_tab'] = array(
		'title' 	=> __( 'Brewing', 'woocommerce' ),
		'priority' 	=> 51,
		'callback' 	=> 'brewing_tab_content'
	);
 
	return $tabs;
 
}
function ingredients_tab_content() {
 
	// The new tab content
 
	echo '<h2>Ingredients</h2>';
	
}

function brewing_tab_content() {
 
	// The new tab content
 
	echo '<h2>Brewing</h2>';
	
}

/**
* SUBSCRIBE BUTTON
**/
add_filter('woocommerce_after_add_to_cart_form', 'woo_cart_btn_after');
function woo_cart_btn_after( $variable ) {
    echo "<a href='#' class='subscribe'><span class='screen-reader-text'>Subscribe</span></a>";
    echo "<h6 class='display'>Don't forget, free delivery on orders over 35!</h6>";
    echo "<div class='clear'></div>";
    return $variable;
}