<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
<meta http-equiv="Cache-Control" content="no-cache"/>

<c:catch var="helper" >
	<c:import url="/AtivarEquipamentoTestes/recuperaTestePortal?acao=15" context="/SascarPortalWeb"  />
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
	
		function solicitarNovaPosicao(){
				
				var cpf 		= $('#numeroCPF').val();
				var numeroOs 	= $('#numeroOS').val();
				var codigoTeste = $('#codigoTeste').val();
				var novaPosicao = $('#novaPosicao').val();
				
				/* var data = $(form).serialize(); */
				$.ajax({
					url: "/SascarPortalWeb/AtivarEquipamentoTestes/recuperaTestePortal?acao=15",
					data: {
						numeroCPF 		: cpf,
						numeroOS	: numeroOs,
						codigoTeste	: codigoTeste,
						novaPosicao : novaPosicao
					},
					success: function(){
							$('#formAtualizar').submit();					
					},
					error: function (request, status, error) {
						$.showMessage("${mensagem}");
				    }
				});
			}
		/* function submeterDadosTeste(form){
		
			var data = $(form).serialize();
			
			$.ajax({
				url: "/SascarPortalWeb/AtivarEquipamentoTestes/submeterExecucaoTeste?acao=7",
				data: data || {},
				dataType:"json",
				success: function(json){
					if (json.success) {
					
						$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv09");
						$(form).unbind('submit').submit();
						
					} else {
						$(form).attr("action", "");
						$.showMessage(json.mensagem);
					}
				}
			});
		} */
		
	</script>
	
	<!-- FORM VOLTAR  -->
	<form method="post" id="formVoltar" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv03">
		<input type="hidden" name="numeroCPF"       value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS"        value="${param.numeroOS }" />
		<input type="hidden" name="indiceTeste"     value="${param.indiceTeste }" />
		<input type="hidden" name="reiniciarTestes" value="${param.reiniciarTestes}" />
		<input type="hidden" name="tipoEquipamento" value="${param.tipoEquipamento}" />
		<input type="hidden" name="codigoTeste"     value="${param.codigoTeste}" />
		<input type="hidden" name="origem"          value="${param.origem}" />
		<input type="hidden" name="numeroPlaca" 	value="${param.numeroPlaca}" />	
		<input type="hidden" name="numeroWebService" value="${param.numeroWebService}" />
	</form>
	
	<!-- FORM RETORNAR AOS TESTES -->
	<form method="post" id="formRetornarTestes" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv09">
		<input type="hidden" name="numeroCPF"       value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS"        value="${param.numeroOS }" />
		<input type="hidden" name="origem"          value="${param.origem }" />
		<input type="hidden" name="reiniciarTestes" value="${param.reiniciarTestes}" />
		<input type="hidden" name="testeExecutado"  value="${param.testeExecutado}" />
		<input type="hidden" name="codigoTeste"     value="${param.codigoTeste}" />
		<input type="hidden" name="indiceTeste"     value="${param.indiceTeste}" />
		<input type="hidden" name="tipoEquipamento" value="${param.tipoEquipamento}" />
		<input type="hidden" name="numeroPlaca" 	value="${param.numeroPlaca}" />
		<input type="hidden" name="numeroWebService" value="${param.numeroWebService}" />	
	</form>
	
	<!-- FORM RETORNAR AOS TESTES -->
	<form method="post" id="formAtualizar" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv13">
		<input type="hidden" name="numeroCPF"       value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS"        value="${param.numeroOS }" />
		<input type="hidden" name="origem"          value="${param.origem }" />
		<input type="hidden" name="reiniciarTestes" value="${param.reiniciarTestes}" />
		<input type="hidden" name="testeExecutado"  value="${param.testeExecutado}" />
		<input type="hidden" name="codigoTeste"     value="${param.codigoTeste}" />
		<input type="hidden" name="indiceTeste"     value="${param.indiceTeste}" />
		<input type="hidden" name="tipoEquipamento" value="${param.tipoEquipamento}" />
		<input type="hidden" name="numeroPlaca" 	value="${param.numeroPlaca}" />	
		<input type="hidden" name="tipoTeste"		value="${param.tipoTeste}"/>
		<input type="hidden" name="numeroWebService" value="${param.numeroWebService}" />
	</form>
	
	<form id="formTestePortal" 
		  method="post" 
		  action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv04" >
	
		<input type="hidden" name="numeroCPF" id="numeroCPF"		value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS"  id="numeroOS"			value="${param.numeroOS }" />
		<input type="hidden" name="origem"          				value="${param.origem }" />
		<input type="hidden" name="reiniciarTestes" 				value="${param.reiniciarTestes}" />
		<input type="hidden" name="testeExecutado"  				value="${param.testeExecutado}" />
		<input type="hidden" name="codigoTeste"  id="codigoTeste"	value="${param.codigoTeste}" />
		<input type="hidden" name="indiceTeste"   					value="${param.indiceTeste}" />
		<input type="hidden" name="tipoEquipamento" 				value="${param.tipoEquipamento}" />
		<input type="hidden" name="numeroPlaca" 					value="${param.numeroPlaca}" />
		<input type="hidden" name="novaPosicao"	id="novaPosicao"	value="true"/>
		<input type="hidden" name="numeroWebService" value="${param.numeroWebService}" />
	
		<div class="cabecalho3">
			${teste.tituloTeste}
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
			
			<br/>
			
			<div class="observacao">${teste.tituloTeste}</div>
			
			<!-- ABRE DIV BLOCO -->	
			<div class="bloco">
				
				
				<div class="celulaInstrucaoTeste">
				
					<c:if test="${param.tipoTeste ne 'CTP'}">
						<div class="colunaLabel">
							<label>${teste.campoTeste}</label>
						</div>
					
						<div class="colunaInput" > 
							<input type="text" value="${teste.valorTeste}" id="valorTeste" name="valorTeste" maxlength="6" class="inputCelulaPequena" readonly="readonly" />
						</div>
					</c:if>
					<c:if test="${param.tipoTeste eq 'CTP'}">
						<div >
							<label>${teste.valorTeste}</label>
						</div>
					</c:if>	
				</div>	
					
			
				<!-- ANTES DE FECHAR A DIV BLOCO -->
				<div style="clear: both"></div>
			</div>
			<!-- FIM BLOCO 01 - INSTRUCOES -->
			
			<!-- DIV BOTOES -->
			<div class="posicaoBotoes">
			
			     <div class="" style="width: 475px;">
				    <p>
				        <input type="button" class="button4" value="<fmt:message key="label.voltar" />"              onclick="$('#formVoltar').submit();" />
				        <input type="button" class="button4" value="<fmt:message key="label.retornarAosTestes" />" onclick="$('#formRetornarTestes').submit();"/>
				        <input type="button" class="button"  value="<fmt:message key="label.atualizar" />"			 onclick="$('#formAtualizar').submit();" />
				        <c:if test="${param.tipoTeste eq 'CTP'}">
				        	<input type="button" class="button"  value="<fmt:message key="label.solicitarNovaposicao" />" onclick="solicitarNovaPosicao();" />
				        </c:if>
				        <input type="submit" class="button"  value="<fmt:message key="label.continuar" />" />
				    </p>
			    </div>
			    
		    	<div style="clear: both;" ></div>
		    </div>
		    <!-- FIM DIV BOTOES -->
			
		</div>
	</form>