<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/EfetuarAtualizacaoCadastral/detalharContratante?acao=1" context="/SascarPortalWeb"  />
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

	function carregarPaises(select) {
		var select = $(select);

		$("option", select).remove();
		select.append($('<option></option>').val("").html('<fmt:message key="label.selecione" />'));

		$.ajax({
			"url": "/SascarPortalWeb/EfetuarAtualizacaoCadastral/listarPaises",
			"data" : {"acao" : 11},
			"dataType" : "json",
			"success": function(json){
				if (json.success) {
					$.each(json.paises, function(i, paises){
						if (paises.value && paises.id) {
							var option = new Option(paises.value, paises.id);
							if ($.browser.msie) {
								select[0].add(option);
							} else {
								select[0].add(option, null);
							}
						}
					});
				} else {
					$.showMessage(json.mensagem);
				}
			}
		});
	}

	function carregarEstados(codigoPais, idSelect, valueOptionSelected, textOptionSelected) {
		var select = $(idSelect);
		
		if (codigoPais == "") {
			$("option", select).remove();
			select.append($('<option></option>').val("").html('<fmt:message key="label.selecione" />'));
			return;
		}

		$.ajax({
			"url": "/SascarPortalWeb/EfetuarAtualizacaoCadastral/listarEstados",
			"data" : { "codigoPais": codigoPais, "acao" : 4 },
			"dataType" : "json",
			"beforeSend": function(){
				$("option", select).remove();
				select.append($('<option></option>').val("").html('<fmt:message key="label.selecione" />'));
			},
			"success": function(json){
				if (json.success) {
					$.each(json.estados, function(i, estado){
						if (estado.value && estado.id) {
							var option = new Option(estado.value, estado.id);
							if ($.browser.msie) {
								select[0].add(option);
							} else {
								select[0].add(option, null);
							}
						}
						
					});

					if (valueOptionSelected) {
						$("option[value='"+valueOptionSelected+"']", idSelect).attr("selected", true);
					}

					if (textOptionSelected) {
						$("option:contains('"+textOptionSelected+"')", idSelect).attr("selected", true);
					}
					
				} else {
					$.showMessage(json.mensagem);
				}
			}
		});
	}

	function carregarCidades(siglaUF, idSelect, valueOptionSelected, textOptionSelected) {

		var select = $(idSelect);

		if (siglaUF == "") {
			$("option", select).remove();
			select.append($('<option></option>').val("").html('<fmt:message key="label.selecione" />'));
			return;
		}

		$.ajax({
			"url": "/SascarPortalWeb/EfetuarAtualizacaoCadastral/listarCidades",
			"data" : { "siglaUF": siglaUF, "acao" : 5 },
			"dataType" : "json",
			"beforeSend": function(){
				$("option", select).remove();
				select.append($('<option></option>').val("").html('<fmt:message key="label.selecione" />'));
			},
			"success": function(json){
				var elementSelected = null;
				if (json.success) {
					$.each(json.cidades, function(i, cidade){
						if (cidade.value && cidade.id) {
							var option = new Option(cidade.value, cidade.id);
							if ($.browser.msie) {
								select[0].add(option);
							} else {
								select[0].add(option,null);
							}
						}
					});

					if (valueOptionSelected) {
						elementSelected = $("option[value='"+valueOptionSelected+"']", idSelect).attr("selected", true);
					}

					if (textOptionSelected) {
						elementSelected = $("option:contains('"+textOptionSelected+"')", idSelect).attr("selected", true);
					}

					if (elementSelected) {
						$("#enderecoCobrancaCidade").val(elementSelected.text());
					}

				} else {
					$.showMessage(json.mensagem);
				}
			}
		});
	}

	function carregarBairros(codigoCidade, idSelect, valueOptionSelected, textOptionSelected) {
	
		var select = $(idSelect);
		if (codigoCidade == "") {
			$("option", select).remove();
			select.append($('<option></option>').val("").html('<fmt:message key="label.selecione" />'));
			return;
		}

		$.ajax({
			"url": "/SascarPortalWeb/EfetuarAtualizacaoCadastral/listarBairros",
			"data" : { "codigoCidade": codigoCidade, "acao" : 6 },
			"dataType" : "json",
			"beforeSend": function(){
				$("option", select).remove();
				select.append($('<option></option>').val("").html('<fmt:message key="label.selecione" />'));
			},
			"success": function(json){
				var elementSelected = null;
				if (json.success) {
					$.each(json.bairros, function(i, bairro){
						if (bairro.value && bairro.id) {
							var option = new Option(bairro.value, bairro.id);
							if ($.browser.msie) {
								select[0].add(option);
							} else {
								select[0].add(option,null);
							}
						}
					});

					if (valueOptionSelected) {
						elementSelected = $("option[value='"+valueOptionSelected+"']", idSelect).attr("selected", true);
					}

					if (textOptionSelected) {
						elementSelected = $("option:contains('"+textOptionSelected+"')", idSelect).attr("selected", true);
					}

					if (elementSelected) {
						$("#enderecoCobrancaBairro").val(elementSelected.text());
					}

				} else {
					$.showMessage(json.mensagem);
				}
			}
		});
	}
	
	function buscarEnderecoCobranca(inputCep) {

		// Captura o número do CEP e retira o excesso de espaços
		var numeroCep = $.trim($(inputCep).val());

		// ER de validação de CEP
		var erCep = /^\d{5}-\d{3}$/;

		// Verifica se o CEP é válido
		if (numeroCep.length > 0) {
			if(erCep.test(numeroCep)) {
	
				$.getJSON('/SascarPortalWeb/EfetuarAtualizacaoCadastral/buscarEndereco?acao=7',
					{'numeroCep' : numeroCep.replace("-", "")},
					function(json) {
					
						if(json && json.success) {
							
							// PAIS
							if (json.endereco.codigoPais) {
								$("#enderecoCobrancaPais").attr("disabled", true);
								$("option[value='"+json.endereco.codigoPais+"']", "#enderecoCobrancaPais").attr("selected", true);
							}

							if (json.endereco.codigoPais && json.endereco.siglaUF) {
								$("#enderecoCobrancaSiglaUF").attr("disabled", true);
								carregarEstados(json.endereco.codigoPais, "#enderecoCobrancaSiglaUF", json.endereco.siglaUF);
							}
							
						    // CIDADE
						    if (json.endereco.localidade) {
								$("option","#enderecoCobrancaCidades").remove();
								$("#enderecoCobrancaCidades").attr("disabled", true).append(
									$('<option></option>').val(json.endereco.localidade).html(json.endereco.localidade)
							    );
							}
							
							// BAIRRO
							if (json.endereco.bairro) {
								$("option","#enderecoCobrancaBairros").remove();
								$("#enderecoCobrancaBairros").attr("disabled", true).append(
									$('<option></option>').val(json.endereco.bairro).html(json.endereco.bairro)
							    );
							}
							
							if (json.endereco.logradouro) {
								$("#enderecoCobrancaLogradouro").attr("disabled", true).val(json.endereco.logradouro);
							}
							
						} else {
							$.showMessage('<fmt:message key="mensagem.enderecoNaoEncontradoParaCepInformado" />');
							
							// PAIS
							$("#enderecoCobrancaPais").removeAttr("disabled");
							$("#enderecoCobrancaPais option[value='']").attr("selected", true);
	
							// ESTADO
							$("option","#enderecoCobrancaSiglaUF").remove();
							$("#enderecoCobrancaSiglaUF").removeAttr("disabled").append(
									$('<option></option>').val("").html('<fmt:message key="label.selecione" />')
						    );
	
							// CIDADE
							$("option","#enderecoCobrancaCidades").remove();
							$("#enderecoCobrancaCidades").removeAttr("disabled").append(
									$('<option></option>').val("").html('<fmt:message key="label.selecione" />')
						    );
	
							// BAIRRO
							$("option","#enderecoCobrancaBairros").remove();
							$("#enderecoCobrancaBairros").removeAttr("disabled").append(
									$('<option></option>').val("").html('<fmt:message key="label.selecione" />')
						    );
						    
							$("#enderecoCobrancaLogradouro").val("").removeAttr("disabled");
						}
						
						cidadeHidden();
						bairroHidden();
					}
				);
			} else {
				$.showMessage('<fmt:message key="mensagem.campo.cepValido" />');
			}
		}
	}

	function replicarEndereco(element) {
		if ($(element).is(':checked')) {
			var cep 		= $('input[name="numeroCep"]').val();
			var codigoPais 	= $('#paises').val();
			var pais 		= $('.pais').text();
			var siglaUF 	= $('#estados').val();
			var cidade 		= $('#cidades').val();
			var bairro 		= $('#bairros').val();
			var logradouro 	= $('input[name="descricaoLogradouro"]').val();
			var numero 		= $('input[name="numeroLogradouro"]').val();
			var complemento = $('input[name="complementoLogradouro"]').val();
			var telefone1 	= $('input[name="telefone1"]').val();
			var telefone2 	= $('input[name="telefone2"]').val();
			var telefone3 	= $('input[name="telefone3"]').val();

			// CEP
			$("#enderecoCobrancaCep").attr("disabled", true).val(cep);

			// PAIS
			$("option", "#enderecoCobrancaPais").remove();
			$("#enderecoCobrancaPais").attr("disabled", true).append(
				$('<option></option>').val(codigoPais).html(pais)
		    );

			// ESTADO
			$("option","#enderecoCobrancaSiglaUF").remove();
			$("#enderecoCobrancaSiglaUF").attr("disabled", true).append(
				$('<option></option>').val(siglaUF).html(siglaUF)
		    );

			// CIDADE
			$("option","#enderecoCobrancaCidades").remove();
			$("#enderecoCobrancaCidades").attr("disabled", true).append(
				$('<option></option>').val(cidade).html(cidade)
		    );

			// BAIRRO
			$("option","#enderecoCobrancaBairros").remove();
			$("#enderecoCobrancaBairros").attr("disabled", true).append(
				$('<option></option>').val(bairro).html(bairro)
		    );

			$("#enderecoCobrancaLogradouro").attr("disabled", true).val(logradouro);
			$("#enderecoCobrancaNumero").attr("disabled", true).val(numero);
			$("#enderecoCobrancaComplemento").attr("disabled", true).val(complemento);
			$("#enderecoCobrancaTelefone1").attr("disabled", true).val(telefone1);
			$("#enderecoCobrancaTelefone2").attr("disabled", true).val(telefone2);
			$("#enderecoCobrancaTelefone3").attr("disabled", true).val(telefone3);
			
	    } else {
	    	$("#enderecoCobrancaCep").removeAttr("disabled").val('');

	    	$("option", "#enderecoCobrancaPais").remove();
			$("#enderecoCobrancaPais").removeAttr("disabled");
			carregarPaises("#enderecoCobrancaPais");
			
			// ESTADO
			$("option","#enderecoCobrancaSiglaUF").remove();
			$("#enderecoCobrancaSiglaUF").removeAttr("disabled").append(
					$('<option></option>').val("").html('<fmt:message key="label.selecione" />')
		    );

			// CIDADE
			$("option","#enderecoCobrancaCidades").remove();
			$("#enderecoCobrancaCidades").removeAttr("disabled").append(
					$('<option></option>').val("").html('<fmt:message key="label.selecione" />')
		    );

			// BAIRRO
			$("option","#enderecoCobrancaBairros").remove();
			$("#enderecoCobrancaBairros").removeAttr("disabled").append(
					$('<option></option>').val("").html('<fmt:message key="label.selecione" />')
		    );
		    
			$("#enderecoCobrancaLogradouro").removeAttr("disabled").val('');
			$("#enderecoCobrancaNumero").removeAttr("disabled").val('');
			$("#enderecoCobrancaComplemento").removeAttr("disabled").val('');
			$("#enderecoCobrancaTelefone1").removeAttr("disabled").val('');
			$("#enderecoCobrancaTelefone2").removeAttr("disabled").val('');
			$("#enderecoCobrancaTelefone3").removeAttr("disabled").val('');
	    }
	    
	    cidadeHidden();
		bairroHidden();
	}

	function abrirExcluirContato(codigoContato){
		$("#dialog_excluir").jOverlay({'onSuccess' : function(){
			$("#codigoContato").val(codigoContato);
		}});
	}

	function abrirGerenciarContato(codigoContato) {
		$.ajax({
			url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC08/dv05",
			data: {"codigoContato" : codigoContato},
			dataType:"html",
			success: function(html){
				$("#dialog").html(html);
				$("#dialog").jOverlay({onSuccess: function(html){
					carregarContato(codigoContato, html);
				}});
			}
		});
	}

	function carregarContato(codigoContato, html) {
		var tds = $("#contato_" + codigoContato).find("td");

		if (codigoContato && tds.length == 6) {
			var nome 		= $.trim($(tds[0]).html());
			var telefone1 	= $.trim($(tds[1]).html());
			var telefone2 	= $.trim($(tds[2]).html());
			var telefone3 	= $.trim($(tds[3]).html());
			var observacao 	= $.trim($(tds[4]).html());

			$(html).find('#nomeContato').val(nome.replace(/&[^;]+;/g, ''));
			$(html).find('#telefone1Contato').val(telefone1.replace(/&[^;]+;/g, ''));
			$(html).find('#telefone2Contato').val(telefone2.replace(/&[^;]+;/g, ''));
			$(html).find('#telefone3Contato').val(telefone3.replace(/&[^;]+;/g, ''));
			$(html).find('#observacaoContato').val(observacao.replace(/&[^;]+;/g, ''));
		}
	}

	
	

	
	function excluirContato() {				
		
		var codigoContato = $("#codigoContato").val();
		$.ajax({
			"url": "/SascarPortalWeb/EfetuarAtualizacaoCadastral/excluirContato?acao=9",
			"data": {"codigoContato" : codigoContato, "tipoContato" : "C"},
			"dataType":"json",
			"success": function(json){							
				$("#dialog_mensagem .popup_padrao_pergunta").html(json.mensagem);
				$("#dialog_mensagem").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
				
			}
		});
	}
	
	function submeterContratante(form) {

		var data = $(form).serialize();
		$(':disabled').each( function() {
			data += '&' + this.name + '=' + $(this).val();
		});

		$.ajax({
			url: "/SascarPortalWeb/EfetuarAtualizacaoCadastral/submeterContratante?acao=10&dados_atualizados=false",
			data: data || {},
			dataType:"json",
			success: function(json){
				$("#dialog_mensagem .popup_padrao_pergunta").html(json.mensagem);
				$("#dialog_mensagem").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
			}
		});
	}
	
	function setValue(valor) {
		$("#faturaSomenteEmail").val(valor);
	}
	
	function cidadeHidden() {
		$("#enderecoCobrancaCidade").val($.trim($(":selected", "#enderecoCobrancaCidades").text()));
	}
	
	function bairroHidden() {
		$("#enderecoCobrancaBairro").val($.trim($(":selected", "#enderecoCobrancaBairros").text()));
	}

	function habilitarSenha(element) {
			if ($(element).is(':checked')) {
				$('#senha').removeAttr('disabled');
				$('#contraSenha').removeAttr('disabled');
			
		    } else {
		    	$('#senha').attr('disabled', true);
				$('#contraSenha').attr('disabled', true);
		    }
		}

	$(document).ready(function(){
		
		$("#enderecoCobrancaCep").setMask('cep');

		$('#numeroCpfCnpj').blur(function(){
			if(this.value.length <= 11) {
				$(this).setMask('cpf');
			} else {
				$(this).setMask('cnpj');
			}
		}).focus(function(){
			$(this).unsetMask();
			$(this).setMask({mask:'9', type:'repeat'});
		});

		$("#enderecoCobrancaTelefone1").setMask({mask:'999999999999'});
		$("#enderecoCobrancaTelefone2").setMask({mask:'999999999999'});
		$("#enderecoCobrancaTelefone3").setMask({mask:'999999999999'});
		$("#enderecoCobrancaNumero").setMask({mask:'9999999'});

		$("#dataNascimento").datepicker({
			dateFormat: 'dd/mm/yy',
			changeMonth: true,
			changeYear: true
		});

		$('#dataNascimento').blur(function(){
			$(this).setMask('date');
		}).focus(function(){
			$(this).unsetMask();
			$(this).setMask({mask:'9', type:'repeat'});
		});
   
		var container = $('div.container2');
		$("#formCadastro").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form) {
				submeterContratante(form);
				return false;
			}
		});
		
		<c:if test="${not empty contratante.endereco.codigoPais }">
			//carregarEstados('${contratante.endereco.codigoPais }', '#estados', '${contratante.endereco.uf }');
		</c:if>

		<c:if test="${not empty contratante.enderecoCobranca.codigoPais }">
			carregarEstados('${contratante.enderecoCobranca.codigoPais }', '#enderecoCobrancaSiglaUF', '${contratante.enderecoCobranca.uf }');
		</c:if>

		<c:if test="${not empty contratante.enderecoCobranca.uf }">
			carregarCidades('${contratante.enderecoCobranca.uf }', '#enderecoCobrancaCidades', '${contratante.enderecoCobranca.codigoCidade }');
		</c:if>

		<c:if test="${not empty contratante.enderecoCobranca.codigoBairro }">
			carregarBairros('${contratante.enderecoCobranca.codigoCidade }', '#enderecoCobrancaBairros', '${contratante.enderecoCobranca.codigoBairro }');
		</c:if>
		
		$("#faturaSomenteEmail").val("${contratante.faturaSomenteEmail}");
		
		<c:choose>			
		      <c:when test="${contratante.faturaSomenteEmail eq 'nao'}">
		      $("#rdbNao").attr("checked", "checked");
		      </c:when>

		      <c:otherwise>
		      	 $("#rdbSim").attr("checked", "checked");
		      </c:otherwise>
	    </c:choose>
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
	<jsp:param name="abaAtiva" value="esquerda" />
</jsp:include>

<div class="container2">
	<ol>
		<li><label for="dataNascimento" class="error"><fmt:message key="mensagem.campo.dataNascimente" /></label></li>
		<li><label for="enderecoCobrancaCep" class="error"><fmt:message key="mensagem.campo.cobranca.cep" /></label></li>
		<li><label for="enderecoCobrancaPais" class="error"><fmt:message key="mensagem.campo.cobranca.pais" /></label></li>
		<li><label for="enderecoCobrancaSiglaUF" class="error"><fmt:message key="mensagem.campo.cobranca.estado" /></label></li>
		<li><label for="enderecoCobrancaCidades" class="error"><fmt:message key="mensagem.campo.cobranca.cidade" /></label></li>
		<li><label for="enderecoCobrancaBairros" class="error"><fmt:message key="mensagem.campo.cobranca.bairro" /></label></li>
		<li><label for="enderecoCobrancaLogradouro" class="error"><fmt:message key="mensagem.campo.cobranca.logradouro" /></label></li>
		<li><label for="enderecoCobrancaNumero" class="error"><fmt:message key="mensagem.campo.cobranca.numero" /></label></li>
		<li><label for="enderecoCobrancaTelefone1" class="error"><fmt:message key="mensagem.campo.cobranca.telefone1" /></label></li>
		<li><label for="enderecoCobrancaTelefone2" class="error"><fmt:message key="mensagem.campo.cobranca.telefone2" /></label></li>
		<li><label for="enderecoCobrancaTelefone3" class="error"><fmt:message key="mensagem.campo.cobranca.telefone3" /></label></li>
		<li><label for="emailCobranca" class="error"><fmt:message key="mensagem.campo.cobranca.emailValido" /></label></li>
		<li><label for="senha" class="error"><fmt:message key="mensagem.campo.senha" /></label></li>
		<li><label for="contraSenha" class="error"><fmt:message key="mensagem.campo.contraSenha" /></label></li>
	</ol>
</div>

<table width="960" cellspacing="0" class="tbatualizacao" >
	<tr class="tbatualizacao">
		<th class="tbatualizacao"><fmt:message key="label.dadosContratante" /></th>
	</tr>
</table>

<form action="" method="post" class="filtro" id="formCadastro">
	
	<input type="hidden" name="codigoPais" id="paises" value="${contratante.endereco.codigoPais }"/>
	<input type="hidden" name="siglaUF" id="estados" value="${contratante.endereco.uf }"/>
	<input type="hidden" name="descricaoCidade" id="cidades" value="${contratante.endereco.descricaoCidade }"/>
	<input type="hidden" name="descricaoBairro" id="bairros" value="${contratante.endereco.descricaoBairro}"/>
	
	<input type="hidden" name="descTipoPessoa" id="descTipoPessoa" value="${contratante.tipoPessoa}"/>
	<input type="hidden" name="nomeContratante" id="nomeContratante" value="${contratante.nome}"/>
	<input type="hidden" name="numeroCpfCnpj" id="numeroCpfCnpj" value="${contratante.numCpfCnpj}" />
	<input type="hidden" name="numeroRg" value="${contratante.numRG}"/>
	<input type="hidden" name="orgaoEmissorRg" value="${contratante.orgaoEmissorRG}"/>
	<input type="hidden" name="dataEmissaoRg" value="${dataEmissaoRg}"/>
	
	<input type="hidden" name="nomePai" value="${contratante.nomePai}"/>
	<input type="hidden" name="nomeMae" value="${contratante.nomeMae}"/>
	<input type="hidden" name="nomeContratante" value="${contratante.nome}"/>
	<input type="hidden" name="numeroCpfCnpj" id="numeroCpfCnpj" value="${contratante.numCpfCnpj}"/>
	<input type="hidden" name="inscricao" value="${contratante.inscricaoEstadual}"/>
	<input type="hidden" name="ufInscricao" value="${contratante.ufInscricaoEstadual}"/>
	<input type="hidden" name="simples" value="${contratante.optanteSimples}"/>
	<input type="hidden" name="dataFundacao" value="${dataFundacao}"/>
	<input type="hidden" name="numeroCep" value="${contratante.endereco.cep}"/>
	<input type="hidden" name="descricaoLogradouro" value="${contratante.endereco.descricaoLogradouro}"/>
	<input type="hidden" name="descricaoCidade" value="${contratante.endereco.descricaoCidade}"/>
	<input type="hidden" name="descricaoBairro" value="${contratante.endereco.descricaoBairro}"/>
	<input type="hidden" name="numeroLogradouro" value="${contratante.endereco.numero}"/>
	<input type="hidden" name="complementoLogradouro" value="${contratante.endereco.complemento}"/>
	<input type="hidden" name="telefone1" value="${contratante.telefone1}"/>
	<input type="hidden" name="telefone2" value="${contratante.telefone2}"/>
	<input type="hidden" name="telefone3" value="${contratante.telefone3}"/>
	<input type="hidden" name="email" value="${contratante.email }"/>
	<input type="hidden" name="faturaSomenteEmail" id="faturaSomenteEmail" value=""/>


	<table width="100%" cellspacing="3" class="detalhe2">
	
		<c:choose>
		
			<c:when test="${contratante.tipoPessoa eq 'F' }">
			
				<tr>
					<th width="200" class="barracinza"><fmt:message key="label.tipoPessoa" /></th>
					<td width="350" class="camposinternos"><fmt:message key="label.fisica" /></td>
					
					<th>&nbsp;</th>
					<td  width="350" class="camposinternos">&nbsp;</td>
			  	</tr>
			  	<tr>
					<th width="200"  class="barracinza"><fmt:message key="label.nome" /></th>
					<td width="350" class="camposinternos">${contratante.nome}</td>
					
					<th width="200" class="barracinza"><fmt:message key="label.cpf" /></th>
				  	<td width="350" class="camposinternos">${contratante.numCpfCnpj}</td>
				</tr>
			  	<tr>
					<th width="200"  class="barracinza"><fmt:message key="label.rg" /></th>
					<td width="350" class="camposinternos">${contratante.numRG}</td>
					
					<th width="200" class="barracinza"><fmt:message key="label.dataNascimento" /></th>
				  	<td width="350" class="camposinternos">
				  		<fmt:formatDate value="${contratante.dataNascimento}" pattern="dd/MM/yyyy" var="dataNascimento"/>

				  		<input type="text" name="dataNascimento" id="dataNascimento" class="required dateBR" value="${dataNascimento}"/>
				  	</td>
				</tr>
			  	<tr>
					<th width="200"  class="barracinza"><fmt:message key="label.filiacaoPai" /></th>
					<td width="350" class="camposinternos">${contratante.nomePai}</td>
					
					<th width="200" class="barracinza"><fmt:message key="label.filiacaoMae" /></th>
				  	<td width="350" class="camposinternos">${contratante.nomeMae}</td>
				</tr>
				
			</c:when>

			<c:otherwise>

				<tr>
					<th  width="200" class="barracinza"><fmt:message key="label.contratante" /></th>
					<td width="350" class="camposinternos">${contratante.nome}</td>
					
					<th width="200" class="barracinza"><fmt:message key="label.cnpj" /></th>
				  	<td width="350" class="camposinternos">${contratante.numCpfCnpj}</td>
				</tr>
				<tr>					
					<th  width="200" class="barracinza"><fmt:message key="label.inscricaoEstadual" /></th>
					<td width="350" class="camposinternos">${contratante.inscricaoEstadual}</td>
			
					
					<th  width="200" class="barracinza"><fmt:message key="label.ufInscricaoEstadual" /></th>
					<td width="350" class="camposinternos">${contratante.ufInscricaoEstadual}</td>
				</tr>
				<tr>					
					<th  width="200" class="barracinza"><fmt:message key="label.optantePeloSimples" /></th>
					<td width="350" class="camposinternos">
						<c:if test="${not contratante.optanteSimples}"><fmt:message key="label.nao" /></c:if>
						<c:if test="${contratante.optanteSimples}"><fmt:message key="label.sim" /></c:if>
					</td>
					
					<th  width="200" class="barracinza"><fmt:message key="label.dataFundacao" /></th>
					<td width="350" class="camposinternos"><fmt:formatDate value="${contratante.dataFundacao}" pattern="dd/MM/yyyy"/></td>
				</tr>

			</c:otherwise>

		</c:choose>

	</table>

	<table cellspacing="0" class="detalhe" >
		<tr class="barraazulzinha">
			<th class="barraazulzinha"><fmt:message key="label.endereco" /></th>
		</tr>
	</table>

	<table width="100%" cellspacing="3" class="detalhe2">
		<tr></tr>
		<tr>
			<th width="205" class="barracinza"><fmt:message key="label.cep" /></th>
			<td width="350" class="camposinternos">${contratante.endereco.cep}</td>
			<th width="200" class="barracinza"><fmt:message key="label.pais" /></th>
			<td width="350" class="camposinternos pais">
				<c:forEach items="${paises }" var="pais">
					<c:if test="${not empty pais.identifier and not empty pais.value and contratante.endereco.codigoPais eq pais.identifier}">
						${pais.value}
					</c:if>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<th  width="200" class="barracinza"><fmt:message key="label.estado" /></th>
			<td width="350" class="camposinternos">${contratante.endereco.uf }</td>
			<th  width="200" width="200" class="barracinza"><fmt:message key="label.cidade" /></th>
			<td width="350" class="camposinternos">${contratante.endereco.descricaoCidade }</td>
		</tr>
		<tr>
			<th  width="200" class="barracinza"><fmt:message key="label.bairro" /></th>
			<td width="350" class="camposinternos">${contratante.endereco.descricaoBairro}</td>
			<th  width="200" class="barracinza"><fmt:message key="label.rua" /></th>
			<td width="350" class="camposinternos">${contratante.endereco.descricaoLogradouro}</td>
		</tr>
		<tr>
			<th  width="200" class="barracinza"><fmt:message key="label.numero" /></th>
			<td class="camposinternos">${contratante.endereco.numero}</td>
			<th  width="200" class="barracinza"><fmt:message key="label.complemento" /></th>
			<td class="camposinternos">${contratante.endereco.complemento}</td>
		</tr>
		<tr>
			<th  width="200" class="barracinza"><fmt:message key="label.telefoneComercial" /></th>
			<td width="350" class="camposinternos">${contratante.telefone1}</td>
			<th  width="200" class="barracinza"><fmt:message key="label.telefoneResidencial" /></th>
			<td width="350" class="camposinternos">${contratante.telefone2}</td>
		</tr>
		<tr>
			<th  width="200" class="barracinza"><fmt:message key="label.telefoneCelular" /></th>
			<td width="350" class="camposinternos">${contratante.telefone3}</td>
			<th  width="200" class="barracinza"><fmt:message key="label.email" /></th>
			<td width="350" class="camposinternos">${contratante.email }</td>
		</tr>
	</table>


	<!-- 
	<table cellspacing="0" class="detalhe">
		<tr class="barraazulzinha">
			<th class="barraazulzinha">Endereço de Cobrança
				<div class="lembretes" style="*position:relative;*margin-right:30px;*margin-top:0px">
					<label>
				      	<input type="checkbox" name="usarEnderecoPadrao" id="usarEnderecoPadrao" value="1" onclick="replicarEndereco(this);"/>O mesmo 
					</label>
				</div>
			</th>
		</tr>
	</table>
	 -->
	 
	<div class="barraazulzinha">
		<div class="textoEsquerda">
			<label><fmt:message key="label.enderecoCobranca" /></label>
		</div>
		<div class="textoDireita">
			<label>
		      	<input type="checkbox" name="usarEnderecoPadrao" id="usarEnderecoPadrao" value="1" onclick="replicarEndereco(this);"/><fmt:message key="label.oMesmo" /> 
			</label>
		</div>
	</div>

	<input type="hidden" name="enderecoCobrancaCidade" id="enderecoCobrancaCidade" />
	<input type="hidden" name="enderecoCobrancaBairro" id="enderecoCobrancaBairro" />
	
	<table width="100%" cellspacing="3" class="detalhe2">
		<tr>
			<th width="200" class="barracinza"><fmt:message key="label.cep" /></th>
			<td width="350" class="camposinternos">
				<input style="width:220px;" type="text" maxlength="9" name="enderecoCobrancaCep" id="enderecoCobrancaCep" onblur="buscarEnderecoCobranca(this);" class="text required" value="${contratante.enderecoCobranca.cep }"/>
			</td>
			
			<th width="200" class="barracinza"><fmt:message key="label.pais" /></th>
			<td width="350" class="camposinternos">
				<select style="width:220px;" class="required" name="enderecoCobrancaCodigoPais" id="enderecoCobrancaPais" onchange="carregarEstados(this.value, '#enderecoCobrancaSiglaUF');">
					<option value=""><fmt:message key="label.selecione" /></option>
					<c:forEach items="${paises }" var="pais">
						<c:if test="${not empty pais.identifier and not empty pais.value}">
							<option <c:if test="${contratante.enderecoCobranca.codigoPais eq pais.identifier}">selected="selected"</c:if> value="${pais.identifier}">${pais.value}</option>
						</c:if>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>					
			<th  width="200" height="28" class="barracinza"><fmt:message key="label.estado" /></th>
			<td width="350" class="camposinternos">
				<select style="width:220px;" class="required" name="enderecoCobrancaSiglaUF" id="enderecoCobrancaSiglaUF" onchange="carregarCidades(this.value, '#enderecoCobrancaCidades'); ">
					<option value=""><fmt:message key="label.selecione" /></option>
				</select>
			</td>
	
			<th width="200" class="barracinza"><fmt:message key="label.cidade" /></th>
			<td width="350" class="camposinternos">
				<select style="width:220px;"  class="required" name="enderecoCobrancaCodigoCidade" id="enderecoCobrancaCidades" onchange="carregarBairros(this.value, '#enderecoCobrancaBairros'); cidadeHidden();">
					<option value=""><fmt:message key="label.selecione" /></option>
				</select>
			</td>
		</tr>
		<tr>					
			<th  width="200" class="barracinza"><fmt:message key="label.bairro" /></th>
			<td width="350" class="camposinternos">
				<select style="width:220px;"  class="required" name="enderecoCobrancaCodigoBairro" id="enderecoCobrancaBairros" onchange="bairroHidden();">
					<option value=""><fmt:message key="label.selecione" /></option>
				</select>
			</td>
			
			<th  width="200" class="barracinza"><fmt:message key="label.rua" /></th>
			<td width="350" class="camposinternos">
				<input style="width:220px;" type="text" name="enderecoCobrancaLogradouro" id="enderecoCobrancaLogradouro" class="required" value="${contratante.enderecoCobranca.descricaoLogradouro }" />
		    </td>
		</tr>
		<tr>					
			<th  width="200" class="barracinza"><fmt:message key="label.numero" /></th>
			<td width="350" class="camposinternos">
				<input style="width:220px;" type="text" name="enderecoCobrancaNumero" id="enderecoCobrancaNumero" class="required number" value="${contratante.enderecoCobranca.numero }" maxlength="7" />
			</td>
			
			<th  width="200" class="barracinza"><fmt:message key="label.complemento" /></th>
			<td width="350" class="camposinternos">
				<input style="width:220px;" type="text" name="enderecoCobrancaComplemento" id="enderecoCobrancaComplemento" value="${contratante.enderecoCobranca.complemento }" />
			</td>
		</tr>
		<tr>					
			<th  width="200" class="barracinza"><fmt:message key="label.telefoneComercial" /></th>
			<td width="350" class="camposinternos">
				<input style="width:220px;" type="text" maxlength="11" name="enderecoCobrancaTelefone1" id="enderecoCobrancaTelefone1" class="required number" value="${contratante.telefoneCobranca1 }" />
			</td>
			
			<th  width="200" class="barracinza"><fmt:message key="label.telefoneResidencial" /></th>
			<td width="350" class="camposinternos">
				<input style="width:220px;" type="text" maxlength="11" name="enderecoCobrancaTelefone2" id="enderecoCobrancaTelefone2" class="required number" value="${contratante.telefoneCobranca2 }" />
			</td>
		</tr>
	    <tr>					
			<th  width="200" class="barracinza"><fmt:message key="label.telefoneCelular" /></th>
			<td width="350" class="camposinternos">
				<input style="width:220px;" type="text" maxlength="11" name="enderecoCobrancaTelefone3" id="enderecoCobrancaTelefone3" class="required number" value="${contratante.telefoneCobranca3 }" />
			</td>
			
			<th  width="200" class="barracinza"><fmt:message key="label.emailCobranca" /></th>
			<td width="350" class="camposinternos">
				<input style="width:220px;" type="text" name="emailCobranca" id="emailCobranca" class="text required email" value="${contratante.emailCobranca }" maxlength="50" />
		    </td>
		</tr>
	</table>
	
	<div class="barraazulzinha">
		<div class="textoEsquerda">
			<label><fmt:message key="label.recebimentoFatura" /></label>
		</div>
	</div>
	<table width="100%" cellspacing="3" class="detalhe2">
		<tr>					
			<th  width="200" class="barracinza"><fmt:message key="label.faturaSomenteEmail" /></th>
			<td width="350" class="camposinternos">
				<input type="radio" name="radioButtons" value="Sim" id="rdbSim" onclick="setValue('sim');"> <fmt:message key="label.sim" />
				<input type="radio" name="radioButtons" value="Nao" id="rdbNao" onclick="setValue('nao');"><fmt:message key="label.nao" />
			</td>
				
			<th  width="200" class="barracinza"><fmt:message key="label.emailNfEletronica" /></th>
			<td width="350" class="camposinternos">
				<input style="width:220px;" type="text" name="emailNFeletronica" id="emailNFeletronica" class="text required email" value="${contratante.emailNFe }" maxlength="50" />
		    </td>
		</tr>
	</table>
	<div class="barraazulzinha">
		<div class="textoEsquerda">
			<label><fmt:message key="uc08.dv01.pessoasInstalacaoAssistencia" /></label>
		</div>
		<div class="textoDireita">
			<label>
		      	<c:if test="${fn:length(contratante.contatosInstalacao) < 5 }">
						<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/icon_arrow_down.png" 
							 width="16" height="16"  align="absmiddle"/>
						
						<a href="javascript:abrirGerenciarContato(0);" title="Incluir" class="linkum"><fmt:message key="label.incluirNovoContato" /></a>
				</c:if>
			</label>
		</div>
	</div>
		
		
	<span class="text4"  style="margin-left:20px;"><fmt:message key="uc08.dv01.incluirPessoasContato" /></span>
	<span class="texthelp2" style="position:absolute; margin-left:120px; ">
		<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" /><fmt:message key="uc08.dv01.incluirMin1Maximo5Pessoas" />
	</span>
	<p>
		
		<!-- aqui -->
		<div style="margin-bottom: 80px; border: 1px transparent solid">
		<span class="texthelp2"  style=" text-align:right; position:relative;">
			<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" /><fmt:message key="uc08.dv01.contatosNaoAutorizados" />
		</span>
		</div>
		
	<div style="margin-left: 90px">
		<table cellspacing="0" width="70%" id="alter">
			<c:if test="${not empty contratante.contatosInstalacao}">
				<tr>
					<th class="texttable_azul" ><fmt:message key="label.nome" /></th>
					<th class="texttable_cinza"><fmt:message key="label.foneResidencial" /></th>
					<th class="texttable_cinza"><fmt:message key="label.foneComercial" /></th>
					<th class="texttable_cinza"><fmt:message key="label.foneCelular" /></th>
					<th class="texttable_cinza"><fmt:message key="label.observacao" /></th>
					<c:if test="${fn:length(contratante.contatosInstalacao) > 1 }">
						<th  class="texttable_cinza"><fmt:message key="label.excluir" /></th>
					</c:if>
				</tr>
				
				<c:forEach items="${contratante.contatosInstalacao }" var="contatos" varStatus="status">
					<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if> id="contato_${contatos.codigo }">
						<td class="camposinternos">${contatos.nome }&nbsp;</td>
						<td class="camposinternos">${contatos.telefone1 }&nbsp;</td>
						<td class="camposinternos">${contatos.telefone2 }&nbsp;</td>
						<td class="camposinternos">${contatos.telefone3 }&nbsp;</td>
						<td class="camposinternos">${contatos.observacao }&nbsp;</td>
						<c:if test="${fn:length(contratante.contatosInstalacao) > 1 }">
							<td class="camposinternos">
								<a   href="javascript:abrirExcluirContato('${contatos.codigo }');" title="Excluir"><img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/excluir16-10.png" alt="<fmt:message key="label.excluir" />" width="16" height="16" border="0"/></a>
							</td>
						</c:if>
					</tr>
				</c:forEach>
			</c:if>
		</table>
	</div>

	<div class="botoesatualizacao">
      <input name="button2" type="submit" class="button" id="button2" value="<fmt:message key="label.salvar" />" />
      <input name="button" type="button" class="button4" id="button" value="<fmt:message key="label.limpar" />" onclick="limparCampos('#formCadastro');"/>
    </div>
</form>


<div id="dialog_excluir" class="popup_padrao" style="display: none;">
	<form action="" id="formExcluirContato">
		<input type="hidden" id="codigoContato" name="codigoContato" />
				
		<div class="popup_padrao_pergunta"><fmt:message key="mensagem.confirmarExclusaoContato" /></div>
		<div class="popup_padrao_resposta">
			<input name="" type="button" class="button close" value="<fmt:message key="label.sim" />" onclick="excluirContato();"/>
			<input type="button" class="button4 close" value="<fmt:message key="label.nao" />" onclick="$.closeOverlay();" />
		</div>
	</form>
</div>


<div id="dialog_mensagem" class="popup_padrao" style="display: none;">
	<div class="popup_padrao_pergunta"></div>
	<div class="popup_padrao_resposta">
		<input type="button" class="button" value="<fmt:message key="label.fechar" />" onclick="window.location.reload();"/>
	</div>
</div>

<div id="dialog" style="display: none;">&nbsp;</div>