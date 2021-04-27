<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/ConsultarBorderosPagos/listarBorderos?acao=1" context="/SascarPortalWeb"  />
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

<jsp:include page="/WEB-INF/views/Corporativo/UC27/dv01.jsp"/>

<c:if test="${not empty listaBorderos}" >

	<div style="margin-top: 30px;">
	
		<h1><fmt:message key="label.resultadoDaBusca" /></h1>
		
		<div class="busca_branca">
			<span class="text1"><fmt:message key="uc28.texto.004.atencaoCliqueNumeBorDetalhes" /></span>
		</div>
		
		<form action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC27/dv01" 
			  method="post" 
			  id="formVoltar">
		
		</form>
		
		<form action="" method="post">
		
			<table width="850" cellpadding="1" id="alter" cellspacing="0">
		
				<tr>
					<th width="25%" class="texttable_cinza" scope="col"><fmt:message key="label.dataHoraFechamentoL" /></th>
					<th width="25%" class="texttable_cinza" scope="col"><fmt:message key="label.nAbrevBordero" /></th>
					<th width="25%" class="texttable_cinza" scope="col"><fmt:message key="label.valor" /></th>
					<th width="25%" class="texttable_azul" scope="col"><fmt:message key="label.dataDePagamento" /></th>
				</tr>
			        
			    <c:forEach var="listaBorderos" items="${listaBorderos}" varStatus="status">
			    	
			    	<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if>>
						<td><fmt:formatDate value="${listaBorderos.dataHoraFechamento}" pattern="dd/MM/yyyy hh:mm"/>&nbsp;</td>
				        <td>
				        	<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC27/dv03&numeroBordero=${listaBorderos.numeroBordero}&representante=${listaBorderos.representante.nome}&dataFechamento=<fmt:formatDate value="${listaBorderos.dataHoraFechamento}" pattern="dd/MM/yyyy"/>&filtroNumeroOS=${param.filtroNumeroOS}&filtroDataInicialFechamento=${param.filtroDataInicialFechamento}&filtroDataFinalFechamento=${param.filtroDataFinalFechamento}&filtroDataInicialPagamento=${param.filtroDataInicialPagamento}&filtroDataFinalPagamento=${param.filtroDataFinalPagamento}&filtroNumeroBordero=${param.filtroNumeroBordero}&filtroStatusBordero=${param.filtroStatusBordero}&valorTotalBordero=${listaBorderos.valor}" class="linkazul">${listaBorderos.numeroBordero}</a>
				        </td>
				        <td><fmt:formatNumber value="${listaBorderos.valor}" type="currency"/></td>
				        <td class="linkazulescuro"><fmt:formatDate value="${listaBorderos.dataPagamento}" pattern="dd/MM/yyyy" />&nbsp;</td>
					</tr>
			    
			    </c:forEach>
				
			</table>
		
		</form>
		
		<div class="pgstabela">
			<span class="busca_branca">
				<input class="button3" 
					   type="button" 
					   onclick="$('#formVoltar').submit();" 
					   value="<fmt:message key="label.voltar" />" />
			</span>
		</div>
		
	</div>

</c:if>
