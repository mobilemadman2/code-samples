jQuery(document).ready(

  function () {
    if (jQuery('body').hasClass('page-template-careers-sub-page')) {
      if(new RegExp('careers/opportunities').test(window.location.href)) {
        fListAll();
      }
      else if(new RegExp('careers/listing').test(window.location.href)) {
        fGetListing();
      }
      else if(new RegExp('careers/category').test(window.location.href)) {
        fListCat();
      }
      else fCheckParams();
    }

    function fGetListing() {
      var obj = fGetParams();
      if (obj.hasOwnProperty('id')) {
        var sQuery = 'https://api.lever.co/v0/postings/coursera/' + obj.id;
        jQuery.getJSON(sQuery).done(
          function( data ) {
            var sTeam = data.categories.team;
            var sHtml = '<h1>' + data.text + '</h1>';
            var sHtml = sHtml.concat('<h2>' + sTeam + '&nbsp;&bullet;&nbsp;' + data.categories.location + '</h2>');
            sHtml = sHtml.concat(data.description);
            jQuery.each( data.lists, function( key, val ) {
              var sExtra = '<h3>' + val.text + '</h3><ul>' + val.content + '</ul>';
              sHtml = sHtml.concat(sExtra);
            });
            jQuery('.lever-content').html(sHtml);
            var sButton = '<a class="careers-button apply" target="_blank" href="' + data.applyUrl + '">Apply</a>';
            jQuery('.lever-footer').append(sButton);
            sTeam = sTeam.replace(" ", "%20");
            sTeam = sTeam.replace("&", "%26");
            var sQueryAside = 'https://api.lever.co/v0/postings/coursera?mode=json&team=' + sTeam;
            jQuery.getJSON( sQueryAside, function( dataAside ) {
              jQuery('.lever-aside').html(fParseListings(dataAside));
            });
          }).fail(function() {
            jQuery('.lever-content').html('<h1>Not found</h1>');
        });
      }
      else {
        jQuery('.lever-content').html('<h1>Not found</h1>');
      }
    }

    function fParseListings(data) {
      var items = [];
      var sHtml = '<ul>';
      jQuery.each( data, function( key, val ) {
        // sort data by 'team'
        var sTeam = val.categories.team;
        if (items.hasOwnProperty(sTeam)) items[sTeam].push(val)
        else items[sTeam] = Array(val);
      });
      for(var key in items) {
        var sCat = '<li><h2>' + key + '</h2><p class="pull-right"></p><ul>';
        var item = items[key];
        for (var i=0; i<item.length; i++) {
          var sJob = '<li><a href="/careers/listing?id=' + item[i].id + '">' + item[i].text +'</a><span class="pull-right">' + item[i].categories.location + '</span></li>';
          sCat = sCat.concat(sJob);
        }
        sCat = sCat.concat('</ul></li>');
        sHtml = sHtml.concat(sCat);
      }
      return sHtml;
    }

    function fListAll() {
      jQuery.getJSON( 'https://api.lever.co/v0/postings/coursera?mode=json', function( data ) {
        jQuery('.lever-content').html(fParseListings(data));
      });
    }

    function fListCat() {
      var obj = fGetParams();

      var sTitle = obj.title.replace(/%20/g, " ");
      sTitle = sTitle.replace(/%26/g, "&");
      jQuery('.intro h1').html(sTitle);

      if (obj.hasOwnProperty('category')) {
        var aCats = obj.category.split(',');
        var sClass = aCats[0].replace(/%20/g, "-");
        jQuery('body').addClass(sClass);
        var sQueryAside = 'https://api.lever.co/v0/postings/coursera?mode=json';
        for (var i=0; i<aCats.length; i++) {
          sQueryAside = sQueryAside.concat('&team=',aCats[i]);
        }
        jQuery.getJSON( sQueryAside).done( function( data ) {
          jQuery('.lever-content').html(fParseListings(data));
        }).fail(function() {
          jQuery('.lever-content').html('<h1>Not found</h1>');
        });
      } else if (obj.hasOwnProperty('commitment')) {
        jQuery('body').addClass(obj.commitment);
        var sQueryAside = 'https://api.lever.co/v0/postings/coursera?mode=json&commitment=' + obj.commitment;
        jQuery.getJSON( sQueryAside).done( function( data ) {
          jQuery('.lever-content').html(fParseListings(data));
        }).fail(function() {
          jQuery('.lever-content').html('<h1>Not found</h1>');
        });
      } else {
        jQuery('.lever-content').html('<h2>Job category not found</h2>');
      }
    }

    function fGetParams(aParams) {
      var sUrl = window.location.search.slice(1);
      var aParams = sUrl.split('#')[0].split('?');
      var oParams = {};
      if (aParams.length > 0) {
        aParams = aParams[0].split('&');

        for (var i=0; i<aParams.length; i++) {
          var a = aParams[i].split('=');
          // in case params look like: list[]=thing1&list[]=thing2
          var paramNum = undefined;
          var paramName = a[0].replace(/\[\d*\]/, function(v) {
            paramNum = v.slice(1,-1);
            return '';
          });
          // set parameter value (use 'true' if empty)
          var paramValue = typeof(a[1])==='undefined' ? true : a[1];
          if (oParams[paramName]) {
            // convert value to array (if still string)
            if (typeof oParams[paramName] === 'string') {
              oParams[paramName] = [oParams[paramName]];
            }
            // if no array index number specified...
            if (typeof paramNum === 'undefined') {
              // put the value on the end of the array
              oParams[paramName].push(paramValue);
            }
            // if array index number specified...
            else {
              // put the value at that index number
              oParams[paramName][paramNum] = paramValue;
            }
          }
          else oParams[paramName] = paramValue;
        }
      }
      return oParams;
    }

    function fCheckParams() {
      fGetParams();
    }

    /*function fCenterHeaderContent() {
      // TODO: ??
    }*/
	}
);
