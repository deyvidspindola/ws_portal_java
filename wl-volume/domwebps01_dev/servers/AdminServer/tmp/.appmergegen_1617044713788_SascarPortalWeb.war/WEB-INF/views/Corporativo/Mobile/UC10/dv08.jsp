<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
<c:catch var="helper" >
	<c:import url="/AtivarEquipamentoVinculo/listarAcessorios?acao=8" context="/SascarPortalWeb"  />
</c:catch>

<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$.showMessage("${mensagem }");
	</script>
</c:if>

<c:if test="${not empty helper}" >
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>

<script type="text/javascript">
	$(document).ready(function(){
		$('#ativar_equipamento').addClass('active');
	});
</script>

	<form id="formPesquisa" 
			method="post"
			action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv09&numeroOS=${param.numeroOS }&numeroCPF=${param.numeroCPF }">
		
		<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
		<input type="hidden" name="codigoItem" value="${acessorio.codigoItem }" />
		<input type="hidden" name="codigoAcessorio" value="${acessorio.codigo }" />
		
		<c:if test="${not empty acessoriosSerial}">
		
			<h2><fmt:message key="uc10.dv08.tabelaServicoContratadosSerial" /></h2>
		    <table cellspacing="1" width="100%" cellpadding="3" class="list">
		        <tbody>
		            <tr>
		                <th><fmt:message key="label.acessorio" /></th>
		                <th><fmt:message key="label.serial" /></th>
		                <th><fmt:message key="label.porta" /></th>
		                <th><fmt:message key="label.local" /></th>
		            </tr>
	
		            <c:forEach var="acessorio" items="${acessoriosSerial}">
			            <tr>
			                <td>${acessorio.descricao}&nbsp;</td>
							<td style="text-align: center;">${acessorio.numeroSerial}&nbsp;</td>
							<td style="text-align: center;">${acessorio.codigoPorta}&nbsp;</td>
							<td>${acessorio.descricaoLocalInstalacao}&nbsp;</td>
			            </tr>
					</c:forEach>
	
		        </tbody>
		    </table>
	
		    <div class="hr"></div>
	
	    </c:if>
	
		<c:if test="${not empty acessoriosQuantidade}">
	
		    <h2><fmt:message key="uc10.dv08.tabelaServicosContratadosSemSerial" /></h2>
		    <table cellspacing="1" width="100%" cellpadding="3" class="list">
		        <tbody>
		            <tr>
		                <th><fmt:message key="label.acessorio" /></th>
		                <th><fmt:message key="label.qtde" /></th>
		                <th><fmt:message key="label.porta" /></th>
		                <th><fmt:message key="label.local" /></th>
		            </tr>
		
					<c:forEach var="acessorio" items="${acessoriosQuantidade}">
			            <tr>
			                <td>${acessorio.descricao}&nbsp;</td>
							<td style="text-align: center;">${acessorio.quantidade}&nbsp;</td>
							<td style="text-align: center;">${acessorio.codigoPorta}&nbsp;</td>
							<td>${acessorio.descricaoLocalInstalacao}&nbsp;</td>
			            </tr>
					</c:forEach>
		
		        </tbody>
		    </table>
	
		</c:if>
	    
		<p class="input" style="padding:10px; margin-top:10px; text-align: center;">
			<input type="submit" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.continuar" />" />
		</p>
	
	</form>

	<jsp:include page="/WEB-INF/views/Corporativo/Mobile/icones.jsp">
		<jsp:param name="voltar" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv07&numeroOS=${param.numeroOS }&numeroCPF=${param.numeroCPF}&tipoSubmeter=A"/>
	</jsp:include>
