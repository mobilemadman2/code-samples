</div><!-- #page -->

<footer id="footer" role="contentinfo">
  <div class="container">

    <!--div class="mb-col-6 large-right">
      <h5 class="mb-col-content">Connect via social media</h5>
    </div-->
    <!--section class="mb-col-3 large-right">
      <div id="facebook-widget" class="col-content">
      </div>
    </section-->
    <section id="twitter-widget" class="mb-col-6 large-right clear-right">
      <div class="col-content">
        <h6 class="fa fa-twitter"></h6>
      </div>
    </section>
    <!-- -->
    <div class="mb-col-6">
      <h5 class="col-content"><a href="/natasha" title="homepage"><strong>Home</home></strong></a> | Explore Natasha Samson Yoga</h5>
    </div>
    <nav id="footer-menu" role="navigation" class="mb-col-2">
      <?php wp_nav_menu( array( 'theme_location' => 'footer-menu', 'menu_class' => 'col-content' ) ); ?>
    </nav>
    <nav id="footer-categories"  role="navigation" class="mb-col-2">
      <div class="col-content">
        <a href="<?php echo esc_url( get_permalink( get_option( 'page_for_posts' ) ) ); ?>" title="view the latest blog posts"><strong>Blog posts</strong></a>
        <?php wp_list_categories (array('title_li' => '')); ?>
      </div>
    </nav>
    <nav id="footer-tags"  role="navigation" class="mb-col-2">
      <div class="col-content">
        <span><strong>Popular tags:&nbsp;</strong></span><?php wp_tag_cloud( array( 'smallest' => 12, 'largest' => 16, 'number' => 36, 'separator' => ', ' )); ?>
      </div>
    </nav>
    <!-- -->
    <section id="bottom"  class="mb-col-12">
      <p id="copyright" class="col-content ">
        <small>&copy; <strong><?php echo get_bloginfo( 'name' ) ?></strong> , all rights reserved |&nbsp;WordPress&nbsp;theme by&nbsp;<a href="http://marianne.digital/" target="_blank"><em>Marianne&nbsp;Butler</em></a></small></p>
    </section>

  </div>
</footer>

<?php wp_footer(); ?>

</body>
</html>
