jQuery('document').ready(function() {
	var jqGallery = jQuery('.banner .gallery');
	if(jqGallery.length > 0 ) {
		var jqLinks = jQuery('.gallery a');
		//var theWidth = jqLinks.width();
		//jQuery('.gallery-item').css('width', theWidth.toString());
		//var galleryWidth = theWidth * jqLinks.length;
		//jqGallery.css('width', galleryWidth.toString());
		var jqItems = jQuery('.gallery-item');
		for (var i=1; i<jqItems.length; i++) {
			jQuery(jqItems[i]).addClass('hidden');
		}
		
		var currentPos = -1; 
		jQuery(jqGallery.parent()).append('<div id="image-container" class="loading"></div>');
		jQuery('.gallery a').each( function(){
			jQuery('#image-container').append('<div></div>');
		});
		
		var jqContainers = jQuery('#image-container div');
		
		jqLinks.click(function(e){ e.preventDefault(); });
		
		function nextImage() {
			myTimer = setTimeout(function() { 
				var t_i = currentPos+1;
				if (t_i == jqLinks.length) t_i =0;
				addImage(jqLinks[t_i]);
			}, 3000);
		}
		
		function addImage(url) {
			if(position == currentPos) return;
			clearTimeout(myTimer);
			var position = jqLinks.index(jQuery(url));
			jQuery(jqContainers[position]).html('<img id="img_' + position + '" src="' + url +'" />');
			jQuery("#img_" + position.toString()).bind('load', function() {
				fadeImage(position);
			});
		}
		
		function fadeImage(position) {
			if (currentPos > -1) jQuery(jqContainers[currentPos]).fadeTo(1000, 0);
			currentPos = position;
			jQuery(jqContainers[currentPos]).fadeTo(1000, 1);
			if (jqContainers.length > 1) nextImage();
		}
		
		var myTimer = setTimeout(function(){
			addImage(jqLinks[0]);
		},10);
		
	}
});