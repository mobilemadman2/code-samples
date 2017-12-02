<?php
/**
 * The sidebar for blog pages.
 * *
 * @package WordPress
 * @subpackage Nutshell
 * @since Nutshell 1.0
 */
?>


<?php if (in_category('3')) { ?>
		
		<aside id='blog-nav' class='inner'>
			<ul>
			<h3>All Nut Blog posts</h3>
			<?php wp_get_archives(array( 'type' => 'postbypost')); ?> 
			</ul>
		</aside>
		
<?php } ?>
