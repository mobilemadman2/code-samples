<?php get_header(); ?>
<section id="content" role="main" class="col-8 right">
<header class="header col-content">
<h1 class="entry-title"><?php _e( 'Category Archives: ', 'blankslate' ); ?><?php single_cat_title(); ?></h1>
<?php if ( '' != category_description() ) echo apply_filters( 'archive_meta', '<div class="archive-meta">' . category_description() . '</div>' ); ?>
</header>
<?php if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>
<?php get_template_part( 'entry' ); ?>
<?php endwhile; endif; ?>
<?php get_template_part( 'nav', 'below' ); ?>
</section>


<div class="col-4">
    <div class="col-content">
<?php get_sidebar(); ?>
    </div>
</div>

<?php get_footer(); ?>