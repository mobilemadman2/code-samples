<?php get_header(); ?>
<section id="content" role="main">
    
    <?php if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>
    <?php include('includes/public-offering-content.php');  ?>
    <?php endwhile; endif; ?>
    
    <aside class="mb-col-12 grid-container">
        <div class="col-content">
            <?php include('includes/public-offerings-list.php');  ?>
        </div>
    </aside>
    
</section>
<?php get_footer(); ?>