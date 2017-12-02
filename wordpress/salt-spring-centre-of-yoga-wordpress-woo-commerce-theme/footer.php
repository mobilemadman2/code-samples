</div></div>
<footer id="footer" class='wrapper' role="contentinfo">
    <section class="mb-col-4 right" id="footer-links">
        <?php wp_nav_menu( array( 'theme_location' => 'footer-menu', 'container_class' => 'col-content' ) ); ?>
    </section> 
        
    <section class="mb-col-4" id="footer-branding">
        <div class="col-content">
            <a href="http://www.saltspringcentre.com/about" title="about the Salt Spring Centre of Yoga" target="_blank"><?php include('images/inline-lotus.svg.php');  ?><?php include('images/inline-logo.svg.php');  ?></a>
            <?php include('includes/pp-donate.php');  ?>
        </div>
    </section>
            
    <div class="mb-col-12">
        <p class="col-content" id="copyright">
            <small>
            <?php echo sprintf( __( '%1$s %2$s %3$s. All Rights Reserved.', 'blankslate' ), '&copy;', date( 'Y' ), esc_html( get_bloginfo( 'name' ) ) ); ?> <a href="http://marianne.digital/">Custom wordpress theme</a>
            </small>
        </p>
    </div>
</footer>
</div>
<?php wp_footer(); ?>
</body>
</html>