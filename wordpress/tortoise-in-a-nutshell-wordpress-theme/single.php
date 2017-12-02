<?php
/**
 * The Template for displaying all single posts.
 *
 * @package WordPress
 * @subpackage Nutshell
 * @since Nutshell 1.0
 */

get_header(); ?>

	<div id="content" class="content-area" role="main">
			<?php /* The loop */ ?>
			<?php while ( have_posts() ) : the_post(); ?>
				
				<?php get_template_part( 'content', get_post_format() ); ?>
				
				
				<div class='inner'>
					<?php twentythirteen_post_nav(); ?>
				</div>
				
			<?php endwhile; ?>
	</div>

<?php get_sidebar(); ?>	
<?php get_footer(); ?>