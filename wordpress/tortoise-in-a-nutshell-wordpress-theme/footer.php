<?php
/**
 * The template for displaying the footer.
 *
 * Contains footer content and the closing of the
 * #main and #page div elements.
 *
 * @package WordPress
 * @subpackage Nutshell
 * @since Nutshell 1.0
 */
?>

		</div><!-- #main -->
		<footer id="colophon" class="site-footer" role="contentinfo">
			<div class='inner'>
				<?php wp_nav_menu( array( 'theme_location' => 'primary', 'menu_class' => 'footer-menu' ) ); ?>
	
				<div id='connect'>
					<h2>Connect:</h2>
					<div class='one'>
					<?php get_template_part('address');?>
					</div>
					<div class='two'>
					<?php get_template_part('mailing-list');?>
					<?php get_template_part('social');?>
					</div>
				</div>
			
				<div class="site-info">
					<p><small>&copy; Tortoise in a Nutshell, 2013<br />Wordpress site by <a href="http://www.mariannebutler.co.uk" title="Web Design & Development" target="_blank">Marianne Butler</a>.</small></p>
				</div><!-- .site-info -->
			</div>	
		</footer><!-- #colophon -->
	</div><!-- #main-container -->
	</div><!-- #page -->

	<?php wp_footer(); ?>
</body>
</html>