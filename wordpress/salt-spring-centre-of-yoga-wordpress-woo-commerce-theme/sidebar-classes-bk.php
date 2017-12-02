<?php $args = array(
  'taxonomy' => 'public_class_day',
  'orderby' => 'id',
  'show_count' => 0,
  'pad_counts' => 0,
  'hierarchical' => 1,
  'echo' => 0
);?>

<h4 class="col-content">
<?php $meta = get_post_meta( '202', 'current_week', 0 ); 
echo $meta[0]; ?>
</h4>
<ul class="col-content"> 
    <?php $class_days = get_categories( $args ); 
    foreach ( $class_days as $class_day ) { 
        echo '<li><h5>' . $class_day->name . '</h5><ul>';    
        // The Query
        $classArgs = array('post_type' => 'sm_class', 'public_class_day' => $class_day->name);
        $daysClasses = get_posts($classArgs); //change this
        foreach ( $daysClasses as $post ) : setup_postdata( $post );
            echo '<li><a href="';
            the_permalink();
            echo '">';
            the_title();
            echo '</a>, ';
            $term_times = wp_get_post_terms( $post->ID, 'public_class_time' );
            echo $term_times[0]->name;
            echo '</li>';
        endforeach; 
        wp_reset_postdata();
        echo '</ul></li>';
    } ?> 
</ul>