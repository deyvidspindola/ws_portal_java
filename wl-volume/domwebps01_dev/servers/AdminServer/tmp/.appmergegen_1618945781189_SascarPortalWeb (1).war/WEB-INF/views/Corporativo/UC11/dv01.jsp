<jsp:directive.include file="/WEB-INF/views/includes.jsp" />

<c:catch var="helper">
	<c:import url="/AgendarOrdemServico/consultarValorVisitaImprodutiva?acao=1" context="/SascarPortalWeb" />
</c:catch>

<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$.showMessage('${mensagem}');
	</script>
</c:if>

<c:if test="${not empty helper}">
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>

<style type="text/css">
.zona { display: none; }
</style>

<script type="text/javascript">
	function carregarCidades(optionSelecionado) {

		// RECUPERA O ELEMENTO SELECIONADO NA COMBOBOX
		var elem = $(optionSelecionado);
		
		// RECUPERA O VALOR DO ID QUE ESTA SENNDO SETADO COM O ${estado.identifier} RETORNADO DO SERVICO.
		var codigoUF = elem.find('option:selected').attr('id');
		
		// RECUPERA A SIGLA DA UF SELECIONADA PARA ENVIAR AO SERVICO QUE RECUPERA AS CIDADES.
		var valueSiglaUF = elem.find('option:selected').attr('value');
		
		// SETA O VALOR DO CODIGOUF NO hidden PARA ENVIAR PARA O SERVICO LISTAREMPRESASPRESTADORAS
		$("#parametroCodigoUF").val(codigoUF);

		if (valueSiglaUF == "") {
			$("option[value!='']", "#cidades").remove();
			return;
		}

		var cidades = $('#cidades')[0];

		$.ajax({
			"url" : "/SascarPortalWeb/AgendarOrdemServico/listarCidades",
			"data" : {
				"siglaUF" : valueSiglaUF,
				"acao" : 2
			},
			"dataType" : "json",
			"beforeSend" : function() {
				$("option[value!='']", "#cidades").remove();
			},
			"success" : function(json) {
				if (json.success) {
					$.each(json.cidades, function(i, cidade) {
						
						if (cidade.value && cidade.id) {
							var option = new Option(cidade.value, cidade.id);
							if ($.browser.msie) {
								cidades.add(option);
							} else {
								cidades.add(option, null);
							}
						}
					});
					
				} else {
					alert(json.mensagem);
				}
			}
		});
	}

	function carregarZonas() {

		var zonas = $('#zonas')[0];

		$.ajax({
			"url" : "/SascarPortalWeb/AgendarOrdemServico/listarZonas",
			"data" : {
				"acao" : 4
			},
			"dataType" : "json",
			"beforeSend" : function() {
				$("option[value!='']", "#zonas").remove();
			},
			"success" : function(json) {
				if (json.success) {
					$.each(json.zonas, function(i, zona) {
						if (zona.id && zona.value) {
							var option = new Option(zona.value, zona.id);
							if ($.browser.msie) {
								zonas.add(option);
							} else {
								zonas.add(option, null);
							}
						}
					});
				} else {
					alert(json.mensagem);
				}
			}
		});
	}

	function carregarBairros(codigoZona) {
		
		var siglaUF = $("#estados").val();
		
		var codigoCidade = $("#cidades").val();

		// Carregar zonas de SP
		if (codigoCidade == 393 && !codigoZona) {
			
			carregarZonas();
			
			$(".zona").show();
			$("#zonas").removeAttr("disabled");
		} else {

			if (!codigoZona) {
				// ESTADO NÃO POSSUI DIVISÃO POR ZONAS ...
				
				$(".zona").hide();
				$("#zonas").attr("disabled", true);
			}

			if (codigoCidade == 0) {
				$("option[value!='']", "#bairros").remove();
				return;
			}

			var bairros = $('#bairros')[0];

			$.ajax({
				"url" : "/SascarPortalWeb/AgendarOrdemServico/listarBairros",
				"data" : {
					"siglaUF" : siglaUF,
					"codigoCidade" : codigoCidade,
					"codigoZona" : codigoZona,
					"acao" : 3
				},
				"dataType" : "json",
				"beforeSend" : function() {
					$("option[value!='']", "#bairros").remove();
				},
				"success" : function(json) {
					if (json.success) {
						$("#bairros").addClass("required");
						$.each(json.bairros,
								function(i, bairro) {
									if (bairro.value && bairro.id) {
										var option = new Option(bairro.value, bairro.id);
										if ($.browser.msie) {
											bairros.add(option);
										} else {
											bairros.add(option, null);
										}
									}
								});
					} else {
						$("#bairros").removeClass("required");
						$("#bairros").removeClass("error");
					}
				}
			});
		}
	}

	function abrirBuscaAgenda() {

		// Campo não obrigatório para abrir o agendamento
		$("#dataHora").removeClass("required").removeClass("error");

		if ($("#formAgendamento").valid()) {
			var siglaUF = $("#estados").val();
			
			var codigoEstado = $("#parametroCodigoUF").val();
			var codigoCidade = $("#cidades").val();
			var codigoZona = $("#zonas").val();
			var codigoBairro = $("#bairros").val();
			var localInstalacao = $("#localInstalacao").val();

			// Campo obrigatório para efetuar o processo de agendamento
			$("#dataHora").addClass("required");

			$.ajax({
				url : "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC11/dv02",
				data : {
					"numeroOS" : "${param.numeroOS }",
					"siglaUF" : siglaUF,
					"codigoEstado" : codigoEstado,
					"codigoCidade" : codigoCidade,
					"codigoBairro" : codigoBairro,
					"codigoZona" : codigoZona,
					"localInstalacao" : localInstalacao
				},
				dataType : "html",
				success : function(html) {
					$("#dialogBuscarAgenda").html(html).jOverlay({
						'closeOnEsc' : false,
						'bgClickToClose' : false
					});
				},
				'css' : {'top' : '10px'}
			});
		}
	}

	function efetuarAgendamento(form) {
		var data = $(form).serialize();

		$.ajax({
			url : "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC11/dv04",
			data : data || {},
			dataType : "html",
			success : function(html) {
				$("#dialogRetorno").html(html).jOverlay();
			}
		});
	}

	$(document).ready(function() {
		var container = $('div.container2');
		$("#formAgendamento").validate({
			errorContainer : container,
			errorLabelContainer : $("ol", container),
			wrapper : 'li',
			submitHandler : function(form) {
				efetuarAgendamento(form);
			}
		});
		$('#observacao').limit('150', '#charsLeft');
		$("#numeroTelefone").setMask('phone');
		
	});
</script>


<div class="cabecalho">
<!--	<fmt:message key="label.agendamentoServico" />
	<div class="caminho">
		
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a>&gt; 
		<a href="#" class="linktres"><fmt:message key="label.servicos" /></a> &gt; 
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC02/dv01" class="linkquatro"><fmt:message key="label.agendarAtendimento" /></a>
	
	</div>-->
</div>


<p>
	<span class="titleagendar"> 
		<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/Silver_Location.png" hspace="5" align="absmiddle" />
		<fmt:message key="mensagem.informacao.agendamentoParaPlaca">
			<fmt:param><span class="text4">${param.numeroPlacaVeiculo}</span></fmt:param>
		</fmt:message>
	</span>
</p>
	

<div class="container2">
	<ol>
		<li><label for="estados" class="error"><fmt:message key="mensagem.selecione.estado" /></label></li>
		<li><label for="cidades" class="error"><fmt:message key="mensagem.selecione.cidade" /></label></li>
		<li><label for="zonas" class="error"><fmt:message key="mensagem.selecione.zona" /></label></li>
		<li><label for="bairros" class="error"><fmt:message key="mensagem.selecione.bairro" /></label></li>
		<li><label for="localInstalacao" class="error"><fmt:message key="mensagem.selecione.localInstalacao" /></label></li>
		<li><label for="dataHora" class="error"><fmt:message key="mensagem.selecione.horaAgendamento" /></label></li>
		<li><label for="numeroTelefone" class="error"><fmt:message key="mensagem.informacao.telefoneContato" /></label></li>
		<li><label for="nomeContato" class="error"><fmt:message key="mensagem.informacao.nomeContato" /></label></li>
		<li><label for="descricaoEndereco" class="error"><fmt:message key="mensagem.informacao.enderecoCompleto" /></label></li>
		<li><label for="observacao" class="error"><fmt:message key="mensagem.informacao.observacao" /></label></li>
	</ol>
</div>


<div id="agendar">

	<p>
		<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/comment32.png" width="16" height="16" align="absmiddle" /> 
		<span class="helpvermelho">
			<fmt:message key="uc11.dv01.text.02">
				<fmt:param><fmt:formatNumber value="${valorVisita}" type="currency" /> (${valorVisitaExtenso})</fmt:param>
			</fmt:message> 
		</span>
	</p>


	<h2><fmt:message key="uc11.dv01.text.01" /></h2>
	
	<div style="height: 19px;"></div>

	<form action="" method="post" name="formAgendamento" id="formAgendamento">
		<input type="hidden" name="numeroOS" value="${param.numeroOS }" /> 
		<input type="hidden" name="codigoInstalador" value="" />
		<input type="hidden" name="parametroCodigoUF" id="parametroCodigoUF" value="" />
		
		
		<div style="height: 39px;">
			<p>
				<label><fmt:message key="label.estado" />: 
					<select name="siglaUF" id="estados" onchange="carregarCidades(this);" class="required">
						<option value=""><fmt:message key="label.selecione" /></option>
						<c:forEach var="estado" items="${estados}">
							<c:if test="${not empty estado.identifier && not empty estado.value}">
								<option id="${estado.identifier}" value="${estado.value}">${estado.value}</option>
							</c:if>
						</c:forEach>
					</select>
				 </label>
			</p>
		</div>
		
		<div style="height: 39px;">
		
			<p>
				<label><fmt:message key="label.cidade" />: 
					<select name="codigoCidade" id="cidades" onchange="carregarBairros(0);" class="required">
						<option value=""><fmt:message key="label.selecione" /></option>
					</select> 
				</label>
			</p>
			
		</div>

		<p class="zona" style="height: 39px;">
			<label><fmt:message key="label.zona" />: 
				<select name="codigoZona" id="zonas" onchange="carregarBairros(this.value);" class="required" disabled="disabled">
						<option value=""><fmt:message key="label.selecione" /></option>
				</select> 
			</label>
		</p>
		
		<div style="height: 39px;">
			<label><fmt:message key="label.bairro" />: 
				<select name="codigoBairro" id="bairros" class="required" >
						<option value=""><fmt:message key="label.selecione" /></option>
				</select> 
			</label>
		</div>
		
		<div style="height: 39px;">
			<p>
				<label><fmt:message key="label.localDoAtendimento" />:
					 <select name="localInstalacao" id="localInstalacao" class="required">
							<option value=""><fmt:message key="label.selecione" /></option>
							<option value="C"><fmt:message key="label.endecoDefinidoCliente" /></option>
							<option value="R"><fmt:message key="label.enderecoRepresentante" /></option>
					</select> 
				</label>
			</p>
		</div>
		
		<div style="height: 39px;">
			<label><fmt:message key="label.buscarDataHoraAtendimento" />: 
				<input type="button" class="button" onclick="abrirBuscaAgenda();" value="Buscar" /> 
			</label>
		</div>
		
		<div style="height: 39px;">
			<p>
				<label><fmt:message key="label.dataHoraSelecionadas" />: 
					<input type="text" name="dataHora" id="dataHora" readonly="readonly" class="required" size="25px" /> 
				</label>
			</p>
		</div>
		
		<div style="height: 39px;">
		
		<p>
			<span class="titleagendar"> <img
				src="${pageContext.request.contextPath}/sascar/images/corporativo_new/Silver_Location.png"
				hspace="5" align="absmiddle" /><fmt:message key="label.enderecoExecucaoServico" />: </span>
		</p>
		
		</div>
		<%--RETIRADO REALEASE CRISTIANE 
				<label>Descrição:
				<input name="descricao" type="text" id="descricao" size="40px"  class="text" disabled="disabled" />
				</label>--%>
		<div style="height: 39px;">
		<label><fmt:message key="label.efetuarContatoCon" />: <input name=nomeContato type="text" id="nomeContato" size="20" class="text" disabled="disabled" /> </label>
		</div>
		
		<p>
		
			<label><fmt:message key="label.enderecoCompleto" />: 
				<input type="text" id="descricaoEndereco" name="descricaoEndereco" readonly="readonly" class="text" /> 
			</label> 
			<label>
				<fmt:message key="label.telefoneContato" />: 
				<input type="text" id="numeroTelefone" name="numeroTelefone" disabled="disabled" class="text" size="20px" /> 
			</label>
		</p>
		
		<p>
			<label><fmt:message key="label.observacao" />:<br /> 
				<span class="texthelp2"><br />
					<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" />
					<fmt:message key="mensagem.informacao.pontoReferenciaServico" /> 
				</span> 
				
				<textarea id="observacao" name="observacao" disabled="disabled" id="observacao" class="text" cols="45" rows="5"></textarea><br /> 
			</label>
		</p>


		<div id="botoesinferiores">
			<input name="button" type="submit" class="button" id="button" value="<fmt:message key="label.agendar" />" onclick="$('#dataHora, #descricaoEndereco, #nomeContato, #numeroTelefone, #observacao').addClass('required');" />
			<input name="button2" type="button" class="button4" id="button2" value="<fmt:message key="label.limpar" />" onclick="limparCampos('#formAgendamento');" />
		</div>
	</form>
</div>


<form id="form1" name="form1" method="post" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC02/dv02">
	
	<div id="botoesinferiores">
		<input type="submit" class="button3" style="*margin-bottom: 20px;" value="<fmt:message key="label.voltar" />" />
	</div>
	
	<input type="hidden" name="numeroOS" value="${ordemServico.numero}" />
	<input type="hidden" name="numeroPlaca" value="${param.numeroPlaca }" />
	<input type="hidden" name="dataInicial" value="${param.dataInicial }" />
	<input type="hidden" name="dataFinal" value="${param.dataFinal }" /> 
	<input type="hidden" name="numeroChassi" value="${param.numeroChassi }" />
	<input type="hidden" name="codigoMarca" value="${param.codigoMarca }" />
	<input type="hidden" name="codigoModelo" value="${param.codigoModelo }" />
</form>


<div id="dialogBuscarAgenda" style="display: none; margin-top: 280px;"></div>

<div id="dialogRetorno" style="display: none;"></div>

