(function() {
    jQuery.showMessage = function(message, options){
	var elem = $('#divMessageError');
	elem.find('span').html(''+message+'');
	window.scrollTo(0,0);
	elem.fadeIn(1500);
	setTimeout(function() {elem.fadeOut(1500)}, 5000);
    }
})(jQuery);