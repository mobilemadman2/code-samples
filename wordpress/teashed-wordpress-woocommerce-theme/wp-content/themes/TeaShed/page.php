<?php get_header(); ?>
<section id="content" role="main" class="col-12">
    <?php if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>
    <article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
        <header class="header col-content">
            <h1 class="entry-title"><?php the_title(); ?></h1> <?php edit_post_link(); ?>
        </header>

        <section class="entry-content col-content">
            <?php if ( has_post_thumbnail() ) { the_post_thumbnail(); } ?>
            <?php the_content(); ?>
        </section>
    </article>
<?php endwhile; endif; ?>
</section>
<?php get_footer(); ?>