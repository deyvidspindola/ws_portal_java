<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/ConsultarBorderosPagos/listarOrdensServicoBordero?acao=2" context="/SascarPortalWeb"  />
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


</script>

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

<form id="formVoltar" method="post" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC27/dv02">
	<!-- CAMPOS UTILIZADOS NO FILTRO DA TELA DV01 -->
	<input type="hidden" name="filtroNumeroOS" 				value="${param.filtroNumeroOS}" />
	<input type="hidden" name="filtroDataInicialFechamento" value="${param.filtroDataInicialFechamento}" />
	<input type="hidden" name="filtroDataFinalFechamento" 	value="${param.filtroDataFinalFechamento}" />
	<input type="hidden" name="filtroDataInicialPagamento"  value="${param.filtroDataInicialPagamento}" />
	<input type="hidden" name="filtroDataFinalPagamento" 	value="${param.filtroDataFinalPagamento}" />
	<input type="hidden" name="filtroNumeroBordero" 		value="${param.filtroNumeroBordero}" />
	<input type="hidden" name="filtroStatusBordero"         value="${param.filtroStatusBordero}" />
</form>

<form method="post" 
	  onsubmit="openPopupPrint(this);" 
	  action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Imprimir&page=Corporativo/UC27/dv05">
	
	<input type="hidden" name="numeroBordero"       value="${param.numeroBordero}" />
	<input type="hidden" name="representante"       value="${param.representante}" />
	<input type="hidden" name="dataFechamento"      value="${param.dataFechamento}" />
	<input type="hidden" name="valorTotalBordero"   value="${param.valorTotalBordero}" />
	<input type="hidden" name="filtroStatusBordero" value="${param.filtroStatusBordero}" />
	
	
	<span class="text3" style="margin-left: 20px;">
		<fmt:message key="uc28.texto.005.aquiVcVerificaBorderoNumero"><fmt:param><span class="debito3">${param.numeroBordero}</span></fmt:param></fmt:message>		
	</span>
	
	<span class="texthelp2">
		<img hspace="5" height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png">
		<fmt:message key="uc28.texto.006.atencaoCliqueOSMaioresDetalhes" />
	</span>
	
	<table width="850" cellpadding="1" id="alter" cellspacing="0">
		<tr>
			<th width="50%" class="texttable_cinza" scope="col"><fmt:message key="label.nAbrevOS" /></th>
			<th width="50%" class="texttable_cinza" scope="col"><fmt:message key="label.valortotalOS" /></th>
		</tr>
		
		<c:forEach var="ordensServicoBordero" items="${listaOrdensServicoBordero}">
			<tr class="dif">
				<td><a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC27/dv04&numeroOS=${ordensServicoBordero.numero}&numeroBordero=${param.numeroBordero}&representante=${param.representante}&dataFechamento=${param.dataFechamento}&filtroStatusBordero=${param.filtroStatusBordero}&valorTotalBordero=${param.valorTotalBordero}" class="linkazul">${ordensServicoBordero.numero}</a></td>
				<td><fmt:formatNumber value="${ordensServicoBordero.valorTotal}" type="currency"/></td>
			</tr>
		</c:forEach>
	</table>
	
	<div class="pgstabela">
		<span class="busca_branca">
			<input class="button3"
				   type="button"
				   onclick="$('#formVoltar').submit();" 
				   value="<fmt:message key="label.voltar" />" />
			<input class="button" type="submit" onclick="" value="<fmt:message key="label.imprimir" />">
		</span>
	</div>
</form>
	
