<?php /* banner-page */
$isSingle = is_single();
?>

<div role="main">
  <article id="post-<?php the_ID(); ?>"  <?php post_class(); ?>>
    <header id="page-header" class="mb-offset-2">
      <div class="mb-col-8">
        <div class="col-content center">
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
          <div id="page-intro">
           <?php echo get_field('intro'); ?>
          </div>
        </div>
      </div>
    </header>
    <?php if (has_post_thumbnail( $page_id )) { ?>
      <div class="mb-col-5" id="mb-side-banner">
        <div class="col-content">
          <?php echo get_the_post_thumbnail( $page_id, 'full' ); ?>
        </div>
      </div>
    <?php }
    $maintext = get_field('body');
    if ($maintext != ""){ ?>
      <section id="page-body" role="main" class="mb-col-7">
        <div class="col-content">
          <?php echo $maintext; ?>
        </div>
      </section>
    <?php } ?>
    <section id="page-body-lower" class="mb-offset-2">
       <div class="mb-col-8">
         <div class="col-content">
           <?php echo get_field('body_2'); ?>
         </div>
       </div>
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
