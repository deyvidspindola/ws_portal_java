<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper">
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
		form.elements.validarObrigacaoBuzzer.value = false;
		var data = $(form).serialize();
			
		//configuracoes para tirar os caches - IE
		$.support.cors = true; //  cross-site scripting
        $.ajaxSetup({ cache: false }); 
		
		document.getElementById('js-popup').style.display = 'none';
		document.getElementById('black_overlay').style.display = 'none';
		
		blockDiv();
		
			//configuracoes para tirar os caches - IE
			$.support.cors = true; //  cross-site scripting
	        $.ajaxSetup({ cache: false });

			document.getElementById('js-popup').style.display = 'none';
			document.getElementById('black_overlay').style.display = 'none';

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
						$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv10");
						$(form).unbind('submit').submit();
					} else {
						noneDiv();
						$.showMessage(json.mensagem);
					}
				}
			});
		
		}
		
		function consultarTesteProgamados(form){
		var data = $(form).serialize();
		var login = "${SascarUser.login}";
		var acessoPiloto = ${SascarUser.acessoPiloto};
			
		//configuracoes para tirar os caches - IE
		$.support.cors = true; //  cross-site scripting
        $.ajaxSetup({ cache: false }); 
		blockDiv();
	
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
						if(acessoPiloto == true) {
							$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv09Piloto");
						} else {
							$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv09");
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
			var formResumoConfiguracoes = document.getElementById('formResumoConfiguracoes')
			var recursiva = function () {
				verificarComandoPendente(formResumoConfiguracoes);
				setTimeout(recursiva,5000);
			}
			recursiva();
		}

		function MudarEstado(){
			var display = document.getElementById('js-popup').style.display;
			if(display == "none")
				document.getElementById('js-popup').style.display = 'block';
				document.getElementById('black_overlay').style.display = 'block';
		}

		$(document).ready(function(){
			var formResumoConfiguracoes = document.getElementById('formResumoConfiguracoes');
			tempo();
			$('#js-fechar').live('click', function(){
				document.getElementById('js-popup').style.display = 'none';
				document.getElementById('black_overlay').style.display = 'none';
			});
			$('#js-entrar').bind('click', function(){
					reenviarConfiguracoes(formResumoConfiguracoes);
			});
		});

	</script>

	<form method="post"	id="formVoltar"	action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv01">
		<input type="hidden" name="numeroOS"        value="${param.numeroOS}" />
		<input type="hidden" name="numeroPlaca" 	value="${param.numeroPlaca}" />
		<input type="hidden" name="motivo"			value="${param.motivo}" />
	</form>

	<form id="formResumoConfiguracoes"  method="post" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv09">
		<input type="hidden" name="numeroOS"  		value="${param.numeroOS }" />
		<input type="hidden" name="numeroPlaca" 	value="${param.numeroPlaca}" />
		<input type="hidden" name="origem" 			value="${param.origem}" />
		<input type="hidden" name="reiniciarTestes" value="${param.reiniciarTestes}" />
		<input type="hidden" name="numeroCPF" 		value="${param.numeroCPF }" />
		<input type="hidden" name="tipoEquipamento" value="${param.tipoEquipamento }" />
		<input type="hidden" name="motivo"			value="${param.motivo}" />
		<input type="hidden" name="validarObrigacaoBuzzer"	value="${param.validarObrigacaoBuzzer}" id="obrBuzzer"/>

		<div class="principal">
			<div class="msg" id="js-msg"
				 style="width: 970px;
						height: 30px;
							font-size: 12px;
						color: #F00;
						font-weight: bold;
						">

			</div>
			<div class="barraTituloPagina">
				<div class="textoTituloPagina"><fmt:message key="label.configuracoes" /></div>
			</div>



			<div class="barraSubtitulos" style="margin-top: 5px; background-color: #00417B">
				<div class="textoBarraSubtitulo"><fmt:message key="label.dataDaConfiguracao" /></div>
			</div>

			<div class="linha">
				<img alt="" class="posicaoSeta" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/setaAzulDireita.png" />
				<div class="colunaTextodv08" style="font-weight: bold;"><fmt:message key="label.data" />:</div>
				<div class="colunaTextodv08">
					<fmt:formatDate value="${configuracao.dataHoraConfiguracao }" pattern="dd/MM//yyyy hh:mm:ss"/>
				</div>
				<div style="clear: both"></div>
			</div>

		<c:if test="${not empty configuracao.statusAntena}">
			<div class="linha">
				<img alt="" class="posicaoSeta" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/setaAzulDireita.png" />
				<div class="colunaTextodv08" style="font-weight: bold;"><fmt:message key="label.statusAntena" />:</div>
				<div class="colunaTextodv08">
					${configuracao.statusAntena}
				</div>
				<div style="clear: both"></div>
			</div>
		</c:if>
			
			<div class="linha">
				<img alt="" class="posicaoSeta" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/setaAzulDireita.png" />
				<div class="colunaTextodv08" style="font-weight: bold;"><fmt:message key="label.posicaoDeMemoria" />:</div>
				<div class="colunaTextodv08">
					<c:choose>
						<c:when test="${configuracao.statusPosicaoMemoria }"><fmt:message key="label.sim" /></c:when>
						<c:otherwise><fmt:message key="label.nao" /></c:otherwise>
					</c:choose>
				</div>
				<div style="clear: both"></div>
			</div>
			
			

			<div class="barraSubtitulos" style="margin-top: 15px">
				<div class="textoBarraSubtitulo"><fmt:message key="label.coordenadas" /></div>
			</div>
			<div class="resultadosTestes">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr style="background-color: #d8d8d8;">
						<td style="width: 470px"><fmt:message key="label.latitude" />:</td>
						<td style="width: 470px">${configuracao.latitude }</td>
					</tr>
					<tr style="background-color: #efefef;">
						<td style="width: 470px"><fmt:message key="label.longitude" />:</td>
						<td style="width: 470px">${configuracao.longitude }</td>
					</tr>
				</table>
			</div>



			<div class="popup_padrao" id="js-popup"
				 style="margin-left: 300px;
						display: none;
						position: absolute;
						z-index: 1002;">

						<p style="margin-top:5px;font-size:14px; text-align: left; font-style:italic; color:#1C1C1C;"> Deseja Reenviar Configura&ccedil;&otilde;es?</p>
						<table>
							<tr></tr>
							<tr>
								<td><input type="button" id="js-fechar" name="fechar" value="<fmt:message key="label.voltar" />" class="button"  /></td>
								<td><input type="button" id="js-entrar" name="Enviar" value="<fmt:message key="label.enviar" />" class="button" /></td>
							</tr>
						</table>
			</div>
			<div id="black_overlay"
				 style="display: none;
						position: absolute;
						top: 0%;
						left: 0%;
						width: 100%;
						height: 110%;
						background-color: black;
						z-index:1001;
						-moz-opacity: 0.8;
						opacity:.80;"></div>

			<c:forEach items="${configuracao.grupoItensConfiguracao }" var="grupo">

				<div class="barraSubtitulos" style="margin-top: 15px">
					<div class="textoBarraSubtitulo">${grupo.descricao }</div>
				</div>

				<div class="resultadosTestes">
					<table border="0" cellpadding="0" cellspacing="0">
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

			<!-- DIV BOTOES -->
			<div class="posicaoBotoes">

			     <div class="botoesResumoConfiguracoes">
				    <p>
						<input type="button" class="button4" value="<fmt:message key="label.voltar" />"                 onclick="$('#formVoltar').submit();" />
				        <input type="button" class="button4" value="<fmt:message key="label.reenviarConfiguracoes" />"  onclick="MudarEstado();"/>
				        <c:if test="${!configuracao.obrigaReenvio}">
				        	<input type="button" class="button"  value="<fmt:message key="label.continuar" />"onclick="consultarTesteProgamados('#formResumoConfiguracoes');"/>
				        </c:if>
				    </p>
			    </div>

		    	<div style="clear: both;" ></div>
		    </div>
		    <!-- FIM DIV BOTOES -->

		</div>

</form>
