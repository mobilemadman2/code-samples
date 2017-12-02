<?php if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>
  <li class="mb-col-4">
    <article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
      <a href="<?php the_permalink() ?>" title="read the full post: <?php the_title(); ?>">
        <div class="img-container">
          <?php if (has_post_thumbnail()) echo get_the_post_thumbnail( $post->ID, 'square-thumbnail' );
          else echo '<img src="http://natashasamsonyoga.com/wp-content/uploads/2016/06/placeholder.jpg" />';?>
        </div>
        <div class="text-container center">
          <header class="article-header">
            <h2><?php the_title(); ?></h2>
            <span class="article-meta">
              <?php if (has_category( 'events' ) ) {
                echo get_field('date');
              }
              else { the_time( get_option( 'date_format' ) );
              } ?>
            </span>
          </header>
          <section>
            <?php
            echo '<span class="teaser">' . get_field('teaser') .'</span>'; ?>
            <span class="more">read the full post <?php echo get_svg('arrow-right'); ?></span>
          </section>
        </a>
      </div>
    </article>
  </li>
<?php endwhile; endif; ?>
