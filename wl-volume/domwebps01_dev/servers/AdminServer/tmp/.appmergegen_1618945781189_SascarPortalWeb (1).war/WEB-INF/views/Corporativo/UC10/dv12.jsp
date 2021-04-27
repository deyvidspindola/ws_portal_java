<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/AtivarEquipamentoVinculo/listarAcessoriosInclusao?acao=14" context="/SascarPortalWeb"  />
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
	function submterAcessorio(codigoAcessorio) {
		$.ajax({
			url: "/SascarPortalWeb/AtivarEquipamentoVinculo/submeterAcessorio?acao=7",
			data: {"codigoAcessorio": codigoAcessorio, "numeroOS": "${param.numeroOS}", "numeroCPF": "${param.numeroCPF}", "tipoSubmeter" : "I"},
			dataType:"json",
			success: function(json){
				if (json.success) {
					$("#formAtualizar").submit();
				} else {
					$.showMessage(json.mensagem);
				}
			}
		});
	}
</script>

<div class="cabecalho">
	<div class="caminho" style="*margin-left:400px;">
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
		<a href="#" class="linktres"><fmt:message key="label.servicos" /></a> &gt; 
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv01" class="linkquatro"><fmt:message key="label.ativacaoEquipamento" /></a>
	</div>
  	<fmt:message key="label.ativacaoEquipamento" />
</div>


	<table class="detalhe" cellspacing="0">
		<tbody>
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="mensagem.campo.servicoAdicionar" />:</th>
			</tr>
		</tbody>
	</table>

	<table id="alter" cellspacing="0" width="70%">
		<tbody>	
			<tr>
				<th class="texttable_azul" width="30%"><fmt:message key="label.servicos" /></th>
			</tr>

			<c:forEach items="${acessorios}" var="acessorio" varStatus="status">
				<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if>>
					<td><a class="linkazul" href="#salvar" onclick="submterAcessorio(${acessorio.identifier});">${acessorio.value }</a></td>
				</tr>
			</c:forEach>

		</tbody>
	</table>
	
	<div class="pgstabela" align="center">
		<p>
			<input class="button4" type="button" onclick="window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv05&numeroOS=${param.numeroOS}&numeroCPF=${param.numeroCPF}'" value="<fmt:message key="label.voltar" />">
		</p>
	</div>

<form id="formAtualizar" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv05" method="post">
	<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
	<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
</form>