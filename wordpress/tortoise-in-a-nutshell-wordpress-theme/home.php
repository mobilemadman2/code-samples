<?php
/**
 * Template Name: Homepage
 *
 * @package WordPress
 * @subpackage Nutshell
 */

get_header(); ?>

		<div id="content" class="site-content" role="main">

			<?php /* The loop */ ?>
			<?php while ( have_posts() ) : the_post(); ?>
			<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>				
				<header class="banner">
					<div class="inner">
						<div class="entry-header">
							<h1 class="entry-title">Welcome!</h1>
							<?php the_field( 'intro' ); ?>
						</div>
					</div>	
					<div class="entry-gallery">
						<?php the_field( 'gallery' ); ?>
					</div>
				</header><!-- .entry-header -->
				
				<div class='inner'>
					<div class="features">
			
					<?php
					$args = array( 'numberposts' => 1, 'category' => 4 );

					$myposts = get_posts( $args );
					foreach ( $myposts as $post ) : setup_postdata( $post ); ?>
						<article class='feature'>
							<h2>Current Project</h2>
							<a href="<?php the_permalink(); ?>" title="<?php the_title(); ?>..."><h3><?php the_title(); ?></h3></a>
							<div class="entry-thumbnail">
								<a href="<?php the_permalink(); ?>" title="<?php the_title(); ?>...">
									<?php the_post_thumbnail('thumbnail'); ?>
								</a>
							</div>
							<div class='summary'><?php the_field( 'intro_banner' ); ?></div>
							<a class='more' href="<?php the_permalink(); ?>" title="<?php the_title(); ?>..."><span>read more...</span></a>
						</article>
					<?php endforeach; 
					wp_reset_postdata();?>
					
					<?php
					$args = array( 'numberposts' => 1, 'category' => 3 );

					$myposts = get_posts( $args );
					foreach ( $myposts as $post ) : setup_postdata( $post ); ?>
						<article class='feature'>
							<h2>Lastest Blog</h2>
							<a href="<?php the_permalink(); ?>" title="<?php the_title(); ?>..."><h3><?php the_title(); ?></h3></a>
							<div class="entry-thumbnail">
								<a href="<?php the_permalink(); ?>" title="<?php the_title(); ?>...">
									<?php the_post_thumbnail('thumbnail'); ?>
								</a>
							</div>							
							<div class='summary'><?php the_field( 'intro_banner' ); ?></div>
							<a class='more' href="<?php the_permalink(); ?>" title="<?php the_title(); ?>..."><span>read more...</span></a>
						</article>
					<?php endforeach; 
					wp_reset_postdata();?>

					<div class='feature mailing-list'>
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