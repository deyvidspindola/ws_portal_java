<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper">
	<c:import url="/VerificarPermissao" context="/SascarPortalWeb"  />
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

<script>

	$(document).ready(function(){
		
		$("#botaoVoltarDv06").toggle();
		
	});
</script>

<jsp:include page="/WEB-INF/views/Corporativo/UC32/dv06.jsp">
	<jsp:param name="ativo" value="dv04" />
</jsp:include>

<body>

	<h1><fmt:message key="label.resultadoDeBusca" /></h1>
	
	<span class="text1" style="margin-left: 100px;"><fmt:message key="label.cliqueNaplacaSelecionar" />:</span>
	
	<table width="750" cellpadding="1" id="alter" cellspacing="0">
		<tr>
			<th width="10%" class="texttable_azul" scope="col"><fmt:message key="label.placa" /></th>
			<th width="25%" class="texttable_cinza" scope="col"><fmt:message key="label.chassi" /></th>
		</tr>
		
		<c:forEach var="contrato" items="${contratos}" varStatus="status">
			
			<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if>>
				<td class="linkazul">
					<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC32/dv07&numeroContrato=${contrato.numeroContrato}&numeroPlaca=${contrato.veiculo.placa}&pagina=${paginacao.paginaAtual}"
					title="<fmt:message key="label.veículosContatos" />" class="linkcinco">${contrato.veiculo.placa}</a>
				</td>
				<td>${contrato.veiculo.chassi}</td>
			</tr>
			
		</c:forEach>
	
	</table>
		
		
	<div class="botaovoltar" style="clear:both; margin-top:50px;position:absolute;">
		<input 
			class="button3" 
			type="button" 
			value="<fmt:message key="label.voltar" />" 
			name="Limpar"
			onclick="window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC32/dv02'">
	</div>
	
	
</body>

<br clear="all"/>
	
<div class="clear:both"></div>