<?php /* default-page */
$isSingle = is_single();
?>

<div role="main" class="mb-offset-2">
  <div class="mb-col-8">

    <article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
      <header id="page-header" class="center">
        <h1 id="page-title"><?php the_title(); ?></h1>
        <?php if ($isSingle) { ?>
          <p class="article-meta">
            <?php if (has_category( 'events' ) ) {
              echo get_field('date');
            }
            else { the_time( get_option( 'date_format' ) );
            } ?>
          </p>
          <?php } ?>
        </header>
        <section id="page-body" role="main">
          <?php echo get_field('intro'); ?>
          <?php echo get_field('body'); ?>
          <?php echo get_field('body_2'); ?>

        </section>
    </article>

    <?php if ($isSingle) { ?>
      <footer class="entry-footer center">
        <span class="cat-links meta">Categories &amp; Tags</span>
        <span class="cats meta"><?php the_category( ', ' ); ?></span>
        <span class="tag-links meta"><?php the_tags( '' ); ?></span>
      </footer>
    <?php } ?>

  </div>
</div>
