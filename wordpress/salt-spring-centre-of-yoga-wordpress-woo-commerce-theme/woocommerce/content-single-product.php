<?php
/**
 * The template for displaying product content in the single-product.php template
 *
 * Override this template by copying it to yourtheme/woocommerce/content-single-product.php
 *
 * @author 		WooThemes
 * @package 	WooCommerce/Templates
 * @version     1.6.4
 */

if ( ! defined( 'ABSPATH' ) ) {
	exit; // Exit if accessed directly
}

?>

<?php
	/**
	 * woocommerce_before_single_product hook
	 *
	 * @hooked wc_print_notices - 10
	 */
	 do_action( 'woocommerce_before_single_product' );

	 if ( post_password_required() ) {
	 	echo get_the_password_form();
	 	return;
	 }
?>

<div itemscope itemtype="<?php echo woocommerce_get_product_schema(); ?>" id="product-<?php the_ID(); ?>" <?php post_class(); ?>>


    <header class="entry-header">
    <?php
		/**
		 * woocommerce_before_single_product_summary hook
		 *
		 * @hooked woocommerce_show_product_sale_flash - 10 (unhooked MB)
		 * @hooked woocommerce_show_product_images - 20 (unhooked MB)
         *
         * @hooked woocommerce_template_single_title - 5
		 */
		do_action( 'woocommerce_before_single_product_summary' );
	?>
    </header>
	<div class="entry-summary mb-col-7 right">
        <div class="col-content">
		<?php
			/**
			 * woocommerce_single_product_summary hook
			 *
			 * @hooked woocommerce_template_single_title - 5 (unhooked MB)
			 * @hooked woocommerce_template_single_rating - 10 (unhooked MB)
			 * @hooked woocommerce_template_single_price - 10 
			 * @hooked woocommerce_template_single_excerpt - 20 
			 * @hooked woocommerce_template_single_add_to_cart - 30
			 * @hooked woocommerce_template_single_meta - 40 (unhooked MB)
			 * @hooked woocommerce_template_single_sharing - 50
			 */
			do_action( 'woocommerce_single_product_summary' );
		?>
        </div>
	</div><!-- .summary -->
       
    <div class="mb-col-5 right">
        <div class="col-content">
        <?php
            /**
             * woocommerce_after_single_product_summary hook
             * @hooked woocommerce_output_product_data_tabs - 10 (unhooked MB)
             */
            do_action( 'woocommerce_after_single_product_summary' );
        ?>
        </div>
    </div>
	
    <div>
        <meta itemprop="url" content="<?php the_permalink(); ?>" />
        <?php 
        /**
        *   @hooked woocommerce_upsell_display - 15
        */
        do_action( 'woocommerce_after_single_product' ); ?>
    </div>
    
</div><!-- #product-<?php the_ID(); ?> -->