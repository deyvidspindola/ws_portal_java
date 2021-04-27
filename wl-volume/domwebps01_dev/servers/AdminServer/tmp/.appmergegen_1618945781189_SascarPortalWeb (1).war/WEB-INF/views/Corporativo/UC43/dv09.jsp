<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

 
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


<table id="alter" cellspacing="0" width="70%">
		<tbody>
			<tr>
				<th class="texttable_azul" width="13%"><fmt:message key="label.Status" /></th>
				<th class="texttable_cinza" width="17%"><fmt:message key="label.dataAgenda" /></th>
				<th class="texttable_cinza" width="28%"><fmt:message key="label.observacao" /></th>
				<th class="texttable_cinza" width="14%"><fmt:message key="label.data" /></th>
				<th class="texttable_cinza" width="28%"><fmt:message key="label.usuario" /></th>
			</tr>
			<tr class="dif">
				<td class="linkazulescuro">${ordemServico.status} Acessorio&nbsp;</td>
				<td class="camposinternos">${ordemServico.agendamento.dataAgendamento}  27/06/2011&nbsp;</td>
				<td class="camposinternos">${ordemServico.observacao} Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean vestibulum luctus porttitor. Morbi sed risus ac elit bibendum pellentesque. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Aenean et leo posuere. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean vestibulum luctus porttitor. Morbi sed risus ac elit bibendum pellentesque. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Aenean et leo posuere. </td>
				<td class="camposinternos">${ordemServico.dataGeracao}  27/06/2011&nbsp;</td>
				<td class="camposinternos"> Usuario</td>
			</tr>
			<tr>
				<td class="linkazulescuro">${ordemServico.status} Acessorio&nbsp;</td>
				<td class="camposinternos">${ordemServico.agendamento.dataAgendamento} 27/06/2011&nbsp;&nbsp;</td>
				<td class="camposinternos">${ordemServico.observacao} abscgeiajsabsc geiajsabscgeiajs</td>
				<td class="camposinternos">${ordemServico.dataGeracao} 27/06/2011&nbsp;&nbsp;</td>
				<td class="camposinternos">Usuario</td>
			</tr>
		</tbody>
	</table>
