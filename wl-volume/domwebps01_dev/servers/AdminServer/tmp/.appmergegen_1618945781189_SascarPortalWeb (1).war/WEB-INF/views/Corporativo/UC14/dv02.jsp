<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/EmitirDeclaracoesServlet/pesquisarContratosDeclaracao?acao=1" context="/SascarPortalWeb"  />
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

<jsp:include page="/WEB-INF/views/Corporativo/UC14/dv01.jsp" />

<script type="text/javascript">
	function validarContratosSelecionados(form) {

		var statusInstalado 	= $("input[name='numeroContrato'].I:checked");
		var statusRoubado 		= $("input[name='numeroContrato'].R:checked");
		var statusNaoInstalado 	= $("input[name='numeroContrato'].N:checked");

		var totalStatusInstalado 	= statusInstalado.length;
		var totalStatusRoubado 		= statusRoubado.length;
		var totalStatusNaoInstalado = statusNaoInstalado.length;
		
		var formAction = null;

		// FROTA
		if (totalStatusInstalado > 1 && totalStatusRoubado == 0 && totalStatusNaoInstalado == 0) {
			formAction = "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Imprimir&page=Corporativo/UC14/dv04";
		}

		// INSTADO INDIVIDUAL
		if (totalStatusInstalado == 1 && totalStatusRoubado == 0 && totalStatusNaoInstalado == 0) {
			formAction = "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Imprimir&page=Corporativo/UC14/dv03";
		}

		// ROUBADO		
		if (totalStatusRoubado && totalStatusInstalado == 0 && totalStatusNaoInstalado == 0) {
			if (totalStatusRoubado > 1) {
				$.showMessage('<fmt:message key="uc14.dv02.textp.002" />');
			} else {
				formAction = "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Imprimir&page=Corporativo/UC14/dv05";
			}
		}
		
		// STATUS DIFERENTE
		if ((totalStatusInstalado && totalStatusRoubado)
			|| (totalStatusInstalado && totalStatusNaoInstalado)
			|| (totalStatusRoubado && totalStatusNaoInstalado)) {

			var mensagem = '<fmt:message key="uc14.dv02.texto.001" />';

			if (totalStatusRoubado > 1) {
				mensagem += '<br/><fmt:message key="uc14.dv02.texto.002" />';
			}			

			$.showMessage(mensagem);
		}

		if (formAction != null){
			$(form).attr("action", formAction);
			return true;
		}
		
		return false;
	}
	
	function confirmarEmissao() {
		var form = $("#formLista");
		if (form.valid() && validarContratosSelecionados(form)) {
			$("#dialog_confirm").jOverlay();
		}
	}
		
	$(document).ready(function() {
		var container = $('div.container2');
		$("#formLista").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li'
		});

		$("#selecionarTodos").click(function(){
			var checked = this.checked; 
			$("input[name='numeroContrato']").attr("checked", checked);
		});
		
	});
</script>

<div class="container2"> 
	<ol>
		<li><label for="numeroContrato" class="error"><fmt:message key="mensagem.campo.selecioneContrato" /></label></li>
	</ol>
</div>

<c:if test="${not empty contratos}">
	<h1><fmt:message key="label.resultadoDaBusca" /></h1>
	<span class="texthelp2">
		<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" />
		<fmt:message key="uc14.dv02.texto.003" />
	</span>

	<form action="" id="formLista" name="formLista" method="post" onsubmit="openPopupPrint(this);">
		<table width="750" cellpadding="1px" id="alter" cellspacing="0px">
			<tr>
				<th width="50px" class="texttable_azul" scope="col">
					<label><fmt:message key="label.selecionarTodos" />
				    	<br><input type="checkbox" id="selecionarTodos"  />
				    	
				    </label>
				</th>
				<th width="200px" class="texttable_cinza" scope="col"><fmt:message key="label.placa" /></th>
				<th width="200px" class="texttable_cinza" scope="col"><fmt:message key="label.chassi" /></th>
				<th width="250px" class="texttable_azul" scope="col"><fmt:message key="label.tipoDeclaracao" /></th>
			</tr>

			<c:forEach var="contrato" items="${contratos}" varStatus="contador">
				<tr <c:if test="${contador.count % 2 != 0 }">class="dif"</c:if>>
					<td class="linkazul">
				  		<label>
				    		<input type="checkbox" id="numeroContrato" name="numeroContrato" class="required ${contrato.status }" value="${contrato.numeroContrato }"/>
				    	</label>
					</td>
					<td>${contrato.veiculo.placa }</td>
					<td>${contrato.veiculo.chassi }</td>
					<td class="linkazul">
						<c:choose>
							<c:when test="${fn:toUpperCase(contrato.status) eq 'I'}"><fmt:message key="label.veiculoMonitorado" /></c:when>
							<c:when test="${fn:toUpperCase(contrato.status) eq 'R'}"><fmt:message key="label.veiculoRoubadoNRecuperado" /></c:when>
							<c:otherwise><fmt:message key="label.naoInstalado" /></c:otherwise>
						</c:choose>
					</td>
				</tr>			
			</c:forEach>
		</table>
		
		<jsp:include page="/WEB-INF/views/paginacao.jsp">
			<jsp:param name="pagina" value="${paginacao.paginaAtual}"/>
			<jsp:param name="totalPaginas" value="${paginacao.totalPaginas}"/>
			<jsp:param name="formName" value="formLista"/>
			<jsp:param name="url" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC14/dv02"/>
		</jsp:include>
		
		<jsp:include page="/WEB-INF/views/icones.jsp">
			<jsp:param name="emitir" value="confirmarEmissao();"/>
		</jsp:include>
		
	</form>
	
	<div id="dialog_confirm" class="popup_padrao" style="display: none;" >
		<div class="popup_padrao_pergunta"><fmt:message key="mensagem.confirmacao.emissaoDocumento" /></div>
		<div class="popup_padrao_resposta">
			<input type="button" class="button close" value="<fmt:message key="label.sim" />" onclick="$('#formLista').submit(); $.closeOverlay();"/>
			<input type="button" class="button4 close" value="<fmt:message key="label.nao" />" onclick="$.closeOverlay();"/>
		</div>
	</div>

</c:if>
