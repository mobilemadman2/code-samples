    <header class="entry-header">
        <h1 class="entry-title"><?php the_title(); ?></h1>
    </header>
    <div class="mb-offset-2">
        <article class="mb-col-8">    
            <section class="entry-content col-content person">
                <?php if ( has_post_thumbnail() ) { the_post_thumbnail(); } ?>
                <?php the_content(); ?>
                <dl class="class_meta">
                    <?php $term_teachers = wp_get_post_terms( $post->ID, 'public_class_teacher' );
                    echo '<dt>Teacher:</dt><dd>' . $term_teachers[0]->name . '</dd>'; ?>
                    <dt>Class Times:</dt>
                    <dd>
                        <?php $term_days = wp_get_post_terms( $post->ID, 'public_class_day' );
                        foreach($term_days as $term_day) {
                            echo $term_day->name . ', ';
                        }
                        $term_times = wp_get_post_terms( $post->ID, 'public_class_time' );
                        echo $term_times[0]->name; ?>
                    </dd>
                    <?php $term_price = wp_get_post_terms( $post->ID, 'public_class_price' ); ?>
                    <?php echo '<dt>Class Price:</dt><dd>' . $term_price[0]->name . ', <em>' . $term_price[0]->description . '</em></dd>'; ?>
                    <dt>Location:</dt>     
                    <?php $term_locations = wp_get_post_terms( $post->ID, 'public_class_location' );
                    echo '<dd>' . $term_locations[0]->name . '</dd>'; ?>
                </dl>
            </section>
            <section class="entry-extra col-content">
                <?php $term_teachers = wp_get_post_terms( $post->ID, 'public_class_teacher' ); ?>
                <h2><?php echo $term_teachers[0]->name;  ?></h2>
                <?php echo $term_teachers[0]->description;  ?>
            </section>
        </article>
    </div>