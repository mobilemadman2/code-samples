<?php
/**
 * Template Name: Test Page
 *
 * @package WordPress
 * @subpackage Natasha
 */
?>

<?php get_header(); ?>

<div role="main">
  <?php if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>
  <article id="post-<?php the_ID(); ?>"  <?php post_class(); ?>>
    <header id="page-header" class="mb-offset-2">
      <div class="mb-col-8">
        <div class="col-content center">
          <h1 id="page-title"><?php the_title(); ?></h1>
          <div id="page-intro">
           <?php echo get_field('intro'); ?>
          </div>
        </div>
      </div>
    </header>
    <div class="mb-col-5" id="mb-side-banner">
      <div class="col-content">
        <?php echo get_the_post_thumbnail( $page_id, 'full' ); ?>
      </div>
    </div>
    <section id="page-body" role="main"class="mb-col-7">
      <div class="col-content">
        <?php echo get_field('body'); ?>
      </div>
    </section>
  </article>
  <?php endwhile; endif; ?>
</div>

<?php get_footer(); ?>
