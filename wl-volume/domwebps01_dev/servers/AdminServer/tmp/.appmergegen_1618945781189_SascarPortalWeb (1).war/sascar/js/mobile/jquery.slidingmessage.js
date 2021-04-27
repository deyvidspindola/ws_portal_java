(function() {
    jQuery.showMessage = function(message, options){
	$('#divMessageError').html(''+message+'').show();
	document.location.href = "#top";
    }
})(jQuery);