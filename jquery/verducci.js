(function ($) {
	$(document).ready(
		function () {
			$(".nav-client-login, .nav-client-login-wrapper > a").fancybox({
				helpers: {
					overlay: {
						locked: false
					}
				}
			});

			$('#intro h1').addClass('slide-in');
			$('#intro h2').addClass('slide-in');

			// utils
			function preloadImg(imgUrl) {
				$('<img/>')[0].src = imgUrl;
			}

			//end utils

			// Blog scripts
			$('#blog-sidebar aside').click(function () {
				$(this).siblings('aside').removeClass('open');
				$(this).toggleClass('open');
			});
			// end Blog scripts

			// home scripts
			if ($('body').hasClass('home'))
			{
				$($('#page').find('.content-area')[0]).attr('id', 'home');
			}
			// end home scripts

			// services scripts
			function fHardSetHeight(jqObject) {
				var nHeight = jqObject.outerHeight();
				jqObject.css('height', nHeight);
			}

			$('.features .row, .table.packages .row').each(function () {
				fHardSetHeight($(this));
			});
			$(window).resize(function () {
				$('.features .row, .table.packages .row').css('height', 'auto');
				$('.features .row, .table.packages .row').each(function () {
					fHardSetHeight($(this));
				});
			});
			// end services scripts

			// gallery scripts
			$(".gallery-item a").attr('rel', 'gallery-group');
			$(".gallery-item a").fancybox({
				helpers: {
					overlay: {
						locked: false
					}
				}
			});
			// end gallery scripts

			// resources scripts
			$(".resource-item").fancybox({
				helpers: {
					overlay: {
						locked: false
					}
				}
			});
			// end resources scripts

			// Team scripts (need on who_is_vep page)
			$('li.team').each(function () {
				var altBG = $(this).attr("data-alt-img");
				if (altBG)
				{
					preloadImg(altBG);
					altBG = 'url(' + altBG + ')';
					var regBG = $(this).css("background-image");
					$(this).attr("data-reg-img", regBG);
					$(this).mouseenter(function () {
						$(this).css('background-image', altBG);
					});
					$(this).mouseleave(function () {
						$(this).css('background-image', regBG);
					});
				}
			});
			// end team scripts


			// navigation scripts
			$(window).scroll(function () {
				if ($(window).scrollTop() > $(window).height() - 500) $('#anchor').addClass('visible');
				else $('#anchor').removeClass('visible');
			});
			$('#anchor').click(function () {
				event.preventDefault();
				$('html, body').animate({scrollTop: 0}, 500);
			});

			var url = window.location.pathname.split('.com');
			if ($('.sub-header').length > 0)
			{
				// maybe only used on special pages
				$(window).scroll(function () {
					if ($(window).scrollTop() > $(window).height() - 208)
					{
						$('#page .sub-header').addClass('vee');
					}
					else
					{
						$('#page .sub-header').removeClass('vee');
					}
					if ($(window).scrollTop() > $(window).height() - 48)
					{
						$('#header .sub-header').addClass('sticky');
						$('#header .sub-header').fadeIn();
					}
					else
					{
						$('#header .sub-header').hide();
						$('#header .sub-header').removeClass('sticky');
					}
				});
				$('.sub-header a').each(function () {
					var href = $(this).attr('href');
					if (href.indexOf('#') > -1 && href.split('#')[0] == url)
					{
						$(this).click(function (event) {
							event.preventDefault();
							var id = '#'.concat(href.split('#')[1]);
							$('.sub-header li').removeClass('current-section-item');
							$(this).parent().addClass('current-section-item');
							$('section').removeClass('focus');
							$(id).addClass('focus');
							$('html, body').animate({scrollTop: $(id).offset().top}, 700, function () {
								//$(id).addClass('focus');
							});
						});
					}
				});
				$('a.btn').each(function () {
					var href = $(this).attr('href');
					if (href.indexOf('#') > -1 && href.split('#')[0] == url)
					{
						$(this).click(function (event) {
							event.preventDefault();
							var id = '#'.concat(href.split('#')[1]);
							$('section').removeClass('focus');
							$(id).addClass('focus');
							$('html, body').animate({scrollTop: $(id).offset().top}, 500, function () {
								//$(id).addClass('focus');
							});
						});
					}
				});
			}
			$('#header a').each(function () {
				var href = $(this).attr('href');
				if (href.indexOf('#') > -1 && href.split('#')[0] == url)
				{
					$(this).click(function (event) {
						event.preventDefault();
						var id = '#'.concat(href.split('#')[1]);
						$('#header li').removeClass('current-section-item');
						$(this).parent().addClass('current-section-item');
						$('html, body').animate({scrollTop: $(id).offset().top}, 1000);
					});
				}
			});
			$('.mobile-nav').click(function () {
				$('#nav .menu-header').toggle();
				return false;
			});
			// end navigation scripts

			// carousel scripts (eg testimonials)
			var jqCarousels = $('.carousel');
			if (jqCarousels.length > 0)
			{
				var timers = [];
				jqCarousels.each(function () {
					var iCarousel = getCarouselIndex(this);
					timers[iCarousel] = setTimeout(fShowItem, 2000, $(this), 0, iCarousel);
					/*$(this).find('.row').each(function() {
					 var imgUrl = $($(this).find('.row')[0]).attr("data-img");
					 if (imgUrl) preloadImg(imgUrl);
					 });*/
				});

				function getCarouselIndex(carousel) {
					return jqCarousels.index(carousel);
				}

				$('.carousel .btns li').click(function () {
					var jqParent = $(this).closest('.carousel');
					var jqBtns = jqParent.find('.btns li');
					var iCarousel = getCarouselIndex(jqParent);
					clearTimeout(timers[iCarousel]);
					fShowItem(jqParent, jqBtns.index(this), iCarousel);
				});

				function fShowItem(carousel, index, iCarousel) {
					var slides = carousel.find('.container li');
					var btns = carousel.find('.btns li');

					slides.each(function () {
						$(this).removeClass('active')
					});
					$(slides[index]).addClass('active');
					/*var imgUrl = $(slides[index]).attr('data-img');
					 if (imgUrl) {
					 imgUrl = 'url(' + imgUrl + ')';
					 carousel.closest('.bg-image').css('background-image', imgUrl);
					 }*/
					btns.each(function () {
						$(this).removeClass('active')
					});
					$(btns[index]).addClass('active');

					var newIndex = (index > btns.length - 2) ? 0 : index + 1;
					timers[iCarousel] = setTimeout(fShowItem, 5000, carousel, newIndex, iCarousel);
				}
			}
			// end carousel scripts

			// Sliders scripts (eg clients)
			var jqSliders = $('.slider');
			if (jqSliders.length > 0)
			{
				var timers2 = [];
				jqSliders.each(function () {
					var jqThis = $(this);
					var sHtml = jqThis.html();

					jqThis.prepend(sHtml);

					var jqLI = $(jqThis.find('li'));
					var jqUL1 = $(jqThis.find('ul')[0]);
					var jqUL2 = $(jqThis.find('ul')[1]);

					var jqItems = jqUL1.find('li');

					var nFrameWidth = jqThis.outerWidth();
					var nSingleWidth = $(jqItems[0]).outerWidth();
					var nTotalWidth = nSingleWidth * jqItems.length;

					jqLI.css('width', nSingleWidth); // all li
					jqUL1.css('width', nTotalWidth);
					jqUL2.css('width', nTotalWidth);

					var nStart = nTotalWidth;
					var nEnd = -1 * nTotalWidth;
					var nTime = nTotalWidth / 0.1;

					jqUL1.css('left', 0);
					jqUL2.css('left', nStart);
					fSlide(jqUL1, jqUL2, nEnd, nStart, nTime);
				});

				function fSliderWidth(slider) {
					return $(slider).find('li').width();
				}

				function getSliderIndex(slider) {
					jqSliders.index(slider);
				}

				function fSlide(group1, group2, end1, start, time) {
					group1.animate({
						left: end1
					}, time, 'linear', function () {
						//on complete, switch the groups and go again
						group1.css('left', start);
						fSlide(group2, group1, end1, start, time);
					});
					group2.animate({
						left: 0
					}, time, 'linear', function () {
					});
				}
			}
			// end Sliders scripts

			// Video scripts
			$('#video .col-lg-8').each(function () {
				if ($(this).height() > $(window).height() - 135)
				{
					maxWidth = ($(window).height() - 135) / 0.5625;
					$(this).css('max-width', maxWidth);
				}
			});
			// end Video scripts

			// Clients logos carousel
			$('#clients-carousel').slick({
				infinite: true,
				autoplay: true,
				autoplaySpeed: 3000,
				arrows: false,
				slidesToShow: 5
			});
			// end Clients logos carousel
		}
	);
})(jQuery);
