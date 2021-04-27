<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/ConsultarBorderosPagos/listarOrdensServicoBordero?acao=2" context="/SascarPortalWeb"  />
</c:catch>

<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$.showMessage('${mensagem}');
	</script>
</c:if>

<c:if test="${not empty helper}">
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>


<script type="text/javascript">

</script>

	<form id="formVoltar" method="post" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC28/dv02" >
		<input type="hidden" id="filtroNumeroOS" 			   name="filtrotNumeroOS" 			   value="${param.filtroNumeroOS}" />
		<input type="hidden" id="filtroNumeroBordero" 		   name="filtroNumeroBordero" 		   value="${param.filtroNumeroBordero}" />
		<input type="hidden" id="filtroDataInicialFechamento"  name="filtroDataInicialFechamento"  value="${param.filtroDataInicialFechamento}" />
		<input type="hidden" id="filtroDataFinalFechamento"    name="filtroDataFinalFechamento"    value="${param.filtroDataFinalFechamento}" />
		<input type="hidden" id="filtroStatusBordero"          name="filtroStatusBordero"          value="${param.filtroStatusBordero}" />
		
		<input type="hidden" id="filtroImputNumeroOS" 			   name="filtroImputNumeroOS" 			   value="${param.filtroNumeroOS}" />
		<input type="hidden" id="filtroImputNumeroBordero" 		   name="filtroImputNumeroBordero" 		   value="${param.filtroNumeroBordero}" />
		<input type="hidden" id="filtroImputDataInicialFechamento" name="filtroImputDataInicialFechamento" value="${param.filtroDataInicialFechamento}" />
		<input type="hidden" id="filtroImputDataFinalFechamento"   name="filtroImputDataFinalFechamento"   value="${param.filtroDataFinalFechamento}" />
		<input type="hidden" id="filtroImputStatusBordero"         name="filtroImputStatusBordero"         value="${param.filtroStatusBordero}" />
	</form>
	
	<form action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Imprimir&page=Corporativo/UC28/dv07" 
		  onsubmit="openPopupPrint(this);" 
		  method="post">
		  
		<input type="hidden" name="numeroBordero"  value="${param.numeroBordero}" />
		<input type="hidden" name="representante"  value="${param.representante}" />
		<input type="hidden" name="dataFechamento" value="${param.dataFechamento}" />
		<input type="hidden" name="valorBordero"   value="${param.valorBordero}" />
		
		<input type="hidden" id="filtroNumeroOS" 			   name="filtrotNumeroOS" 			   value="${param.filtroNumeroOS}" />
		<input type="hidden" id="filtroNumeroBordero" 		   name="filtroNumeroBordero" 		   value="${param.filtroNumeroBordero}" />
		<input type="hidden" id="filtroDataInicialFechamento"  name="filtroDataInicialFechamento"  value="${param.filtroDataInicialFechamento}" />
		<input type="hidden" id="filtroDataFinalFechamento"    name="filtroDataFinalFechamento"    value="${param.filtroDataFinalFechamento}" />
		<input type="hidden" id="filtroStatusBordero"          name="filtroStatusBordero"          value="${param.filtroStatusBordero}" />
		
		<input type="hidden" id="filtroImputNumeroOS" 			   name="filtroImputNumeroOS" 			   value="${param.filtroNumeroOS}" />
		<input type="hidden" id="filtroImputNumeroBordero" 		   name="filtroImputNumeroBordero" 		   value="${param.filtroNumeroBordero}" />
		<input type="hidden" id="filtroImputDataInicialFechamento" name="filtroImputDataInicialFechamento" value="${param.filtroDataInicialFechamento}" />
		<input type="hidden" id="filtroImputDataFinalFechamento"   name="filtroImputDataFinalFechamento"   value="${param.filtroDataFinalFechamento}" />
		<input type="hidden" id="filtroImputStatusBordero"         name="filtroImputStatusBordero"         value="${param.filtroStatusBordero}" />
		
		<div class="cabecalho3" style="padding-left: 40px; width: 920px;">
			<fmt:message key="label.borderosTramitacao" />
			<span style="font-size: 11px;"> - <fmt:message key="label.conjuntoOSAbrev" /></span>
				<div class="caminho" style="margin-left: 200px;">
					<a class="linktres" title="Home" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}"><fmt:message key="label.home" /></a>
					&gt;
					<a class="linktres" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC28/dv01"><fmt:message key="label.pagamentos" /></a>
					&gt;
					<a class="linkquatro" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC28/dv01"><fmt:message key="label.borderosTramitacao" /></a>
				</div>
		</div>
	
		<span class="text1" style="margin-left: 20px;"><fmt:message key="uc28.texto.005.aquiVcVerificaBorderoNumero"><fmt:param>${param.numeroBordero}</fmt:param></fmt:message></span>
	
		<span class="texthelp2">
			<img hspace="5" height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png">
			<fmt:message key="uc28.texto.006.atencaoCliqueOSMaioresDetalhes" />
		</span>
	
		<div class="busca_branca">
			<div style="width: 450px; float: right;">
				<span class="texthelp2" style="">
					<img hspace="5" height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png">
					<fmt:message key="label.legenda" />:
					<span class="tooltip" title="<fmt:message key="mensagem.informacao.borderosProcessoPagamento" />">
						<img height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/status_ok.png">
						<fmt:message key="label.recebido" />
					</span>
					<span class="tooltip" title="<fmt:message key="mensagem.informacao.borderosConferenciaTramitacao" />">
						<img height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/status_pend.png">
						<fmt:message key="label.pendente" />
					</span>
					<span class="tooltip" title="<fmt:message key="mensagem.informacao.borderosPendenciasRegularizacao" />">
						<img height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/status_nook.png">
						<fmt:message key="label.incompleto" />
					</span>
				</span>
			</div>
		</div>
	
		<table class="tabelaBorderos" id="alter" cellspacing="0" cellpadding="1" width="600">
			<tr>
				<th class="texttable_azul"  width="10%" scope="col"><fmt:message key="label.statusOS" /></th>
				<th class="texttable_cinza" width="35%" scope="col"><fmt:message key="label.numOSTermoAditivo" /></th>
				<th class="texttable_cinza" width="20%" scope="col"><fmt:message key="label.valortotalOS" /></th>
			</tr>
			
			<c:forEach var="ordensServicoBordero" items="${listaOrdensServicoBordero}" varStatus="status">
			
				<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if> >
					<td class="linkazul">
						<img height="16" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/status_ordem_servico/status_ordem_servico_${ordensServicoBordero.status}.png" />
					</td>
					<td>
						<a class="linkazul" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC28/dv05&numeroOS=${ordensServicoBordero.numero}&numeroBordero=${param.numeroBordero}&filtroNumeroOS=${param.filtroImputNumeroOS}&filtroNumeroBordero=${param.filtroNumeroBordero}&filtroDataInicialFechamento=${param.filtroDataInicialFechamento}&filtroDataFinalFechamento=${param.filtroDataFinalFechamento}&filtroStatusBordero=${param.filtroStatusBordero}">
							${ordensServicoBordero.numero}
								<c:if test="${ordensServicoBordero.numeroTermo != null}">
									 / ${ordensServicoBordero.numeroTermo}  
								</c:if>
						</a>
					</td>
					<td>
						<fmt:formatNumber value="${ordensServicoBordero.valorTotal}" type="currency" />	
					</td>
				</tr>
			
			</c:forEach>
			
		</table>
		
		<div style="clear:both;"></div>
		<br />
		
		<div class="pgstabela">
			<span class="busca_branca">
				<input id="Limpar2" class="button3" type="button" onclick="$('#formVoltar').submit();" value="<fmt:message key="label.voltar" />" name="Voltar" />				
				<input class="button" type="submit" value="<fmt:message key="label.imprimir" />" />
			</span>
		</div>
	</form>

