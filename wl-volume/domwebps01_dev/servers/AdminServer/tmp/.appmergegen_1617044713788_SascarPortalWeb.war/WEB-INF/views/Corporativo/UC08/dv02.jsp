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

<script type="text/javascript">
	
	function desmarcar(input) {
		var valor = $.trim($(input).val());

		if (valor && valor.length > 0) {
			$("#selecionarTodos").removeAttr("checked");
		}
	}
	
	$(document).ready(function(){
		
		$("#selecionarTodos").click(function(){
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
	<jsp:param name="abaAtiva" value="central" />
</jsp:include>

<table width="1026" cellspacing="0" class="tbatualizacao" >
	<tr class="tbatualizacao">
		<th class="barraazulzinha"><fmt:message key="label.pesquisaDeVeiculos" /></th>
	</tr>
</table>

<div class="busca_cinza2">
	<form action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC08/dv03" id="formPesquisa" method="post">
		<label>
			<span class="text3"><fmt:message key="label.pelaPlaca" />:</span>
			<input type="text" name="numeroPlaca" class="text" value="${param.numeroPlaca }" />
		</label>
		<label>
			<input name="selecionarTodos" type="checkbox" class="check" id="selecionarTodos" checked="checked"/>
			<span class="text3"><fmt:message key="label.buscarTodos" /></span>
		</label>
		<input type="hidden" name="valida_contrato" value="false" id="valida_contrato" />
		<input type="submit" class="button" value="<fmt:message key="label.buscar" />" />
	</form>
</div>
