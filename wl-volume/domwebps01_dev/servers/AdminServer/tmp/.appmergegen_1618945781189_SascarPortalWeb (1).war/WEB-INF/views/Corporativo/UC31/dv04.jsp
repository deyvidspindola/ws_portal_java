<jsp:directive.include file="/WEB-INF/views/includes.jsp" />

<c:catch var="helper">
	<c:import url="/IncluirGrupoContatoVeiculo/pesquisarContratos?acao=1"
		context="/SascarPortalWeb" />
</c:catch>


<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$.showMessage("${mensagem }");
	</script>
</c:if>

<c:if test="${not empty helper}">
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>


<script>
	$(document).ready(function() {
		
		$("#visibleDIV03").hide();
		$("#visibleDIV05").hide();

		$("#selecionarTodosPlaca").click(
				function() {
					var checked = this.checked;
					$("input[name='numeroDestino']").attr("checked", checked);
				});

		$("input[name='numeroDestino']").click(
				function() {
					var checked = this.checked;
					if (!checked)
						$("#selecionarTodosPlaca").removeAttr("checked");
				});

		<c:if test="${not empty param.pessoas }">
			var codA = "${param.pessoas}";
			var substr = codA.split('|');
			for (i in substr) {
				var html = '<input type="hidden" name="pessoas" value="'+substr[i]+'"/>';
				$("#formUC31DV04").append(html);
			}
		</c:if>

	});

	function adicionarContatos() {

		var isChecked = $("input[name='numeroDestino']").is(':checked');

		//E4 Não selecionada placa para inclusão
		if (!isChecked) {

			//M5
			$.showMessage("Placa para recebimento da inclusão não selecionada.");

		} else {
			var data = $("#formUC31DV04").serialize();
			$(':disabled').each(function() {
				data += '&' + this.name + '=' + $(this).val();
			});

			$.ajax({
				url : "/SascarPortalWeb/IncluirGrupoContatoVeiculo/adicionarContato?acao=4",
				data : data || {},
				dataType : "json",
				success : function(json) {
					$("#dialog_mensagem .popup_padrao_pergunta").html(
							json.mensagem);
					$("#dialog_mensagem").jOverlay({
						'closeOnEsc' : false,
						'bgClickToClose' : false
					});
				}
			});
		}
	}
	function voltar(){
		$("#formUC31DV04").attr("action","${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC31/${param.tela}");
		$("#formUC31DV04").submit();
	}
</script>


<div class="cabecalho">
	<fmt:message key="label.atualizacaoCadastral" />
	<div class="caminho">
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
		<a href="#" class="linktres"><fmt:message key="label.informacoes" /></a> &gt;
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC08/dv01" class="linkquatro"><fmt:message key="label.atualizacaoCadastral" /></a>
	</div>
</div>

<jsp:include page="/WEB-INF/views/Corporativo/UC08/MenuAbas.jsp">
	<jsp:param name="abaAtiva" value="direita" />
</jsp:include>

<body>
	<table class="tbatualizacao" cellspacing="0" width="960">
		<tbody>
			<tr class="tbatualizacao">
				<th class="tbatualizacao"><fmt:message key="label.incluirContato" /></th>
			</tr>
		</tbody>
	</table>


	<form method="post" action="" id="formUC31DV04" name="formUC31DV04">
		<div class="explicacao_replicacao">
			<fmt:message key="uc31.dv04.texto.001" />
			<span lass="texthelp2">
				<img hspace="5" height="16"
					align="absmiddle" width="16"
					src="/SascarPortalWeb/sascar/images/corporativo_new/lightbulb32.png">
				
				<fmt:message key="uc31.dv03.texto.002" />				
			</span>
		</div>


		<table id="alter" cellspacing="0" width="750px">
			<tbody>
				<tr>
					<th class="texttable_azul" width="9%"><input
						id="selecionarTodosPlaca" type="checkbox" name="checkbox">
					</th>
					<th class="texttable_cinza" width="91%"><fmt:message key="label.placaVeiculo" />:</th>
				</tr>
				<c:forEach var="contrato" items="${contratos}" varStatus="status">
					<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if>>
						<td class="camposinternos"><input type="checkbox"
							name="numeroDestino" value="${contrato.numeroContrato}">
						</td>
						<td class="camposinternos">${contrato.veiculo.placa}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
	    <!-- PAGINAÇÃO INCLUÍDA EM 25/02/2013, PARA O RETORNO DO WS LISTACONTRATO -->
	    <c:if test="${param.DIV03 eq 'sim'}">
         <jsp:include page="/WEB-INF/views/paginacao.jsp">
	       <jsp:param name="pagina" value="${paginacao.paginaAtual}"/>
	       <jsp:param name="totalPaginas" value="${paginacao.totalPaginas}"/>
	       <jsp:param name="formName" value="formUC31DV03"/>
	       <jsp:param name="url" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC31/dv04&pessoas=${param.pessoas}&tela=${param.tela}&DIV03=sim"/>
         </jsp:include>
         </c:if>
         <c:if test="${param.DIV05 eq 'sim'}">
         <jsp:include page="/WEB-INF/views/paginacao.jsp">
	       <jsp:param name="pagina" value="${paginacao.paginaAtual}"/>
	       <jsp:param name="totalPaginas" value="${paginacao.totalPaginas}"/>
	       <jsp:param name="formName" value="formUC31DV04"/>
	       <jsp:param name="url" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC31/dv04&pessoas=${param.pessoas}&tela=${param.tela}&DIV05=sim"/>
         </jsp:include>
        </c:if> 
		<div class="pgstabela" style="*text-align:left;">
			<input type="submit" class="button3" value="<fmt:message key="label.voltar" />" onclick="javascript:voltar();"/>
			<input id="incluir" 
				class="button tooltip"
				type="button" 
				onclick="javascript:adicionarContatos();"
				value="<fmt:message key="label.incluir" />" 
				name="incluir"
				style="*margin-left:400px;"
				title="<fmt:message key="uc31.dv03.tooltip.001" />">
				<input type="hidden" name="tipoContato" value="<c:if test="${not empty param.tipoContato}">${param.tipoContato}</c:if>" />
				<input type="hidden" name="pessoasVoltar" value="${param.pessoas}">
		</div>

	</form>
</body>

<div id="dialog_mensagem" class="popup_padrao" style="display: none;">
	<div class="popup_padrao_pergunta"></div>
	<div class="popup_padrao_resposta">
		<input type="button" class="button" value="<fmt:message key="label.fechar" />" onclick="javascript:$.closeOverlay();" />
	</div>
</div>

<br clear="all" />

<div class="clear:both"></div>
<c:if test="${param.DIV03 eq 'sim'}">
<jsp:include page="/WEB-INF/views/Corporativo/UC31/dv03.jsp"/>
</c:if>
<c:if test="${param.DIV05 eq 'sim'}">
<jsp:include page="/WEB-INF/views/Corporativo/UC31/dv05.jsp"/>
</c:if>