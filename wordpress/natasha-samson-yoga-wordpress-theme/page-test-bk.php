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
<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>

<?php if (has_post_thumbnail($page_id)) { ?>
  <div class="mb-col-12">
    <header id="page-header" class="mb-offset-2">
      <div class="mb-col-8">
        <div class="col-content">
          <h1 id="page-title"><?php the_title(); ?></h1>
            <?php if (is_single()) { ?>
              <p class="article-meta">
                <?php if (has_category( 'events' ) ) {
                  echo get_field('date');
                }
                else { the_time( get_option( 'date_format' ) );
                } ?>
              </p>
            <?php } ?>
          <?php echo get_field('intro'); ?>
        </div>
      </div>
    </header>
    <div class="mb-col-5">
      <div class="col-content">
        <?php echo get_the_post_thumbnail( $page_id, 'full' ); ?>
      </div>
    </div>
    <section id="page-body" role="main"class="mb-col-7">
      <div class="col-content">
        <?php echo get_field('body'); ?>
      </div>
    </section>
  </div>
<?php } ?>

</article>
<?php endwhile; endif; ?>
<?php get_footer(); ?>
