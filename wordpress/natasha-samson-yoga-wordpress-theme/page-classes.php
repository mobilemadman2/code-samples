<?php
/**
 * Template Name: Classes Page
 *
 * @package WordPress
 * @subpackage Natasha
 */
?>

<?php get_header(); ?>

<?php get_template_part('post-content'); ?>

<section id="children">
   <?php list_children(21); ?>
</section>

<?php get_footer(); ?>
