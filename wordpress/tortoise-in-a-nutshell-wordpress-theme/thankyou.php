<?php
/**
 * Template Name: thankyou Page
 * The template for displaying thankyou page.
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
						<div class="entry-header contact">
							<h1 class="entry-title">Get in touch!</h1>
							<?php the_field( 'contact_details' ); ?>
						</div>
					</div>	
					<div class="contact-form">
						
						<h2>Thanks for your message!</h2>
					
					</div>
				</header><!-- .entry-header -->
				
				<div class='inner'>
					<div class="features">
					
					<div class='feature twitter-feed'>
						<h2>Latest Tweets</h2>
						<div id="twitter-feed-container">	
						
						<img class='loading' src='<?php echo get_stylesheet_directory_uri() ?>/images/loading.gif' alt='Loading' />
						
						<div id="twitter-feed">
						<a class="twitter-timeline" href="https://twitter.com/MiyeongBae" data-widget-id="367211788703526912" data-tweet-limit="3">Tweets by @MiyeongBae</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
						</div>
					</div>
					</div>

					<div class='feature'>
						<?php get_template_part('mailing-list');?>
					</div>
					
					</div><!-- .features -->
				</div><!-- .inner -->
			</article><!-- #post -->
			<?php endwhile; ?>
		</div><!-- #content -->

<?php get_footer(); ?>