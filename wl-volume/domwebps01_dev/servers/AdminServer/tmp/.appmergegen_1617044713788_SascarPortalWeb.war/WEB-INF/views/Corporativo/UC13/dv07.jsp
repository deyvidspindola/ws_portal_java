<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/AtivarEquipamentoTestes/consultarKmOdometro?acao=12" context="/SascarPortalWeb"  />
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
	<form method="post" id="formAtualizar" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv07">
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
	
	<form id="formConfirmacaoKmInicial" 
		  method="post" 
		  action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv04" >
	
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
		<input type="hidden" name="idTipoTeste" value="${idTipoTeste}" />
	
		<div class="cabecalho3">
			<fmt:message key="label.confirmacaoKmInicial" />
			<div class="caminho3" style="*margin-left:100px;">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a>&gt; 
				<a href="#" class="linktres"><fmt:message key="label.informacoes" /></a> &gt; 
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC13/dv01"  class="linkquatro"><fmt:message key="label.testesAtivacaoEquipamento" /></a>
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
						<label><fmt:message key="label.kmInicialGravado" /></label>
					</div>
				
					<div class="colunaInput" > 
						<input type="text" value="${consultaKmOdometro.valorKm}" id="kilometragemFinal" name="kilometragemFinal" maxlength="7" class="inputCelulaPequena" disabled="disabled" />
					</div>
				</div>
			
			
				<!-- ANTES DE FECHAR A DIV BLOCO -->
				<div style="clear: both"></div>
			</div>
			<!-- FIM BLOCO 01 - INSTRUCOES -->
			
			<!-- DIV BOTOES -->
			<div class="posicaoBotoes">
			
			     <div class="botoes_confirmacao_km_inicial" style="width: 360px;">
				    <p>
				        <input type="button" class="button4" value="<fmt:message key="label.voltar" />"              onclick="$('#formVoltar').submit();" />
				        <input type="button" class="button4" value="<fmt:message key="label.retornarAosTestes" />" onclick="$('#formRetornarTestes').submit();"/>
				        <input type="button" class="button"  value="<fmt:message key="label.atualizar" />"			 onclick="$('#formAtualizar').submit();" />
				        <input type="submit" class="button"  value="<fmt:message key="label.continuar" />" />
				    </p>
			    </div>
			    
		    	<div style="clear: both;" ></div>
		    </div>
		    <!-- FIM DIV BOTOES -->
			
		</div>
	</form>