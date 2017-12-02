<?php
/**
 * Template Name: Home Page
 *
 * @package WordPress
 * @subpackage Natasha
 */

get_header(); ?>

<div role="main">
  <?php if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>
  <div id="post-<?php the_ID(); ?>" class="article">
    <header id="page-header" class="mb-col-12">
      <div class="col-content center">
         <?php echo get_field('intro'); ?>
      </div>
    </header>
    <div class="mb-offset-2">
      <section id="page-body" role="main" class="mb-col-8">
        <div class="col-content">
          <?php echo get_field('body'); ?>
        </div>
      </section>
    </div>
  </div>
  <?php endwhile; endif; ?>
</div>

<nav id="children" role="navigation" class="mb-row">
 <?php list_features(); ?>
</nav>

<?php get_footer(); ?>
