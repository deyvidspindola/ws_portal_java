<jsp:directive.include file="/WEB-INF/views/includes.jsp" />

<c:catch var="helper">
	<c:import url="/VerificarPermissao" context="/SascarPortalWeb" />
</c:catch>

<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$.showMessage("${mensagem }");
	</script>
</c:if>

<c:if test="${not empty helper}">
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>

<script>
	function adicionarContatosAutorizado() {
		//Validar E3 e E3
		if (validacaoE2E3()) {

			//contar as placas adicionadas na tabela, execet a linha do cabe?alho
			var contadorPlacasAdd = $(".tabelaPlacas tr").not("tr:first").length;

			//E4 N?o selecionada placa para replica??o
			if (contadorPlacasAdd == 0) {

				//M5
				$.showMessage('<fmt:message key="mensagem.informacao.placaInclusaoNaoSelecionada" />');

			} else {
				var data = $("#formUC31DV05").serialize();
				$(':disabled').each(function() {
					data += '&' + this.name + '=' + $(this).val();
				});

				$.ajax({
					url : "/SascarPortalWeb/IncluirGrupoContatoVeiculo/adicionarContato?acao=4",
					data : data || {},
					dataType : "json",
					success : function(json) {
						$("#dialog_mensagem .popup_padrao_pergunta")
								.html(json.mensagem);
						$("#dialog_mensagem").jOverlay({
							'closeOnEsc' : false,
							'bgClickToClose' : false
						});
					}
				});
			}
		}
	}

	function adicionarContatosTela() {

		// Pegando o valor do contato digitada no campo input
		var nomePessoaAutorizada = $("#nomePessoaAutorizada").val();
		var numRG = $("#numRG").val();
		var numCpfCnpj = $("#numCpfCnpj").val();
		var telefone1 = $("#telefone1").val();
		var telefone2 = $("#telefone2").val();
		var telefone3 = $("#telefone3").val();

		if ($.trim(nomePessoaAutorizada) && (telefone1) && (telefone2)&& (numCpfCnpj) && (numRG)) {

			appendHtmlPessoa(nomePessoaAutorizada, telefone1, telefone2, telefone3, numCpfCnpj,numRG);
			
			//O n?mero m?ximo de contatos em cada lista ? de 10 contatos.
			var qtdeAdd = $(".tabelaContatos tr").not("tr:first").length;
			if(qtdeAdd == 10){
				$("#addContatos").hide();
			}
			
			// Limpando o valor do input
			$("#nomePessoaAutorizada").val('');
			$("#nomePessoaAutorizada").focus();
			$("#numRG").val('');
			$("#numRG").focus();
			$("#numCpfCnpj").val('');
			$("#numCpfCnpj").focus();
			$("#telefone1").val('');
			$("#telefone1").focus();
			$("#telefone2").val('');
			$("#telefone2").focus();
			$("#telefone3").val('');
			$("#telefone3").focus();

		} else {
			//Mensagem n?o definida no UC
			$.showMessage('<fmt:message key="uc31.dv05.informacao.001" /> ');
		}
	}

	function excluirContato(element) {
		var elem = $(element);
		elem.parents('tr').remove();

		//reposiciona o css da linha
		$(".tabelaContatos tr").each(function(i, value) {
			if (i % 2 == 0) {
				$(this).attr("class", "dif");
			} else {
				$(this).removeAttr("class");
			}
		});
		
		//O n?mero m?ximo de contatos em cada lista ? de 10 contatos. menos q isso exibe o botao de add
		var qtdeAdd = $(".tabelaContatos tr").not("tr:first").length;
		if(qtdeAdd < 10){
			$("#addContatos").show();
		}
		
		if(qtdeAdd == 0){
			$("#divTabelaContatos").hide();
		}
	}

	function adicionarPlacas() {

		// Pegando o valor da placa digitada no campo input
		var numeroPlaca = $("#numeroPlaca").val();

		//Chamar o ajax para procurar o contrato
		$.ajax({
			"url" : "/SascarPortalWeb/IncluirGrupoContatoVeiculo/adicionarPlacaDestino",
			"data" : {"numeroPlaca" : numeroPlaca,"acao" : 3},
			"dataType" : "json",
			"success" : function(json) {

				if (json != null && json.success) {

					var placasJaAdd = "";

					$.each(json.contratos, function(i, contratos) {
						if (contratos.placa) {

							//Verifica se a placa ja esta add
							var achou = false;
							$("input[name=numeroContratoDestino]").each(function(i, value) {
								if ($(this).val() == contratos.numeroContrato) {
									achou = true;
									placasJaAdd += contratos.placa
											+ ", ";
								}

							});

							//se n?o achou pode add
							if (!achou) {

								// Pegando a tabela onde ser? adicionada a numeroPlaca
								var tabela = $(".tabelaPlacas");

								var css = $(".tabelaPlacas tr:last").attr("class");

								css = (css == '') ? 'dif': '';

								var html = "<tr class="+ css +">"
										+ "<td class='camposinternos'>"
										+ contratos.placa
										+ " <input type='hidden' value="+contratos.numeroContrato+" name='numeroContratoDestino'/>"
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

					if (placasJaAdd != "") {
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
		$(".tabelaPlacas tr").each(function(i, value) {
			if (i % 2 == 0) {
				$(this).attr("class", "dif");
			} else {
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
	function buscarTodos(element) {
		//Validar E3 e E3
		if (validacaoE2E3()) {
			//Qtde de linhas
			var tamanho = $("input[name='pessoas']").length;
			tamanho = tamanho - 1;

			var listaPessoas = "";
			$("input[name='pessoas']").each(function(i, value) {
				var lista = $(this).val();
				listaPessoas += lista;
				//so inserir o separador se nao for o ultimo item
				if (tamanho != i) {
					listaPessoas += "|";
				}
			});

			var href = "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC31/dv04&tela=dv05&tipoContato=A&DIV05=sim";
			href += "&pessoas=" + listaPessoas;

			//Mandar para a dv05
			$(element).attr("href", href);
			$(element).removeAttr("onclick");
			$(element).click();
		}
	}

	$(document).ready(function() {

		$("#numCpfCnpj").setMask("cpf");
		$("#telefone1").setMask({ mask : '999999999999'});
		$("#telefone2").setMask({mask : '999999999999'});
		$("#telefone3").setMask({mask : '999999999999'});
		$("#numRG").setMask({mask : '9999999999'});
		
		montarHtmlContatos();

	});
	
	function montarHtmlContatos(){
		var pessoas = "";
		<c:if test="${not empty param.pessoasVoltar}">
			pessoas = "${param.pessoasVoltar}";
		</c:if>
		
		if(pessoas != ""){
		
			var splitPessoas = pessoas.split("|");
			
			for(i in splitPessoas){
			
				var split = splitPessoas[i].split(",");
				
				var nomePessoaAutorizada = split[0];
				var telefone1 = split[1];
				var telefone2 = split[2];
				var telefone3 = split.length > 3 ? split[3] : "";
				var numCpfCnpj = split[4];
				var numRG = split[5];
			
				appendHtmlPessoa(nomePessoaAutorizada, telefone1, telefone2, telefone3, numCpfCnpj, numRG);
			}
		}
	}
	
	function appendHtmlPessoa(nomePessoaAutorizada, telefone1, telefone2, telefone3, numCpfCnpj, numRG){
		// Pegando a tabela onde ser? adicionado o contato
		var tabela = $(".tabelaContatos");

		var css = $(".tabelaContatos tr:last").attr("class");
		css = (css == '') ? 'dif' : '';

		var hidden = nomePessoaAutorizada + "," + telefone1 + ","+ telefone2 + "," + telefone3 + "," + numCpfCnpj + "," + numRG;
		
		// HTML Template para <tr> + campo
		var html = '<tr class='+ css +'>'
					+ '<input type="hidden" value="' + hidden + '" name="pessoas"/>'
					+ '<td class="camposinternos">'+ nomePessoaAutorizada+ '</td>'
					+ '<td class="camposinternos">'+ numRG+ '</td>'
					+ '<td class="camposinternos">'+ numCpfCnpj+ '</td>'
					+ '<td class="camposinternos">'+ telefone1+ '</td>'
					+ '<td class="camposinternos">'+ telefone2+ '</td>'
					+ '<td class="camposinternos">'+ (telefone3 != "" ? telefone3 : "&nbsp;") + '</td>'
					+ '<td class="camposinternos">'
						+ '<a href="#remover" onclick="excluirContato(this)" title="<fmt:message key="label.excluir" />">'
						+ '<img height="16" border="0" align="absmiddle" width="16" src="/SascarPortalWeb/sascar/images/corporativo_new/excluir16-10.png" />'
						+ '</a>' 
					+ '</td>' 
				 + '</tr>';	

		// Pegando o tbody da tabela e adicionando uma <tr>
		tabela.find('tbody').append(html);
		
		$("#divTabelaContatos").show();
	}

	/*
	 * Valida as regra de E2- limite de 10 e E3 - Contato n?o selecionado
	 */
	function validacaoE2E3(element) {
		var validacao = false;

		//Verifica quantidade de contatos inseridos na tabela
		var qtdeContatos = $(".tabelaContatos tr").not(
				'.tabelaContatos tr:first').length;

		//E3 N?o selecionar contato
		if (qtdeContatos != null && qtdeContatos > 0) {

			//E2 Execedeu numero maximo de contatos
			if (qtdeContatos > 10) {

				//M3
				$.showMessage('<fmt:message key="mensagem.informacao.maximoContatosExcedido" />');

			} else {
				//Retorna validacao ok
				validacao = true;
			}
		} else {

			//M4
			$.showMessage('<fmt:message key="mensagem.informacao.contatoInclusaoNSelecionado" />');

		}
		return validacao;
	}
</script>

<div id="visibleDIV05">
<div class="cabecalho">
	<fmt:message key="label.atualizacaoCadastral" />
	<div class="caminho">
		<a
			href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}"
			title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; <a href="#"
			class="linktres"><fmt:message key="label.informacoes" /></a> &gt; <a
			href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC08/dv01"
			class="linkquatro"><fmt:message key="label.atualizacaoCadastral" /></a>
	</div>
</div>


<jsp:include page="/WEB-INF/views/Corporativo/UC08/MenuAbas.jsp">
	<jsp:param name="abaAtiva" value="direita" />
</jsp:include>


<body>
	<table class="tbatualizacao" cellspacing="0" width="960">
		<tbody>
			<tr class="tbatualizacao">
				<th class="tbatualizacao"><fmt:message key="label.incluirContato" /></th>
			</tr>
		</tbody>
	</table>


	<form method="post" action="" id="formUC31DV05" name="formUC31DV05">
		<div class="explicacao_replicacao">
			<fmt:message key="uc31.dv03.texto.001" />
			<span class="texthelp2"> 
				<img hspace="5" height="16" align="absmiddle" width="16" src="/SascarPortalWeb/sascar/images/corporativo_new/lightbulb32.png">
				<fmt:message key="uc30.dv04.texto.001" />
			</span>
		</div>

	<div id="tudo">

		<div class="replicacao_grandetabela4">

			<h1 style="margin-left: 0pt;"><fmt:message key="mensagem.informacao.contatoAutorizado" />:</h1>

			<table width="480px" cellspacing="3" class="detalhe2">
				<tbody>
					<tr>
						<th class="barracinza" height="25" width="200"><fmt:message key="label.nome" /> <span class="asterisco">*</span></th>
						<td class="camposinternos2" width="350">
							<input id="nomePessoaAutorizada" type="text" name="nomePessoaAutorizada" class="required" maxlength="30"/>
						</td>
					</tr>
					<tr>
						<th class="barracinza" height="25" width="200"><fmt:message key="label.rg" /> <span class="asterisco">*</span></th>
						<td class="camposinternos2" width="350">
							<input id="numRG" type="text" name="numRG" class="required"/>
						</td>
					</tr>
					<tr>
						<th class="barracinza" height="25" width="200"><fmt:message key="label.cpf" /> <span class="asterisco">*</span></th>
						<td class="camposinternos2" width="350">
							<input id="numCpfCnpj" type="text" name="numCpfCnpj" class="required"/>
						</td>
					</tr>
					<tr>
						<th class="barracinza" height="25" width="200"><fmt:message key="label.telefoneComercial" /> <span class="asterisco">*</span></th>
						<td class="camposinternos2" width="350">
							<input id="telefone1" type="text" name="telefone1" maxlength="11" class="required"/>
						</td>
					</tr>
					<tr>
						<th class="barracinza" height="25" width="200"><fmt:message key="label.telefoneCelular" /> <span class="asterisco">*</span></th>
						<td class="camposinternos2" width="350">
							<input id="telefone2" type="text" name="telefone2" maxlength="11" class="required" />
						</td>
					</tr>
					<tr>
						<th class="barracinza" height="25" width="200"><fmt:message key="label.telefoneResidencial" /></th>
						<td class="camposinternos2" width="350">
							<input id="telefone3" type="text" name="telefone3" maxlength="11" />
							<a class="linkazul" id="addContatos" onclick="adicionarContatosTela();"><fmt:message key="label.mAdicionarContato" /></a>
						</td>
					</tr>
				</tbody>
			</table>


			<div class="inclusao_tabela4" style="display: none;" id="divTabelaContatos">

				<span class="text2"><fmt:message key="label.contatoAutorizado" />:</span>

				<table id="alter" class="tabelaContatos" style="margin:10px 10px 10px 0px;"cellspacing="0" width="580" >
						<tr>
							<th class="texttable_cinza" width="32%"><fmt:message key="label.nome" /></th>
							<th class="texttable_cinza" width="12%"><fmt:message key="label.rg" /></th>
							<th class="texttable_cinza" width="16%"><fmt:message key="label.cpf" /></th>
							<th class="texttable_cinza" width="11%"><fmt:message key="label.telefoneComercial" /></th>
							<th class="texttable_cinza" width="11%"><fmt:message key="label.telefoneCelular" /></th>
							<th class="texttable_cinza" width="11%"><fmt:message key="label.telefoneResidencial" /></th>
							<th class="texttable_cinza" width="7%"><fmt:message key="label.excluir" /></th>
						</tr>
				</table>
			</div>
		</div>

		
		<div class="img_replicacao"><img src="/SascarPortalWeb/sascar/images/corporativo_new/arrowright.jpeg" width="32" height="32" /></div>


		<div class="replicacao_grandetabela4_3">

			<h1 style="margin-left: 0pt;"><fmt:message key="label.paraAsPlacas" />:</h1>

			 <table width="280px" cellspacing="3" class="detalhe2" >
				<tbody>
					<tr>
						<th class="barraroxa" height="25" width="150"><fmt:message key="label.placaVeiculo" />:</th>
						<td class="camposinternos" width="150">
							<label>
								<input id="numeroPlaca" type="text" maxlength="10" name="numeroPlaca" style="width: 100px;"/> 
							</label> 
							<br /><a class="linkazul" href="javascript:adicionarPlacas();"><fmt:message key="label.adicionarALista" /></a>
							<span style="margin-left: 15px;"></span>
						</td>
					</tr>
				</tbody>
			</table>


			<div class="replicacao_tabela" style="display: none;" id="divTabelaPlacas">
				<table class="tabelaPlacas" style="margin:10px 10px 10px 10px;" cellspacing="0" width="200px" ID="alter">
					<tbody>
						<tr>
							<th class="texttable_azul" width="80%"><fmt:message key="label.placaAdicionadas" /></th>
							<th class="texttable_cinza" width="20%"><fmt:message key="label.excluir" /></th>
						</tr>
					</tbody>
				</table>
			</div>


			<div class="botoes_replicacao4" style="text-align:left;">
				<img height="16" border="0" align="absbottom" width="16" src="/SascarPortalWeb/sascar/images/corporativo_new/search32.png">
				<a class="linkazul" href="#buscarTodos" onclick="javascript:buscarTodos(this);"><fmt:message key="label.buscarTodos" /></a> 
				<label>
					<input id="incluir" 
						class="button tooltip" 
						type="button"
						value="<fmt:message key="label.incluir" />" 
						onclick="javascript:adicionarContatosAutorizado();"
						name="incluir"
						title="<fmt:message key="uc31.dv05.tooltip.001" />"/>
					<input type="hidden" name="tipoContato" value="A" /> </label>
			</div>
		</div>

		<div class="botaovoltar" style="clear:both;">
			<input 
				type="button" 
				value="<fmt:message key="label.voltar" />" 
				class="button3" 
				onclick="window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC31/dv02'" >
		</div>
	</div>
	
	</form>
</body>


<div id="dialog_mensagem" class="popup_padrao" style="display: none;">
	<div class="popup_padrao_pergunta"></div>
	<div class="popup_padrao_resposta">
		<input type="button" class="button" value="<fmt:message key="label.fechar" />" onclick="javascript:$.closeOverlay();" />
	</div>
</div>

<br clear="all" />

<div class="clear:both"></div>
</div>