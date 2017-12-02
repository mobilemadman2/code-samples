jQuery('document').ready(function() {
	setTimeout(function(){
		var jqTweets = jQuery(jQuery('#twitter-widget-0').contents().find('.h-feed'));
		jQuery('#twitter-feed-container').html(jqTweets[0]);
		jQuery('#twitter-feed-container').css("height", "auto");
	},5000);
});