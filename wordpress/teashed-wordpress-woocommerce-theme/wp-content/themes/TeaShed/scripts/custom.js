jQuery(document).ready(function( $ ) {
	var jqHamburger = $('.header');
    if (jqHamburger.length > 0) {
        var jqParent = $(jqHamburger.parent()).parent();
        jqHamburger.click(function() {
            jqParent.toggleClass('open');
            if (jqParent.hasClass('open')) {
                jqParent.css('height', ($(jqParent.children()[1]).height() * (jqParent.children().length -1)) + 50);
            }
            else jqParent.css('height', 50);
        });
    }
    var jqQuestion = $('.question');
    if (jqQuestion.length > 0) {
        var jqList = $($(jqQuestion.parent()).parent()).find('ul');
        var height = 500;
        jqQuestion.click(function() {
            //jqQuestion.toggleClass('open');
            jqList.toggleClass('open');
            (jqList.hasClass('open')) ? jqList.css('height', height) : jqList.css('height', 0);
        });
    }
    
    var jqSearchLabel = $('#searchform label');
    if (jqSearchLabel.length > 0) {
        jqSearchLabel.click(function() {
            $('#search').toggleClass('open');
        });
    }
    
    var jqInsta = $('#insta');
    if(jqInsta.length > 0) {
        var iFrame = jqInsta.find('iframe');
    }
});