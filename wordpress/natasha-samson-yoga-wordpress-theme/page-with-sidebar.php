<?php
/**
 * Template Name: Sidebar Page
 *
 * @package WordPress
 * @subpackage Natasha
 */
?>

<?php get_header(); ?>

<div class="mb-col-12 offset-body">
  <?php if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>
    <article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
      <header id="page-header" class="center">
        <h1 id="page-title"><?php the_title(); ?></h1>
        </header>
        <section id="page-body" role="main">
          <?php echo get_field('intro'); ?>
          <?php echo get_field('body'); ?>
        </section>
    </article>

    <aside class="mb-col-12">
      <?php if (has_post_thumbnail()) echo get_the_post_thumbnail( $post->ID, 'full' ); ?>

      <?php $featureId = get_field('featured_posts'); ?>

      <article class="col-content">
        <header class="article-header">
          <h4><a href="<?php echo get_permalink( $featureId );?>"<h2><?php echo get_post( $featureId )->post_title; ?></a></h4>
        </header>
        <section class="article-body">
          <?php
          $intro = get_field('intro', $featureId);
          if ( ! empty( $intro ) ) echo $intro; ?>
          <p><a href="<?php echo get_permalink( $featureId );?>" title="read the full post"><span class="more">read more <?php echo get_svg('arrow-right'); ?></span></a></p>
        </section>
      </article>
    </aside>

<?php endwhile; endif; ?>
</div>

<?php get_footer(); ?>
