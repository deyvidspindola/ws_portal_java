<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper">
	<c:import url="/ExcluirGrupoContatoVeiculo/pesquisarContratos?acao=3" context="/SascarPortalWeb"  />
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

	$(document).ready(function() {

		$("#visibleDIV04").hide();
		
		$("#selecionarTodosPlaca").click(
				function() {
					var checked = this.checked;
					$("input[name='numerosDestinoPlaca']").attr("checked", checked);
				});

		$("input[name='numerosDestinoPlaca']").click(
				function() {
					var checked = this.checked;
					if (!checked)
						$("#selecionarTodosPlaca").removeAttr("checked");
				});

		<c:if test="${not empty param.codigoContratanteAutorizado }">
			var codA = "${param.codigoContratanteAutorizado}";
			var substr = codA.split(',');
			for(i in substr){
				var html = '<input type="hidden" name="codigoContratanteAutorizado" value="'+substr[i]+'"/>';
				$("#formCadastro").append(html);
			}
		</c:if>	
		
		<c:if test="${not empty param.codigoContratanteEmergencia }">
			var codA = "${param.codigoContratanteEmergencia}";
			var substr = codA.split(',');
			for(i in substr){
				var html = '<input type="hidden" name="codigoContratanteEmergencia" value="'+substr[i]+'"/>';
				$("#formCadastro").append(html);
			}
		</c:if>	
		
		<c:if test="${not empty param.permiteExclusao}">
			var permiteExclusao = "${param.permiteExclusao}";
			var html = '<input type="hidden" name="permiteExclusao" value="'+permiteExclusao+'"/>';
			$("#formCadastro").append(html);
		</c:if>	

	});

	function excluirContatos() {

		var isChecked = $("input[name='numerosDestinoPlaca']").is(':checked');

		//E4 Não selecionada placa para inclusão
		if (!isChecked) {

			//M5
			$.showMessage('<fmt:message key="mensagem.informacao.placaExclusaoNaoSelecionada" />');

		} else {
			var data = $("#formCadastro").serialize();
			$(':disabled').each(function() {
				data += '&' + this.name + '=' + $(this).val();
			});

			$.ajax({
				url : "/SascarPortalWeb/ExcluirGrupoContatoVeiculo/excluirContratos?acao=4",
				data : data || {},
				dataType : "json",
				success : function(json) {
					if(json != null){
						
						var msg = json.mensagem;
						
						if(json.success){
							msg = '<fmt:message key="mensagem.informacao.exclusaoContatosSucesso" />';
						}
						
						$("#popupinterior .texto").html(msg);
						$("#popup").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
					
					}else{
						$.showMessage('<fmt:message key="mensagem.erro.aoExcluir" />');
					}
				}
			});
		}
	}
	function voltar(){
		$("#formCadastro").attr("action","${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC32/dv04");
		$("#formCadastro").submit();
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
				<th class="tbatualizacao"><fmt:message key="label.excluirContato" /></th>
			</tr>
		</tbody>
	</table>
	
	
	<div class="busca_branca">
		<span class="text1"><fmt:message key="mensagem.informacao.placasSelecionadasContatosExluidos" />: </span>
	</div>
	
	<form action="" id="formCadastro" name="formCadastro" method="post">
		<table id="alter" cellspacing="0" width="750px">
			<tbody>
				<tr>
					<th class="texttable_azul" width="9%">
						<input id="selecionarTodosPlaca" type="checkbox" name="checkbox">
					</th>
					<th class="texttable_cinza" width="91%"><fmt:message key="label.placaVeiculo" /></th>
				</tr>
				<c:forEach var="contrato" items="${contratos}" varStatus="status">
					<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if>>
						<td class="camposinternos">
							<input type="checkbox" name="numerosDestinoPlaca" value="${contrato.numeroContrato};${contrato.veiculo.placa}">
						</td>
						<td class="camposinternos">${contrato.veiculo.placa}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>		
	</form>
	<jsp:include page="/WEB-INF/views/paginacao.jsp">
	       <jsp:param name="pagina" value="${paginacao.paginaAtual}"/>
	       <jsp:param name="totalPaginas" value="${paginacao.totalPaginas}"/>
	       <jsp:param name="formName" value="formCadastros"/>
	       <jsp:param name="url" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC32/dv05&codigoContratanteAutorizado=${param.codigoContratanteAutorizado}&codigoContratanteEmergencia=${param.codigoContratanteEmergencia}&permiteExclusao=${param.permiteExclusao}"/>
         </jsp:include>
	
	<div class="pgstabela" style="*text-align:left;">
		<input name="button" type="submit" class="button3"  id="button" value="<fmt:message key="label.voltar" />" onclick="$('#formBack').submit();" />
		<input name="excluir" 
			type="button" 
			class="button"  
			id="excluir" 
			onclick="javascript:excluirContatos();"
			value="<fmt:message key="label.excluirContatoPS" />" 
			style="*margin-left:330px;" />
	</div>
	
	<form method="post" id="formBack" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC32/dv04">
		<input type="hidden" name="codigoContratanteAutorizado" value="${param.codigoContratanteAutorizado }"/>
		<input type="hidden" name="codigoContratanteEmergencia" value="${param.codigoContratanteEmergencia }"/>
		<input type="hidden" name="numRG" value="${param.numRG}">
		<input type="hidden" name="numCpfCnpj" value="${param.numCpfCnpj}">
		<input type="hidden" name="numeroCelular" value="${param.numeroCelular}">
		<input type="hidden" name="numeroPlaca" value="${param.numeroPlaca}">
		<input type="hidden" name="nome" value="${param.nome}">
	</form>
	
	
</body>

<div id="popup" style="display: none; position:relative; top:100px; width:700px; height:400px; left: 0;">
	<div id="popup_bordacima"></div>
  	<div id="popupinterior" style="text-align:center; overflow: auto;  width:660px; height:auto; max-height: 400px;" >
  	
		<div class="texto" style="font-size:12px; font-weight:bold; color: #00417B;"> </div>
	 	
	 	<div style="clear: both;"></div>
	 	<br />
	 	
	 	<div style="text-align:center; ">
			<input type="button" 
				class="buttonExcluirContato" 
				value="<fmt:message key="label.fechar" />"
				onclick="javascript:$.closeOverlay();"/>
		</div>
		
  	</div>
 	<div id="popup_bordarodape"></div>
</div>	

<jsp:include page="/WEB-INF/views/Corporativo/UC32/dv04.jsp"/>