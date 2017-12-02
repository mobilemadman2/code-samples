/*
$xs-width: 400px;
$sm-width: 600px;

$sm-med-width: 768px;
$med-width: 960px;

$lrg-width: 1040px;
$max-width: 1200px;
$ultra-width: 1300px;
*/

jQuery(document).ready(function( $ ) {

    $.ajaxSetup({ cache: true });

    var theW = $(window);
    var theNav = $('#nav');
    var theHead, landmark;

    var linkContact = $('#menu-item-122 a');
    var divContact = $('#contact');

    if (Modernizr.touchevents) {
        fInitTouch();
    } else {
        fInitHover();
    }
    fInit();

    function fInitTouch() {}

    function fInitHover() {}

    function fInit() {
      theHead = $('#header');
      if (theHead.hasClass('banner')) {
        var tMaxHeight = theW.height();
        if(theHead.height() > tMaxHeight ) {
          var tImage = theHead.find('#mb-banner img');
          var tGradient = theHead.find('.gradient');
          var tWidth = ($('body').hasClass('page-template-home-page')) ? (tMaxHeight - 40) / 8 * 12: tMaxHeight - 40;
          theHead.css("height", tMaxHeight);
          tImage.css("width", tWidth);
          tGradient.css("width", tWidth);
        }
        landmark = theNav.offset().top;
        if ($('body').hasClass('admin-bar')) landmark -= 30;
        theW.scroll(fCheckPos);
      }

      $('#down a').click(function(){
        $('html, body').animate({
          scrollTop: $("#down").offset().top
        }, 1100);
      });

      $('#menu-item-377 a').html('<span>more <i class="fa fa-ellipsis-v" aria-hidden="true"></i></span><span>less <i class="fa fa-times aria-hidden="true"></i></span>')
      $('#menu-item-377 a').click(function(e){
        e.preventDefault();
        theNav.toggleClass('expanded');
      });


      linkContact.click(fHighlightContact);
      $('article ul li').wrapInner('<span></span>');
      $('#footer h6').wrapInner('<span></span>');
    }

    function fCheckPos() {
      if (theW.scrollTop() < landmark) theHead.removeClass('sticky');
      else theHead.addClass('sticky')
    }

    function fHighlightContact() {
      divContact.addClass('highlight');
      setTimeout(function(){ divContact.removeClass('highlight'); }, 5000);
    }

    setTimeout(function(){
		    var jqTweets = $($('#twitter-widget-0').contents().find('.timeline-TweetList'));
        var twHeight = $('#facebook-widget').height() - 18;
        if (twHeight < 200) twHeight = 200;
        $('#twitter-widget').css("height", twHeight);
        $('#twitter-feed-container').css("height", twHeight -111);
        $('#twitter-feed-container').prepend(jqTweets[0]);

	  },5000);
});
