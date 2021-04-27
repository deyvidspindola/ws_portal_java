<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/VerificarPermissao" context="/SascarPortalWeb"  />
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

<script>

	function desmarcar(input) {
		var valor = $.trim($(input).val());

		if (valor && valor.length > 0) {
			$("#selecionarTodosContratos").removeAttr("checked");
		}
	}

	$(document).ready(function(){
	
		$("#selecionarTodosContratos").click(function(){
			if ($(this).is(':checked')){
				$(":text").val('');
			}
		});

		$(":text").each(function(){
			desmarcar(this);
		}).keypress(function(){
			desmarcar(this);
		}).keyup(function(){
			desmarcar(this);
		}).blur(function(){
			desmarcar(this);
		});
		
	});

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
	<form id="formPesquisa" action="<c:url value="/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC32/dv09"/>" method="post">
		<table class="tbatualizacao" cellspacing="0" width="960">
			<tbody>
				<tr class="tbatualizacao">
				<th class="tbatualizacao">
					<span class="barraazulzinha"><fmt:message key="label.excluirContato" /></span>
					<fmt:message key="uc32.dv05.subTitulo.consulta" />
				</th>
				</tr>
			</tbody>
		</table>
		
		
		<div class="busca_branca">
			<span class="text1"><fmt:message key="mensagem.informacao.placaVeiculo" />:</span>
		</div>
		
		
		<div class="busca_cinza">
			<span class="text2"><fmt:message key="label.porPlacaVeiculo" />:</span>
			<span class="text3"><fmt:message key="label.nAbrev" />:</span>
			<input id="numeroPlaca" type="text" value="${param.numeroPlaca}" maxlength="10" name="numeroPlaca">
		</div>
		
		
		<div class="busca_branca">
			<input id="selecionarTodosContratos" class="check" type="checkbox" onclick="" name="selecionarTodosContratos">
			<span class="text2"><fmt:message key="label.buscarTodos" /></span>
		</div>
		
		
		<div class="busca_cinza">
			<input id="button" class="button" type="submit" value="<fmt:message key="label.buscar" />" name="button">
			<input id="Limpar" class="button4" type="button" value="<fmt:message key="label.limpar" />" name="limpar" onclick="document.location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC32/dv06';">
		</div>
		
		<div id="botoes_exclusao">
			<input id="botaoVoltarDv06" class="button3" type="reset" onclick="window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC32/dv02'" value="<fmt:message key="label.voltar" />" name="voltar">
			<input type="hidden" name="valida_contrato" value="false" id="valida_contrato" />
		</div>
	</form>
</body>
