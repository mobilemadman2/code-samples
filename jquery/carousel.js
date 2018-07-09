(function($) {
	$('.carousel').each(function() {
		var jqThis = $(this);
		var jqItems = $(this).find('li');
		jqThis.append('<ul class="carousel-controls"></ul><span class="prev"><i class="fa fa-chevron-circle-left"></i></span><span class="next"><i class="fa fa-chevron-circle-right"></i></span>');
		var jqControls = jqThis.find('.carousel-controls');
 		var i = 0;
		while (i < jqItems.length) {
			jqControls.append('<li></li>');
			i=i+3;
		}
		jqControls = jqControls.find('li');
		$(jqControls[0]).addClass('on');
		$(jqItems[0]).addClass('on');
		$(jqItems[1]).addClass('on');
		$(jqItems[2]).addClass('on');
		var interval = 24000;
		var iCarousel = 0;
		var direction = 1;
		var timer = setTimeout(carousel, interval);

		jqControls.click(function() {
			iCarousel = jqControls.index(this)-direction;
			carousel();
		});

		jqThis.find('.prev').click(function() {
			direction = -1;
			carousel();
		});

		jqThis.find('.next').click(function() {
			direction = 1;
			carousel();
		});

		function carousel() {
			window.clearTimeout(timer);
			iCarousel = iCarousel+direction;
			if (iCarousel > jqControls.length-1) iCarousel = 0;
			else if (iCarousel < 0) iCarousel=jqControls.length -1;
			jqControls.removeClass('on');
			jqItems.removeClass('on');
			$(jqControls[iCarousel]).addClass('on');
			$(jqItems[3*iCarousel]).addClass('on');
			$(jqItems[(3*iCarousel)+1]).addClass('on');
			$(jqItems[(3*iCarousel)+2]).addClass('on');
			timer = setTimeout(carousel, interval);
		}
	});
})(jQuery);
