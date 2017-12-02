<?php get_header(); ?>
<section id="content" role="main" class="bg-image dyad">
    <?php if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>
    <article id="post-<?php the_ID(); ?>">
        <header class="entry-header">
            <h1 class="entry-title"><?php the_title(); ?></h1>
            <aside id="page-menu">
                <ul>
                    <li><a href="#ayurvedic" title="Ayurvedic Treatments">Ayurvedic Treatments</a></li>
                    <li><a href="#health" title="Health Treatments">Health Treatments</a></li>
                    <li><a href="/about" title="About">About CSWC</a></li>
                    <li><a href="/guidelines" title="Guidelines">Guidelines</a></li>
                    <li><a href="/practitioners" title="Practitioners">Practitioners</a></li>
                </ul>
            </aside>
            
        </header>
        <div class="mb-offset-2">
            <section class="entry-content mb-col-8">
                <h2 id ="ayurvedic" class="col-content">Ayurvedic Treatments</h2>
                <?php echo do_shortcode( '[product_category category="ayurvedic-treatments" columns=1]' ); ?>
                <h2 id="health" class="col-content">Health Treatments</h2>
                <?php echo do_shortcode( '[product_category category="health-treatments" columns=1]' ); ?>
            </section>
        <div>    
    </article>
    <?php if ( has_post_thumbnail() ) { the_post_thumbnail(); } ?>
    <?php endwhile; endif; ?>
</section>
<?php get_footer(); ?>