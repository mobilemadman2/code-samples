<?php get_header(); ?>
<section id="content" role="main">
    <header class="entry-header">
        <h1 class="entry-title">Not Found</h1>        
    </header>
    <div class="mb-offset-2">
        <div class="mc-col-8">
            <section class="entry-content col-content">
                <p><?php _e( 'Nothing found for the requested page. Try a search instead?', 'blankslate' ); ?></p>
                <?php get_search_form(); ?>
            </section>
        </div>
    </div>
</section>
<?php get_footer(); ?>