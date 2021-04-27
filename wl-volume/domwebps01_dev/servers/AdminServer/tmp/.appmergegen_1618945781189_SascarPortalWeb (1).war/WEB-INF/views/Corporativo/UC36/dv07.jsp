<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/ConsultarPendenciasUsuario/detalharHistoricoServicosRealizados?acao=2" context="/SascarPortalWeb"  />
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

	$(document).ready(function(){
			window.print();
		});
		
</script>

<form method="post" onsubmit="openPopupPrint(this);" action="">
	<table id="alter" cellspacing="0" width="850">
		<tbody>
			<tr>
				<th class="texttable_azul" width="16%" scope="col"><fmt:message key="label.dataHora" /></th>
				<th class="texttable_cinza tooltip" width="18%" title="<fmt:message key="label.dataAberturaServico" />" scope="col"><fmt:message key="label.naturezaDaOperacao" /></th>
				<th class="texttable_cinza" width="19%" scope="col"><fmt:message key="label.detalhamento" /></th>
			</tr>
			
			<c:forEach var="detalheHistorico" items="${detalheHistorico}">
				<tr>
					<td class="debito1">
						<fmt:formatDate value="${detalheHistorico.dataHoraServico}" pattern="dd/MM/yyyy"/>
					</td>
					
					<td class="camposinternos" width="549">${detalheHistorico.naturezaOperacao}</td>
					<td class="camposinternos">${detalheHistorico.detalhamentoOperacao}</td>
				</tr>
			</c:forEach>
			
		</tbody>
	</table>
</form>