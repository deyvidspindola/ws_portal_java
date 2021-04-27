<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/AtivarEquipamentoTestes/consultarResumoConfiguracao?acao=9" context="/SascarPortalWeb"  />
</c:catch>

<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$.showMessage("${mensagem}");
	</script>
</c:if>

<c:if test="${not empty helper}" >
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>

<script type="text/javascript">
		function reenviarConfiguracoes(form){

			var data = $(form).serialize();
			$("input[type='submit']").attr('disabled', 'disabled');
			//configuracoes para tirar os caches - IE
			$.support.cors = true; //  cross-site scripting
		      $.ajaxSetup({ cache: false });

			blockDiv();

			//Recupera defeitos conforme OS
			$.ajax({
				type: "POST",
				sync: false,
				crossDomain: true,
				url: "/SascarPortalWeb/AtivarEquipamentoTestes/reenviarConfiguracoes?acao=14",
				data: data || {},
				dataType:"json",
				success: function(json){
				if (json.success) {
						noneDiv();
						$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC13/dv10");
						$(form).unbind('submit').submit();
					} else {
						noneDiv();
						$.showMessage(json.mensagem);
						$("input[type='submit']").removeAttr('disabled');
					}
				}
			});

		}

		function consultarTesteProgamados(form){
			var data = $(form).serialize();
			var login = "${SascarUser.login}";

			//configuracoes para tirar os caches - IE
			$.support.cors = true; //  cross-site scripting
		      $.ajaxSetup({ cache: false });
			blockDiv();

			//Recupera defeitos conforme OS
			$.ajax({
				type: "POST",
				sync: false,
				crossDomain: true,
				url: "/SascarPortalWeb/AtivarEquipamentoTestes/reenviarConfiguracoes?acao=24",
				data: data || {},
				dataType:"json",
				success: function(json){
					if (json.mensagem.length <= 0) {
						noneDiv();
						if(login == 'SUPORTESAT.INST' || login == 'PRS.1571' || login == 'SUPORTESAT' || login == 'MARCELOLIN.INST' || login == 'ANDRECOSMOS') {
							$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv09Piloto");
						} else {
							$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC13/dv09");
						}
						$(form).unbind('submit').submit();
					} else {
						noneDiv();
						$('#js-msg').html(json.mensagem);
						$('#js-msg').show('slow');
					}
				}
			});
		}

		function verificarComandoPendente(form){
			var data = $(form).serialize();
			$.support.cors = true; //  cross-site scripting
			$.ajaxSetup({ cache: false });
			$.ajax({
				type : "POST",
				sync : false,
				crossDomain : true,
				url : "/SascarPortalWeb/AtivarEquipamentoTestes/reenviarConfiguracoes?acao=24",
				data: data || {},
				dataType: "json",
				global : false,
				success : function(json) {
					if(json) {
						$('#js-msg').html(json.mensagem);
						$('#js-msg').show('slow');
					} else {
						document.getElementById('js-msg').style.display = 'none';
					}
				}
			});

		}

		function noneDiv(){
			$().jOverlay.setDefaults({'opacity' : '0.0'});
			$("#loading").css('visibility','hidden');
			$("#carregando_text").css('visibility','hidden');
		}

		function blockDiv(){
			$().jOverlay.setDefaults({'color':'#BBBBBB', 'opacity' : '0.8', 'css' : {'top' : '150px'}});
			$("#loading").css('visibility','visible');
			$("#carregando_text").css('visibility','visible');
		}

		function tempo(){
			var formResumoConfiguracoes = document.getElementById('formReenviarConfiguracoes')
			var recursiva = function () {
				verificarComandoPendente(formResumoConfiguracoes);
				setTimeout(recursiva,5000);
			}
			recursiva();
		}

		function MudarEstado(){
			var t = confirm('Deseja Reenviar Configurações?');
			if(t) reenviarConfiguracoes(document.getElementById('formReenviarConfiguracoes'));
		}

		$(document).ready(function(){
			var login = "${SascarUser.login}";
			if(login == 'SUPORTESAT.INST' || login == 'PRS.1571' || login == 'SUPORTESAT' || login == 'MARCELOLIN.INST' || login == 'ANDRECOSMOS') {
				tempo();
			}
		});
</script>

	<form id="formReenviarConfiguracoes"  method="post" action="">
		<input type="hidden" name="numeroOS"  		value="${param.numeroOS }" />
		<input type="hidden" name="numeroPlaca" 	value="${param.numeroPlaca}" />
		<input type="hidden" name="origem" 			value="${param.origem}" />
		<input type="hidden" name="reiniciarTestes" value="${param.reiniciarTestes}" />
		<input type="hidden" name="numeroCPF" 		value="${param.numeroCPF }" />
		<input type="hidden" name="tipoEquipamento" value="${param.tipoEquipamento }" />
		<input type="hidden" name="fromMobile" value="true" />
	</form>

	<h1><fmt:message key="label.configuracoes" /></h1>

	<form id="formPesquisa"  method="get" action="">

		<input type="hidden" name="pagename"      value="SascarPortal_Corporativo/Mobile/RepresentanteTecnico" />
		<input type="hidden" name="page"          value="Corporativo/Mobile/UC13/dv09" />

		<input type="hidden" name="numeroOS"  		value="${param.numeroOS }" />
		<input type="hidden" name="numeroPlaca" 	value="${param.numeroPlaca}" />
		<input type="hidden" name="origem" 			value="${param.origem}" />
		<input type="hidden" name="reiniciarTestes" value="${param.reiniciarTestes}" />
		<input type="hidden" name="numeroCPF" 		value="${param.numeroCPF }" />
		<input type="hidden" name="tipoEquipamento" value="${param.tipoEquipamento }" />

		<fieldset>

			<legend style="font-size: 120%;"><strong><fmt:message key="label.dataDaConfiguracao" /></strong></legend>

			<div class="inputData"><fmt:message key="label.data" /></div>
			<p class="font130">
				<fmt:formatDate value="${configuracao.dataHoraConfiguracao}" pattern="dd/MM/yyyy HH:mm:ss"/>
			</p>

			<div class="inputData"><fmt:message key="label.posicaoDeMemoria" /></div>
			<p class="font130">
				<c:choose>
					<c:when test="${configuracao.statusPosicaoMemoria }"><fmt:message key="label.sim" /></c:when>
					<c:otherwise><fmt:message key="label.nao" /></c:otherwise>
				</c:choose>
			</p>

		</fieldset>

		<fieldset>

			<legend style="font-size: 120%;"><strong><fmt:message key="label.coordenadas" /></strong></legend>

			<div class="inputData"><fmt:message key="label.latitude" /></div>
			<p class="font130">${configuracao.latitude}</p>

			<div class="inputData"><fmt:message key="label.longitude" /></div>
			<p class="font130">${configuracao.longitude}</p>

		</fieldset>

		<c:forEach items="${configuracao.grupoItensConfiguracao }" var="grupo">

			<div class="barraSubtitulos" style="margin-top: 15px">

				<table id="alter_extrato" width="100%" cellpadding="0" cellspacing="5" border="0" class="dados">
					<tr align="center">
						<th class="barraGruposTesteCarga" scope="col" colspan="5" >${grupo.descricao}</th>
					</tr>
				</table>

			</div>

			<div class="resultadosTestesMobile">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">

					<c:forEach items="${grupo.itensConfiguracao }" var="item" varStatus="status">

						<c:set var="bgColor" value="#efefef"/>

						<c:if test="${status.count % 2 != 0 }">
							<c:set var="bgColor" value="#d8d8d8"/>
						</c:if>

						<tr style="background-color: ${bgColor}">
							<td style="width: 470px">${item.descricao }</td>
							<td style="width: 470px">${item.valor }</td>
						</tr>

					</c:forEach>
				</table>
			</div>

		</c:forEach>

		<p class="input" style="padding:10px; margin-top:10px; text-align: center;">
			<input type="button" onclick="MudarEstado();" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.reenviarConfiguracoes" />" />
		</p>

		<p class="input" style="padding:10px; margin-top:10px; text-align: center;">
			<input type="button" onclick="consultarTesteProgamados('#formReenviarConfiguracoes');" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.continuar" />" />
		</p>

	</form>

	<jsp:include page="/WEB-INF/views/Corporativo/Mobile/icones.jsp">
		<jsp:param name="voltar" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC13/dv01&numeroOS=${param.numeroOS}&numeroPlaca=${param.numeroPlaca} "/>
	</jsp:include>
