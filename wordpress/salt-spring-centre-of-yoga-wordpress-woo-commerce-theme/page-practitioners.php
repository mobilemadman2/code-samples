<?php get_header(); ?>
<section id="content" role="main" class="bg-image">
<?php if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>
<article <?php post_class(); ?>>
<section class="entry-content">
    <?php if ( has_post_thumbnail() ) { the_post_thumbnail(); } ?>
    <header class="entry-header">
        <h1 class="entry-title"><?php the_title(); ?></h1>
        <aside id="page-menu">
            <ul>
                <li><a href="/about" title="About">About CSWC</a></li>
                <li><a href="/treatments#ayurvedic" title="Ayurvedic Treatments">Ayurvedic Treatments</a></li>
                <li><a href="/treatments#health" title="Health Treatments">Health Treatments</a></li>
                <li><a href="/guidelines" title="Guidelines">Guidelines</a></li>
                <li><a href="/practitioners" title="Practitioners">Practitioners</a></li>
            </ul>
        </aside>
    </header>
    <div class="mb-offset-2" id="practitioners">
        <?php $args = array( 'post_type' => 'sm_practitioner', 'posts_per_page' => 10 );
        $loop = new WP_Query( $args );
        while ( $loop->have_posts() ) : $loop->the_post(); ?>
        <div class="mb-col-8 practitioner person">
            <div class="col-content">
                <?php if ( has_post_thumbnail() ) { the_post_thumbnail(); } ?>
                <h2><?php the_title(); ?></h2>
                <?php the_content(); ?>
            </div>
        </div>
        <?php endwhile; ?>
    </div>
</section>
<?php endwhile; endif; ?>
</article>
</section>
<?php get_sidebar(); ?>
<?php get_footer(); ?>

