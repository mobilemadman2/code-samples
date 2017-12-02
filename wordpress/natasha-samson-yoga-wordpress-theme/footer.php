</div><!-- #page -->

<footer id="footer" role="contentinfo">
<div class="container">

<section id="contact" class="mb-col-4">
  <div class="col-content">
    <h6>Contact</h6>
    <p>e: <a href="mailto:admin@natashasamsonyoga.com" title="email natasha">admin@natashasamsonyoga.com</a></p>
    <?php list_social_icons(''); ?>
  </div>
</section>

<section id="social-feeds" class="mb-col-6">
  <div class="col-content">
    <h6>Social Media</h6>
    <div id="facebook-widget">
	     <?php include('includes/facebook-feed.php'); ?>
    </div>
    <div id="twitter-widget">
      <?php include('includes/twitter-feed.php'); ?>
      <header>
        <i class="fa fa-twitter"></i><a href="https://twitter.com/natashasyoga" title="@natashasyoga"><span class="username">@natashasyoga</span></a>
      </header>
      <div id="twitter-feed-container"></div>
      <footer>
        <a id="follow-link" class="button" href="https://twitter.com/natashasyoga" title="@natashasyoga">Find us on Twitter <span class="bigger">&nbsp;&nbsp;&gt;</span></a>
      </footer>
    </div>
    <div id="instagram-widget">
	     <?php include('includes/instagram-feed.php'); ?>
       <a id="instagram-badge" title="find us on Instagram" href="https://instagram.com/natashasyoga"><img src="<?php echo get_template_directory_uri(); ?>/images/instagram.png" alt="instagram"/></a>
    </div>
  </div>
</section>

<section id="mailchimp" class="mb-col-4">
  <div class="col-content">
    <?php include('includes/mailchimp.php'); ?>
  </div>
</section>

<!-- -->
<section id="bottom" class="mb-col-12">
  <div id="copyright" class="col-content ">
    <h6>&copy; <?php echo get_bloginfo( 'name' ) ?></h6>
    <small>all rights reserved. WordPress&nbsp;theme by&nbsp;<a href="http://marianne.digital/" target="_blank"><em>Marianne&nbsp;Butler</em></a></small>
  </div>
</section>

</div>
</footer>

</div><!-- #wrapper -->

<?php wp_footer(); ?>

</body>
</html>
