<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper">
	<c:import url="/AgendarOrdemServico/consultarDetalheOSRepresentante?acao=13" context="/SascarPortalWeb" />
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

	function carregarComboAcoes(){
		
		var listaAcoes = $('#acao')[0];
		
		$.ajax({
			"url" : "/SascarPortalWeb/AgendarOrdemServico/consultarAcoes",
			"data" : {
				"acao" : 20
			},
			"dataType" : "json",
			"beforeSend" : function() {
				$("option[value!='']", "#acao").remove();
			},
			"success" : function(json) {
				if (json.success) {
					$.each(json.listaAcoes, function(i, acao) {
						if (acao.id && acao.value) {
							var option = new Option(acao.value, acao.id);
							if ($.browser.msie) {
								listaAcoes.add(option);
							} else {
								listaAcoes.add(option, null);
							}
						}
					});
				} else {
					$.showMessage(json.mensagem);
				}
			}
		});
			
	}

	function incluirNovoHistorico(){
		
		var codAcao = $("#acao").val();
		var observacao = $("#observacao").val();
		var ordemServicoAgendamento = $("#numeroOrdemServico").val();
		
		$.ajax({
			"url" : "/SascarPortalWeb/AgendarOrdemServico/submeterNovoHistoricoAgendamento",
			"data" : {
				"acao" : 19,
				"codAcao" : codAcao, 
				"observacao" : observacao,
				"numeroOrdemServico" : ordemServicoAgendamento
			},
			dataType:"json",
			success: function(json){
				if (json.success) {
					
					$("#formInclusaoHistorico").attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC43/dv06&numeroOrdemServico=${param.numeroOrdemServico}&codCliente=${param.codCliente}");
					$("#formInclusaoHistorico").unbind('submit').submit();
					
				} else {
					
					$("#formInclusaoHistorico").attr("action", "");
					$.showMessage(json.mensagem);
				}
			}
		});
		
	}	
		
	function imprimirOrdemServico(urlOrdemServicoImpressao){
			
		if(urlOrdemServicoImpressao != ''){
			
			/* ABRE TELA DE IMPRESSAO */
			window.open(urlOrdemServicoImpressao, '_blank'); 
		
		}else{
			
			/* ABRE CAIXA DE DIALOGO INFORMANDO QUE A URL PARA IMPRESSAO ESTA VAZIA */
			var onclick = "javascript:$.closeOverlay();";
			var html = '<input type="button" class="button" value="OK" onclick="'+onclick+'" />';
			$("#dialog_confirm .popup_maior_resposta").html(html);
			$("#dialog_confirm").jOverlay(); 
		
		}
		
	}
	
	function imprimirComprovante(urlComprovanteImpressao){
		
		if(urlComprovanteImpressao != ''){
			
			/* ABRE TELA DE IMPRESSAO */
			window.open(urlComprovanteImpressao, '_blank'); 
		
		}else{
			
			/* ABRE CAIXA DE DIALOGO INFORMANDO QUE A URL PARA IMPRESSAO ESTA VAZIA */
			var onclick = "javascript:$.closeOverlay();";
			var html = '<input type="button" class="button" value="OK" onclick="'+onclick+'" />';
			$("#dialog_confirm_comprovante .popup_maior_resposta").html(html);
			$("#dialog_confirm_comprovante").jOverlay(); 
		
		}
		
	}
	
	$(document).ready(function(){
		
		carregarComboAcoes();
		
	});
		
</script>

<form id="novaBusca" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC43/dv01" method="post">

</form>

<form id="formVoltar" 
	  method="post"
	  action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC43/dv01" >
	
</form>

<form id="formInclusaoHistorico" method="post" action="">

	<input type="hidden" id="numeroOrdemServico" name="numeroOrdemServico" value="${param.numeroOrdemServico}" /> 
	<input type="hidden" id="codCliente" name="codCliente" value="${param.codCliente}" /> 
	<input type="hidden" id="placaAgendamento" 	 name="placaAgendamento"   value="${param.placaAgendamento}" />

	<div class="cabecalho2">

		<strong><fmt:message key="label.agendarAtendimento" /></strong>
	</div>
	
	
	<h1><fmt:message key="label.detalhamentoOrdemServico" /></h1>
	
	
	<!-- INICIO BLOCO - INFORMACOES SOBRE O SERVICO -->
	<table cellspacing="0" class="detalhe" >
		<tr class="barraazulzinha">
			<th class="barraazulzinha"><fmt:message key="label.informacoesSobreServico" /></th>
		</tr>
	</table>


	<table width="100%" cellspacing="3" class="detalhe2">
		<tr>
			
			<!-- COLUNA ESQUERDA -->
			<th width="200" class="barraroxa"><fmt:message key="label.numDaOrdemServico" /></th>
			<td width="350" class="camposinternos5">${ordemServicoDetalhe.numero}</td>
			
			<!-- COLUNA DIREITA -->
			<th width="200"  rowspan="2" class="barradata">
				<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/1304960183_Calendar.png" 
					 width="32" height="32" hspace="2" align="absmiddle" />
				<fmt:message key="label.dataDoAgendamento" />
			</th>
			<td width="350" rowspan="2" class="camposinternos3">
				
				<c:choose>
					<c:when test="${renderizaDataAgendamento}">
						
						<fmt:formatDate value="${ordemServicoDetalhe.agendamento.dataAgendamento}" pattern="dd/MM/yyyy HH:mm" />
						
						<c:if test="${renderizaBotaoAgendamento}">
							<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC43/dv03&placaAgendamento=${ordemServicoDetalhe.contrato.veiculo.placa}&ordemServicoAgendamento=${ordemServicoDetalhe.numero}" class="linkum">
								<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/botoes-38.png" hspace="5" align="absmiddle" border="0"/>
							</a>
						</c:if>
					
					</c:when>
					<c:otherwise>
							
						<fmt:message key="label.naoInformado" />
					
						<c:if test="${renderizaBotaoAgendamento}">
							<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC43/dv03&placaAgendamento=${ordemServicoDetalhe.contrato.veiculo.placa}&ordemServicoAgendamento=${ordemServicoDetalhe.numero}" class="linkum">
								<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/botoes-38.png" hspace="5" align="absmiddle" border="0"/>
							</a>
						</c:if>
						
					</c:otherwise>
				</c:choose>
					
			</td>
			
		</tr>
		<tr>	
		 	<th width="200" class="barracinza"><fmt:message key="label.dataOrdemServico" /></th>
			<td width="350" class="camposinternos">
				<fmt:formatDate value="${ordemServicoDetalhe.dataCadastro}" pattern="dd/MM/yyyy" />
			</td>
		</tr>
		<tr>	
		 	<th width="200" class="barracinza"><fmt:message key="label.dataDeConclusao" /></th>
			<td width="350" class="camposinternos">
				<fmt:formatDate value="${ordemServicoDetalhe.dataConclusao}" pattern="dd/MM/yyyy"/>
			</td>
		</tr>
		<tr>	
		 	<th width="200" class="barracinza"><fmt:message key="label.Status" /></th>
			<td width="350" class="camposinternos">${ordemServicoDetalhe.status}</td>
		</tr>
		<tr>	
		 	<th width="200" class="barracinza"><fmt:message key="label.modalidade" /></th>
			<td width="350" class="camposinternos">${ordemServicoDetalhe.modalidade}</td>
		</tr>
		<tr>
			<th width="200" class="barracinza"><fmt:message key="label.prioridade" /></th>
			<td width="350" class="camposinternos">${ordemServicoDetalhe.prioridade}</td>
		</tr>
	</table>

	<table width="100%" cellspacing="3" class="detalhe2">
		<tr>
			<td colspan="2" class="titleagendar">
				<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/Silver_Location.png" hspace="5" align="absmiddle"/><fmt:message key="label.enderecoExecucaoServico" />
			</td>
			<td colspan="2" class="titleagendar">
				<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/Silver_Location.png" hspace="5" align="absmiddle"/><fmt:message key="label.contatoRespAcompanhamentoTec" />
			</td>
		</tr>
		
		<tr>
			
			<!-- COLUNA ESQUERDA -->
			<th width="200"class="barracinza"><fmt:message key="label.rua" /></th>
			<td width="350" class="camposinternos">${ordemServicoDetalhe.contrato.contratante.enderecoCobranca.descricaoLogradouro}</td>
			
			
			<!-- COLUNA DIREITA -->
			<th width="200" class="barracinza"><fmt:message key="label.nomeDoContato" /></th>
			<td width="350" class="camposinternos">${ordemServicoDetalhe.contrato.contratante.enderecoCobranca.contato}</td>
		</tr>
		
		<tr>
			
			<!-- COLUNA ESQUERDA -->
			<th width="200" class="barracinza"><fmt:message key="label.numeroComplemento" /></th>
			<td width="350" class="camposinternos">${ordemServicoDetalhe.contrato.contratante.enderecoCobranca.complemento}</td>	
			
			<!-- COLUNA DIREITA -->
			<th width="200" class="barracinza"><fmt:message key="label.telefoneCelular" /></th>
			<td width="350" class="camposinternos">${ordemServicoDetalhe.contato.foneCelular}</td>
			
		</tr>
		
		<tr>		
			
			<!-- COLUNA ESQUERDA -->
			<th width="200" class="barracinza"><fmt:message key="label.bairro" /></th>
			<td width="350" class="camposinternos">${ordemServicoDetalhe.contrato.contratante.enderecoCobranca.descricaoBairro}</td>
			
			<!-- COLUNA DIREITA -->
			<th width="200" class="barracinza"><fmt:message key="label.telefoneComercial" /></th>
			<td width="350" class="camposinternos">${ordemServicoDetalhe.contato.foneComercial}</td>
			
		</tr>
		<tr>	
		
			<!-- COLUNA ESQUERDA -->	
			<th width="200" class="barracinza"><fmt:message key="label.cidadeEstado" /></th>
			<td width="350" class="camposinternos">${ordemServicoDetalhe.contrato.contratante.enderecoCobranca.descricaoUf}</td>
			
			<!-- COLUNA DIREITA -->
			<th></th>
			<td></td>
			
		</tr>
		<tr>
		
			<!-- COLUNA ESQUERDA -->
			<th width="200" class="barracinza"><fmt:message key="label.pontoReferencia" /></th>
			<td width="350" class="camposinternos">${ordemServicoDetalhe.contrato.contratante.enderecoCobranca.pontoReferencia}</td>
			
			<!-- COLUNA DIREITA -->
			<th></th>
			<td></td>
			
		</tr>
	</table>
	<!-- FIM BLOCO - INFORMACOES SOBRE O SERVICO -->


	<!-- INICIO BLOCO - INFORMACOES DO CLIENTE -->
	<table cellspacing="0" class="detalhe" >
		<tr class="barraazulzinha">
			<th class="barraazulzinha"><fmt:message key="label.informacoesCliente" /></th>
		</tr>
	</table>


	<table width="100%" cellspacing="3" class="detalhe2">
		<tr>
			<th width="200" class="barraroxa"><fmt:message key="label.NomeCliente" /></th>
			<td width="300" class="camposinternos5" colspan="3">${ordemServicoDetalhe.contrato.contratante.nome}</td>
			<td width="100px" rowspan="6">
				<c:if test="${true == ordemServicoDetalhe.contrato.contratante.clienteEspecial}">
					<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/especial.png" width="60" height="60" hspace="10" vspace="20" border="0" />
				</c:if>
			</td>
		</tr>
		<tr>
			<th width="200" class="barracinza"><fmt:message key="label.telefoneCelular" /></th>
			<td width="300" class="camposinternos">${ordemServicoDetalhe.contrato.contratante.telefone3}</td>
			
			<th width="200" class="barracinza"><fmt:message key="label.rua" /></th>
			<td width="300"class="camposinternos">${ordemServicoDetalhe.contrato.contratante.endereco.descricaoLogradouro}</td>
		</tr>
		<tr>					
			<th width="200" class="barracinza"><fmt:message key="label.telefoneComercial" /></th>
			<td width="300" class="camposinternos">${ordemServicoDetalhe.contrato.contratante.telefone2}</td>
			
			<th width="200" class="barracinza"><fmt:message key="label.numeroComplemento" /></th>
			<td width="300" class="camposinternos">${ordemServicoDetalhe.contrato.contratante.endereco.complemento}</td>
		</tr>
		<tr>	
			<th width="200" class="barracinza"><fmt:message key="label.tipoContrato" /></th>
			<td width="300" class="camposinternos">${ordemServicoDetalhe.contrato.tipoContrato}</td>			
			
			<th width="200" class="barracinza"><fmt:message key="label.bairro" /></th>
			<td width="300" class="camposinternos">${ordemServicoDetalhe.contrato.contratante.endereco.descricaoBairro}</td>
		</tr>
		<tr>					
			<th width="200" class="barracinza"><fmt:message key="label.servicoContratado" /></th>
			<td width="300" class="camposinternos">${ordemServicoDetalhe.contrato.servicoContratado}</td>	
					
			<th width="200" class="barracinza"><fmt:message key="label.cidadeEstado" /></th>
			<td width="300" class="camposinternos">${ordemServicoDetalhe.contrato.contratante.endereco.descricaoUf}</td>
		</tr>
		<tr>					
			<th width="200" class="barracinza"><fmt:message key="label.numeroDoContrato" /></th>
			<td width="300" class="camposinternos">${ordemServicoDetalhe.contrato.numeroContrato}</td>			
			
			<th width="200" class="barracinza"><fmt:message key="label.cep" /></th>
			<td width="300" class="camposinternos">${ordemServicoDetalhe.contrato.contratante.endereco.cep}</td>
		</tr>
	</table>
	<!-- FIM BLOCO - INFORMACOES DO CLIENTE -->


	<!-- INICIO BLOCO - INFORMACOES DO VEICULO -->
	<table cellspacing="0" class="detalhe" >
		<tr class="barraazulzinha">
			<th class="barraazulzinha">
				<fmt:message key="label.informacoesDoVeiculo" />
			</th>
		</tr>
	</table>


	<table width="100%" cellspacing="3" class="detalhe2">
		<tr>
			<th width="200" class="barracinza"><fmt:message key="label.placa" /></th>
			<td width="350" class="camposinternos">${ordemServicoDetalhe.contrato.veiculo.placa}</td>
			
			<th width="200" class="barracinza"><fmt:message key="label.chassi" /></th>
			<td width="350" class="camposinternos">${ordemServicoDetalhe.contrato.veiculo.chassi}</td>
		</tr>
		<tr>
			<th width="200" class="barracinza"><fmt:message key="label.marcaModelo" /></th>
			<td width="350" class="camposinternos">${ordemServicoDetalhe.contrato.veiculo.descricaoModelo}</td>
			
			<th width="200" class="barracinza"><fmt:message key="label.renavam" /></th>
			<td width="350" class="camposinternos">${ordemServicoDetalhe.contrato.veiculo.renavan}</td>
		</tr>
		<tr>					
			<th width="200" class="barracinza"><fmt:message key="label.cor" /></th>
			<td width="350" class="camposinternos">${ordemServicoDetalhe.contrato.veiculo.cor}</td>
		</tr>
		<tr>
			<th width="200" class="barracinza"><fmt:message key="label.ano" /></th>
			<td class="camposinternos">${ordemServicoDetalhe.contrato.veiculo.anoFabricacao}</td>
		</tr>
		<tr>
							
		<th class="barracinza"><fmt:message key="label.particularidades" /></th>
		<td class="camposinternos">${ordemServicoDetalhe.particularidades}</td>
		
		<td></td>
		<td></td>
		</tr>
	</table>
	<!-- FIM BLOCO - INFORMACOES DO VEICULO -->
	
	<!-- INICIO BLOCO - PESSOAS PARA INSTALACAO / ASSISTENCIA -->
	<table class="detalhe" cellspacing="0">
		<tbody>
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.listaPessoasInstalacaoAssis" /></th>
			</tr>
		</tbody>
	</table>
	
	
	<table id="alter" cellspacing="0" width="70%">
		<tbody>
			<tr>
				<th class="texttable_azul" width="26%"><fmt:message key="label.nomeContato" /></th>
				<th class="texttable_cinza" width="11%"><fmt:message key="label.telefoneResidencial" /></th>
				<th class="texttable_cinza" width="11%"><fmt:message key="label.telefoneComercial" /></th>
				<th class="texttable_cinza" width="11%"><fmt:message key="label.telefoneCelular" /></th>
				<th class="texttable_cinza" width="41%"><fmt:message key="label.observacaoDoContato" /></th>
			</tr>
			
			<c:choose>
				<c:when test="${not empty listaPessoasInstalacao}">
					<c:forEach var="pessoa" items="${listaPessoasInstalacao}" varStatus="statusPessoa">
						<tr <c:if test="${statusPessoa.count % 2 != 0 }">class="dif"</c:if> >
							<td class="linkazulescuro">${pessoa.nome}</td>
							<td class="camposinternos">${pessoa.telefone2}</td>
							<td class="camposinternos">${pessoa.telefone1}</td>
							<td class="camposinternos">${pessoa.telefone3}</td>
							<td>${pessoa.observacao}</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="6"><fmt:message key="mensagem.informacao.nenhumaPessoaCadastrada" /></td>
					</tr>
				</c:otherwise>
			</c:choose>
			
		</tbody>
	</table>
	<!-- FIM BLOCO - PESSOAS PARA INSTALACAO / ASSISTENCIA -->
	
	<!-- INICIO BLOCO - SERVICOS A SEREM EXECUTADOS -->	
	<table class="detalhe" cellspacing="0">
		<tbody>
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.servicosSeremExecutados" /></th>
			</tr>
		</tbody>
	</table>
	
	
	<table id="alter" cellspacing="0" width="70%">
		<tbody>
			<tr>
				<th class="texttable_azul" width="30%"><fmt:message key="label.item" /></th>
				<th class="texttable_cinza"><fmt:message key="label.tipo" /></th>
				<th class="texttable_cinza" width="30%"><fmt:message key="label.Motivo" /></th>
				<th class="texttable_cinza" width="30%"><fmt:message key="label.defeitoAlegado" /></th>
				<th class="texttable_cinza" width="30%"><fmt:message key="label.Status" /></th>
				<th class="texttable_cinza" width="30%"><fmt:message key="label.observacao" /></th>
			</tr>
			
			<c:choose>
				<c:when test="${not empty listaServicosParaExecucao}">
					<c:forEach var="servico" items="${listaServicosParaExecucao}" varStatus="statusServicos">
						<tr <c:if test="${statusServicos.count % 2 != 0 }">class="dif"</c:if> >
							<td class="linkazulescuro">${servico.descricao}</td>
							<td class="camposinternos">${servico.tipo}</td>
							<td class="camposinternos">${servico.motivo}</td>
							<td class="camposinternos">${servico.defeitoAlegado}</td>
							<td class="camposinternos">${servico.status}</td>
							<td class="camposinternos">${servico.observacao}</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="6"><fmt:message key="mensagem.informacao.nenhummServicoCadastrado" /></td>
					</tr>
				</c:otherwise>
			</c:choose>
			
		</tbody>
	</table>
	<!-- FIM BLOCO - SERVICOS A SEREM EXECUTADOS -->	
	
	<!-- INICIO BLOCO - HISTORICO DA ORDEM DE SERVICO -->	
	<table class="detalhe" cellspacing="0">
		<tbody>
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.historicoOS" /></th>
			</tr>
		</tbody>
	</table>
	
	<div class="historicoOrdemServico">
	
		<div class="bloco">
		
			<div class="celula">
				<div class="colunaLabel" style="background-color: #FAFAFA !important; width: 75px !important;">
					<label><fmt:message key="label.acao" />:</label>
				</div>
				
				<div class="colunaInput" > 
					<select id="acao" name="codAcao" class="colunaInputCombo">
						<option value=""><fmt:message key="label.selecione" /></option>
					</select>
				</div>
			</div>
			
			<div class="celula">
				<div class="colunaLabel" style="background-color: #FAFAFA !important; width: 75px !important;">
					<label><fmt:message key="label.observacao" />:</label>
				</div>
				
				<div class="colunaInput" > 
					<textarea id="observacao" 
							  name="observacao"
							  class="text"
							  style="margin-left: 11px !important; resize: none;" 
							  rows="5">
					</textarea>
				</div>
			</div>
			
			<div style="clear: both"></div>
		
		</div>
		
		<!-- DIV BOTOES -->
		<div class="posicaoBotoes" style="width: 348px !important;">
		     <div class="botoes">
			    <p>
			        <input type="button" class="button" value="<fmt:message key="label.incluirHistorico" />" onclick="incluirNovoHistorico();" />
			    </p>
		    </div>
		    
	    	<div style="clear: both;" ></div>
	    </div>

	</div>
	
	<div style="clear:both;"></div>
	<br />
	
	<table id="alter" cellspacing="0" width="70%">
		<tbody>
			<tr>
				<th class="texttable_azul" width="13%"><fmt:message key="label.Status" /></th>
				<th class="texttable_cinza" width="17%"><fmt:message key="label.dataAgenda" /></th>
				<th class="texttable_cinza" width="28%"><fmt:message key="label.observacao" /></th>
				<th class="texttable_cinza" width="14%"><fmt:message key="label.data" /></th>
				<th class="texttable_cinza" width="28%"><fmt:message key="label.usuario" /></th>
			</tr>
			
			<c:choose>
				<c:when test="${not empty listaHistoricoOrdemServico}">
					<c:forEach var="ordemServico" items="${listaHistoricoOrdemServico}" varStatus="statusHistoricoOrdemServico">
						<tr <c:if test="${statusHistoricoOrdemServico.count % 2 != 0 }">class="dif"</c:if> >
							<td class="linkazulescuro">${ordemServico.statusOrdemServico}</td>
							<td class="camposinternos">
								<fmt:formatDate value="${ordemServico.dataAgendamento}" pattern="dd/MM/yyyy HH:mm"/>
							</td>
							<td class="camposinternos">${ordemServico.observacao}</td>
							<td class="camposinternos">
								<fmt:formatDate value="${ordemServico.dataCadastroHistorico}" pattern="dd/MM/yyyy HH:mm"/>
							</td>
							<td class="camposinternos">${ordemServico.usuario.nome}</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="6"><fmt:message key="mensagem.informacao.nenhummHistoricoCadastrado" /></td>
					</tr>
				</c:otherwise>
			</c:choose>
			
		</tbody>
	</table>
	<!-- FIM BLOCO - HISTORICO DA ORDEM DE SERVICO -->

</form>

<div class="clear"></div>
	

<c:if test="${not empty param.UC52}">	
	  <input  class="button3" type="submit" onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC52/dv02&dataInicial=${param.dataInicial}&codigoInstalador=${param.codigoInstalador}&nome_instalador=${param.nome_instalador}'" tabindex="10" value="<fmt:message key="label.voltar" />" style="margin: 10px 0px; margin-left:17px;">
</c:if>	
<c:if test="${empty param.UC52}">	
	<input class="button3" 
		   type="submit" 
		   onclick="$('#formVoltar').submit();" 
		   value="<fmt:message key="label.voltar" />" />
</c:if>	
<div class="pgstabela">	  
<c:if test="${empty param.UC52}">	 
	<input class="button" 
		   type="button" 
		   value="<fmt:message key="btn.novaBusca" />" 
		   onclick="$('#novaBusca').submit();"/>
</c:if>		   
	<input class="button" 
		   type="button" 
		   value="<fmt:message key="btn.imprimirOS" />" 
		   onclick="imprimirOrdemServico('${ordemServicoDetalhe.urlImpressaoOrdemServico}');" />
		   
	<c:if test="${ordemServicoDetalhe.indicativoComprovante eq 'S'}">	   
		<input class="button" 
			   type="button" 
			   value="<fmt:message key="btn.imprimirComprovante" />" 
			   onclick="imprimirComprovante('${ordemServicoDetalhe.urlComprovanteImpressao}');" />
	</c:if>
	
</div>

<div id="dialog_confirm" class="popup_maior" style="display: none;" >
	<div class="popup_maior_pergunta"><fmt:message key="mensagem.informacao.naoPossivelRealizarImpressaoOS" /></div>
	<div class="popup_maior_resposta">
		
	</div>
</div>	

<div id="dialog_confirm_comprovante" class="popup_maior" style="display: none;" >
	<div class="popup_maior_pergunta"><fmt:message key="mensagem.informacao.naoPossivelRealizarImpressaoOS" /></div>
	<div class="popup_maior_resposta">
		
	</div>
</div>	
