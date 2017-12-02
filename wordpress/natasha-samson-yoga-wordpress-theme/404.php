<?php get_header(); ?>
<div role="main" class="mb-offset-2">
  <div class="mb-col-8">
    <article id="not-found" class="col-content">
      <header id="page-header">
       <h1 id="page-title">Oops that page doesn't exist...</h1>
      </header>

      <section id="page-body" role="main">
        <h3>Try a search instead?</h3>
         <?php get_search_form(); ?>
      </section>
    </article>
  </div>
</div>
<?php get_footer(); ?>


<?php /* echo get_svg( 'arrow-right' ) */ ?> 
