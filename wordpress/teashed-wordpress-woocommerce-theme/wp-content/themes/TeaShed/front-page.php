<?php
/**
 * The template for the home page
 * *
 * @package WordPress
 * @subpackage TeaShed
 */
?>

<?php get_header(); ?>
<section id="content" role="main">
<?php if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>
<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
    
<div class="row-fluid">
    
    <section class="col-12">
        <div class="col-content" id="banner">
        <?php   
            if ( function_exists( 'soliloquy' ) ) { soliloquy( '131' ); } 
if ( function_exists( 'soliloquy' ) ) { soliloquy( 'banner-2', 'slug' ); }
        ?> 
    </div></section>

 

    <section id="problems" class="clear">
        <h4>Hey! how are You Feeling?<span class="question"><span class="down">&nbsp; &#x25BC;</span><span class="up">&nbsp; &#x25B2;</span></span></h4>
        <ul class="col-12" class="fluid-row clear">
            <li class="col-content"><img src="<?php echo get_template_directory_uri(); ?>/images/problem-1.png" alt="Pick Me Up"  /></li>
            <li class="col-content"><img src="<?php echo get_template_directory_uri(); ?>/images/problem-2.png" alt="Caffine Free Me"  /></li>
            <li class="col-content"><img src="<?php echo get_template_directory_uri(); ?>/images/problem-3.png" alt="Detox Baby"  /></li>
            <li class="col-content"><img src="<?php echo get_template_directory_uri(); ?>/images/problem-4.png" alt="Skinny Love"  /></li>
            <li class="col-content"><img src="<?php echo get_template_directory_uri(); ?>/images/problem-5.png" alt="Flatten My Tum Tum"  /></li>
            <li class="col-content"><img src="<?php echo get_template_directory_uri(); ?>/images/problem-6.png" alt="Prezzies"  /></li>
            <li class="col-content"><img src="<?php echo get_template_directory_uri(); ?>/images/problem-7.png" alt="Bundle Me Up"  /></li>
        </ul>
    </section>
    
    <section id="promos" class="clear" >
        <ul class="fluid-row">
            <li class="col-4"><a class="col-content" href="<?php the_field('promo_link_1'); ?>"><img src="<?php the_field('promo_1'); ?>" /></a></li>
            <li class="col-4"><a class="col-content" href="<?php the_field('promo_link_2'); ?>"><img src="<?php the_field('promo_2'); ?>" /></a></li>
            <li class="col-4"><a class="col-content" href="<?php the_field('promo_link_3'); ?>"><img src="<?php the_field('promo_3'); ?>" /></a></li>
        </ul>
    </section>

    
    <section id="feeds" class="clear">
        
        <div id="twitter" class="col-6">
            <div class="col-content">
                <?php if ( !function_exists('dynamic_sidebar') || !dynamic_sidebar('twitter-sidebar') ) :
                endif; ?>
                <a class="right more" href="https://twitter.com/The_TeaShed" title="The Tea Shed on Twitter" target-"_blank">More...</a>

            </div>
        </div>
        
        <div id="blog" class="col-6">
            <div class="col-content">
                <?php $latest = new WP_Query( array( 'posts_per_page' => 1 ));  
                if( $latest->have_posts() ) : ?>
               
                <?php while( $latest->have_posts() ) : $latest->the_post(); ?>
                <a href="<?php the_permalink(); ?>">
                    <div class="latest-post">
                        <?php 
                            if ( has_post_thumbnail() ) { // check if the post has a Post Thumbnail assigned to it.
                                the_post_thumbnail(array(100, 100));
                            } 
                        ?>
                        <h5><?php the_title(); ?></h5>
                        <?php the_excerpt(); ?>
                        
                    </div>
                </a>
                <?php endwhile; ?>
                <?php endif; wp_reset_postdata(); ?>
            </div>
        </div>
        
    </section>
        
    <section id="press">
        <ul class="col-12" class="fluid-row">
            <li class="col-content"><img src="<?php echo get_template_directory_uri(); ?>/images/press-1.png" alt="Living"  /></li>
            <li class="col-content"><img src="<?php echo get_template_directory_uri(); ?>/images/press-2.png" alt="Times"  /></li>
            <li class="col-content"><img src="<?php echo get_template_directory_uri(); ?>/images/press-3.png" alt="Telegraph"  /></li>
            <li class="col-content"><img src="<?php echo get_template_directory_uri(); ?>/images/press-4.png" alt="Closer"  /></li>
            <li class="col-content"><img src="<?php echo get_template_directory_uri(); ?>/images/press-5.png" alt="BBC"  /></li>
            <li class="col-content"><img src="<?php echo get_template_directory_uri(); ?>/images/press-6.png" alt="Closer"  /></li>
        </ul>
    </section>
    
    <ul>
        <li id="tea-queen" class="col-4">
            <div class="col-content">
                <img src="<?php echo get_template_directory_uri(); ?>/images/queen.png" alt="Tea Queen"  />
            </div>
        </li>
        <li id="insta" class="col-8">
            <div class="col-content">
                <img src="<?php echo get_template_directory_uri(); ?>/images/instagram.png" alt="Instagram"  />
                <?php if ( !function_exists('dynamic_sidebar') || !dynamic_sidebar('homepage-sidebar') ) :
                endif; ?>
            </div>
        </li>
    </ul>
    
    
    
</div>    
    
</section>
</article>
<?php endwhile; endif; ?>
</section>
<?php get_footer(); ?>