<?php get_header(); ?>
<?php $term = get_term_by( 'slug', get_query_var( 'term' ), get_query_var( 'taxonomy' ) );?>
<section id="content" role="main">
    <header class="entry-header">
        <h1 class="entry-title">
        <?php echo $term->name; ?>
        </h1>
    </header>
    <div class="mb-offset-2">
        <article class="mb-col-8">        
            <div class="col-content">
                <?php echo $term->description; ?>
            </div>
            <ul class="class_meta expandable">
                <?php if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>
                <li>
                    <div class="col-content">
                        <h3 class="entry-title"><?php the_title(); ?></h3>
                        <p>
                            <strong>
                                <?php $term_days = wp_get_post_terms( $post->ID, 'public_class_day' );
                                foreach($term_days as $term_day) {
                                    echo $term_day->name . ', ';
                                }
                                $term_times = wp_get_post_terms( $post->ID, 'public_class_time' );
                                echo $term_times[0]->name . ', '; ?>
                            </strong>
                            <span class="class-location">in the     
                                <?php $term_locations = wp_get_post_terms( $post->ID, 'public_class_location' );
                                echo $term_locations[0]->name . '.' ; ?>
                            </span>
                            <br />
                            <span class="class-price">
                                <?php $term_prices = wp_get_post_terms( $post->ID, 'public_class_price' );
                                echo $term_prices[0]->name . ' <span class="description">(' . $term_prices[0]->description . ')</span>'; ?>
                            </span>
                        </p>
                    </div>
                    <?php the_content(); ?>
                </li>
                <?php endwhile; endif; ?>
            </ul>
        </article>
    </div>    
    <aside class="mb-col-12 grid-container">
        <div class="col-content">
            <?php include('includes/public-offerings-list.php');  ?>
        </div>
    </aside>
        
</section>
<?php get_footer(); ?>