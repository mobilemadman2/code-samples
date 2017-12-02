<?php
/**
 * Template Name: Float Left Content
 * @package WordPress
 * @subpackage SSCY Responsive
 */
 ?>
<?php get_header(); ?>
<section id="content" role="main" class="bg-image">
<?php if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>
<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
    <header class="entry-header">
        <h1 class="entry-title"><?php the_title(); ?></h1>
    </header>
    <section class="entry-content mb-col-8">
        <div class="col-content">
            <?php the_content(); ?>
        </div>
    </section>
    <?php if ( has_post_thumbnail() ) { the_post_thumbnail(); } ?>
</article>
<?php endwhile; endif; ?>
</section>
<?php get_footer(); ?>