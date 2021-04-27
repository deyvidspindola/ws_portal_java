<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>


<c:catch var="helper">
	<c:import url="/ReplicarGrupoContatoVeiculo/pesquisarContratos?acao=1" context="/SascarPortalWeb"  />
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

	$(document).ready(function() {
		
		$("#visibleDIV04").hide();
		

		$("#selecionarTodosPlaca").click(function(){
				var checked = this.checked; 
				$("input[name='numeroDestino']").attr("checked", checked);
			});
			
		$("input[name='numeroDestino']").click(function(){
				var checked = this.checked; 
				if(!checked) $("#selecionarTodosPlaca").removeAttr("checked"); 
			});
			
		<c:if test="${not empty param.codigoContratanteAutorizado }">
			var codA = "${param.codigoContratanteAutorizado}";
			var substr = codA.split(',');
			for(i in substr){
				var html = '<input type="hidden" name="codigoContratanteAutorizadoo" value="'+substr[i]+'"/>';
				$("#formUC30DV05").append(html);
			}
		</c:if>	
		
		<c:if test="${not empty param.codigoContratanteEmergencia }">
			var codA = "${param.codigoContratanteEmergencia}";
			var substr = codA.split(',');
			for(i in substr){
				var html = '<input type="hidden" name="codigoContratanteEmergenciaa" value="'+substr[i]+'"/>';
				$("#formUC30DV05").append(html);
			}
		</c:if>	
		
	});
	
	/*
	 * Submeter para Substituir ou Adicionar, pois são as mesmas validações. 
	 */
	function submeterContatosDIV05(tipoContato) {		

		var isChecked = $("input[name='numeroDestino']").is(':checked'); 
		
    	//E4 Não selecionada placa para replicação
    	if(!isChecked){
    	
    		//M5
			$.showMessage("Placa para recebimento da replicação não selecionada.");
			
    	}else{
    	
    		var url = null;
    		if(tipoContato == "substituir"){
    			url = "/SascarPortalWeb/ReplicarGrupoContatoVeiculo/substituirPessoas?acao=3&codigoContratanteAutorizado=${param.codigoContratanteAutorizado}&codigoContratanteEmergencia=${param.codigoContratanteEmergencia}";
    		}else if(tipoContato == "adicionar"){
    			url = "/SascarPortalWeb/ReplicarGrupoContatoVeiculo/adicionarPessoas?acao=4&codigoContratanteAutorizado=${param.codigoContratanteAutorizado}&codigoContratanteEmergencia=${param.codigoContratanteEmergencia}";
    		}
			
			if(url != null){
				var data = $("#formUC30DV05").serialize();
				$(':disabled').each( function() {
					data += '&' + this.name + '=' + $(this).val();
				});
		
				$.ajax({
					url: url,
					data: data || {},
					dataType:"json",
					success: function(json){
						
						
						$("#dialog_mensagem1 .popup_padrao_pergunta").html(json.mensagem);
						$("#dialog_mensagem1").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
					}
				});
			}

			
		}
	}
	
	function voltar(){
	
		var href = "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC30/dv04";
			href += "&numeroContrato=${param.numeroContrato}";
			href += "&numeroPlaca=${param.placa}";
			href += "&codigoContratanteAutorizado=${param.codigoContratanteAutorizado }";
			href += "&codigoContratanteEmergencia=${param.codigoContratanteEmergencia }";
	
		$("#formUC30DV05").attr("action",href);
		$("#formUC30DV05").submit();
	}

</script>
<jsp:include page="/WEB-INF/views/Corporativo/UC30/dv04.jsp"/>

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
				<th class="tbatualizacao"><fmt:message key="label.replicarContatos" /></th>
			</tr>
		</tbody>
	</table>


	<form method="post" action="" id="formUC30DV05" name="formUC30DV05">
		<div class="explicacao_replicacao">
			<fmt:message key="uc30.dv05.label.placasContatosReplicados">
				<fmt:param>
					<span class="debito3">${param.placa}</span>
				</fmt:param>
			</fmt:message>			
			<span class="texthelp2">
				<img hspace="5" height="16" align="absmiddle" width="16" src="/SascarPortalWeb/sascar/images/corporativo_new/lightbulb32.png">
				<fmt:message key="uc30.dv04.texto.001" />
			</span>
		</div>
	
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
							<input type="checkbox" name="numeroDestino" value="${contrato.numeroContrato}">
						</td>
						<td class="camposinternos">${contrato.veiculo.placa}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<!-- PAGINAÇÃO INCLUÍDA EM 25/02/2013, PARA O RETORNO DO WS LISTACONTRATO -->
         <jsp:include page="/WEB-INF/views/paginacao.jsp">
	       <jsp:param name="pagina" value="${paginacao.paginaAtual}"/>
	       <jsp:param name="totalPaginas" value="${paginacao.totalPaginas}"/>
	       <jsp:param name="formName" value="formUC30DV04"/>
	       <jsp:param name="url" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC30/dv05&pessoas=${param.pessoas}&codigoContratanteAutorizado=${param.codigoContratanteAutorizado}&codigoContratanteEmergencia=${param.codigoContratanteEmergencia}&DIV04=true"/>
         </jsp:include>
		<div class="pgstabela" style="*text-align:left; *margin-left: 150px;">
		
		<br>	
			<input id="substituir" 
			       class="button tooltip" 
			       type="button" 
			       onclick="javascript:submeterContatosDIV05('substituir');" 
			       value="<fmt:message key="label.substituirContatos" />" 
			       name="substituir"
			       style="*margin-left:00px;"
				   title="<fmt:message key="uc30.dv04.tooltip.001" />">
			
			<input id="adicionar" 
				   class="button tooltip" 
				   type="button" 
				   onclick="javascript:submeterContatosDIV05('adicionar');" 
				   value="<fmt:message key="label.adicionarContatos" />" 
				   name="adicionar"
				   style="*margin-left:0px;"
				   title="<fmt:message key="uc30.dv04.tooltip.002" />">
			
			<input type="hidden" name="numeroPlaca"    value="${param.placa}"/>
			<input type="hidden" name="numeroContrato" value="${param.numeroContrato}"/>
		</div>
			<input type="submit" class="button3" value="<fmt:message key="label.voltar" />" onclick="javascript:voltar();"/>
	</form>
	
</body>




<div id="dialog_mensagem1" class="popup_padrao" style="display: none;">
	<div class="popup_padrao_pergunta"></div>
	<br>
	<div class="popup_padrao_resposta">
		<input type="button" class="button" value="<fmt:message key="label.fechar" />" onclick="javascript:$.closeOverlay();"/>
	</div>
</div>

<br clear="all"/>
	
<div class="clear:both"></div>
