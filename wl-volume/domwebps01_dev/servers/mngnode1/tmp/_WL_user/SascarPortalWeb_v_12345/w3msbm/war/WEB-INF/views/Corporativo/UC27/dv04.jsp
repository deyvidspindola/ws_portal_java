<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/ConsultarBorderosPagos/detalharOrdemServicoBordero?acao=3" context="/SascarPortalWeb"  />
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


<div class="cabecalho3" style="padding-left: 90px; width: 870px;">
	<fmt:message key="label.borderosPagos" />
	<span style="font-size: 11px;"> - <fmt:message key="label.conjuntoOSAbrev" /></span>
	
	<div class="caminho" style="">
		<a class="linktres" title="<fmt:message key="label.home" />" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}"><fmt:message key="label.home" /></a>
			&gt;
		<a class="linktres" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC27/dv01"><fmt:message key="label.pagamentos" /></a>
			&gt;
		<a class="linkquatro" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC27/dv01"><fmt:message key="label.borderosPagos" /></a>
	</div>
</div>

	<form method="post" 
		  id="formVoltar"
	      action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC27/dv03"> 
	   
	   	<input type="hidden" name="numeroBordero" 		value="${param.numeroBordero}" />
		<input type="hidden" name="representante" 		value="${param.representante}" />
		<input type="hidden" name="dataFechamento" 		value="${param.dataFechamento}" />
		<input type="hidden" name="filtroStatusBordero" value="${param.filtroStatusBordero}" />
	    <input type="hidden" name="valorTotalBordero"   value="${param.valorTotalBordero}" />
	   
	 </form>
	
	<form method="post" action="">
	
		<input type="hidden" name="numeroBordero" 		value="${param.numeroBordero}" />
		<input type="hidden" name="representante" 		value="${param.representante}" />
		<input type="hidden" name="dataFechamento" 		value="${param.dataFechamento}" />
		<input type="hidden" name="valorTotalBordero"   value="${param.valorTotalBordero}" />
		<input type="hidden" name="filtroStatusBordero" value="${param.filtroStatusBordero}" />
	
		<table class="tbatualizacao" cellspacing="0" width="1026">
			<tbody>
				<tr class="tbatualizacao">
					<th class="barraazulzinha"><fmt:message key="label.detalhesOS" /></th>
				</tr>
			</tbody>
		</table>
		
		<table width="900" cellspacing="3" class="detalhe2">
		  <tr>
		    <th width="200px" class="barracinza"><fmt:message key="label.numDaOrdemServico" /></th>
		    <td width="350px" class="camposinternos">${ordemServico.numero}</td>
		    <th width="200px" class="barracinza"><fmt:message key="label.cliente" /></th>
		    <td  width="350px" class="camposinternos">${ordemServico.contrato.contratante.nome}</td>
		  </tr>
		  <tr>
		    <th width="200px" class="barracinza"><fmt:message key="label.placa" /></th>
		    <td width="350px" class="camposinternos">${ordemServico.contrato.veiculo.placa}</td>
		    <th width="200px" class="barracinza"><fmt:message key="label.servicoContratado" /></th>
		    <td width="350px" class="camposinternos">${ordemServico.contrato.servicoContratado}</td>
		  </tr>
		  <tr>
		    <th width="200px" class="barracinza"><fmt:message key="label.tipoContrato" /></th>
		    <td width="350px" class="camposinternos">${ordemServico.contrato.tipoContrato}</td>
		    <th width="200px" class="barracinza"><fmt:message key="label.valorDeslocamento" /></th>
		    <td width="350px" class="camposinternos"><fmt:formatNumber value="${ordemServico.valorDeslocamento}" type="currency"/></td>
		  </tr>
		  <tr>
		    <th width="200px" class="barracinza"><fmt:message key="label.valorPedagio" /></th>
		    <td width="350px" class="camposinternos"><fmt:formatNumber value="${ordemServico.valorPedagio}" type="currency"/></td>
		    <th width="200px" class="barracinza"><fmt:message key="label.valorServico" /></th>
		    <td width="350px" class="camposinternos"><fmt:formatNumber value="${ordemServico.valorServico}" type="currency"/></td>
		  </tr>
		   <tr>
		    <th>&nbsp;</th>
		    <td width="350px" class="camposinternos">&nbsp;</td>
		   <th width="200px" class="barracinza"><fmt:message key="label.valorTotal" /></th>
		    <td width="350px" class="camposinternos"><fmt:formatNumber value="${ordemServico.valorTotalOrdemServico}" type="currency"/></td>
		  </tr>
		</table>
		
		<div class="pgstabela">
			<span class="busca_branca">
				<input class="button3" 
					   type="button" 
					   onclick="$('#formVoltar').submit();" 
					   value="<fmt:message key="label.voltar" />" />
			</span>
		</div>
	
	</form>