<?php get_header(); ?>
<section id="content" role="main" class="bg-image center maximize">
<?php if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>
<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
<section class="entry-content">
    <header class="entry-header">
        <h1 class="entry-title"><?php the_title(); ?></h1>
    </header>
    <?php if ( has_post_thumbnail() ) { the_post_thumbnail(); } ?>
    <?php include('includes/public-offerings-list.php');  ?>
</section>
</article>
<?php endwhile; endif; ?>
</section>
<?php get_footer(); ?>