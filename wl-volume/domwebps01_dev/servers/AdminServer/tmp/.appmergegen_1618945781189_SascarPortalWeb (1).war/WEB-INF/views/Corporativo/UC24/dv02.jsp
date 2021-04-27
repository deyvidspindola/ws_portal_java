<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/ConsultarVeiculosServlet/consultarVeiculos?acao=1" context="/SascarPortalWeb"  />
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
		$("div.breadcrumb").html('<fmt:message key="label.tituloAtendimentoConsultasVeiculos" />');
	});

	function abrirExcluirVeiculo(index){
		$("#dialog_excluir").jOverlay({'onSuccess' : function(){
			$("#indexVeiculoExcluir").val(index);
		}});
	}

	function abrirSolicitarRetirada(index){
		$("#dialog_solicitarRetirada").jOverlay({'onSuccess' : function(){
			$("#indexSolicitarRetirada").val(index);
		}});
	}
	
	function submeterRetiradaEquipamento() {
		var numeroContrato=$("#indexSolicitarRetirada").val();
		$.ajax({
			url: "/SascarPortalWeb/SolicitarRetiradaEquipamentoServlet/solicitarRetiradaEquipamento?acao=1",
			data: {"numeroContrato" : numeroContrato},
			dataType:"json",
			success: function(json){
				if (json.success) {
					$("#dialog_mensagem").find('h4').html('<fmt:message key="mensagem.sucesso.retirarEquipamento" />');
				} else {
					$("#dialog_mensagem").find('h4').html(json.mensagem);
				}
				$("#dialog_mensagem").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
			}
		});
	}
	
	
</script>

<jsp:include page="/WEB-INF/views/Corporativo/UC24/dv01.jsp" />

<c:if test="${not empty solicitacoes}" >
	
	<h1><fmt:message key="label.resultadoDaBusca" /></h1>
	
	<span class="texthelp2">
		<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" /><fmt:message key="label.cliqueNomeSeguradoHistoricoAtendimento" />
	</span>
	
	<table cellspacing="0" width="850" id="alter">
		<tr>
			<th colspan="2" width="350" class="texttable_azul" scope="col"><fmt:message key="label.segurado" /></th>
			<th width="80" class="texttable_cinza" scope="col"><fmt:message key="label.dataDeCadastro" /></th>
			<th width="100" class="texttable_azul"  scope="col"><fmt:message key="label.nProposta" /></th>
			<th width="80" class="texttable_cinza" scope="col"><fmt:message key="label.placa" /></th>
			<th width="100" class="texttable_azul" scope="col"><fmt:message key="label.chassi" /></th>
			<th width="100" class="texttable_azul" scope="col"><fmt:message key="label.emitirDeclaracao" /></th>
			<c:choose>
			<c:when test="${(param.menu eq '1' || param.menu eq '3')}">
				<th width="100" class="texttable_cinza" scope="col"><fmt:message key="label.solicitarRetirada" /></th>
			</c:when>
			</c:choose>
		</tr>

		<c:forEach var="solicitacao" varStatus="status" items="${solicitacoes }">
		<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if>>
					
			<td colspan="2" class="linkazul tooltip" title="Clique aqui para visualizar o histórico de atendimento" >
				<form id="formSubmeter_${status.index}" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC24/dv03&numeroContrato=${solicitacao.contrato.numeroContrato}" method="post">
					<input type="hidden" name="dataInicial" value="${param.dataInicial }" />
					<input type="hidden" name="dataFinal" value="${param.dataFinal }" />
					<input type="hidden" name="numeroPlaca" value="${param.numeroPlaca }" />
					<input type="hidden" name="tipoSeguradora" value="${param.tipoSeguradora }" />
					<input type="hidden" name="nomeCliente" value="${param.nomeCliente }" />
					<input type="hidden" name="numeroChassi" value="${param.numeroChassi }" />
					<input type="hidden" name="numeroProposta" value="${param.numeroProposta }" />
					<input type="hidden" name="menu" value="${param.menu}" />
					
					<input type="hidden" name="nome" value="${solicitacao.solicitante.nome}" />
					<input type="hidden" name="placa" value="${solicitacao.veiculoPlanta.placa }" />
					<input type="hidden" name="chassi" value="${solicitacao.veiculoPlanta.chassi }" />
					<input type="hidden" name="proposta" value="${solicitacao.apolice.numeroProposta }" />
					
					<input type="hidden" name="dataSolicitacao" value="<fmt:formatDate value="${solicitacao.dataInstalacao}" pattern="dd/MM/yyyy" />"/>
					<input type="hidden" name="dataCadastro" value="<fmt:formatDate value="${solicitacao.dataCadastro}" pattern="dd/MM/yyyy" />" />
					<input type="hidden" name="nomeSegurado" value="${solicitacao.segurado.nome}" />
					<input type="hidden" name="cpfCnpj" value="${solicitacao.segurado.numCpfCnpj }" />
					<input type="hidden" name="marca" value="${solicitacao.veiculoPlanta.descricaoMarca }" />
					<input type="hidden" name="modelo" value="${solicitacao.veiculoPlanta.descricaoModelo }" />
					<input type="hidden" name="ano" value="${solicitacao.veiculoPlanta.anoFabricacao }" />
					<input type="hidden" name="cor" value="${solicitacao.veiculoPlanta.cor }" />
					<input type="hidden" name="paginaAtual" value="${paginacao.paginaAtual }" />

					<a href="#submter" onclick="$('#formSubmeter_${status.index}').submit();">${solicitacao.segurado.nome }</a>
				</form>
			</td>
			
			<td><fmt:formatDate value="${solicitacao.dataCadastro}" pattern="dd/MM/yyyy" />&nbsp;</td>
			
			<td>${solicitacao.apolice.numeroProposta }&nbsp;</td>
			
			<td>${solicitacao.veiculoPlanta.placa }&nbsp;</td>
			
			<td>${solicitacao.veiculoPlanta.chassi }&nbsp;</td>
			
			<c:choose>
			<c:when test="${(param.menu eq '1' || param.menu eq '2' ||param.menu eq '3') and solicitacao.emitirDeclaracao}">
				<td class="linkazulescuro">
					<form method="post" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Imprimir&page=Corporativo/UC25/dv01" onsubmit="openPopupPrint(this);">
						<input type="hidden" value="${solicitacao.contrato.numeroContrato }" name="numeroContrato" />
							<a href="#" onclick="$(this).parent().submit();"/> 
								<img class="tooltip" title="Cique aqui para imprimir a declaração" hspace="5" height="24" border="0" align="absmiddle" width="24" alt="2ª via da Fatura" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/1304528228_monotone_printer_hardware.png">
							</a>
					</form>
				</td>
			</c:when>
			<c:otherwise>
				<td class="linkazulescuro">A&nbsp;</td>
			</c:otherwise>
			</c:choose>
			
			<c:choose>
			<c:when test="${(param.menu eq '1' || param.menu eq '3')}">
				<td align="center" nowrap="nowrap">
					<a href="javascript:abrirSolicitarRetirada('${solicitacao.contrato.numeroContrato }');" title="Solicitar Retirada"><fmt:message key="label.solicitarRetirada" /></a>
				</td>
			</c:when>
			</c:choose>
			
		</tr>

		</c:forEach>
	</table>
	
	<jsp:include page="/WEB-INF/views/paginacao.jsp">
		<jsp:param name="pagina" value="${paginacao.paginaAtual}"/>
		<jsp:param name="totalPaginas" value="${paginacao.totalPaginas}"/>
		<jsp:param name="formName" value="formPesquisa"/>
		<jsp:param name="url" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC24/dv02"/>
	</jsp:include>
	
	<div id="dialog" class="window modal_big" style="display: none;">
	</div>
	
	
	<div id="dialog_solicitarRetirada" class="popup_padrao" style="display: none;">
		<input type="hidden" id="indexSolicitarRetirada" />
		<div id="popup_msg_modal" class="popup_padrao_pergunta"><fmt:message key="mensagem.confirmacao.retiradaEquipamentoVeiculo" />
		</div>
	
	
		<div class="popup_padrao_resposta">
			<input type="submit" value="<fmt:message key="label.sim" />" class="button" onclick="submeterRetiradaEquipamento();"/>
			<input type="button" class="button4" value="<fmt:message key="label.nao" />" onclick="javascript:$.closeOverlay();"/>
		</div>
	
	</div>
	
	<div id="dialog_mensagem" class="popup_padrao" style="display: none;">
		<div id="popup_msg_modal" class="popup_padrao_pergunta"><fmt:message key="mensagem.sucesso.efetuarOperacao" />
		</div>
	
		<div class="popup_padrao_resposta">
			<input type="button" class="button" value="<fmt:message key="label.fechar" />" onclick="javascript:$.closeOverlay();"/>
		</div>
	</div>
</c:if>