<?php
/**
 * Template Name: splash
 * @package WordPress
 * @subpackage SSCY Responsive
 */
 ?>
<?php get_header(); ?>
<section id="content" role="main" class="splash bg-image">
<?php if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>

    <?php if ( has_post_thumbnail() ) { the_post_thumbnail(); } ?>
    
<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
    <header class="entry-header mb-col-9">
        <h1 class="entry-title"><?php the_title(); ?></h1>
    </header>
    <section class="entry-content mb-col-9">
        <div class="col-content">
            <?php the_content(); ?>
        </div>
    </section>
</article>
<?php if ( ! post_password_required() ) comments_template( '', true ); ?>
<?php endwhile; endif; ?>
</section>
<?php get_sidebar(); ?>
<?php get_footer(); ?>