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
					
						$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC13/dv09");
						$(form).unbind('submit').submit();
						
					} else {
						$(form).attr("action", "");
						$.showMessage(json.mensagem);
					}
				}
			});
		} */
		
		function retornarTestes(){
			document.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC13/dv09&numeroCPF=${param.numeroCPF }&numeroOS=${param.numeroOS }&numeroPlaca=${param.numeroPlaca}&origem=${param.origem}&reiniciarTestes=S&testeExecutado=${param.testeExecutado}&codigoTeste=${param.codigoTeste}&indiceTeste=${param.indiceTeste}&tipoEquipamento=${param.tipoEquipamento} ';
		}
		
	</script>
	
	<!-- FORM VOLTAR  -->
	<form method="post" 
		  id="formVoltar" 
		  action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC13/dv03">
		
		<input type="hidden" name="numeroCPF"       value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS"        value="${param.numeroOS }" />
		<input type="hidden" name="indiceTeste"     value="${param.indiceTeste }" />
		<input type="hidden" name="reiniciarTestes" value="${param.reiniciarTestes}" />
		<input type="hidden" name="tipoEquipamento" value="${param.tipoEquipamento}" />
		<input type="hidden" name="codigoTeste"     value="${param.codigoTeste}" />
		<input type="hidden" name="origem"          value="${param.origem}" />
		<input type="hidden" name="numeroPlaca" 	value="${param.numeroPlaca}" />	
		
	</form>
	
	<form id="formAtualizar" 
		  method="post" 
		  action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC13/dv07" >
	
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
	
	<%-- formConfirmacaoKmInicial --%>
	<form id="formPesquisa" method="post" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC13/dv04" >
	
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
		
		<fieldset>
		
			<legend>
				<strong><fmt:message key="label.instrucoes" /></strong>
			</legend>
			
			<p class="input">
				<label><span><fmt:message key="label.kmInicialGravado" />:</span></label>
				<input type="text" value="${consultaKmOdometro.valorKm}" id="kilometragemFinal" name="kilometragemFinal" maxlength="7" class="inputCelulaPequena" disabled="disabled" />
			</p>
			
			<p class="input" style="padding:10px; margin-top:10px; text-align: center;">
				<input type="button" onclick="retornarTestes();" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.retornarAosTestes" />" />
			</p>
			
			<p class="input" style="padding:10px; margin-top:10px; text-align: center;">
				<input type="button" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.voltar" />" onclick="$('#formVoltar').submit();" />
			</p>
			
			<p class="input" style="padding:10px; margin-top:10px; text-align: center;">
				<input type="button" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.atualizar" />" onclick="$('#formAtualizar').submit();" />
			</p>
			
			<p class="input" style="padding:10px; margin-top:10px; text-align: center;">
				<input type="submit" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.continuar" />"/> 
			</p>
			
		</fieldset>
		
	</form>

	<jsp:include page="/WEB-INF/views/Corporativo/Mobile/icones.jsp">
		<jsp:param name="voltar" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC13/dv03&numeroCPF=${param.numeroCPF}&numeroOS=${param.numeroOS}&indiceTeste=${param.indiceTeste }&reiniciarTestes=${param.reiniciarTestes}&tipoEquipamento=${param.tipoEquipamento}&origem=${param.origem}&numeroPlaca=${param.numeroPlaca} "/>
	</jsp:include>