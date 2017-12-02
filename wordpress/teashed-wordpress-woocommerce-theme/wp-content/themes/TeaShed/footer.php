<div class="clear"></div>
</div>
<footer id="footer" role="contentinfo">
    
    <div class="fluid-row">
        <section id="mailing-list" class="col-12">
            <div class="col-content">
                <h6>Stay up to date! sign up for our newsletter</h6>
                <a href="<?php echo esc_url( home_url( '/newsletter' ) ); ?>" title="Sign up">Newsletter signup</a>
            </div>
        </section>
    
        <!--p id="address">
            The *TeaShed Limited<br />Northern Design Centre,<br />Abbots Hill,<br />Baltic Business Quarter<br />Tyne and Wear<br />United Kingdom<br />NE8 3DF
        </p-->
        
        <?php wp_nav_menu( array( 'theme_location' => 'footer-menu' ) ); ?>
    </div>
    
<div id="copyright" class="col-12">
    <div class="col-content">
        <?php echo sprintf( __( '%1$s %2$s %3$s. All Rights Reserved.', 'blankslate' ), '&copy;', date( 'Y' ), esc_html( get_bloginfo( 'name' ) ) ); ?>    
        <a class="right" href="http://www.readysalted.co.uk" title="Readysalted">Readysalted</a>
    </div>
</div>

</footer>
</div>
<?php wp_footer(); ?>
</body>
</html>