<?php get_header(); ?>
<section id="content" role="main">
    
<?php if ( have_posts() ) : ?>
    
    <header class="entry-header">
        <h1 class="entry-title"><?php printf( __( 'Search Results for: %s', 'blankslate' ), get_search_query() ); ?></h1>
    </header>
    <div class="mb-offset-2">
        <section class="entry-content mb-col-8">
            <div class="col-content">
                <?php while ( have_posts() ) : the_post(); ?>
                <?php get_template_part( 'entry' ); ?>
                <?php endwhile; ?>
            </div>
        </section>
    </div>
    
<?php else : ?>
    
    <header class="entry-header">
        <h1 class="entry-title"><?php _e( 'Nothing Found', 'blankslate' ); ?></h1>
    </header>
    <div class="mb-offset-2">
        <section class="entry-content mb-col-8">
            <div class="col-content">
                <p><?php _e( 'Sorry, nothing matched your search. Please try again.', 'blankslate' ); ?></p>
                <?php get_search_form(); ?>
            </div>
        </section>
    </div>
    
<?php endif; ?>
    
</section>
<?php get_footer(); ?>