<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>
<c:catch var="helper" >
	<c:import url="/ConsultarPedidoEstoque/consultarListaPedidos?acao=1" context="/SascarPortalWeb"  />
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


<jsp:include page="/WEB-INF/views/Corporativo/UC40/dv01.jsp" />

<c:if test="${not empty listaPedidos}">
	<h1><fmt:message key="label.resultadoDaBusca" /></h1>
	
	<table id="alter" cellspacing="0" cellpadding="1" width="850">
		<tbody>		
			<tr>
				<th class="texttable_azul" width="28%" title="Data da abertura do serviço" scope="col"><fmt:message key="label.numeroDoPedido" /></th>
				<th class="texttable_cinza" width="15%" scope="col"><fmt:message key="label.dataDoPedido" /></th>
				<th class="texttable_cinza" width="15%" scope="col"><fmt:message key="label.Status" /></th>
				<th class="texttable_cinza" width="16%" scope="col"><fmt:message key="label.qtdeEquipamentos" /></th>
				<th class="texttable_cinza" width="15%" scope="col"><fmt:message key="label.qtdeMateriais" /></th>
			</tr>
		
			<c:forEach  items="${listaPedidos}" var="pedido" varStatus="contador">			 	
			<tr class="dif">
				<td class="linkazulescuro">
					<a class="linkazul" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC40/dv03&np=${param.numeroPedido}&numeroPedidoLink=${pedido.numero}&statusPedido=${param.statusPedido}&dataInicial=${param.dataInicial}&dataFinal=${param.dataFinal}">${pedido.numero}</a>
				</td>
				<td>${pedido.dataPedido}</td>
				<td> 
				  <c:if test="${pedido.status eq 'C'}"><fmt:message key="label.pedidoStatus.concluido" /></c:if>
				  <c:if test="${pedido.status eq 'P'}"><fmt:message key="label.pedidoStatus.pendente" /></c:if>
				  <c:if test="${pedido.status eq 'N'}"><fmt:message key="label.pedidoStatus.naoAutorizado" /></c:if>
				  <c:if test="${pedido.status eq 'A'}"><fmt:message key="label.pedidoStatus.aguardandoAutorizacao" /></c:if>
				  <c:if test="${pedido.status eq 'AA'}"><fmt:message key="label.pedidoStatus.aguardandoAutorizacaoAutomatica" /></c:if>
				  <c:if test="${pedido.status eq 'E'}"><fmt:message key="label.pedidoStatus.cancelado" /></c:if>
				</td>
				<td>${pedido.equipamento.quantidadeEquipamento}</td>
				<td>${pedido.produto.quantidade}</td>
			</tr>			
			</c:forEach>
		</tbody>
	</table>
<input class="button3" type="button" onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC40/dv01'" tabindex="10" value="<fmt:message key="label.voltar" />">	
</c:if>	
	