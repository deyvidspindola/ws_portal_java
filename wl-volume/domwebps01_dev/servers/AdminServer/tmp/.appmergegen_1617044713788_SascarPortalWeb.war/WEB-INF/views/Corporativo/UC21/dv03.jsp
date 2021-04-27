<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/ConsultarSolicitacaoInstalacaoServlet/consultarDetalhesSolicitacaoServico?acao=2" context="/SascarPortalWeb"  />
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

	function abrirConfirmarAlteracaoStatus(numeroSolicitacao, statusSolicitacao){
	
		$("#dialog_alterStatus").jOverlay({'onSuccess' : function(){
			$("#numeroSolicitacao").val(numeroSolicitacao);
			$("#statusSolicitacao").val(statusSolicitacao);
			
			if(statusSolicitacao == "A"){
				$("#dialog_alterStatus .popup_padrao_pergunta").html('<fmt:message key="mensagem.confirmacao.autorizacaoSolicitacao" />');
			}else{
				$("#dialog_alterStatus .popup_padrao_pergunta").html('<fmt:message key="mensagem.confirmacao.recusaSolicitacao" />');
			} 
			
		}});
	}	
	
	function alterarStatusSolicitacao() {
				
		var numeroSolicitacao = $("#numeroSolicitacao").val();
		var statusSolicitacao = $("#statusSolicitacao").val();
		$.ajax({
			url: "/SascarPortalWeb/ConsultarSolicitacaoInstalacaoServlet/submeterStatusSolicitacao?acao=4",
			data: {"numeroSolicitacao" : numeroSolicitacao, "statusSolicitacao" : statusSolicitacao},
			dataType:"json",
			success: function(json){
				$("#dialog_mensagem .popup_padrao_pergunta").html(json.mensagem);
				$("#dialog_mensagem").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
			}
		});
	}		
</script>



		<div class="cabecalho3"><fmt:message key="label.solicitacaoInstalacaoEquipamento" />
			<div class="caminho3">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/SegCorretora" class="linktres"><fmt:message key="label.home" /></a> > 
				<a href="#" class="linktres"><fmt:message key="label.servicos" /></a> 
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC21/dv01" class="linkquatro"><fmt:message key="label.solicitacaoInstalacaoEquipamento" /></a>
			</div>
		</div>


	<form action="" method="post" class="filtro" id="formCadastro">
			<table width="900" cellspacing="3" class="detalhe2">
				<tr>
					<th width="200px" class="barracinza"><fmt:message key="label.codigoDaSolicitacao" /></th>
					<td width="350px" class="camposinternos">${param.numeroSolicitacao}</td>
					<th width="200px" class="barracinza"><fmt:message key="label.usuario" /></th>
					<td  width="350px" class="camposinternos">${solicitacao.nomeCadastrante }</td>
				</tr>
				<tr>
					<th width="200px" class="barracinza"><fmt:message key="label.naturezaDaSolicitacao" /></th>
					<td width="350px" class="camposinternos">${solicitacao.naturezaSolicitacao}</td>
					<th width="200px" class="barracinza"><fmt:message key="label.nlote" /></th>
					<td  width="350px" class="camposinternos">${solicitacao.numLote}</td>
				</tr>
			</table>
			
			<table cellspacing="0" class="detalhe" >
				<tr class="barraazulzinha">
					<th class="barraazulzinha"><fmt:message key="label.dadosDoSolicitanteCorretor" /></th>
				</tr>
			</table>
			
			<table width="900" cellspacing="3" class="detalhe2">
				<tr>
					<th width="200px" class="barracinza"><fmt:message key="label.nome" /></th>
					<td width="350px" class="camposinternos">${solicitacao.solicitante.nome}</td>
					<th width="200px" class="barracinza"><fmt:message key="label.email" /></th>
					<td width="350px" class="camposinternos">${solicitacao.solicitante.email }</td>
				</tr>
				<tr>
					<th width="200px" class="barracinza"><fmt:message key="label.telefone" /></th>
					<td  width="350px" class="camposinternos">${solicitacao.solicitante.telefone1}</td>
				</tr>
			</table>
				
			<div class="hr"></div>
			
			<table cellspacing="0" class="detalhe" >
					<tr class="barraazulzinha">
						<th class="barraazulzinha"><fmt:message key="label.dadosDoSegurado" /></th>
					</tr>
				</table>
				
			<table width="900" cellspacing="3" class="detalhe2">
				<tr>
					<th width="200px" class="barracinza"><fmt:message key="label.nome" /></th>
					<td width="350px" class="camposinternos">${solicitacao.segurado.nome}</td>
					<th width="200px" class="barracinza"><fmt:message key="label.contatoResponsavel" /></th>
					<td width="350px" class="camposinternos">${solicitacao.segurado.endereco.contato }</td>
				</tr>
				<tr>
					
					<th width="200px" class="barracinza"><fmt:message key="label.tipo" /></th>
					<td width="350px" class="camposinternos">
						<c:choose>
							<c:when test="${fn:toUpperCase(solicitacao.segurado.tipoPessoa) eq 'F'}">Fisica</c:when>
							<c:when test="${fn:toUpperCase(solicitacao.segurado.tipoPessoa) eq 'J'}">Juridica</c:when>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th width="200px" class="barracinza"><fmt:message key="label.rua" /></th>
					<td width="350px" class="camposinternos">${solicitacao.segurado.endereco.descricaoLogradouro }</td>
					
					<th width="200px" class="barracinza"><fmt:message key="label.numero" /></th>
					<td width="350px" class="camposinternos">${solicitacao.segurado.endereco.numero }</td>
				</tr>
				<tr>
					<th width="200px" class="barracinza"><fmt:message key="label.complemento" /></th>
					<td width="350px" class="camposinternos">${solicitacao.segurado.endereco.complemento }</td>
					
					<th width="200px" class="barracinza"><fmt:message key="label.bairro" /></th>
					<td width="350px" class="camposinternos">${solicitacao.segurado.endereco.descricaoBairro }</td>
				</tr>
				
				<tr>
					<th width="200px" class="barracinza"><fmt:message key="label.estado" /></th>
					<td width="350px" class="camposinternos">${solicitacao.segurado.endereco.descricaoUf }</td>
					
					<th width="200px" class="barracinza"><fmt:message key="label.cidade" /></th>
					<td width="350px" class="camposinternos">${solicitacao.segurado.endereco.descricaoCidade }</td>
				</tr>
				<tr>
					<th width="200px" class="barracinza"><fmt:message key="label.cep" /></th>
					<td width="350px" class="camposinternos">${solicitacao.segurado.endereco.cep }</td>
				
					<th width="200px" class="barracinza"><fmt:message key="label.telefoneComercial" /></th>
					<td width="350px" class="camposinternos">${solicitacao.segurado.telefone1 }</td>
				</tr>
				<tr>
					<th width="200px" class="barracinza"><fmt:message key="label.telefoneResidencial" /></th>
					<td width="350px" class="camposinternos">${solicitacao.segurado.telefone2 }</td>
					
					<th width="200px" class="barracinza"><fmt:message key="label.telefoneCelular" /></th>
					<td width="350px" class="camposinternos">${solicitacao.segurado.telefone3 }</td>
				</tr>
			</table>
				
			<table  cellspacing="0" class="detalhe" >
				<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.dadosDaApolice" /></th>
				</tr>
			</table>
			
			
			<table width="900" cellspacing="3" class="detalhe2">
				<tr>
					<th width="200" class="barracinza"><fmt:message key="label.nProposta" /></th>
					<td width="350" class="camposinternos">${solicitacao.apolice.numeroProposta}</td>
					<th width="200" class="barracinza"><fmt:message key="label.nApolice" /></th>
					<td width="350" class="camposinternos">${solicitacao.apolice.numeroApolice}</td>
				</tr>
				<tr>
					<th width="200" class="barracinza"><fmt:message key="label.nItem" /></th>
					<td width="350" class="camposinternos">${solicitacao.apolice.numeroItem}</td>
					<th width="200" class="barracinza"><fmt:message key="label.nSucursal" /></th>
					<td width="350" class="camposinternos">${solicitacao.apolice.numeroSucursal}</td>
				</tr>
				<tr>
					<th width="200" class="barracinza"><fmt:message key="label.codigoCIA" /></th>
					<td width="350" class="camposinternos">${solicitacao.apolice.codigoCia}</td>
				</tr>
				<tr>
					<th width="200" class="barracinza"><fmt:message key="label.inicioDeVigencia" /></th>
					<td class="camposinternos"><fmt:formatDate var="iniVigencia" value="${solicitacao.apolice.dataInicialVigencia }" pattern="dd/MM/yyyy"/>${iniVigencia}</td>
					<th width="200" class="barracinza"><fmt:message key="label.terminoDeVigencia" /></th>
					<td width="350"class="camposinternos"><fmt:formatDate var="finalVigencia" value="${solicitacao.apolice.dataFinalVigencia }" pattern="dd/MM/yyyy"/>${finalVigencia} </td>
				</tr>
			</table>
				
			<table cellspacing="0" class="detalhe" >
				<tr class="barraazulzinha">
					<th class="barraazulzinha"><fmt:message key="label.dadosDeInstalacao" /></th>
				</tr>
			</table>
			
			<table width="900" cellspacing="3" class="detalhe2">
				<tr>
					<th width="200px" class="barracinza"><fmt:message key="label.localDeInstalacao" /></th>
					<td width="350px" class="camposinternos">
						<c:if test="${solicitacao.localInstalacaoEquipamento eq '1'}"><fmt:message key="label.localInstalacao.concessionaria" /></c:if>
						<c:if test="${solicitacao.localInstalacaoEquipamento eq '2'}"><fmt:message key="label.localInstalacao.empresaDoCliente" /></c:if>
						<c:if test="${solicitacao.localInstalacaoEquipamento eq '3'}"><fmt:message key="label.localInstalacao.residenciaDoCliente" /></c:if>
						<c:if test="${solicitacao.localInstalacaoEquipamento eq '4'}"><fmt:message key="label.localInstalacao.outros" /></c:if>
					</td>
					<th width="200px" class="barracinza"><fmt:message key="label.dataDeInstalacao" /></th>
					<td width="350"class="camposinternos"><fmt:formatDate var="dataInstalacao" value="${solicitacao.dataInstalacao}" pattern="dd/MM/yyyy"/>${dataInstalacao}</td>
				</tr>
				<tr>
					<th width="200px" class="barracinza"><fmt:message key="label.nome" /></th>
					<td  width="350px" class="camposinternos">${solicitacao.localInstalacao.contato }</td>
				</tr>
				<tr>
					<th width="200px" class="barracinza"><fmt:message key="label.rua" /></th>
					<td width="350px" class="camposinternos">${solicitacao.localInstalacao.descricaoLogradouro }</td>
					<th width="200px" class="barracinza"><fmt:message key="label.numero" /></th>
					<td width="350px" class="camposinternos">${solicitacao.localInstalacao.numero }</td>
				</tr>
				<tr>
					<th width="200px" class="barracinza"><fmt:message key="label.complemento" /></th>
					<td width="350px" class="camposinternos">${solicitacao.localInstalacao.complemento }</td>
					<th width="200px" class="barracinza"><fmt:message key="label.bairro" /></th>
					<td width="350px" class="camposinternos">${solicitacao.localInstalacao.descricaoBairro }</td>
				</tr>
				<tr>
					<th width="200px" class="barracinza"><fmt:message key="label.estado" /></th>
					<td width="350px" class="camposinternos">${solicitacao.localInstalacao.descricaoUf }</td>
					<th width="200px" class="barracinza"><fmt:message key="label.cidade" /></th>
					<td width="350px" class="camposinternos">${solicitacao.localInstalacao.descricaoCidade }</td>
				</tr>
				<tr>
					<th width="200px" class="barracinza"><fmt:message key="label.cep" /></th>
					<td width="350px" class="camposinternos">${solicitacao.localInstalacao.cep }</td>
					<th width="200px" class="barracinza"><fmt:message key="label.telefone" /></th>
					<td width="350px" class="camposinternos">${solicitacao.telefoneInstalacao }</td>
				</tr>
				<tr>
					<th width="200px" class="barracinza"><fmt:message key="label.responsavel" /></th>
					<td width="350px" class="camposinternos">${solicitacao.responsavelInstalacao }</td>
					<th width="200px" class="barracinza"><fmt:message key="label.telefoneResponsavel" /></th>
					<td width="350px" class="camposinternos">${solicitacao.telefoneResponsavelInstalacao }</td>
				</tr>
			</table>
				
			<table cellspacing="0" class="detalhe" >
				<tr class="barraazulzinha">
					<th class="barraazulzinha"><fmt:message key="label.dadosDosVeiculos" /></th>
				</tr>
			</table>
				
			<c:if test="${empty listaVeiculos}"><span style="margin-left:20px;font-size:11px;"><fmt:message key="label.nenhumaLista" /> ${mensagemListaVeiculo }</span></c:if>
			
			<c:if test="${not empty listaVeiculos}">
				<table width="750" cellpadding="1px" ID="alter" cellspacing="0px">
						<tr>
							<th width="12%" class="texttable_azul" scope="col"><fmt:message key="label.placa" /></th>
							<th width="11%" class="texttable_cinza" scope="col"><fmt:message key="label.chassi" /></th>
							<th width="18%" class="texttable_cinza"  scope="col"><fmt:message key="label.marca" /></th>
							<th width="8%" class="texttable_cinza" scope="col"><fmt:message key="label.modelo" /></th>
							<th width="6%" class="texttable_cinza" scope="col"><fmt:message key="label.ano" /></th>
							<th width="13%" class="texttable_cinza" scope="col"><fmt:message key="label.cor" /></th>
							<th width="16%" class="texttable_cinza" scope="col"><fmt:message key="label.renavan" /></th>
						</tr>
					<c:forEach var="veiculo" items="${listaVeiculos }" varStatus="contador">
						<tr <c:if test="${contador.count % 2 != 0 }">class="dif"</c:if>>
							<td class="linkazulescuro">${veiculo.placa }&nbsp;</td>
							<td>${veiculo.chassi }&nbsp;</td>
							<td>${veiculo.descricaoMarca }&nbsp;</td>
							<td>${veiculo.descricaoModelo }&nbsp;</td>
							<td>${veiculo.anoFabricacao }&nbsp;</td>
							<td>${veiculo.cor }&nbsp;</td>
							<td>${veiculo.renavan }&nbsp;</td>
						</tr>
					</c:forEach>
				</table>
			</c:if>

			
			<table cellspacing="0" class="detalhe" >
				<tr class="barraazulzinha">
					<th class="barraazulzinha"><fmt:message key="label.observacoesGerais" /></th>
				</tr>
			</table>
			
			<table width="900" cellspacing="3" class="detalhe2">
				<tr>
					<th width="200px" class="barracinza"><fmt:message key="label.observacao" /></th>
					<td width="350" class="camposinternos">${solicitacao.apolice.observacao}</td>
				</tr>
			</table>
			
			<div style="height: 100px;">
	</form>
	<div class="pgstabela_desc" style="margin-bottom:20px;margin-top:20px;">
		<form method="post" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC21/dv02">
			<input type="hidden" name="dataInicial" value="${param.dataInicial }" />
			<input type="hidden" name="dataFinal" value="${param.dataFinal }" />
			<input type="hidden" name="numeroPlaca" value="${param.numeroPlaca }" />
			<input type="hidden" name="numeroChassi" value="${param.numeroChassi }" />
			<input type="hidden" name="nomeCliente" value="${param.nomeCliente }" />
			<input type="hidden" name="numSolicitacao" value="${param.numSolicitacao }" />
			<input type="hidden" name="numeroProposta" value="${param.numeroProposta }" />
			<input type="hidden" name="tipoSeguro" value="${param.tipoSeguro }" />
			<input type="hidden" name="statusSolicitacao" value="${param.statusSolicitacao }" />
			<input type="hidden" name="menu" value="${param.menu}" />
			<input type="hidden" name="pagina" value="${param.pagina}" />
			
			<input type="submit" class="button3" value="<fmt:message key="label.voltar" />" />
		</form>
	</div>				
				
		
		<div id="dialog_alterStatus" class="popup_padrao" style="display: none;">
			<form action="" id="alterarStatus">
					<input type="hidden" id="numeroSolicitacao" name="numeroSolicitacao" />
					<input type="hidden" id="statusSolicitacao" name="statusSolicitacao" />
				<div id="popup_msg_modal" class="popup_padrao_pergunta"></div>
				
				
				<div class="popup_padrao_resposta">
					<input name="" type="button" class="button close" value="<fmt:message key="label.sim" />"  style="*margin-left:25px; *width:40px;" onclick="javascript:alterarStatusSolicitacao();"/>
					<input type="button" class="button4 close" value="<fmt:message key="label.nao" />"  style="*margin-right:100px; *width:40px;" onclick="javascript:$.closeOverlay();" />
				</div>
			</form>
		</div>
		
		<div id="dialog_mensagem" class="popup_padrao" style="display: none;">
			<div class="popup_padrao_pergunta"></div>
			<div class="popup_padrao_resposta">
					<input type="button" class="button" value="<fmt:message key="label.fechar" />" onclick="document.location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC21/dv01'"/>
			</div>
		</div>
