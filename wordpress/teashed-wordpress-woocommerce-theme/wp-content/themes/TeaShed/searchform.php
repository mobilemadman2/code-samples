<form method="get" id="searchform" action="<?php bloginfo('url'); ?>">
<div>
<label for="s"><span class="screen-reader-text">Search the site:</span></label> <input class="text" type="text" placeholder="Type and hit Enter to search" value="<?php if(trim(wp_specialchars($s,1))!='') echo trim(wp_specialchars($s,1));else echo '';?>" name="s" id="s" />
<input type="submit" class="submit" name="Submit" value="Search" />
</div>
</form>