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
						$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv07");
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
						$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv04");
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
						$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv04");
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
										
						$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv13"+str);
						$(form).unbind('submit').submit();
						
					} else {
						$(form).attr("action", "");
						$.showMessage(json.mensagem);
					}
				}
			});
		}
	
		$(document).ready(function(){
			
			var container = $('div.container2');
			$("#formAtualizar").validate({
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
							$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv04");
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

	<div class="container2"> 
		<ol>
			<li><label for="kilometragemInicial" class="error"><fmt:message key="mensagem.campoObrigatorio.kilometragem" /></label></li>
			<li><label for="kilometragemFinal" class="error"><fmt:message key="mensagem.campoObrigatorio.kilometragem" /></label></li>
			<li><label for="idTML" class="error"><fmt:message key="mensagem.campoObrigatorio.voltagemBateria" /></label></li>
		</ol>
	</div>

	<!-- FORM VOLTAR -->
	<form method="post" id="formVoltar" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv02">
		<input type="hidden" name="numeroCPF"       value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS"        value="${param.numeroOS }" />
		<input type="hidden" name="reiniciarTestes" value="${param.reiniciarTestes}" />
		<input type="hidden" name="indiceTeste"     value="${param.indiceTeste}" />
		<input type="hidden" name="tipoEquipamento" value="${param.tipoEquipamento}" />
		<input type="hidden" name="origem"          value="${param.origem}" />
		<input type="hidden" name="numeroPlaca" 	value="${param.numeroPlaca}" />	
		<input type="hidden" name="tipoTeste"		value="${teste.tipoTeste}"/>
		<input type="hidden" name="motivo"		value="${param.motivo}"/>
	</form>

	<form id="formAtualizar" action="" method="post">
	
		<input type="hidden" name="numeroCPF"   	 value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS"    	 value="${param.numeroOS }" />
		<input type="hidden" name="indiceTeste" 	 value="${empty param.indiceTeste ? 1 : param.indiceTeste }" />
		<input type="hidden" name="totalTestes" 	 value="${teste.total }" />
		<input type="hidden" name="codigoTeste"		 value="${teste.codigo}" />
		<input type="hidden" name="precisaoOdometro" value="${teste.precisaoOdometro}" />
		<input type="hidden" name="numeroPlaca" 	 value="${param.numeroPlaca}" />	
		
		<input type="hidden" name="reiniciarTestes" value="${param.reiniciarTestes}" />
		<input type="hidden" name="tipoEquipamento" value="${param.tipoEquipamento}" />
		<input type="hidden" name="origem"          value="${param.origem}" />
		<input type="hidden" name="tipoTeste"		value="${teste.tipoTeste}"/>	
		<input type="hidden" name="motivo"		value="${param.motivo}"/>
		<input type="hidden" name="numeroWebService" value="${teste.numeroWebService}" />
		
		
		<!-- INCLUDE DV03 - TIPO EQUIPAMENTO CASCO -->
		<div class="cabecalho3">
			<fmt:message key="label.testesAtivacaoEquipamento" />  
			<div class="caminho3" style="*margin-left:100px;">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a>&gt; 
				<a href="#" class="linktres"><fmt:message key="label.informacoes" /></a> &gt; 
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv01"  class="linkquatro"><fmt:message key="label.testesAtivacaoEquipamento" /></a>
			</div>
		</div>
	
		<div class="principal">
		
			<!-- INICIO BLOCO 01 - INSTRUCOES -->
			<div class="tarjaAzul">
				<label><fmt:message key="label.instrucoes" /></label>
			</div>
			
			<!-- ABRE DIV BLOCO -->	
			<div class="bloco">
	
				<div class="celulaInstrucaoTeste">
					<div class="colunaLabel">
						<label><fmt:message key="label.instrucao" /></label>
					</div>
				
					<div class="colulaCamposInternosInstrucaoTeste">
						<label>${teste.instrucao}</label>
					</div>
				</div>
				
				<!-- TESTE DE ODOMETRO INICIAL -->
				<c:if test="${teste.tipoTeste eq 'OI' }" >
					<div class="celula positionCelulaInstrucaoTeste">
						<div class="colunaLabelInstrucaoTeste">
							<label><fmt:message key="label.kilometragem" /></label>
						</div>
						
						<div class="colunaInput" > 
							<input type="text" id="kilometragemInicial" name="kilometragemInicial" maxlength="7" class="inputCelulaPequena required" />
						</div>
					</div>
				</c:if>
				
				<!-- TESTE DE ODOMETRO FINAL -->
				<c:if test="${teste.tipoTeste eq 'OF' }" >
					<div class="celula positionCelulaInstrucaoTeste">
						<div class="colunaLabelInstrucaoTeste">
							<label><fmt:message key="label.kilometragem" /></label>
						</div>
						
						<div class="colunaInput" > 
							<input type="text" id="kilometragemFinal" name="kilometragemFinal" maxlength="7" class="inputCelulaPequena required" />
						</div>
					</div>
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
	
				<!-- ANTES DE FECHAR A DIV BLOCO -->
				<div style="clear: both"></div>
			</div>
			<!-- FIM BLOCO 01 - INSTRUCOES -->
			 
				
			<!-- DIV BOTOES -->
			<div class="posicaoBotoes">
			
			     <div class="botoes">
				    <p>
				        <input type="button" onclick="$('#formVoltar').submit();" value="<fmt:message key="label.voltar" />" class="button4"/>
				        <input type="submit" class="button" value="<fmt:message key="label.continuar" />" />
				    </p>
			    </div>
			    
		    	<div style="clear: both;" ></div>
		    </div>
		    <!-- FIM DIV BOTOES -->
		
		</div>
		
	</form>

	