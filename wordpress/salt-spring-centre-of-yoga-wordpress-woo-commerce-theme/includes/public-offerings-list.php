<div id="sub-header">
    <h2>
        <?php $meta = get_post_meta( '202', 'current_week', 0 ); 
        echo $meta[0]; ?>
    </h2>
</div>
<ul class="grid"> 
    <?php $args = array(
    'taxonomy' => 'public_class_day',
    'orderby' => 'id',
    'show_count' => 0,
    'pad_counts' => 0,
    'hierarchical' => 1,
    'echo' => 0
    );?>
    <?php $class_days = get_categories( $args ); 
    foreach ( $class_days as $class_day ) { 
        echo '<li class="mb-col-4 parent"><div class="col-content"><h3>' . $class_day->name . '</h3><ul>';    
        // The Query
        $classArgs = array('post_type' => 'sm_class', 'public_class_day' => $class_day->name);
        $daysClasses = get_posts($classArgs);
        foreach ( $daysClasses as $post ) : setup_postdata( $post );
            echo '<li><a href="';
            the_permalink();
            echo '">';
            $term_times = wp_get_post_terms( $post->ID, 'public_class_time' );
            echo '<strong>' . $term_times[0]->name . ':</strong> ';
            echo '<span class="class-name">';
            the_title();
            echo '</span> <span class="class-location">in the ';     
            $term_locations = wp_get_post_terms( $post->ID, 'public_class_location' );
            echo $term_locations[0]->name .'</span> ';
            //$term_prices = wp_get_post_terms( $post->ID, 'public_class_price' );
            //echo ' &#40;' . $term_prices[0]->name . '&#41; ';
            $term_teachers = wp_get_post_terms( $post->ID, 'public_class_teacher' );
            echo ' &#126;&nbsp;<em>' . $term_teachers[0]->name . '</em></a>';        
            //echo '<div class="lightbox">';
            //include('public-offering-content.php');
            //echo '</div>';
            echo '</li>';
        endforeach; 
        wp_reset_postdata();
        echo '</ul></li>';
    } ?> 
</ul>