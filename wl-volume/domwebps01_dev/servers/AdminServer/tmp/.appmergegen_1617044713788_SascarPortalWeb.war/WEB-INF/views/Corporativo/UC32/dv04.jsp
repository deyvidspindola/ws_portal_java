<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/ExcluirGrupoContatoVeiculo/pesquisarContato?acao=1" context="/SascarPortalWeb"/>
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

	$(document).ready(function(){
			
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
			"url": "/SascarPortalWeb/ExcluirGrupoContatoVeiculo/adicionarPlacaDestino",
			"data" : { "numeroPlaca": numeroPlaca, "valida_contrato": "false", "acao" : 2 },
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
												+ "<td class='camposinternos'>"+ contratos.placa 
												+ " <input type='hidden' value="+contratos.placa+" name='numeroPlacaDestino'/>"
												+ " <input type='hidden' value="+contratos.numeroContrato+" name='numeroContratoDestino'/>"
												+ " <input type='hidden' value="+contratos.numeroContrato+ ";"+contratos.placa+" name='numerosDestino'/>"
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
		//Validar E3 
		if(validacaoE3()){
		
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
			
			var permitaExclusao = "";
			
			if(validacaoR5R4_sem_memsagem()){
				permitaExclusao = "s";
			}else{
				permitaExclusao = "f";
			}
			
			//Passar todos parametros para o botão voltar funcionar
			var href = "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC32/dv05";
			href += "&codigoContratanteAutorizado="+listaCodAutorizado;
			href += "&codigoContratanteEmergencia="+listaCodEmergencia;
			href += "&numRG="+$("#numRG").val();
			href += "&numCpfCnpj="+$("#numCpfCnpj").val();
			href += "&numeroCelular="+$("#numeroCelular").val();
			href += "&numeroPlaca="+$("#numeroPlaca").val();
			href += "&nome="+$("#nome").val();
			href += "&permiteExclusao="+permitaExclusao;
			href += "&valida_contrato= false";
			
			//Mandar para a dv05
			$(element).attr("href",href);
			$(element).removeAttr("onclick");
			$(element).click();
		}
	}

	function excluirContatoPlaca() {
		//Validar E3
		if(validacaoE3()){
		
			//contar as placas adicionadas na tabela, execet a linha do cabeçalho
			var contadorPlacasAdd = $(".tabelaPlacas tr").not("tr:first").length;
		
	    	//E4 Não selecionada placa para exclusao
	    	if(contadorPlacasAdd == 0){
	    	
	    		//M5
				$.showMessage('<fmt:message key="mensagem.informacao.placaExclusaoNaoSelecionada" />');
				
	    	}else{
	    		
	    		if(validacaoR5R4()){
	    			
	    			var data = $("#formCadastro").serialize();
					$(':disabled').each( function() {
						data += '&' + this.name + '=' + $(this).val();
					});
			
					$.ajax({
						url: "/SascarPortalWeb/ExcluirGrupoContatoVeiculo/excluirContratos?acao=4",
						data: data || {},
						dataType:"json",
						success: function(json){
							
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
		}
	}
	
	/*
	 * Valida a regra E3 - Contato não selecionado
	 */
	function validacaoE3(){
		
		var validacao = false;
		
		var isCheckedAutorizado 	=  $("input[name='codigoContratanteAutorizado']").is(':checked'); 
		var isCheckedEmergencia 	= $("input[name='codigoContratanteEmergencia']").is(':checked');
		
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
	
	// R5. O Sistema não deve permitir a exclusão de todos os contatos autorizados.
	function validacaoR5R4_sem_memsagem(){
		
		var validacao = false;

		var contContatosAutorizados = 0;
		var contContatosEmergencia = 0;
		
		var contContatosAutorizadosSelecionados = 0;
		var contContatosEmergenciaSelecionados = 0;
		
		
		// RECUPERA O NUMERO DE CONTATOS AUTORIZADOS CADASTRADOS
		$("input[name='codigoContratanteAutorizado']").each(function(i, value){
			contContatosAutorizados = contContatosAutorizados + 1;
		});
		
		// RECUPERA O NUMERO DE CONTATOS AUTORIZADOS SELECIONADOS
		$("input[name='codigoContratanteAutorizado']").each(function(i, value){
			if($(this).attr("checked")){
				contContatosAutorizadosSelecionados = contContatosAutorizadosSelecionados + 1;				
			}
		});
		
		// RECUPERA O NUMERO DE CONTATOS PARA EMERGENCIA CADASTRADOS
		$("input[name='codigoContratanteEmergencia']").each(function(i, value){
			contContatosEmergencia = contContatosEmergencia + 1;
		});
		
		// RECUPERA O NUMERO DE CONTATOS PARA EMERGENCIA SELECIONADOS
		$("input[name='codigoContratanteEmergencia']").each(function(i, value){
			if($(this).attr("checked")){
				contContatosEmergenciaSelecionados = contContatosEmergenciaSelecionados + 1;				
			}
		});
		
		if(contContatosAutorizados == contContatosAutorizadosSelecionados || 
		   contContatosEmergencia == contContatosEmergenciaSelecionados ){
			
			validacao = false;
			
		}else{
			
			//Retorna validacao ok
			validacao = true;
			
		}
		
		return validacao;
		
	}
	
	// R5. O Sistema não deve permitir a exclusão de todos os contatos autorizados.
	function validacaoR5R4(){
		
		var validacao = false;

		var contContatosAutorizados = 0;
		var contContatosEmergencia = 0;
		
		var contContatosAutorizadosSelecionados = 0;
		var contContatosEmergenciaSelecionados = 0;
		
		
		// RECUPERA O NUMERO DE CONTATOS AUTORIZADOS CADASTRADOS
		$("input[name='codigoContratanteAutorizado']").each(function(i, value){
			contContatosAutorizados = contContatosAutorizados + 1;
		});
		
		// RECUPERA O NUMERO DE CONTATOS AUTORIZADOS SELECIONADOS
		$("input[name='codigoContratanteAutorizado']").each(function(i, value){
			if($(this).attr("checked")){
				contContatosAutorizadosSelecionados = contContatosAutorizadosSelecionados + 1;				
			}
		});
		
		// RECUPERA O NUMERO DE CONTATOS PARA EMERGENCIA CADASTRADOS
		$("input[name='codigoContratanteEmergencia']").each(function(i, value){
			contContatosEmergencia = contContatosEmergencia + 1;
		});
		
		// RECUPERA O NUMERO DE CONTATOS PARA EMERGENCIA SELECIONADOS
		$("input[name='codigoContratanteEmergencia']").each(function(i, value){
			if($(this).attr("checked")){
				contContatosEmergenciaSelecionados = contContatosEmergenciaSelecionados + 1;				
			}
		});
		
		if(contContatosAutorizados == contContatosAutorizadosSelecionados || 
		   contContatosEmergencia == contContatosEmergenciaSelecionados ){
			
			$.showMessage('<fmt:message key="mensagem.informacao.naoPermitidoExcluirTodos" />');
			
			validacao = false;
			
		}else{
			
			//Retorna validacao ok
			validacao = true;
			
		}
		
		return validacao;
		
	}
		
	function excluirTodosContato() {
		
		if(validacaoE3()){
			
			if(validacaoR5R4()){
				
				var data = $("#formCadastro").serialize();
				$(':disabled').each( function() {
					data += '&' + this.name + '=' + $(this).val();
				});
				
				
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
				
				$.ajax({
					url: "/SascarPortalWeb/ExcluirGrupoContatoVeiculo/excluirTodosContratos?acao=5&codigoContratanteAutorizado="+listaCodAutorizado+"&codigoContratanteEmergencia="+listaCodEmergencia,
					data: data || {},
					dataType:"json",
					success: function(json){
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
		
	}
	
	
</script>
<div id="visibleDIV04">
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
	
	<span class="texthelp2">
		<img hspace="5" height="16" align="absmiddle" width="16" src="/SascarPortalWeb/sascar/images/corporativo_new/lightbulb32.png">
		<fmt:message key="uc32.dv04.texto.001" />
	</span>
	
	<form method="post" action="" id="formCadastros" name="formCadastros">
	
	<div class="replicacao_grandetabela2">
	
		<h1 style="margin-left: 0pt;"><fmt:message key="label.resultadoDeBusca" />:</h1>
		
		<span class="text1"><fmt:message key="uc32.dv04.texto.002" /></span>
		
		<p class="text1">&nbsp;</p>
		
		<div class="replicacao_grandetabela">
		
				<div class="replicacao_tabela" style="*margin-top:20px;">
					<c:if test="${not empty grupoContato.contatosAutorizado}">
						<span class="text2"><fmt:message key="label.contatoAutorizado" />:</span>
						<table id="alter" cellspacing="0" width="230" style="margin: 10px;">
							<tbody>
								<tr>
									<th class="texttable_azul" width="10%">
									</th>
									<th class="texttable_cinza" id="" width="90%"><fmt:message key="label.nomeContatoAutorizado" /></th>
								</tr>
								
								<c:forEach var="contatoAutorizada" items="${grupoContato.contatosAutorizado}" varStatus="status">
									<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if> id="contato_autorizado_${contatoAutorizada.codigo}">
										<td class="camposinternos">
											<input 
												type="checkbox" 
												name="codigoContratanteAutorizado" 
												class="required" 
												value="${contatoAutorizada.codigo};${contatoAutorizada.nome}"/>
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
									</th>
									<th class="texttable_cinza" width="90%"><fmt:message key="label.nomeContatoEmergencia" /></th>
								</tr>
								<c:forEach var="contatoEmergencia" items="${grupoContato.contatosEmergencia}" varStatus="status">
									<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if> id="contato_emergencia_${contatoEmergencia.codigo}">
										<td class="camposinternos">
											<input 
												type="checkbox" 
												name="codigoContratanteEmergencia" 
												class="required" 
												value="${contatoEmergencia.codigo};${contatoEmergencia.nome}"/>
										</td>
										<td class="camposinternos">${contatoEmergencia.nome}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:if>
				</div>
		</div>
			
		
		<div class="botoes_replicacao" style="width: 480px; text-align: center;">
			<label>
				<input 
					id="button" 
					name="button" 
					class="buttonExcluirContato" 
					type="button" 
					style="" 
					title="<fmt:message key="mensagem.informacao.opcaoExcluiraContatos" />" 
					value="<fmt:message key="label.excluirContatoPS" />" 
					onclick="javascript:excluirTodosContato();"/>
			</label>
			<input type="hidden" id="codigoSelecionadosAutorizado" value="${param.codigoContratanteAutorizado }"/>
			<input type="hidden" id="codigoSelecionadosEmergencia" value="${param.codigoContratanteEmergencia }"/>
			<input type="hidden" name="valida_contrato" value="false" id="valida_contrato" />
			<input type="hidden" id="contatoEmergencia" value="${param.contatoEmergencia }"/>
			<input type="hidden" id="param.contatoAutorizado" value="${param.contatoAutorizado }"/>
			<input type="hidden" id="nome" value="${param.nome }"/>
			<input type="hidden" id="numRG" value="${param.numRG }"/>
			<input type="hidden" id="numCpfCnpj" value="${param.numCpfCnpj }"/>
			<input type="hidden" id="numeroCelular" value="${param.numeroCelular }"/>
			
		</div>
	</div>
	
	
	<div class="img_replicacao">
		<img height="32" width="32" src="/SascarPortalWeb/sascar/images/corporativo_new/arrowright.jpeg"/>
	</div>
	
	
	<div class="replicacao_grandetabela3">
	
		<h1 style="margin-left: 0pt;"><fmt:message key="mensagem.informacao.placaVeiculo" />:</h1>
		
		<table class="detalhe2" cellspacing="3" width="390px">
			<tbody>
				<tr>
					<th class="barraroxa" height="25" width="130"><fmt:message key="label.placaVeiculo" />:</th>
					<td class="camposinternos" width="250">
						<label>
							<input id="numeroPlaca" type="text" name="numeroPlaca" maxlength="10" style="width: 100px;"/>
						</label>
						<a class="linkazul" href="javascript:adicionarPlacas();"><fmt:message key="label.adicionarALista" /></a>
						<span style="margin-left: 15px;"></span>
					</td>
				</tr>
			</tbody>
		</table>
		
		
		<div class="replicacao_tabela" style="display: none;" id="divTabelaPlacas">
			<table id="alter" class="tabelaPlacas" cellspacing="0" width="200px" style="margin: 10px;">
				<tbody>
					<tr>
						<th class="texttable_azul" width="80%"><fmt:message key="label.placaAdicionadas" /></th>
						<th class="texttable_cinza" width="20%"><fmt:message key="label.excluir" /></th>
					</tr>
				</tbody>
			</table>
		</div>
		
		
		<div class="botoes_replicacao" style="*text-align:left;">
			<img height="16" border="0" align="absbottom" width="16" src="/SascarPortalWeb/sascar/images/corporativo_new/search32.png"/>
			<a class="linkazul" href="#buscarTodos" onclick="javascript:buscarTodos(this);"><fmt:message key="label.buscarTodos" /></a>
			<label>
				<input 
				id="excluirContato" 
				class="button" 
				type="button" 
				onclick="excluirContatoPlaca();" 
				style="*width:240px;"
				value="<fmt:message key="mensagem.informacao.excluirContatoAcima" />" 
				name="excluirContato"/>
			</label>
		</div>
	</div>
	
	<div class="botaovoltar" style="clear:both;">
		<input 
			type="button" 
			value="<fmt:message key="label.voltar" />" 
			class="button3" 
			onclick="window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC32/dv03&nome=${param.nome}&numRG=${param.numRG}&numCpfCnpj=${param.numCpfCnpj}&numeroCelular=${param.numeroCelular}&contatoEmergencia=${param.contatoEmergencia}&contatoAutorizado=${param.contatoAutorizado}'" />
	</div>
	
	</form>	
	
</body>

<div id="popup" style="display: none; position:relative; top:100px; width:700px; height:400px; left: 0;">
	<div id="popup_bordacima"></div>
  	<div id="popupinterior" style="text-align:center; overflow: auto;  width:660px; height:400px;">
		<div class="texto" style="font-size:12px; font-weight:bold; color: #00417B;"> </div>
	 	<div style="text-align:center; ">
			<input type="button" 
				class="buttonExcluirContato" 
				value="<fmt:message key="label.fechar" />"
				onclick="document.location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC32/dv04&nome=${param.nome}&numCpfCnpj=${param.numCpfCnpj}&numRG=${param.numRG}&numeroCelular=${param.numeroCelular}'"/>
		</div>
  	</div>
 	<div id="popup_bordarodape"></div>
</div>	

<br clear="all"/>
	
<div class="clear:both"></div>
</div>
