<?php get_header(); ?>
<section id="content" role="main" class="col-8 right">
    <?php if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>
    <?php get_template_part( 'entry' ); ?>
    <?php comments_template(); ?>
    <?php endwhile; endif; ?>
    <?php get_template_part( 'nav', 'below' ); ?>
</section>

<div class="col-4">
    <div class="col-content">
<?php get_sidebar(); ?>
    </div>
</div>
    
<?php get_footer(); ?>