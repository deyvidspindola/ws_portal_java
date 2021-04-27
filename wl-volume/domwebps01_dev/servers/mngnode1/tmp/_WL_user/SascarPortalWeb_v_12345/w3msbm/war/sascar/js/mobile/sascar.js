$(document).ready(function(){
	/*$("input:text").keyup(function() {
		$(this).val(
			$(this).val().replace(/[^a-zA-Z0-9!@#$%&*()\[\].,:;?<>{}_ \-+=]/g, '')
		);
	});*/

	$().jOverlay.setDefaults({'color':'#ffffff', 'opacity' : '0.8'});

});

function blockAccess(errorType) {

	if (errorType.indexOf('SESSAO') > -1) {
		$("#msgPermissao").html('Sua sess&atilde;o foi finalizada. Execute LOGIN novamente');
		$("#linkPopupPermissao").attr('href', '/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Login');
		$("#popupPermissao").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
	} else if (errorType.indexOf('PROFILEDENIED') > -1) {
		$("#msgPermissao").html('Voc&ecirc; n&atilde;o possui permiss&atilde;o para acessar a op&ccedil;&atilde;o desejada.');
		$("#linkPopupPermissao").attr('href', '/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Login');
		$("#popupPermissao").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
	} else {
		$("#msgPermissao").html('Voc&ecirc; n&atilde;o possui permiss&atilde;o para acessar a op&ccedil;&atilde;o desejada.');
		$("#linkPopupPermissao").click(function(){$.closeOverlay();});
		$("#popupPermissao").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
	}

	document.location.href = "#top";

}

function openDefaultErroPage(errorType) {
	if (String(errorType).indexOf('THROWABLE') > -1) {
		window.location="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/ErrorPage";
	}
}