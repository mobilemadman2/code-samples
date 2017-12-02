<div id="mb-banner">
  <?php if (has_post_thumbnail($page_id)) echo get_the_post_thumbnail( $page_id, 'full' );
  <div id="mb-frame"><div class="gradient"></div></div>
  <h1><?php echo esc_html( get_bloginfo( 'name' ) ); ?></h1><h2><?php echo esc_html( get_bloginfo( 'description' ) ); ?></h2>
</div>
