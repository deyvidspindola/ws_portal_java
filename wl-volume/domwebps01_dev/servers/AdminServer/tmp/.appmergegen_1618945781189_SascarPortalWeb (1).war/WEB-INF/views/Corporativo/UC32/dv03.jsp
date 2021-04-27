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
		
		$("#numRG").setMask({mask : '9999999999'});
		$('#numCpfCnpj').setMask({mask:'99999999999999'});
		$('#numeroCelular').setMask({mask:'999999999999'});
		$("#numCpfCnpj").setMask("cpf");
		
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


<form action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC32/dv04" method="post">
	<table class="tbatualizacao" cellspacing="0" width="960">
		<tbody>
		<tr class="tbatualizacao">
			<th class="tbatualizacao">
			<span class="barraazulzinha"><fmt:message key="label.excluirContato" /></span>
			<fmt:message key="uc32.dv03.subTitulo.consulta" />
			</th>
		</tr>
		</tbody>
	</table>
	
	
	<div class="busca_branca">
		<span class="text1"><fmt:message key="mensagem.campo.aoMenosUmCampo" />:</span>
		<span class="texthelp2">
			<img hspace="5" height="16" align="absmiddle" width="16" src="/SascarPortalWeb/sascar/images/corporativo_new/lightbulb32.png">
			<fmt:message key="label.buscaAvancada" />
		</span>
	</div>
	
	
	<div class="busca_cinza">
		<span class="text2"><fmt:message key="label.porTipocontato" />:</span>
		<span class="text3">
		
			<input id="contatoEmergencia" class="check" type="checkbox" name="contatoEmergencia" value="E" <c:if test="${not empty param.contatoEmergencia }">checked="checked"</c:if>>
			<fmt:message key="label.contatosEmergencia" />
		</span>
		<span class="text3">
			<input id="contatoAutorizado" class="check" type="checkbox" name="contatoAutorizado" value="A" <c:if test="${not empty param.contatoAutorizado}">checked="checked"</c:if>>
			<fmt:message key="label.contatosAutorizados" />
		</span>
	</div>
	
	
	<div class="busca_branca">
		<span class="text2"><fmt:message key="label.porNomeContato" />:</span>
		<span class="text3"><fmt:message key="label.nome" />:</span>
		<input id="nome" class="text" type="text" maxlength="30" value="${param.nome}" name=nome>
	</div>
	
	
	<div class="busca_cinza">
		<span class="text2"><fmt:message key="label.porRG" />:</span>
		<span class="text3"><fmt:message key="label.nAbrev" />:</span>
			<input id="numRG" type="text" value="${param.numRG}" name="numRG">
		<span class="text2"><fmt:message key="label.porCPF" />:</span>
		<span class="text3"><fmt:message key="label.nAbrev" />:</span>
			<input id="numCpfCnpj" type="text" value="${param.numCpfCnpj}" name="numCpfCnpj">
	</div>
	
	
	<div class="busca_branca">
		<span class="text2"><fmt:message key="label.porCelular" />:</span>
		<span class="text3"><fmt:message key="label.nAbrev" />:</span>
		<input id="numeroCelular" type="text" value="${param.numeroCelular}" name="numeroCelular">
	</div>
	
	
	<div class="busca_cinza">
		<input id="selecionarTodosContratos" class="check" type="checkbox" name="selecionarTodosContratos">
		<span class="text2"><fmt:message key="label.buscarTodos" /></span>
	</div>
	
	
	<div class="busca_branca">
		<input class="button" type="submit" value="Buscar">
		<input id="Limpar" class="button4" type="button" value="<fmt:message key="label.limpar" />" onclick="document.location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC32/dv03';">
	</div>
	
	<div id="botoesinferiores">
		<input id="voltarUC32DV03" name="button2" type="button" class="button3" value="<fmt:message key="label.voltar" />" onclick="document.location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC32/dv02'"/>
	</div>	

</form>
	


