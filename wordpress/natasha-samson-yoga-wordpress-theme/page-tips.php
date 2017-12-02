<?php
/**
 * Template Name: Recipies Page
 *
 * @package WordPress
 * @subpackage Natasha
 */

get_header();

get_template_part('banner-page'); ?>

  <section id="children" role="main">
    <ul>
      <?php query_posts(array ( 'posts_per_page' => 12, 'cat' => 25 )); ?>
      <?php get_template_part( 'the-loop' ); ?>
      <?php wp_reset_query(); ?>
    </ul>
  </section>

<?php get_footer(); ?>
