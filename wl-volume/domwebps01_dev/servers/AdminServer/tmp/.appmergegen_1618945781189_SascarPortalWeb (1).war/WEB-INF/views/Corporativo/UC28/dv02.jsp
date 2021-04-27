<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/ConsultarBorderosPagos/listarBorderos?acao=1" context="/SascarPortalWeb"  />
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

<jsp:include page="/WEB-INF/views/Corporativo/UC28/dv01.jsp" />

<c:if test="${not empty listaBorderos}" >

	<form action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC28/dv01" 
		  method="post" id="formVoltar">
	
	</form>

	<form action="" method="post">
	
		<input type="hidden" id="filtroNumeroOS" 			   name="filtrotNumeroOS" 			   value="${param.filtroNumeroOS}" />
		<input type="hidden" id="filtroNumeroBordero" 		   name="filtroNumeroBordero" 		   value="${param.filtroNumeroBordero}" />
		<input type="hidden" id="filtroDataInicialFechamento"  name="filtroDataInicialFechamento"  value="${param.filtroDataInicialFechamento}" />
		<input type="hidden" id="filtroDataFinalFechamento"    name="filtroDataFinalFechamento"    value="${param.filtroDataFinalFechamento}" />
		<input type="hidden" id="filtroStatusBordero"          name="filtroStatusBordero"          value="${param.filtroStatusBordero}" />
	
		<div style="margin-top: 30px;">
			
			<h1><fmt:message key="label.resultadoDaBusca" /></h1>
			
			<div class="busca_branca" style="width: 840px;
											 height: 100px;
											 padding: 10px 20px 5px 100px;" >
			
				<span class="text1"><fmt:message key="uc28.texto.003.aquiVcVerificaResultadoBorStatus" /></span>
				
				<div style="clear:both;"></div>
				<br />
				
				<span class="texthelp2" >
					<img hspace="5" height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png">
					<fmt:message key="uc28.texto.004.atencaoCliqueNumeBorDetalhes" />
				</span>
				
				<div style="clear:both;"></div>
				
				<div style="width: 450px; float: right; display: block; ">
					<span class="texthelp2" style="">
						<img hspace="5" height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png">
						<fmt:message key="label.legenda" />:
						<span class="tooltip" title="Borderôs conferidos, em processo de pagamento.">
							<img height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/status_ok.png">
							<fmt:message key="label.statusBorderoC" />
						</span>
						<span class="tooltip" title="Borderôs em processo de conferência e tramitação.">
							<img height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/status_pend.png">
							<fmt:message key="label.statusBorderoP" />
						</span>
						<span class="tooltip" title="Borderôs analisados e com pendências pra regularização.">
							<img height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/status_nook.png">
							<fmt:message key="label.statusBorderoI" />
						</span>
					</span>
				</div>
			</div>
			
			<table id="alter" cellspacing="0" cellpadding="1" width="850" style="display: inline-table;">
				<tr>
					<th class="texttable_azul"  width="20%" scope="col"><fmt:message key="label.statusBordero" /></th>
					<th class="texttable_cinza" width="25%" scope="col"><fmt:message key="label.dataHoraFechamentoL" /></th>
					<th class="texttable_cinza" width="20%" scope="col"><fmt:message key="label.dataRecebimento" /></th>
					<th class="texttable_cinza" width="20%" scope="col"><fmt:message key="label.nAbrevBordero" /></th>
					<th class="texttable_cinza" width="15%" scope="col"><fmt:message key="label.valor" /></th>
				</tr>
				
				<c:forEach var="listaBorderos" items="${listaBorderos}" varStatus="status">
				
					<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if> >
					
						<td class="linkazul" >
							<img height="16" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/status_bordero/status_bordero_${listaBorderos.status}.png" />
						</td>
						<td>
							<fmt:formatDate value="${listaBorderos.dataHoraFechamento}" pattern="dd/MM/yyyy HH:mm"/>
						</td>
						<td>
							<fmt:formatDate value="${listaBorderos.dataRecebimento}" pattern="dd/MM/yyyy"/>
						</td>
						<td>
						
							<c:choose>
								<c:when test="${listaBorderos.status eq 'I'}">
									<a class="linkazul" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC28/dv03&numeroBordero=${listaBorderos.numeroBordero}&representante=${listaBorderos.representante.nome}&dataFechamento=<fmt:formatDate value="${listaBorderos.dataHoraFechamento}" pattern="dd/MM/yyyy"/>&filtroNumeroOS=${param.filtroImputNumeroOS}&filtroNumeroBordero=${param.filtroNumeroBordero}&filtroDataInicialFechamento=${param.filtroDataInicialFechamento}&filtroDataFinalFechamento=${param.filtroDataFinalFechamento}&filtroStatusBordero=${param.filtroStatusBordero}&valorBordero=${listaBorderos.valor}" >
										${listaBorderos.numeroBordero}
									</a>
								</c:when>
								<c:when test="${listaBorderos.status eq 'P'}">
									<a class="linkazul" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC28/dv04&numeroBordero=${listaBorderos.numeroBordero}&representante=${listaBorderos.representante.nome}&dataFechamento=<fmt:formatDate value="${listaBorderos.dataHoraFechamento}" pattern="dd/MM/yyyy"/>&valorBordero=${listaBorderos.valor}&filtroNumeroOS=${param.filtroImputNumeroOS}&filtroNumeroBordero=${param.filtroNumeroBordero}&filtroDataInicialFechamento=${param.filtroDataInicialFechamento}&filtroDataFinalFechamento=${param.filtroDataFinalFechamento}&filtroStatusBordero=${param.filtroStatusBordero}&valorBordero=${listaBorderos.valor}" >
										${listaBorderos.numeroBordero}
									</a>
								</c:when>
								<c:when test="${listaBorderos.status eq 'C'}">
									<a class="linkazul" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC28/dv04&numeroBordero=${listaBorderos.numeroBordero}&representante=${listaBorderos.representante.nome}&dataFechamento=<fmt:formatDate value="${listaBorderos.dataHoraFechamento}" pattern="dd/MM/yyyy"/>&valorBordero=${listaBorderos.valor}&filtroNumeroOS=${param.filtroImputNumeroOS}&filtroNumeroBordero=${param.filtroNumeroBordero}&filtroDataInicialFechamento=${param.filtroDataInicialFechamento}&filtroDataFinalFechamento=${param.filtroDataFinalFechamento}&filtroStatusBordero=${param.filtroStatusBordero}&valorBordero=${listaBorderos.valor}" >
										${listaBorderos.numeroBordero}
									</a>
								</c:when>
							</c:choose>
						</td>
						<td>
							<fmt:formatNumber value="${listaBorderos.valor}" type="currency"/>
						</td>
				
					</tr>
					
				</c:forEach>
					
			</table>
			
		</div>
		
	</form>
	
	<div class="pgstabela">
		<span class="busca_branca">
			<input class="button3" 
				   type="button" 
				   onclick="$('#formVoltar').submit();" 
				   value="<fmt:message key="label.voltar" />" />
		</span>
	</div>

</c:if>
	