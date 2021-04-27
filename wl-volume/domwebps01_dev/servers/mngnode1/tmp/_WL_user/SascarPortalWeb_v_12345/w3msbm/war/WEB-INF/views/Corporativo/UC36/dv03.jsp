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
	
			var container = $('div.container2');
			$("#formPesquisa").validate({
				errorContainer: container,
				errorLabelContainer: $("ol", container),
				wrapper: 'li'
			});
					
			$("#dataInicial").datepicker({
				dateFormat: 'dd/mm/yy',
				changeMonth: true,
		        changeYear: true,
		        onClose: function( selectedDate ) {
		            $( "#dataFinal" ).datepicker( "option", "minDate", selectedDate );
		          }
			});
			
			$("#dataFinal").datepicker({
				dateFormat: 'dd/mm/yy',
				changeMonth: true,
		        changeYear: true,
		        onClose: function( selectedDate ) {
		            $( "#dataInicial" ).datepicker( "option", "maxDate", selectedDate );
		          }
			});
	
			$('#dataInicial, #dataFinal').blur(function(){
				$(this).setMask('date');
			}).focus(function(){
				$(this).unsetMask();
			});
	
		});
		
	</script>

	<div class="container2">
		<ol>
			<li><label for="dataInicial" class="error"><fmt:message key="mensagem.campo.dataInicialValida" /></label></li>
			<li><label for="dataFinal" class="error"><fmt:message key="mensagem.campo.dataFinalValidaMaiorOuIgualInicial" /></label></li>
		</ol>
	</div>

	<div class="cabecalho">
		<fmt:message key="label.verHistoricoPendencias" />
		<div class="caminho" style="">
			<a class="linktres" title="<fmt:message key="label.home" />" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}"><fmt:message key="label.home" /></a>
			&gt;
			<a class="linkquatro" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC36/dv01"><fmt:message key="label.verHistoricoPendencias" /></a>
		</div>
	</div>

	<table class="detalhe" cellspacing="0">
		<tbody>
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.listaDePendencias" /></th>
			</tr>
		</tbody>
	</table>

	<div class="busca_branca">
		<span class="texthelp2" style="">
			<img hspace="5" height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png">
			<fmt:message key="uc36.texto.07.resultadoHistoricoServicosDetalhamento" />
		</span>
	</div>

	<form id="formPesquisa" 
		  method="post" 
		  action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC36/dv03" >
		
		<input type="hidden" name="tipoConsulta" value="${param.tipoConsulta}" />
	
		<div class="busca_cinza">
			<span class="text2"><fmt:message key="label.filtrePor" />:</span>
			
			<label>
				<span class="text3"><fmt:message key="label.ataInicial" />:</span>
				<input type="text" name="dataInicial" id="dataInicial" value="${param.dataInicial}" class="text dateBR" maxlength="10" readonly="readonly" />
			</label>
			
			<label>
				<span class="text3"><fmt:message key="label.dataFinal" />:</span>
				<input type="text" name="dataFinal" id="dataFinal" value="${param.dataFinal}" dateHigher="#dataInicial" class="text dateBR" maxlength="10" readonly="readonly" />
			</label>
			
			<input class="button" type="submit" tabindex="10" value="<fmt:message key="label.buscar" />" />
			<input class="button4" type="button" tabindex="10" id="Limpar" value="<fmt:message key="label.limpar" />" onclick="limparCampos('#formPesquisa');"/>
		
		</div>
	</form>

	<form method="post" onsubmit="openPopupPrint(this);" 
		  action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Imprimir&page=Corporativo/UC36/dv07">
		  
		<input type="hidden" name="tipoConsulta" value="${param.tipoConsulta}" />
		
		<c:if test="${not empty detalheHistorico}">
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
		</c:if>
	
		<div class="pgstabela">
			<input class="button3" type="button" value="<fmt:message key="label.voltar" />" onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC36/dv01'">
			<c:if test="${not empty detalheHistorico}">
			<input class="button" type="submit" value="<fmt:message key="label.imprimir" />">
			</c:if>
		</div>
		
	</form>

