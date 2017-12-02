<?php
/**
 * Template Name: Holding Page
 *
 * @package WordPress
 * @subpackage Natasha
 */

 <!DOCTYPE html>
 <html <?php language_attributes(); ?>>
 <head>
 <meta charset="<?php bloginfo( 'charset' ); ?>" />
 <meta name="viewport" content="width=device-width" />
 <title><?php wp_title( ' | ', true, 'right' ); ?></title>
 <link rel="stylesheet" type="text/css" href="<?php echo get_stylesheet_uri(); ?>" />
 <link rel="shortcut icon" href="<?php echo get_stylesheet_directory_uri(); ?>/favicon.ico" />

 <?php wp_head(); ?>
 </head>

 <body <?php body_class(); ?>>

</div><!-- #container -->
</div><!-- .wrapper -->

<?php wp_footer(); ?>

</body>
</html>
