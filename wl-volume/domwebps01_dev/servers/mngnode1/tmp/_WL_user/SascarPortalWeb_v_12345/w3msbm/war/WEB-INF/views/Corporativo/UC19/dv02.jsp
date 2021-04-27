<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>


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

	<div class="cabecalho2"><fmt:message key="label.extratoServicosExecutados" />
  		<div class="caminho">
	  		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" class="linktres"><fmt:message key="label.home" /></a> &gt;  
	  		<a href="#" class="linktres"><fmt:message key="label.pagamentos" /></a> &gt;   
	  		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC19/dv01" class="linkquatro"><fmt:message key="label.extratoServicosExecutados" /></a>
	  	</div>
 	</div>


	<form id="formPesquisa" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC19/dv03&
																										vtOS=${param.valorTotalOrdemServico }&
																										vtPend=${param.valorTotalPendencias }&
																										vtTestes=${param.valorTotalTestes }&
																										vtOCred=${param.valorTotalOutrosCreditos }&
																										vtDesc=${param.valorTotalDescontos }&
																										vtLiq=${param.valorTotalLiquido }&
																										vtNf=${param.valorTotalNotaFiscal }&
																										valorCustoEficiencia=${param.valorCustoEficiencia}&
																										tipoPesquisa=${param.tipoPesquisa}"
																										method="post" class="filtro">
				
				
		<table cellspacing="0" class="detalhe" >
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.resumoPagamentoServico" /></th>
			</tr>
		</table>
		
		
		<table width="960" cellpadding="1" id="alter_extrato" cellspacing="0">
			<tr>
				<th width="250" scope="col"><fmt:message key="label.totalOsComDocumentacaoAutorizada" /></th>
				<th width="280" scope="col"><fmt:message key="label.totalOsComPendecia" /></th>
				<th width="100" scope="col"><fmt:message key="label.valorTestes" /></th>
				<th width="70" scope="col"><fmt:message key="label.outrosCreditos" /></th>
				<th width="30" scope="col"><fmt:message key="label.desconto" /></th>
				<th width="70" scope="col"><fmt:message key="label.valorLiquido" /></th>
				<th width="90" scope="col"><fmt:message key="label.valorNf" /></th>
				<th width="70" scope="col"><fmt:message key="label.custoEficienciaOperacional" /></th>
			</tr>
			<tr class="dif">
				<td><fmt:formatNumber value="${param.valorTotalOrdemServico }" type="currency"/></td>
				<td><fmt:formatNumber value="${param.valorTotalPendencias }" type="currency"/></td>
				<td class="linkazulescuro"><fmt:formatNumber value="${param.valorTotalTestes }" type="currency"/></td>
				<td><fmt:formatNumber value="${param.valorTotalOutrosCreditos }" type="currency"/></td>
				<td><fmt:formatNumber value="${param.valorTotalDescontos }" type="currency"/></td>
				<td><fmt:formatNumber value="${param.valorTotalLiquido }" type="currency"/></td>
				<td class="linkazulescuro"><fmt:formatNumber value="${param.valorTotalNotaFiscal }" type="currency"/></td>
				<td class="linkazulescuro"><fmt:formatNumber value="${param.valorCustoEficiencia }" type="currency"/></td>
			</tr>
		</table>	
		
		<br>
		<br>	
		<input type="button" class="button3" value="Voltar" onclick="window.location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC19/dv01';" />
	    
		<div class="pgstabela">
			<input type="submit" class="button" value="<fmt:message key="label.detalhar" />" />
		    
			<input type="hidden" name="dataInicial" value="${param.dataInicial}" />
			<input type="hidden" name="dataFinal" value="${param.dataFinal}" />
			<input type="hidden" name="codigoInstalador" value="${param.codigoInstalador }" />
			<input type="hidden" name="codigoStatus" value="${param.codigoStatus }" />
			<input type="hidden" name="numeroOS" value="${param.numeroOS }" />			
		</div>
	</form>
	
		
		