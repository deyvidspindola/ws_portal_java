<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

	<script type="text/javascript">
	
		function submeteFormInstrucaoTesteOdometroInicial(form){
			
			var data = $(form).serialize();			
			//configuracoes para tirar os caches - IE
			$.support.cors = true; //  cross-site scripting
	        $.ajaxSetup({ cache: false }); 
	        								
			$.ajax({
				type: "POST",
				sync: false,
				crossDomain: true,
				url: "/SascarPortalWeb/AtivarEquipamentoTestes/submeterTesteOdometroInicial?acao=11",
				data: data || {},
				dataType:"json",
				success: function(json){
					if (json.success) {
						$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC13/dv07");
						$(form).unbind('submit').submit();
					} else {
						$(form).attr("action", "");
						$.showMessage(json.mensagem);
					}
				}
			});
		}
		
		function submeteFormInstrucaoTesteOdometroFinal(form){
			
		
			var data = $(form).serialize();			
						
			//configuracoes para tirar os caches - IE
			$.support.cors = true; //  cross-site scripting
	        $.ajaxSetup({ cache: false }); 
			
			$.ajax({
				type: "POST",
				sync: false,
				crossDomain: true,
				url: "/SascarPortalWeb/AtivarEquipamentoTestes/submeterTesteOdometroFinal?acao=10",
				data: data || {},
				dataType:"json",
				success: function(json){
					if (json.success) {
						$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC13/dv04");
						$(form).unbind('submit').submit();
					} else {
						$(form).attr("action", "");
						$.showMessage(json.mensagem);
					}
				}
			});
		}
		
	function submeteFormInstrucaoTesteParametroPortal(form) {			
			
			var data = $(form).serialize();
			
			//configuracoes para tirar os caches - IE
			$.support.cors = true; //  cross-site scripting
	        $.ajaxSetup({ cache: false }); 
			
			$.ajax({
				type: "POST",
				sync: false,
				crossDomain: true,
				url: "/SascarPortalWeb/AtivarEquipamentoTestes/submeterTestePortal?acao=16",
				data: data || {},
				dataType:"json",
				success: function(json){
					if (json.success) {
						
						var str = "&codigoTeste="+json.testeId;
								str += "&nome="+json.nome;
								str += "&indicador="+json.indicador;								
								str += "&resultado="+json.resultado;								
								str += "&numOS="+json.numOS;
								str += "&numeroCPF="+json.numeroCPF;
								str += "&tipoTeste="+"${teste.tipoTeste}";
										
						$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC13/dv13"+str);
						$(form).unbind('submit').submit();
						
					} else {
						$(form).attr("action", "");
						$.showMessage(json.mensagem);
					}
				}
			});
		}
		
		function submeteFormInstrucaoTestePortal(form) {
				
			var data = $(form).serialize();
			
			//configuracoes para tirar os caches - IE
			$.support.cors = true; //  cross-site scripting
	        $.ajaxSetup({ cache: false }); 
			
			$.ajax({
				type: "POST",
				sync: false,
				crossDomain: true,
				url: "/SascarPortalWeb/AtivarEquipamentoTestes/submeterTestePortal?acao=16",
				data: data || {},
				dataType:"json",				
				success: function(json){
					if (json.success) {
						$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC13/dv04");
						$(form).unbind('submit').submit();
					} else {
						$(form).attr("action", "");
						$.showMessage(json.mensagem);
					}
				}
			});
		}
	
		$(document).ready(function(){
			
			var container = $('div.container-error');
			$("#formPesquisa").validate({
				errorContainer: container,
				errorLabelContainer: $("ol", container),
				wrapper: 'li',
				submitHandler : function(form) {
					
					<c:if test="${not empty teste.tipoTeste}">
					
						var tipoTeste = "${teste.tipoTeste}";
						var numeroWS  = "${teste.numeroWebService}";
						var exibeConfirmacao = "${teste.exibeConfirmacao}";
						var exibeConfirmacao = exibeConfirmacao.toLowerCase()=="true"?1:0;
						

												
						if (numeroWS == 163) {
							// Odometro Inicial
							if (exibeConfirmacao == true) {
							submeteFormInstrucaoTesteOdometroInicial(form);
							// Odometro Final
							} else {
								submeteFormInstrucaoTesteOdometroInicial(form);
							}
						}
						else if (numeroWS == 205) {
								if (exibeConfirmacao == true) {
									submeteFormInstrucaoTesteParametroPortal(form);
								}else{
							submeteFormInstrucaoTestePortal(form);
						}
						}
						else{							
							$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC13/dv04");
							$(form).unbind('submit').submit();
						}							
						
					</c:if>
	
				}
			});
			
			<c:if test="${not empty teste.precisaoOdometro}">
			
				// RECUPERA O NUMERO DE CASAS DECIMAIS
				var precisao = "${teste.precisaoOdometro}";
				
				// CRIA UM ARRAY COM 10 POSICOES PARA CONTROLAR A MASCARA DO CAMPO
				var mask = new Array("9","9","9","9","9","9","9","9","9","9");
				
				// ALTERA A PRECISAO DA MASCARA COM BASE NA PRECISAO RETORNADA NO PARAMETRO ${teste.precisaoOdometro}
				mask[precisao - 1] = "9.";
				
				// TRANSFORMA O ARRAY EM UMA STRING
				var stringMask = mask.toString();
				
				// REMOVE AS VIRGULAS QUE O METODO toString() CRIA AO TRANSFORMAR O ARRAY EM UMA STRING
				stringMask = stringMask.replace(/,/g, "");
								
				// SETA A MASCARA NO CAMPO
				$("#kilometragemInicial").setMask({ mask : stringMask, type : 'reverse', defaultValue : '' });	
				$("#kilometragemFinal").setMask({ mask : stringMask, type : 'reverse', defaultValue : '' });
			
			</c:if>
			
		});
	
	</script>

	<div class="container-error"> 
		<ol>
			<li><label for="kilometragemInicial" class="error"><fmt:message key="mensagem.campoObrigatorio.kilometragem" /></label></li>
			<li><label for="kilometragemFinal" class="error"><fmt:message key="mensagem.campoObrigatorio.kilometragem" /></label></li>
			<li><label for="idTML" class="error"><fmt:message key="mensagem.campoObrigatorio.voltagemBateria" /></label></li>
		</ol>
	</div>

	<h1><fmt:message key="label.testesAtivacaoEquipamento" /></h1>
	
	<br/>
	
	<form id="formPesquisa" method="post" action="" >
	
		<input type="hidden" name="numeroCPF"        value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS"         value="${param.numeroOS }" />
		<input type="hidden" name="indiceTeste"  	 value="${empty param.indiceTeste ? 1 : param.indiceTeste }" />
		<input type="hidden" name="totalTestes" 	 value="${teste.total }" />
		<input type="hidden" name="codigoTeste" 	 value="${teste.codigo }" />
		<input type="hidden" name="precisaoOdometro" value="${teste.precisaoOdometro}" />
		<input type="hidden" name="numeroPlaca"      value="${param.numeroPlaca}" />	
		
		<input type="hidden" name="reiniciarTestes" value="${param.reiniciarTestes}" />
		<input type="hidden" name="tipoEquipamento" value="${param.tipoEquipamento}" />
		<input type="hidden" name="origem"          value="${param.origem}" />
		<input type="hidden" name="tipoTeste"		value="${teste.tipoTeste}"/>	
		<input type="hidden" name="numeroWebService" value="${teste.numeroWebService}" />

		<fieldset>
			<legend>
				<strong><fmt:message key="label.instrucoes" /></strong>
			</legend>
			
			<p class="input">
				<label><span><fmt:message key="label.instrucao" />:</span></label>
				<label>${teste.instrucao}</label>
			</p>
			
			<!-- TESTE DE ODOMETRO INICIAL -->
			<c:if test="${teste.tipoTeste eq 'OI' }" >
				<p class="input">
					<label><span><fmt:message key="label.kilometragem" />:</span></label>
					<input type="text" id="kilometragemInicial" name="kilometragemInicial" maxlength="7" class="inputCelulaPequena required" />
				</p>
			</c:if>
			
			<!-- TESTE DE ODOMETRO FINAL -->
			<c:if test="${teste.tipoTeste eq 'OF' }" >
				<p class="input">
					<label><span><fmt:message key="label.kilometragem" />:</span></label>
					<input type="text" id="kilometragemFinal" name="kilometragemFinal" maxlength="7" class="inputCelulaPequena required" />
				</p>
			</c:if>
			
			<!-- TESTE DE MEIA LUZ -->
				<c:if test="${teste.tipoTeste eq 'TML'}">
					<div class="celula positionCelulaInstrucaoTeste">
					<div class="colunaLabelInstrucaoTeste">
							
					</div>
						
						<label style="margin-left: 5px;"><fmt:message key="mensagem.informacao.tensaoBateriaVeiculo" />:</label><br/>
						<div class="colunaLabelInstrucaoTeste">
							
						</div>
						<div style="margin-top: 12px;" class="colunaInput" >							
							<input type="radio" id="idTML" name="parametroTela" 	
							 	value="12" class="required"/>12V
							 	
							<input type="radio" id="idTML" name="parametroTela" 	
							 	value="24" class="required" checked="checked"/>24V
						</div>
					</div>
				</c:if>
			
			<p class="input" style="padding:10px; margin-top:10px; text-align: center;">
				<input type="submit" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.continuar" />" />
			</p>	
		
		</fieldset>
	
	</form>
	
	<jsp:include page="/WEB-INF/views/Corporativo/Mobile/icones.jsp">
		<jsp:param name="voltar" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC13/dv02&numeroCPF=${param.numeroCPF}&numeroOS=${param.numeroOS}&reiniciarTestes=${param.reiniciarTestes}&indiceTeste=${param.indiceTeste}&tipoEquipamento=${param.tipoEquipamento}&origem=${param.origem}&numeroPlaca=${param.numeroPlaca} "/>
	</jsp:include>