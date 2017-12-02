jQuery(document).ready(function( $ ) {
    
    $.ajaxSetup({ cache: true });
       
    if (Modernizr.touch) {
        fInitTouch();
    } else {
        fInitDefault();
    }
    fInitAll();
    
    function fInitTouch() {
        
        var oNavMenu = $('#main-menu');
        
        $('#main-menu-toggle').click(function() {
            oNavMenu.toggleClass('open');
        });
        
        $(window).on('resize', function(){
            var win = $(this); //this = window
            if (win.width() < 800) { 
                oNavMenu.removeClass('open');
            }
        });
        
        ($('.expandable ')).find('li').click(function() {
            $(this).toggleClass('open');
        });
    }
    
    function fInitDefault() {}
    
    function fInitAll() {
        
        if ($('#content').hasClass('bg-image')) {
            if ($('.attachment-post-thumbnail').length > 0) {
                $('#content-background').html($('.attachment-post-thumbnail')[0]);
                if ($('#content').hasClass('center')) { $('#content-background').addClass('center'); }
            } 
        }
        
        if ($('#content').hasClass('maximize')) { $('#wrapper').addClass('maximize'); }
        
        if($('.grid').length > 0) {
            ($('.grid').find('.col-content')).matchHeight();
        }
    }
});