<?php
/**
 * Template Name: Contact Page
 * The template for displaying contact page.
 *
 * @package WordPress
 * @subpackage Nutshell
 *
 *
 */


get_header(); ?>

		<div id="content" class="site-content" role="main">

			<?php /* The loop */ ?>
			<?php while ( have_posts() ) : the_post(); ?>
			<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>				
				
				<div class='inner sans-banner'>
					<div class="features">
					<article class='feature'>	
						<?php the_field( 'intro' ); ?>
						<?php the_field( 'contact_details' ); ?>
					</article>
					
					<div class='feature'>
						<?php echo do_shortcode('[recaptcha_form]'); ?>	
					</div>

					<div class='feature mailing-list' id='mailing-list'>
						<h2>Subscribe to our mailing list</h2>
						<?php get_template_part('mailing-list');?>
					</div>
					
					<div class='feature twitter-feed'>
						<?php get_template_part('twitter-feed'); ?>
					</div>

					
					</div><!-- .features -->
				</div><!-- .inner -->
			</article><!-- #post -->
			<?php endwhile; ?>
		</div><!-- #content -->

<?php get_footer(); ?>