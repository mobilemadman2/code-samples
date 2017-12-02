<?php
/**
 * My Account page
 *
 * @author 		WooThemes
 * @package 	WooCommerce/Templates
 * @version     2.0.0
 */

if ( ! defined( 'ABSPATH' ) ) {
	exit; // Exit if accessed directly
}

wc_print_notices(); ?>

<div class="mb-col-12">
    <div class="col-content">
        <h2>Dashboard</h2>
        <p>
 <?php
printf(
		__( 'Hello <strong>%1$s</strong><br /> (not %1$s? <a href="%2$s">Sign out</a>).', 'woocommerce' ) . ' ',
		$current_user->display_name,
		wc_get_endpoint_url( 'customer-logout', '', wc_get_page_permalink( 'myaccount' ) )
	); ?>
        </p>
        <p>
<?php	  	
printf( __( 'From your account dashboard you can view your recent orders, manage your shipping and billing addresses<br />and <a href="%s">edit your password and account details</a>.', 'woocommerce' ),
		wc_customer_edit_account_url()
	);
	?>
        </p>
        <?php do_action( 'woocommerce_before_my_account' ); ?> 
    </div>
</div>
<div class="mb-col-6">
    <div class="col-content"> 
        <?php wc_get_template( 'myaccount/my-address.php' ); ?>
    </div>
</div>
<div class="mb-col-6">
    <div class="col-content">        
        <?php wc_get_template( 'myaccount/my-orders.php', array( 'order_count' => $order_count ) ); ?>
    </div>
</div>        
<div class="mb-col-6">
    <div class="col-content">  
        <?php do_action( 'woocommerce_after_my_account' ); ?>
    </div>
</div>
<!--div class="mb-col-6">
    <div class="col-content">
        php wc_get_template( 'myaccount/my-downloads.php' ); ?>
    </div>
</div-->