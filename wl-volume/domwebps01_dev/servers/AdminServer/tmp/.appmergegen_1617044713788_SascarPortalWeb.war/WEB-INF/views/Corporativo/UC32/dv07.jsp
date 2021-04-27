<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>


<c:catch var="helper" >
	<c:import url="/ExcluirGrupoContatoVeiculo/pesquisarContato?acao=1&numeroPlaca=${param.numeroPlaca}" context="/SascarPortalWeb"/>
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

	$(document).ready(function(){
		
		$("#selecionarTodosAutorizado").click(function(){
			var checked = this.checked; 
			$("input[name='codigoContratanteAutorizado']").attr("checked", checked);
		});
			
		$("#selecionarTodosEmergencia").click(function(){
			var checked = this.checked; 
			$("input[name='codigoContratanteEmergencia']").attr("checked", checked);
		});
			
		$("input[name='codigoContratanteAutorizado']").click(function(){
			var checked = this.checked; 
			if(!checked) $("#selecionarTodosAutorizado").removeAttr("checked"); 
		});
	
		$("input[name='codigoContratanteEmergencia']").click(function(){
			var checked = this.checked; 
			if(!checked) $("#selecionarTodosEmergencia").removeAttr("checked"); 
		});
		
		$("#botaoVoltarDv06").toggle();
		
	});


	function excluirContatoPlaca() {
		//Validar E3
		if(validacaoE3()){
			
			//var totalAutorizado = $("input[name='codigoContratanteAutorizado[]']").length;
			//var totalEmergencia = $("input[name='codigoContratanteEmergencia[]']").length;

			var totalAutorizadoChecked  = 0;
			var totalEmergenciaChecked = 0;
			var totalAutorizado = 0;
			var totalEmergencia = 0;
			
			
			//  ATIVIDADE: COLOCAR PAGINAÇÃO PARA O RETORNO DO WS ListaContratos
			//  FOI COLOCADO COLCHETES NOS NAMES DOS CHECKS 'codigoContratanteAutorizado'
			//  e 'codigoContratanteEmergencia' , POIS ANTES NÃO ESTAVA SENDO 
			//  FEITA A CONTAGEM CORRETA DOS ITENS.
			
			//  CONTAGEM DOS CHECKBOXES SELECIONADOS E A QUANTIDADE TOTAL
			//  COMPARAÇÃO FEITA PARA QUE NÃO PERMITA EXLCUIR TODOS OS ITENS 
		
			//  Verificar em que momento o parâmetro permiteExclusao está sendo utilizado
			//  Foi alterado para que, caso sejam feitas todas as validações, ele
			//  passará o parâmetro s para a servlet.
			
			$("input[name='codigoContratanteAutorizado[]']").each(function(i, value){
				if($(this).attr("checked")){
					totalAutorizadoChecked++;					
				}
				totalAutorizado++;
			});
			$("input[name='codigoContratanteEmergencia[]']").each(function(i, value){
				if($(this).attr("checked")){
					totalEmergenciaChecked++;
				}
				totalEmergencia ++;
			});

			
			//var totalAutorizadoChecked = $("input[name='codigoContratanteAutorizado[]']:checked").size();
			//var totalEmergenciaChecked = $("input[name='codigoContratanteEmergencia[]']:checked").size();
			
			///** Caso o total de emergências ou autorizados fosse zero, ele não permitia excluir os contatos que tivessem
			//    algum item.
			
			if (((totalAutorizado == totalAutorizadoChecked) || (totalEmergencia == totalEmergenciaChecked))&& (totalEmergencia > 0 && totalAutorizado > 0)){
			
				//M2 R5 
				$.showMessage('<fmt:message key="mensagem.informacao.naoPermitidoExcluirTodos" />');
			
			} else {
	
				var data = $("#formCadastro").serialize();
				$(':disabled').each( function() {
					data += '&' + this.name + '=' + $(this).val();
				});
		
				$.ajax({
					url: "/SascarPortalWeb/ExcluirGrupoContatoVeiculo/excluirContratos?acao=4&permiteExclusao=s",
					data: data || {},
					dataType:"json",
					success: function(json){
						if(json != null){
							if(json.success){
								$("#dialog_mensagem .popup_padrao_pergunta").html('<fmt:message key="mensagem.informacao.exclusaoContatosSucesso" />');
								$("#dialog_mensagem").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
							}else{
								$.showMessage(json.mensagem);
							}
						}else{
							$.showMessage('<fmt:message key="mensagem.erro.aoExcluir" />');
						}
					}
				});
			}
		}
	}
	
	/*
	 * Valida a regra E3 - Contato não selecionado
	 */
	function validacaoE3(){
		var validacao = false;
		
		var isCheckedAutorizado 	=  $("input[name='codigoContratanteAutorizado[]']").is(':checked'); 
		var isCheckedEmergencia 	= $("input[name='codigoContratanteEmergencia[]']").is(':checked');
		
		//E3 Não selecionar contato(autorizado ou emerg.)
		if(isCheckedAutorizado || isCheckedEmergencia){
		
	        //Retorna validacao ok
	        validacao = true;
		}else{
		
			//M4
			$.showMessage('<fmt:message key="mensagem.informacao.contatoNaoSelecionado" />');
			
		}
		return validacao;
	}
	
	function recarregar(){
		$("#formCadastro").attr("action","${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC32/dv0");
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
				<th class="tbatualizacao">
					<span class="barraazulzinha"><fmt:message key="label.excluirContato" /></span>
				</th>
			</tr>
		</tbody>
	</table>
	
	<span class="texthelp2" style="margin-top: 10px;">
		<img hspace="5" height="16" align="absmiddle" width="16" src="/SascarPortalWeb/sascar/images/corporativo_new/lightbulb32.png">
		<fmt:message key="uc32.dv07.text.001" />
	</span>
	<p></p>
	
	<form action="" id="formCadastro" name="formCadastro" method="post">
		
		<div class="replicacao_grandetabela2">
		
			<span class="text1">
			
				<fmt:message key="uc32.dv07.label.excluirPlaca">
					<fmt:param>
						<span class="debito3">${param.numeroPlaca}</span>
					</fmt:param>
				</fmt:message>
			</span>
			
			<p class="text1">&nbsp;</p>
			
			<div class="replicacao_grandetabela">
			
				<div class="replicacao_tabela" style="*margin-top:20px;">
					<c:if test="${not empty grupoContato.contatosAutorizado}">
						<span class="text2"><fmt:message key="label.contatoAutorizado" />:</span>
						<table id="alter" cellspacing="0" width="230" style="margin: 10px;">
							<tbody>
								<tr>
									<th class="texttable_azul" width="10%">
										<input id="selecionarTodosAutorizado" type="checkbox" name="">
									</th>
									<th class="texttable_cinza" id="" width="90%"><fmt:message key="label.nomeContatoAutorizado" /></th>
								</tr>
								
								<c:forEach var="contatoAutorizada" items="${grupoContato.contatosAutorizado}" varStatus="status">
									<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if> id="contato_autorizado_${contatoAutorizada.codigo}">
										<td class="camposinternos">
											<input 
												type="checkbox" 
												name="codigoContratanteAutorizado[]" 
												class="required" 
												value="${contatoAutorizada.codigo};${contatoAutorizada.nome}">
										</td>
										<td class="camposinternos">${contatoAutorizada.nome}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:if>
				</div>
				
				<div class="replicacao_tabela" style="*margin-top:20px;">
					<c:if test="${not empty grupoContato.contatosEmergencia}">
						<span class="text2"><fmt:message key="label.contatoEmergencia" />:</span>
						<table id="alter" cellspacing="0" width="230" style="margin: 10px;">
							<tbody>
								<tr>
									<th class="texttable_azul" width="10%">
										<input id="selecionarTodosEmergencia" type="checkbox" name="">
									</th>
									<th class="texttable_cinza" width="90%"><fmt:message key="label.nomeContatoEmergencia" /></th>
								</tr>
								
								<c:forEach var="contatoEmergencia" items="${grupoContato.contatosEmergencia}" varStatus="status">
									<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if> id="contato_emergencia_${contatoEmergencia.codigo}">
										<td class="camposinternos">
											<input 
												type="checkbox" 
												name="codigoContratanteEmergencia[]" 
												class="required" 
												value="${contatoEmergencia.codigo};${contatoEmergencia.nome}">
										</td>
										<td class="camposinternos">${contatoEmergencia.nome}</td>
									</tr>
								</c:forEach>
								
							</tbody>
						</table>
					</c:if>
				</div>
				
				
				<div class="botoes_replicacao" style="width: 480px; text-align: center;">
					<label>
						<input 
							id="button" 
							name="button" 
							class="buttonExcluirContato" 
							type="button" 
							value="Excluir Contato (s)" 
							onclick="excluirContatoPlaca();"/>
							
						<input type="hidden" name="numerosDestino" value="${param.numeroContrato};${param.numeroPlaca}"/>
					</label>
				</div>
			
			</div>
		</div>
		
<%-- Caso retorne apenas um contrato, ele retorna para a página de pesquisa,
     pois, quando ele retorna para o resultado da busca contendo um item,
     ele faria uma nova pesquisa e retornaria para esta mesma página --%>	
	<c:choose>
		<c:when test="${fn:length(contratos) == 1 }">
				
		<div id="botoes_exclusao">
			<input 
				id="Limpar2" 
				class="button3" 
				type="button" 
				onclick="window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC32/dv06'" 
				value="Voltar" 
				name="voltar">
		</div>
	</c:when>
		<c:otherwise>
			<div id="botoes_exclusao">
			<input 
				id="Limpar2" 
				class="button3" 
				type="button" 
				onclick="window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC32/dv09&numeroPlaca=&pagina=${param.pagina}'" 
				value="Voltar" 
				name="voltar">
		</div>
		</c:otherwise>
	</c:choose>	
	</form>
</body>

<div id="dialog_mensagem" class="popup_padrao" style="display: none;">
	<div class="popup_padrao_pergunta"></div>
	<div class="popup_padrao_resposta">
		<input type="button" class="button" value="Fechar" onclick="javascript:$.closeOverlay(); window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC32/dv09&numeroPlaca=${param.numeroPlaca}';"/>
	</div>
</div>

<br clear="all"/>
	
<div class="clear:both"></div>