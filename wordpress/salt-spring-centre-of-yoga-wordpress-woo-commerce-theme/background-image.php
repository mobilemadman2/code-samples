<?php
/**
 * Template Name: Background Image
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
    <div class="mb-offset-2">
        <section class="entry-content mb-col-8">
            <div class="col-content">
                <?php the_content(); ?>
            </div>
        </section>
    </div>
</article>
<?php if ( has_post_thumbnail() ) { the_post_thumbnail(); } ?>
<?php endwhile; endif; ?>
</section>
<?php get_sidebar(); ?>
<?php get_footer(); ?>