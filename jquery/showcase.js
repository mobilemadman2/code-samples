

jQuery(document).ready(

  function () {

    var slides = jQuery(".showcase .slide");
    var numSlides = slides.length;
    var nextIndex = 0;

    var reverse = false;

    var nextSlide;
    var previousSlide;
    var currentSlide = jQuery(slides[0]);
    currentSlide.addClass('theSlide');

    var theTimer;

    var slashField = jQuery('.showcase #slash');
    var dynamicField = jQuery('.showcase #counter');
    var totalField = jQuery('.showcase #total');

    totalField.html(numSlides);
    setCounter(nextIndex+1);
    theTimer = setTimeout(slideNow, 3000);

    slides.find("img").one("load", function() {
      if(jQuery(this).height() / jQuery(window).height() < 1) {
        fullHeight(this);
        centerSlide(this);
      }
    }).each(function() {
      if(this.complete) jQuery(this).load();
    });

    jQuery(window).resize(function() {
      slides.find("img").each(function() {
        if(jQuery(this).height() / jQuery(window).height() < 1) fullHeight(this);
        else if(jQuery(this).width() / jQuery(window).width() < 1) fullWidth(this);
        centerSlide(this);
      });
    });

    function centerSlide(image) {
      var nLeft = 0.5 * (jQuery(window).width() - jQuery(image).width());
      jQuery(image).closest('.slide').css('left', nLeft);
    }

    function setNextSlide() {
      if (reverse) {
        nextIndex -= 1;
        if (nextIndex == -1) nextIndex = numSlides -1;
      }
      else {
        nextIndex += 1;
        if (nextIndex == numSlides) nextIndex = 0;
      }
      nextSlide = jQuery(slides[nextIndex]);
    }

    function slideNow() {
      setNextSlide();

      if (previousSlide) previousSlide.removeClass('previousSlide');

      currentSlide.addClass('previousSlide');
      currentSlide.removeClass('theSlide');
      previousSlide = currentSlide;

      nextSlide.addClass('theSlide');
      currentSlide = nextSlide;
      setCounter(nextIndex);

      theTimer = setTimeout(slideNow, 3000);
    }

    function setCounter() {
      dynamicField.html(nextIndex +1);
    }

    function fullHeight(image) {
      jQuery(image).css('height', '100%');
      jQuery(image).css('width', 'auto');
    }
    function fullWidth(image) {
      jQuery(image).css('width', '100%');
      jQuery(image).css('height', 'auto');
    }

    totalField.click(function() {
      clearTimeout(theTimer);
      if (reverse) {
        reverse = false;
        slashField.html('\/');
      }
      slideNow();
    });

    dynamicField.click(function() {
      clearTimeout(theTimer);
      if (!reverse) {
        reverse = true;
        slashField.html('\\');
      }
      slideNow();
    });
  }
);
