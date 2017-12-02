

jQuery(document).ready(
  function () {
    var isTouch = ('ontouchstart' in document.documentElement);
    var toolTip = jQuery('#map-tooltip');
    var jqRegions = jQuery( "#map-svg #interactive g" );
    var jqLabels = jQuery( ".region-label" );

    var currentLink;

    if(jQuery('body').hasClass('single-region')) {
      var slug = window.location.href.split('/');
      var $id = '#'.concat(slug[slug.length - 2]);
      highlightRegion(jQuery($id));
    }

    function highlightNone() {
      toolTip.find('div').html('');
      jqLabels.removeClass("show-more");
      jqRegions.removeClass("highlight");
      jqRegions.removeClass("lowlight");
    }

    function highlightRegion(jqO) {
      jqRegions.removeClass("highlight");
      jqRegions.addClass("lowlight");
      jQuery(jqO).addClass("highlight");
    }

    if ( isTouch ) {
      jqRegions.on('tap', function(e) {
        var sID = '#'.concat(jQuery(this).attr("id"), "-label");
        if(jQuery(this).hasClass('highlight')) highlightNone();
        else {
          var sID = '#'.concat(jQuery(this).attr("id"), "-label");
          toolTip.css("top", e.pageY - jQuery(window).scrollTop());
          toolTip.css("left", e.pageX);
          toolTip.find('div').html(jQuery(sID).html());
          highlightRegion(this);
        }
      });
      jQuery( "#map-svg #flat" ).on('tap', highlightNone );
    } else {
      jQuery( "#map-svg #flat" ).hover( highlightNone );
      jqLabels.hover(
        function() {
          var sID = '#'.concat(jQuery(this).attr("id").split('-label')[0]);
          highlightRegion(jQuery(sID));
        }, highlightNone
      );
      jqLabels.click(
        function() {
          jQuery(this).toggleClass("show-more");
        }
      );
      jqRegions.hover(
        function(e) {
          var sID = '#'.concat(jQuery(this).attr("id"), "-label");
          toolTip.css("top", e.pageY - jQuery(window).scrollTop());
          toolTip.css("left", e.pageX);
          toolTip.find('div').html(jQuery(sID).html());
          highlightRegion(this);
          currentLink = jQuery(jQuery(sID).find('a strong')[0]);
        }
      );
      jqRegions.click(
        function(e) {
          if(currentLink) jQuery(currentLink).click();
        }
      );
    }
	}
);
