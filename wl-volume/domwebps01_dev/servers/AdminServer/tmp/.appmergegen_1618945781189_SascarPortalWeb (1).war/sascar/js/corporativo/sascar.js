//VERSAO: ${BUILD_TAG}

$(document).ready(function(){
	$("input:text").not("[readonly]").not("[disabled]").not('.decimal').not('.nofilter').not('.number').keyup(function() {
		$(this).val(
			$(this).val().replace(/[^a-zA-Z0-9!@#$%&*()\[\].,:;?<>{}_ \-+=]/g, '')
		);
	});
	
	$('#observacaoRemessaEstoque').not("[readonly]").not("[disabled]").not('.decimal').not('.nofilter').not('.number').keyup(function() {
		$(this).val(
			$(this).val().replace(/[^a-zA-Z0-9!()\[\].,:;?<>{}_ \-+=]/g, '')
		);
	});
	
	$('#observacaoAgendamentoRepresentante').not('.decimal').not('.nofilter').not('.number').keyup(function() {
		$(this).val(
			$(this).val().replace(/[^a-zA-Z0-9!()\[\].,:;?<>{}_ \-+=]/g, '')
		);
	});

	//$().jOverlay.setDefaults({'color':'#ffffff', 'opacity' : '0.8'});
	$().jOverlay.setDefaults({'color':'#ffffff', 'opacity' : '0.8', 'css' : {'top' : '150px'}});

	$(window).unload(function() {
		$("#loading").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
	}).one("beforeunload", function(){
		$("#loading").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
	});

	$('#loading').ajaxStart(function() {
		$(this).jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
	}).ajaxStop(function() {
		if ($("#loading").is(':visible')) {
			$.closeOverlay();
		}
	});
	
	//iframeListener();
	$.mask.masks = $.extend($.mask.masks,{});
});

function isLocalHost() {
	var isLocalHost = window.top.location.href.indexOf('localhost') != -1
						|| window.location.href.indexOf('Imprimir') != -1
						|| window.location.href.indexOf('Ajax') != -1;
	return isLocalHost;
}

function isOpenForIframe() {
	if (isLocalHost()){
		return true;
	}
	return window.top.location != self.location;
}

function iframeListener() {
	if (!isOpenForIframe()) {
		redirect("/PortalSascar/");
	} 
}

function blockAccess(errorType) {
	bloquearMenu();
	bloquearBannerAcesso();
	if (errorType.indexOf('SESSAO') > -1) {
		$("#msgPermissao").html('Sua sess&atilde;o foi finalizada. Execute LOGIN novamente');
		$("#linkPopupPermissao").attr('href', '/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Login');
		$("#popupPermissao").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false, 'css' : {'top' : '120px'}});
	} else if (errorType.indexOf('PROFILEDENIED') > -1) {
		$("#msgPermissao").html('Voc&ecirc; n&atilde;o possui permiss&atilde;o para acessar a op&ccedil;&atilde;o desejada.');
		$("#linkPopupPermissao").attr('href', '/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Login');
		$("#popupPermissao").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false, 'css' : {'top' : '120px'}});
	} else {
		$("#msgPermissao").html('Voc&ecirc; n&atilde;o possui permiss&atilde;o para acessar a op&ccedil;&atilde;o desejada.');
		$("#linkPopupPermissao").click(function(){$.closeOverlay();});
		$("#popupPermissao").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false, 'css' : {'top' : '120px'}});
	}
	
	setTimeout(function(){
		setIframeParentHeight(300);
	}, 500);
}

function openDefaultErroPage(errorType) {
	if (String(errorType).indexOf('THROWABLE') > -1) {
		window.location="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/ErrorPage";
	}
}

function openPopupPrint(form) {
	var largura = 700;
	var altura = 660;
	var esquerda = (screen.width)  ? (screen.width - largura) / 2 : 0;
	var topo = (screen.height) ? (screen.height - altura) / 2 : 0;
	var str = 'height='+altura+', width='+largura+', top='+topo+', left='+esquerda+', scrollbars=1';
	var janela = null;

	$(form).attr("target", "imprimir");
	janela = window.open('about:blank', 'imprimir', str);
	janela.focus();
	window.setTimeout(function(){
		$(form).removeAttr("target");
	}, 1000);
}

function getSaudacao() {
	var hoje = new Date();

	if ((hoje.getHours() >= 6) && (hoje.getHours() < 12)) {
		return "Bom dia";
	} else if ((hoje.getHours() >= 12) && (hoje.getHours() < 18)) {
		return "Boa tarde";
	} else if ((hoje.getHours() >= 18) || (hoje.getHours() < 6)) {
		return "Boa noite";
	} else {
		return "Seja vem vindo";
	}
}

function definirSaudacao(usuario, data, hora) {

	var textoSaudacao = "%saudacao%, <i>%usuario%</i>. Seu &#250;ltimo acesso foi em <i>%data%</i>, &#224;s <i>%hora%</i>.";
	textoSaudacao = textoSaudacao.replace("%saudacao%", getSaudacao());
	textoSaudacao = textoSaudacao.replace("%usuario%", usuario);
	textoSaudacao = textoSaudacao.replace("%data%", data);
	textoSaudacao = textoSaudacao.replace("%hora%", hora);

	$wparent("#saudacao").html(textoSaudacao).parent().css("display", "block");
}

/* INICIO CHAMADA AO CHAT PERFIL CLIENTE */
function definirUrlClienteChat(nomeUsuario){

		var parametroCI = nomeUsuario;
		
		parametroCI = parametroCI.replace(/[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/]/gi, '');
		
		/* CONFORME SOLICITADO PELA SASCAR - PASSANDO O PARAMETRO NOME CLIENTE DUAS VEZES PELA FUNCAO -> encodeURIComponent */
		parametroCI = encodeURIComponent(parametroCI);
		parametroCI = encodeURIComponent(parametroCI);
		
		//var funcao = "openPopupChatCliente('"+ parametroCI +"');";
		var valorLink = "javascript:;";
		
		var linkChat = $("<a href=" + valorLink + " id='chamada_chat'>Atendimento Online</a>");
		
		//LIMPA  LI PARA ADICIONAR NOVAMENTE OS VALORES
		$wparent("#li_cliente_chat").html('');
		$wparent("#li_cliente_chat").append(linkChat).css("display", "list-item");
		
		linkChat.bind('click', function(e){
			//openPopupChatCliente(parametroCI);
			abrirPopupAtendimentoOnlineCliente();
			e.preventDefault();
			return false;
		});	
}

function openPopupChatCliente(nomeUsuario){
	
	var parametroCI = nomeUsuario;
	var parametroServico = "Chat%2520Portal";
	var parametroCSS = "http://intranet.sascar.com.br/includes/css/chat.css";
	
	var valorLink = "http://chat.sascar.com.br/interact_chatclient/chat.php?ci=" + parametroCI + "&servico=" + parametroServico + "&notif=1&css=" + parametroCSS;
	
	myWindow = window.open(valorLink,'','width=600,height=600');
}
/* FIM CHAMADA AO CHAT PERFIL CLIENTE */

/* INICIO CHAMADA AO CHAT PERFIL REPRESENTANTE TECNICO */
function definirUrlRepresentanteTecnicoChat(nomeUsuario){
	
	/* VALIDACAO PARA CRIAR O MENU APENAS UMA VEZ */
		
		var parametroCI = nomeUsuario;
		
		parametroCI = parametroCI.replace(/[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/]/gi, '');
		
		/* CONFORME SOLICITADO PELA SASCAR - PASSANDO O PARAMETRO NOME CLIENTE DUAS VEZES PELA FUNCAO -> encodeURIComponent */
		parametroCI = encodeURIComponent(parametroCI);
		parametroCI = encodeURIComponent(parametroCI);
		
		//var funcao = "openPopupRepresentanteTecnicoChat('"+ parametroCI +"');";
		var valorLink = "javascript:;";
		
		var linkChat = $("<a href=" + valorLink + " id='chamada_chat_rep'>Atendimento Online</a>");
		
		$wparent("#li_representante_tecnico_chat").html('');
		$wparent("#li_representante_tecnico_chat").append(linkChat).css("display", "list-item");
		
	linkChat.bind('click', function(e){
			//openPopupRepresentanteTecnicoChat(parametroCI);
			abrirPopupAtendimentoOnlineRepresentante();
			e.preventDefault();
			return false;
		});
	
}

function openPopupRepresentanteTecnicoChat(nomeUsuario){
	
	var parametroCI = nomeUsuario;
	
	var parametroServico = "Chat%2520Representante";
	var parametroCSS = "http://intranet.sascar.com.br/includes/css/chat.css";
	
	var valorLink = "http://chat.sascar.com.br/interact_chatclient/chat.php?ci=" + parametroCI + "&servico=" + parametroServico + "&notif=1&css=" + parametroCSS;
	
	myWindow = window.open(valorLink,'','width=600,height=600');
}

/* INICIO CHAMADA AO CHAT PERFIL REPRESENTANTE TECNICO */

function habilitarMenuAdminRepresentanteTecnico()
{
	$wparent("#menuAdministrativo").show();
}

function desabilitarMenuAdminRepresentanteTecnico()
{
	$wparent("#menuAdministrativo").hide();
}

function habilitarRodapeLinkVersaoMobile()
{
	$wparent("#rodape").show();
}

function desabilitarRodapeLinkVersaoMobile()
{
	$wparent("#rodape").hide();
}

function redirect(url) {
	window.parent.location.href = url;
}

function log(e) {
	if ("console" in window) {
		console.warn(e);
	}
}

// Functions para o projeto PortalSacar (projeto parent)
function $wparent(elem) {
	return $(elem, window.parent.document);
}
function bloquearMenu() {
	$wparent("div.menu").hide();
}
function habilitarMenu() {
	$wparent("div.menu").show();
}

function bloquearItemMenu(useCases) {

	var links = $("a[href*=UC], *[class*=validate-access-UC]");
	links.hide(); 
	
	for(var i in useCases) {
		$wparent("div.menu ul li ul li a[href*=" + useCases[i] + "]").parents('li').show();
		$("a[href*=" + useCases[i] + "]").show();
		$("#" + useCases[i]).show();
		$(".validate-access-" + useCases[i]).show();
	}
}

function liberarMenusComPermissao(menus) {
	for ( var i in menus) {
		$("#" + menus[i]).show();
	}
}

function resizeIframeParent() {
	if (window.parent && window.parent["resizeIframe"]) {
		window.parent.resizeIframe();
	}
}

function setIframeParentHeight(height) {
	log("Iframe Height Atual: " + $wparent("#iframeContent").attr("height"));
	log("Iframe Height Novo: " + height);
	$wparent("#iframeContent").attr("height", height);
}

function bloquearBannerAcesso() {
	$wparent("#acesso").hide();
}