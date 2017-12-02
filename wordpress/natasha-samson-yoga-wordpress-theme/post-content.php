<?php if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>

<?php if (has_post_thumbnail() && !is_page('classes')) {
  get_template_part('banner-page');
} else {
  get_template_part('default-page');
} ?>

<?php endwhile; endif; ?>
