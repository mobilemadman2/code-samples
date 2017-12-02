<?php
/**
 * The default template for displaying content. Used for both single and index/archive/search.
 *
 * @package WordPress
 * @subpackage Nutshell
 * @since Nutshell 1.0
 */
?>

<?php if ( is_single() || is_page() ) : ?> 

<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>

	<?php if(get_field('gallery')): ?>
	<header class="banner">
		<div class="inner">
			<div class="entry-header">
				<h1 class="entry-title"><?php the_title(); ?></h1>
				<?php the_field( 'intro_banner' ); ?>
			</div>
		</div>	
		<div class="entry-gallery">
			<?php the_field( 'gallery' ); ?>
		</div>
	</header><!-- .entry-header -->
	
	<div class='inner'>
		<div class="entry-content">
			<?php the_field( 'main_content' ); ?>
		</div><!-- .entry-content -->
	</div><!-- .inner -->
	
	<?php else : ?>
	
	<?php if ( has_post_thumbnail() && ! post_password_required() ) : ?>
	<header class="banner">
		<div class="inner">
			<div class="entry-header">
				<h1 class="entry-title"><?php the_title(); ?></h1>
				<?php the_field( 'intro_banner' ); ?>
			</div>
		</div>	
		<div class="entry-gallery">
			<?php the_post_thumbnail('full'); ?>
		</div>
	</header><!-- .entry-header -->
	
	
	<div class='inner'>
		<div class="entry-content">
			<?php the_field( 'main_content' ); ?>
		</div><!-- .entry-content -->
	</div><!-- .inner -->
	
	<?php else : ?>
		
	<div class='inner sans-banner'>
		<div class="entry-content">
			<div class="entry-header">
				<h1 class="entry-title"><?php the_title(); ?></h1>
				<?php the_field( 'intro_banner' ); ?>
			</div>
			<?php the_field( 'main_content' ); ?>
		</div><!-- .entry-content -->
	</div><!-- .inner -->
		
		
	<?php endif; ?>
	<?php endif; ?>
		
</article><!-- #post -->


<!-- category / archive / search  -->
<?php else : ?>

<article id="post-<?php the_ID(); ?>" <?php post_class('inner'); ?>>
	<a class='article-link' href="<?php the_permalink(); ?>" rel="bookmark" title="read more...">
	
		<header class="entry-header">
			<h1 class="entry-title">
				<?php the_title(); ?>
			</h1>
		</header><!-- .entry-header -->
	
		<?php if ( has_post_thumbnail() && ! post_password_required() ) : ?>
		<div class="entry-thumbnail">
			<?php the_post_thumbnail('medium'); ?>
		</div>
		<?php endif; ?>

		<div class="entry-summary">
			<?php the_field( 'intro_banner' ); ?>
		</div><!-- .entry-summary -->
	</a>

	<div class="entry-meta">
		<?php twentythirteen_entry_meta(); ?>
	</div><!-- .entry-meta -->
	
</article><!-- #post -->




<?php endif; // is_single() ?>
