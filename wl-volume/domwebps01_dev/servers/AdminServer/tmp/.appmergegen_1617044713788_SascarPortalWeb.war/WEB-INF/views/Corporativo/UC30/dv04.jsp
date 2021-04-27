<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:if test="${not param.DIV04 eq 'true' }">
<c:catch var="helper" >
	<c:import url="/ReplicarGrupoContatoVeiculo/listaPessoas?acao=2" context="/SascarPortalWeb"/>
</c:catch>
</c:if>

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
			
		 //Percorre os valores que estavam marcados para seta-los na volta da tela dv05
         $("#codigoSelecionadosAutorizado").each(function(i, value){
         	var valores = $(this).val();
         	if(valores != null && valores != ""){
	         	var split = valores.split(',');
				for(i in split){
					$("input[name='codigoContratanteAutorizado']").each(function(){
						if($(this).val() == split[i]){
							$(this).attr("checked", "checked");
						}
					});
				}
         	}
         });
         
         //Percorre os valores que estavam marcados para seta-los na volta da tela dv05
         $("#codigoSelecionadosEmergencia").each(function(i, value){
         	var valores = $(this).val();
         	if(valores != null && valores != ""){
	         	var split = valores.split(',');
				for(i in split){
					$("input[name='codigoContratanteEmergencia']").each(function(){
						if($(this).val() == split[i]){
							$(this).attr("checked", "checked");
						}
					});
				}
         	}
         });
	});
	
	function adicionarPlacas() {
	
		// Pegando o valor da placa digitada no campo input
		var numeroPlaca = $("#numeroPlaca").val();
		
		//Chamar o ajax para procurar o contrato
		$.ajax({
			"url": "/SascarPortalWeb/ReplicarGrupoContatoVeiculo/adicionarPlacaDestino",
			"data" : { "numeroPlaca": numeroPlaca, "acao" : 5 },
			"dataType" : "json",
			"success": function(json){
			
				if (json != null && json.success) {

					var placasJaAdd = "";
					
					$.each(json.contratos, function(i, contratos){
						if (contratos.placa) {
							
							//Verifica se a placa ja esta add
							var achou = false;
				            $("input[name=numeroContratoDestino]").each(function(i, value){
				            	if($(this).val() == contratos.numeroContrato){
				            		achou = true;
				            		placasJaAdd += contratos.placa + ", ";
				            	}
				            	
				            });
						
							//se não achou pode add
							if(!achou){
							
								// Pegando a tabela onde será adicionada a numeroPlaca
								var tabela = $(".tabelaPlacas");

								var css = $(".tabelaPlacas tr:last").attr("class");

								css = (css == '') ? 'dif' : '';
					
								var html = "<tr class="+ css +">"
												+ "<td class='camposinternos'>"+ contratos.placa + " <input type='hidden' value="+contratos.numeroContrato+" name='numeroContratoDestino'/>"
												+ "</td>"
												+ "<td class='camposinternos'>"
													+ "<a href='#remover' onclick='excluirPlaca(this)' title='<fmt:message key="label.excluir" />'>"
													+ "<img height='16' border='0' align='absmiddle' width='16' src='/SascarPortalWeb/sascar/images/corporativo_new/excluir16-10.png' />"
													+ "</a>"
												+ "</td>"
											+ "</tr>";
					
								if ($.trim(numeroPlaca)) {
									// Pegando o tbody da tabela e adicionando uma <tr>
									tabela.find('tbody').append(html);
									
									//Mostra a tabela 
									$("#divTabelaPlacas").show();
									
									// Limpando o valor do input
									$("#numeroPlaca").val('');
									$("#numeroPlaca").focus();
								}
							}
						}
					});
					
					if(placasJaAdd != ""){
						$.showMessage('<fmt:message key="mensagem.informacao.placasJaadicionadas" /> '+ placasJaAdd.substring(0, placasJaAdd.length - 2));
					}
					
				} else {
					$.showMessage(json.mensagem);
				}
			}
		});
		
	}
	
	function excluirPlaca(element) {
		var elem = $(element);
		elem.parents('tr').remove();
		
		//reposiciona o css da linha
		$(".tabelaPlacas tr").each(function(i, value){
			if(i % 2 == 0){
				$(this).attr("class", "dif");
			}else{
				$(this).removeAttr("class");
			}
		});
		
		
		//Esconde a tabela se nao tive elementos
		var qtdeAdd = $(".tabelaPlacas tr").not("tr:first").length;
		if(qtdeAdd == 0){
			$("#divTabelaPlacas").hide();
		}
		
	}
	
	/*
	 *  Valida regras e manda para a dv5 buscar todas as placas
	 */
	function buscarTodos(element){
		//Validar E3 e E3
		if(validacaoE2E3()){
		
			var listaCodAutorizado = [];
			$("input[name='codigoContratanteAutorizado']").each(function(i, value){
				if($(this).attr("checked")){
					listaCodAutorizado.push($(this).val());
				}
			});
			
			var listaCodEmergencia = [];
			$("input[name='codigoContratanteEmergencia']").each(function(i, value){
				if($(this).attr("checked")){
					listaCodEmergencia.push($(this).val());
				}
			});
			
			var href = "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC30/dv05&numeroContrato=${param.numeroContrato}&placa=${param.numeroPlaca}";
			href += "&codigoContratanteAutorizado="+listaCodAutorizado;
			href += "&codigoContratanteEmergencia="+listaCodEmergencia;
			href += "&valida_contrato=false";
			href += "&DIV04=true&pagina=";
			//Mandar para a dv05
			$(element).attr("href",href);
			$(element).removeAttr("onclick");
			$(element).click();
			
		}
	}
	
	/*
	 * Submeter para Substituir ou Adicionar, pois são as mesmas validações. 
	 */
	function submeterContatos(tipoContato) {		
		//Validar E3 e E3
		if(validacaoE2E3()){
		
			//contar as placas adicionadas na tabela, execet a linha do cabeçalho
			var contadorPlacasAdd = $(".tabelaPlacas tr").not("tr:first").length;
		
	    	//E4 Não selecionada placa para replicação
	    	if(contadorPlacasAdd == 0){
	    	
	    		//M5
				$.showMessage('<fmt:message key="mensagem.informacao.placaReplicacaoNaoSelecionada" />');
				
	    	}else{
	    		var url = null;
	    		if(tipoContato == "substituir"){
	    			url = "/SascarPortalWeb/ReplicarGrupoContatoVeiculo/substituirPessoas?acao=3";
	    		}else if(tipoContato == "adicionar"){
	    			url = "/SascarPortalWeb/ReplicarGrupoContatoVeiculo/adicionarPessoas?acao=4";
	    		}
				
				if(url != null){
					var data = $("#formUC30DV04").serialize();
					$(':disabled').each( function() {
						data += '&' + this.name + '=' + $(this).val();
					});
			
					$.ajax({
						url: url,
						data: data || {},
						dataType:"json",
						success: function(json){
							$("#dialog_mensagem .popup_padrao_pergunta").html(json.mensagem);
							$("#dialog_mensagem").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
						}
					});
				}
			}
		}
	}


	/*
	 * Valida as regra de E2- limite de 10 e E3 - Contato não selecionado
	 */
	function validacaoE2E3(element){
		var validacao = false;
		
		var isCheckedAutorizado 	=  $("input[name='codigoContratanteAutorizado']").is(':checked'); 
		var isCheckedEmergencia 	= $("input[name='codigoContratanteEmergencia']").is(':checked');
		
		//E3 Não selecionar contato(autorizado ou emerg.)
		if(isCheckedAutorizado || isCheckedEmergencia){
		
			//Verifica quantidade para autorizada, nao conta o check de selecionar todos
			var contAutorizado = $('input[name=codigoContratanteAutorizado]').filter(':checked').not("#selecionarTodosAutorizado").length;
			
			//Verifica quantidade para autorizada, nao conta o check de selecionar todos
			var contEmergencia = $('input[name=codigoContratanteEmergencia]').filter(':checked').not("#selecionarTodosEmergencia").length;
	        
	        //E2 Execedeu numero maximo de contatos
	        if(contAutorizado > 10 || contEmergencia > 10){
	        
	        	//M6
				$.showMessage('<fmt:message key="mensagem.informacao.maximoContatosExcedido" />');
				
	        }else{
	        	//Retorna validacao ok
	        	validacao = true;
			}
		}else{
		
			//M4 ******* Atualizada
			$.showMessage('<fmt:message key="mensagem.informacao.contatoReplicacaoNSelecionado" />');
			
		}
		return validacao;
	}
		
</script>

<div id="visibleDIV04">

<div class="cabecalho">


<!-- TESTE DE ATUALIZAÇÃO PÁGINA -->
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




	<table class="tbatualizacao" cellspacing="0" width="960">
		<tbody>
			<tr class="tbatualizacao">
				<th class="tbatualizacao"><fmt:message key="label.replicarContatos" /></th>
			</tr>
		</tbody>
	</table>
	
	
	<form method="post" action="" id="formUC30DV04" name="formUC30DV04">
		<div class="explicacao_replicacao">
				<fmt:message key="uc30.dv04.label.selecioneContatos" />
			<span class="texthelp2">
				<img hspace="5" height="16" align="absmiddle" width="16" src="/SascarPortalWeb/sascar/images/corporativo_new/lightbulb32.png">
				<fmt:message key="uc30.dv04.texto.001" />
			</span>
		</div>

				
		<div class="replicacao_grandetabela2">
			<h1 style="margin-left: 0pt;"><fmt:message key="label.replicarContatos" />:</h1>
			
			<table class="detalhe2" cellspacing="3" width="480px">
				<tbody>
					<tr>
						<th class="barraroxa" height="25" width="200"><fmt:message key="label.placaVeiculo" />:</th>
							<td class="camposinternos2" width="350">${param.numeroPlaca}</td>
					</tr>
				</tbody>
			</table>
	
				
			<div class="replicacao_grandetabela">
				 
				<div class="replicacao_tabela">
					<c:if test="${not empty pessoasAutorizadas}">
						<span class="text2"><fmt:message key="label.contatoAutorizado" />:</span>
						<table id="alter" cellspacing="0" width="230" style="margin: 10px;">
							<tbody>
								<tr>
									<th class="texttable_azul" width="10%">
										<input id="selecionarTodosAutorizado" type="checkbox" name="">
									</th>
									<th class="texttable_cinza" id="" width="90%"><fmt:message key="label.nomeContatoAutorizado" /></th>
								</tr>
								
								<c:forEach var="pessoaAutorizada" items="${pessoasAutorizadas}" varStatus="status">
									<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if> id="contato_autorizado_${pessoaAutorizada.codigo}">
										<td class="camposinternos">
											<input type="checkbox" name="codigoContratanteAutorizado" class="required" value="${pessoaAutorizada.codigo}">
										</td>
										<td class="camposinternos">${pessoaAutorizada.nome}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:if>
				</div>
				
				<div class="replicacao_tabela">
					<c:if test="${not empty pessoasEmergencia}">
						<span class="text2"><fmt:message key="label.contatoEmergencia" />:</span>
						<table id="alter" cellspacing="0" width="230" style="margin: 10px;">
							<tbody>
								<tr>
									<th class="texttable_azul" width="10%">
										<input id="selecionarTodosEmergencia" type="checkbox" name="">
									</th>
									<th class="texttable_cinza" width="90%"><fmt:message key="label.nomeContatoEmergencia" /></th>
								</tr>
								
								<c:forEach var="pessoaEmergencia" items="${pessoasEmergencia}" varStatus="status">
									<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if> id="contato_emergencia_${pessoaEmergencia.codigo}">
										<td class="camposinternos">
											<input type="checkbox" name="codigoContratanteEmergencia" class="required" value="${pessoaEmergencia.codigo}">
										</td>
										<td class="camposinternos">${pessoaEmergencia.nome}</td>
									</tr>
								</c:forEach>
								
							</tbody>
						</table>
					</c:if>
				</div>
			</div>
				
		</div>
		
		
		<div class="img_replicacao">
			<img height="32" width="32" src="/SascarPortalWeb/sascar/images/corporativo_new/arrowright.jpeg">
		</div>
		
		
		<div class="replicacao_grandetabela3">
		
			<h1 style="margin-left: 0pt;"><fmt:message key="label.paraAsPlacas" />:</h1>
			
			<table class="detalhe2" cellspacing="3" width="390px">
				<tbody>
					<tr>
						<th class="barraroxa" height="25" width="130"><fmt:message key="label.placaVeiculo" />:</th>
						<td class="camposinternos" width="250">
							<label>
								<input id="numeroPlaca" type="text" name="numeroPlaca" maxlength="10" style="width: 100px;">
							</label>
							<a class="linkazul" href="javascript:adicionarPlacas();"><fmt:message key="label.adicionarPlca" /></a>
							<span style="margin-left: 15px;"></span>
						</td>
					</tr>
				</tbody>
			</table>
			
			
			<div class="replicacao_tabela" style="display: none;" id="divTabelaPlacas">
				<table id="alter" class="tabelaPlacas" cellspacing="0" width="200px" style="margin: 10px;">
					<tbody>
						<tr>
							<th class="texttable_azul" width="80%"><fmt:message key="label.placasAdicionais" /></th>
							<th class="texttable_cinza" width="20%"><fmt:message key="label.excluir" /></th>
						</tr>
					</tbody>
				</table>
			</div>
			
			<div class="botoes_replicacao" style=" *text-align:left; float:left">
				<img height="16" border="0" align="absbottom" width="16" src="/SascarPortalWeb/sascar/images/corporativo_new/search32.png">
				<a class="linkazul" href="#buscarTodos" id="buscarTodos"  onclick="javascript:buscarTodos(this);"><fmt:message key="label.buscarTodos" /></a>
				 <br>
				 <div style="float:left;">
				<input id="substituir" 
					   class="button tooltip" 
					   type="button" 
					   onclick="javascript:submeterContatos('substituir');" 
					   value="<fmt:message key="label.substituirContatos" />" 
					   name="substituir"
					   style="*width:120px;"
					   title="<fmt:message key="uc30.dv04.tooltip.001" />"> 
				
				<input id="adicionar" 
					   class="button tooltip" 
					   type="button" 
					   onclick="javascript:submeterContatos('adicionar');" 
					   value="<fmt:message key="label.adicionarContatos" />" 
					   name="adicionar"
					   style="*margin-left:120px; *width:120px;" 
					   title="<fmt:message key="uc30.dv04.tooltip.002" />">
				<input type="hidden" value="${param.numeroContrato}" name="numeroContrato"/>
				<input type="hidden" id="codigoSelecionadosAutorizado" value="${param.codigoContratanteAutorizado }"/>
				<input type="hidden" id="codigoSelecionadosEmergencia" value="${param.codigoContratanteEmergencia }"/>
				</div>
			</div>
		</div>
	  
		<div class="botaovoltar" style="clear:both;">
			<input 
				type="button" 
				value="<fmt:message key="label.voltar" />" 
				class="button3" 
				onclick="window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC30/dv03&pagina=${param.pagina}'" >
		</div>
		
	</form>



<div id="dialog_mensagem" class="popup_padrao" style="display: none;">
	<div class="popup_padrao_pergunta"></div>
	
	<div class="popup_padrao_resposta">
		<input 
			type="button" 
			class="button" 
			value="<fmt:message key="label.fechar" />" 
			onclick="javascript:$.closeOverlay(); window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC30/dv04&numeroContrato=${param.numeroContrato}&numeroPlaca=${param.numeroPlaca}';"/>
	</div>
</div>

<br clear="all"/>
	
<div class="clear:both"></div>
</div>
