<?php get_header(); ?>

<header id="page-header" class="mb-col-12 center">
  <h1 class="entry-title col-content">
    <?php $pageTitle = 'Blog Posts';
    if ( is_search() ) { $pageTitle = 'You searched for: ' . get_search_query(); }
    else if ( is_category() ) $pageTitle = single_cat_title('Blog Category: ', false);
    else if ( is_tag() ) $pageTitle =  single_tag_title('Blog Tag: ', false);
    else if ( is_archive() ) { /*$pageTitle =  "Blog Posts"; */ }
    else query_posts('cat=-25,-37,-48');
    echo $pageTitle; ?>
    </h1>
</header>

<section id="children" role="main">
  <ul>
    <?php get_template_part( 'the-loop' ); ?>
  </ul>
</section>

<aside id="cat-menu" role="complementary" class="mb-col-12">
  <div class="col-content">
    <h5 class="cat-links center">Browse the Blog by Category</h5>
    <ul>
      <?php wp_list_categories (array('title_li' => '', 'exclude'  => array( 48 ))); ?>
    </ul>
  </div>
</aside>

<?php wp_reset_query(); ?>
<?php get_footer(); ?>
