<jsp:directive.include file="/WEB-INF/views/includes.jsp" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="pt-br" xml:lang="pt-br" dir="ltr">
	<head>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache"/>
		<meta http-equiv="expires" content="0"/>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

		<title>Sascar - Paix&atilde;o pela Inova&ccedil;&atilde;o</title>
		<link rel="shortcut icon" href="${pageContext.request.contextPath}/sascar/images/favicon_sascar.ico" />
		<!--[if IE 7]><link href="${pageContext.request.contextPath}/sascar/css/corporativo/iehacks.css" rel="stylesheet" type="text/css" media="screen" /><![endif]-->
		<link href="${pageContext.request.contextPath}/sascar/css/corporativo/geral.css" media="all" rel="stylesheet" type="text/css" />
		<link href="${pageContext.request.contextPath}/sascar/css/corporativo/menu.css" media="all" rel="stylesheet" type="text/css" />
		<link href="${pageContext.request.contextPath}/sascar/css/corporativo/home.css" media="all" rel="stylesheet" type="text/css" />
		<link href="${pageContext.request.contextPath}/sascar/css/corporativo/sistema.css" media="all" rel="stylesheet" type="text/css" />
		<!--[if IE]> <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sascar/css/corporativo/iehacks.css" /> <![endif]-->
		<!--[if IE 7]>  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sascar/css/corporativo/iehacks-7.css" />  <![endif]-->
		<link href="${pageContext.request.contextPath}/sascar/css/corporativo/jquery-ui-1.8.6.custom.css" media="screen" rel="stylesheet" type="text/css" />
		
		<link href="${pageContext.request.contextPath}/sascar/jDataTable/media/css/demo_page.css" media="screen" rel="stylesheet" type="text/css" />
		<link href="${pageContext.request.contextPath}/sascar/jDataTable/media/css/demo_table.css" media="screen" rel="stylesheet" type="text/css" />

		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/jquery.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/jquery.cookie.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/jquery-ui-1.8.6.custom.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/jquery.ui.datepicker-pt-BR.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/jquery.meio.mask.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/jquery.validate.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/messages_ptbr.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/jquery.joverlay.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/md5.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/jquery.slidingmessage.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/validators.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/jquery.limit-1.2.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/sascar.js" charset="utf-8"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/jquery.tooltip.1.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/js/corporativo/passwordStrengthMeter.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sascar/jDataTable/media/js/jquery.dataTables.js"></script>

		<script type="text/javascript">
		
		function abrirPopupAtendimentoOnlineCliente(){
			//document.location.href="/SascarPortalWeb/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC45/dv02";
			$.ajax({
				url : "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC45/dv02",
				dataType : "html",
				success : function(html) {
					$('#popup-chat').html('');
					$('#popup-chat').html(html);
					$('#popup-chat').jOverlay();
				}				
			});
		};
			
			function limparCampos(container) {
			    $(container).find(":input, select").each(function () {
			        switch (this.type) {
			            case "file":
			            case "password":
			            case "text":
			            case "textarea":
			                $(this).val("");
			                break;
			            case "checkbox":
			            case "radio":
			                this.checked = false;
			        }
			
			        $(this).children("option:selected").removeAttr("selected").end()
			               .children("option:first").attr("selected", "selected");
			    });
			}
		
			$(document).ready(function() {
				
				
				var data = '<fmt:formatDate value="${SascarUser.dataHoraUltimoAcesso }" pattern="dd/MM/yyyy" />';
				var hora = '<fmt:formatDate value="${SascarUser.dataHoraUltimoAcesso }" pattern="HH:mm:ss" />';

			 	definirSaudacao("${SascarUser.nomeUsuario}", data, hora);
			 	
			 	definirUrlClienteChat("${SascarUser.nomeUsuario}");

				$(".tooltip").simpletooltip();
				
				// Ativando o menu
				habilitarMenu();

				/*
				* Trava para indicar se um popup já está aberto. Trava liberada somente com reload.
				* Abrir 1 por vez.
				* Ordem: Email NFe, Placas Fictícias e Pendências Financeiras
				*/
				var lockPopup = false;
				
				<c:if test="${SascarUser.indicadorComunicados}">				
					if (!lockPopup) {
						lockPopup = true;
						bloquearMenu();
						showModalComunicados();
					}				
				</c:if>

				<c:if test="${SascarUser.cadastrarEmailNFe}">
					if (!lockPopup) {
						lockPopup = true;
						bloquearMenu();
						showModalCadastroEmailNFe();
					}
				</c:if>
				
				
				<c:if test="${SascarUser.indicadorPendenciasFinanceiras}">
				   if (!lockPopup) {
					 lockPopup = true;
					 bloquearMenu();
					 showModalCadastroPendenciaFinanceira();
				   }
			    </c:if>

				/*
				 *       STI 8101
				 *    	 Usuário que não atualizou seus dados cadastrais a mais de 90 dias
				 *       e que possui indicativo de placas fictícias. 
  			     *       indicador_atualizacao_cadastral = False
				 *       indicador_placas_ficticias = True
                 */
				<c:if test="${SascarUser.indicadorPlacasFicticias and not SascarUser.indicadorAtualizacaoCadastral }" >
					if (!lockPopup) {
						lockPopup = true;
						bloquearMenu();
						showModalAtualizacaoCadastral();						
					}
				</c:if>
				
				/*
				 *       STI 8101
				 *    	 Usuário que não atualizou seus dados cadastrais a mais de 90 dias (não possui indicativo de placas fictícias)
   				 *       indicador_atualizacao_cadastral = False
				 *       indicador_placas_ficticias = False
               	 */
				<c:if test="${not SascarUser.indicadorPlacasFicticias and not SascarUser.indicadorAtualizacaoCadastral }" >
					if (!lockPopup) {
						lockPopup = true;
						bloquearMenu();
						showModalAtualizacaoCadastralSemPlacaFicticia();						
					}
				</c:if>
				
				
				/*
				 *       STI 8101
				 *    	 Usuário que possui somente placa fictícia (SEM ALTERAÇÃO NO PROCESSO ATUAL)
             	 *  	 Apresenta a tela de mensagem de placa fictícia.
               	 */
               	<c:if test="${SascarUser.indicadorPlacasFicticias and SascarUser.indicadorAtualizacaoCadastral }" >
					if (!lockPopup) {
						lockPopup = true;
						bloquearMenu();
						showModalCadastroPlacaFicticia();
					}
				</c:if>
				
			});

			function showModalCadastroPlacaFicticia() {
				$.ajax({
					url : "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC12/dv06",
					dataType : "html",
					cache : false,
					success : function(html) {
						$("#popupPlacaFicticia").html(html);
						$("#popupPlacaFicticia").jOverlay({
							bgClickToClose : false,
							closeOnEsc : false,
							'css' : {'top' : '40px'}
						});

						setTimeout(function(){
							setIframeParentHeight($("#popupPlacaFicticia").height() + 20);
						}, 500);
					}
				});
			}

			function showModalCadastroPendenciaFinanceira() {
				$.ajax({
					url : "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC12/dv07",
					dataType : "html",
					cache : false,
					success : function(html) {
						$("#popupPendenciaFinanceira").html(html);
						$("#popupPendenciaFinanceira").jOverlay({
							bgClickToClose : false,
							closeOnEsc : false,
							'css' : {'top' : '90px'}
						});

						setTimeout(function(){
							setIframeParentHeight($("#popupPendenciaFinanceira").height() + 25);
						}, 500);

					}
				});
			}
			
			
			function showModalAtualizacaoCadastral() {
				$.ajax({
					url : "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC12/dv09&placaFicticia=Show",
					data : {"adiarAtualizacao" : '${SascarUser.adiarAtualizacao}' },
					dataType : "html",
					cache : false,
					success : function(html) {
						$("#popupAtualizacaoCadastral").html(html);
						$("#popupAtualizacaoCadastral").jOverlay({
							bgClickToClose : false,
							closeOnEsc : false,
							'css' : {'top' : '90px'}
						});

						setTimeout(function(){
							setIframeParentHeight($("#popupAtualizacaoCadastral").height() + 25);
						}, 500);

					}
				});
			}
			
			
			function showModalAtualizacaoCadastralSemPlacaFicticia() {
				$.ajax({
					url : "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC12/dv09&placaFicticia=noShow",
					data : {"adiarAtualizacao" : '${SascarUser.adiarAtualizacao}' },
					dataType : "html",
					cache : false,
					success : function(html) {
						$("#popupPlacaFicticia").html(html);
						$("#popupPlacaFicticia").jOverlay({
							bgClickToClose : false,
							closeOnEsc : false,
							'css' : {'top' : '90px'}
						});

						setTimeout(function(){
							setIframeParentHeight($("#popupPlacaFicticia").height() + 25);
						}, 500);

					}
				});
			}

			// Abre a modal para cadastro do e-mail NFe
			function showModalCadastroEmailNFe() {
				$.ajax({
					url : "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC12/dv05",
					dataType : "html",
					cache : false,
					success : function(html) {
						$("#popupEmailNFe").html(html);
						$("#popupEmailNFe").jOverlay({
							bgClickToClose : false,
							closeOnEsc : false,
							'css' : {'top' : '120px'}
						});

						setTimeout(function(){
							setIframeParentHeight($("#popupEmailNFe").height() + 30);
						}, 500);
					}
				});
			}
			
			function showModalComunicados() {
				
				$.ajax({
					url : "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC12/dv08",
					dataType : "html",
					cache : false,
					success : function(html) {
						
						//Pega o tamanho do joverlay
						var element = $("#jOverlayContent");
						var elemHeight = element.height();
						
						//Pega o tamanho do joverlay mais um pouco para o top 
						var top = $(window).scrollTop() + ($(window).height() / 2);
						top = elemHeight +55;
						
						//Abre o popup seta o tamanho do top e margin de acordo com o tamanho do joverlay
						$("#popupComunicados").html(html);
						$("#popupComunicados").jOverlay({
							bgClickToClose : false,
							closeOnEsc : false,
							'css' : {'top' : top+'px',
							'marginTop' : '-' + elemHeight / 2 + 'px'}
						});
						
						//Recupera o tamanho do popup
						var elementC = $("#popupComunicados");
						var elemHeightCom = elementC.height();
						
						if(elemHeightCom == 0) elemHeightCom = 500;
						//Seta mais 150 para o iframe aumentar com o popup 
						setTimeout(function(){
							setIframeParentHeight(elemHeightCom + 150);
						}, 500);

					}
				});
			}
			
		</script>
		
		<script type="text/javascript" defer="defer">
			window.location.hash = "";
			//alert('testeHASH:  '+window.location.hash);
		</script>
		
		<style type="text/css">
			div.menu ul li ul li {
				display:none;
			}
		</style>

		<c:catch var="helper">
			<c:import url="/VerificarPermissao" context="/SascarPortalWeb" />
		</c:catch>

	</head>

	<body>
		<div id="popup-chat" style="display: none;"></div>
		<c:if test="${isLocalHost and empty helper}">
			<!-- SAUDACAO -->
	        <div id="acesso"><span id="saudacao">&nbsp;</span>
	        	<div class="btnHistoricoPendencias">
		            <a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&amp;page=Corporativo/UC36/dv01">
		                <span>Ver meu Hist&oacute;rico/Pend&ecirc;ncias</span>
		            </a>
	            </div>
	        </div>
	        
	        <div class="menu">
				<jsp:directive.include file="/WEB-INF/views/common/menu.jsp" />
			</div>
		</c:if>

		<div id="divMessageError" class="error_div" style="display: none;">
			<h3 class="erro">
				<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/001_19.png" 
						width="24" 
						height="24" 
						hspace="5" 
						border="0" 
						align="absmiddle" />
				<span></span>
			</h3>
		</div>
		
		<c:choose>
			<c:when test="${not empty helper}">
				<script type="text/javascript">
					$(document).ready(function() {
						blockAccess('${helper}');
					});
				</script>
			</c:when>
			<c:otherwise>

				<script type="text/javascript">
					var useCases = [];
					<c:forEach items="${SascarUser.funcionalidades }" var="funcionalidade" varStatus="count">
						useCases[${count.index}] = '${funcionalidade.useCase }';
					</c:forEach>
					$(document).ready(function() {
						bloquearItemMenu(useCases);
					});
				</script>
				
				<script type="text/javascript">
					var menus = [];
					<c:forEach items="${SascarUser.menus}" var="menu" varStatus="count">
						menus[${count.index}] = '${menu.menu }';
					</c:forEach>
					$(document).ready(function() {
						liberarMenusComPermissao(menus);
					});
				</script>

				<jsp:directive.include file="/WEB-INF/views/common/detail.jsp" />

				<div id="popupEmailNFe" style="display: none;"></div>
				<div id="popupPlacaFicticia" style="display: none;"></div>
				<div id="popupPendenciaFinanceira" style="display: none;"></div>
				<div id="popupComunicados" style="display: none;"></div>
				<div id="popupAtualizacaoCadastral" style="display: none;"></div>
				
			</c:otherwise>
		</c:choose>

		<jsp:directive.include file="/WEB-INF/views/common/footer.jsp" />
	</body>
</html>