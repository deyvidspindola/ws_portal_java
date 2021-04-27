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
	
	$(document).ready(function(){
		$('#ativar_equipamento').addClass('active');
	});
</script>
		
<h1><fmt:message key="label.ativacaoDesativacaoEquipamento" /></h1>
	
<br/>
<br/>
		
<table class="detalhe" cellspacing="0">
	<tbody>
		<tr class="barraazulzinha">
			<th class="barraazulzinha"><fmt:message key="mensagem.campo.servicoAdicionar" />:</th>
		</tr>
	</tbody>
</table>

<table cellspacing="0" width="70%" class="listaItens" border="0">
	<tr align="center">
		<th class="texttable_azul" width="30%"><fmt:message key="label.servicos" /></th>
	</tr>
	<c:forEach items="${acessorios}" var="acessorio" varStatus="status">
		<tr align="center" <c:if test="${status.count % 2 != 0 }">class="dif"</c:if>>
			<td><a class="linkazul" href="#salvar" onclick="submterAcessorio(${acessorio.identifier});">${acessorio.value }</a></td>
		</tr>
	</c:forEach>
</table>

<br/>
<br/>

<form id="formAtualizar" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv05" method="post">
	<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
	<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
</form>

<jsp:include page="/WEB-INF/views/Corporativo/Mobile/icones.jsp">
	<jsp:param name="voltar" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv05&numeroOS=${param.numeroOS }&numeroCPF=${param.numeroCPF}"/>
</jsp:include>

<div class="clear"></div>