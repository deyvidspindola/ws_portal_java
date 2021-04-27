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
		
	function abrirModalVisualizacaoObervacao(element){
		
		elemen = $(element).attr('name');
		
		var observacao = $("#observacaoOrdemServicoBordero"+elemen).val();
		
		$.ajax({
			url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC28/dv06",
			data: {"observacao" : observacao, "numeroBordero" :  $("#numeroBordero").val()},
			dataType:"html",
			success: function(html){
				$("#popupObservacaoOrdemServico").html(html).jOverlay({
					bgClickToClose : false, 
					closeOnEsc : false
				});
			}
		}); 		
	}
	
	function showModalConfirmarExclusaoOrdemServicoBordero(ordemServico) {
		
		$.ajax({
			url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC28/dv08",
			data: {"ordemServico" : ordemServico, "numeroBordero" : $("#numeroBordero").val()},
			dataType:"html",
			success: function(html){
				$("#popupSolicitacaoConfirmacaoRetirada").html(html).jOverlay({
					bgClickToClose : false, 
					closeOnEsc : false
				});
			}
		});
	}
	
	function confirmarExclusaoOrdemServico(numeroOrdemServico, numeroBordero){
		$.ajax({
			url: "/SascarPortalWeb/ConsultarBorderosPagos/removerOrdemServicoBordero?acao=7",
			data: {"ordemServico" : numeroOrdemServico, "numeroBordero" : numeroBordero},
			dataType:"json",
			success: function(json){
				if (json.success) {
					abrirModalConfirmacaoExclusaoOrdemServicoBordero();
				} else {
					$.showMessage(json.mensagem);
				}
			}
		});
	}
	
	function abrirModalConfirmacaoExclusaoOrdemServicoBordero(){
		$.ajax({
			url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC28/dv09",
			data: {},
			dataType:"html",
			success: function(html){
				$("#popupConfirmacaoRetirada").html(html).jOverlay({
					bgClickToClose : false, 
					closeOnEsc : false
				});
			}
		});
	}
		
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

	<form id="formAtualizar" method="post" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC28/dv03" >
		
		<input type="hidden" name="numeroBordero" id="numeroBordero" value="${param.numeroBordero}" />
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
		
	</form>

	<form action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Imprimir&page=Corporativo/UC28/dv07" 
		  onsubmit="openPopupPrint(this);"  
		  method="post">
		  
	  	<input type="hidden" name="numeroBordero" id="numeroBordero" value="${param.numeroBordero}" />
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
					<a class="linktres" title="<fmt:message key="label.home" />" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}"><fmt:message key="label.home" /></a>
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
		
		<table class="tabelaBorderos" id="alter" cellspacing="0" cellpadding="1" width="850">
			<tr>
				<th class="texttable_azul"  width="9%"  scope="col"><fmt:message key="label.statusOS" /></th>
				<th class="texttable_cinza" width="35%" scope="col"><fmt:message key="label.nAbrevOS" /></th>
				<th class="texttable_cinza" width="48%" scope="col"><fmt:message key="label.valortotalOS" /></th>
				<th class="texttable_azul"  width="8%"  scope="col"><fmt:message key="label.excluir" /></th>
			</tr>
			
			<c:forEach var="ordensServicoBordero" items="${listaOrdensServicoBordero}" varStatus="status">
			
				<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if> >
					<td class="linkazul">
						<img height="16" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/status_ordem_servico/status_ordem_servico_${ordensServicoBordero.status}.png" />
					</td>
					
					<td>
						
						<!-- R9. O Sistema deve apresentar um poup-up com a descrição do campo "Observação da conferência Sascar"
						     para Ordens de Serviço com status "Incompleto" e "Pendente"; -->
						<c:choose>
				 			<c:when test="${ordensServicoBordero.status eq 'R'}">
								<label class="linkDisable" >
									${ordensServicoBordero.numero}
								</label>
							</c:when>
							<c:otherwise>
								<a class="linkazul" href="#" name="${ordensServicoBordero.numero}" onclick="abrirModalVisualizacaoObervacao(this);" >
									<input type="hidden" id="observacaoOrdemServicoBordero${ordensServicoBordero.numero}" value="${ordensServicoBordero.observacao}" />
									${ordensServicoBordero.numero}
								</a>
							</c:otherwise>
						 </c:choose>
						
					</td>
					
					<td>
						<fmt:formatNumber value="${ordensServicoBordero.valorTotal}" type="currency" />	
					</td>
					
					<!-- R7. O Sistema deve possibilitar a exclusão de Ordem de Serviço com status "Incompleto". -->
			 		<td>
				 		<c:choose>
				 			<c:when test="${ordensServicoBordero.status eq 'I'}">
								<a href="#" onclick="showModalConfirmarExclusaoOrdemServicoBordero(${ordensServicoBordero.numero});" >
									<img height="16" width="16" border="0" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/excluir16-10.png">
								</a>
							</c:when>
							<c:otherwise>
								<a href='#'>
									<img height="16" width="16" border="0" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/excluir-cinza-10.png">
								</a>
							</c:otherwise>
						 </c:choose>
					</td>
					
				</tr>
			
			</c:forEach>
			
		</table>
		
		<div style="clear: both;"></div>
		<br />
	
		<div class="pgstabela">
			<span class="busca_branca">
				<input id="Limpar2" class="button3" type="button" onclick="$('#formVoltar').submit();" value="<fmt:message key="label.voltar" />" name="Voltar" />
				<input class="button" type="submit" value="<fmt:message key="label.imprimir" />" />
			</span>
		</div>
		
	</form>

	<!-- DIV MODAL DV03 - TELA OBSERVACAO ORDEM SERVICO  -->
	<div id="popupObservacaoOrdemServico" style="display: none;"></div>
	
	<!-- DIV MODAL DV08 - TELA SOLICITACAO DE CONFIRMACAO EXCLUSAO ORDEM SERVICO BORDERO -->
	<div id="popupSolicitacaoConfirmacaoRetirada" style="display: none;"></div>
	
	<!-- DIV MODAL DV09 - TELA CONFIRMACAO EXCLUSAO ORDEM SERVICO BORDERO -->
	<div id="popupConfirmacaoRetirada" style="display: none;"></div>
