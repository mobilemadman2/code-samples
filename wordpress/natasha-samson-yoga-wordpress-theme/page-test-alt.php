<?php
/**
 * Template Name: Test Page
 *
 * @package WordPress
 * @subpackage Natasha
 */
?>

<?php get_header(); ?>
<?php if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>
  <header id="page-header">
    <?php if (has_post_thumbnail($page_id)) echo get_the_post_thumbnail( $page_id, 'full' ); ?>
    <div id="mb-frame"><div class="gradient"></div></div>
    <div class="mb-col-5">
        <h1 id="page-title"><?php the_title(); ?></h1>
           <?php if (is_single()) { ?>
             <p class="article-meta">
               <?php if (has_category( 'events' ) ) {
                 echo get_field('date');
               }
               else {
                 the_time( get_option( 'date_format' ) );
               } ?>
             </p>
           <?php } ?>
           <?php echo get_field('intro'); ?>
         </div>
  </header>
</div></div>
  <article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
    <div role="main" class="mb-offset-2">
      <div class="mb-col-8">
        <section id="page-body" role="main" class="col-content">
          <?php echo get_field('body'); ?>
        </section>
      </div>
    </div>
  </article>
<?php endwhile; endif; ?>
<?php get_footer(); ?>
