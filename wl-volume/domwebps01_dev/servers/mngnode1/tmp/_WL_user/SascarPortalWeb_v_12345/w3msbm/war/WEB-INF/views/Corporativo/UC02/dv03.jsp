	<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

	<c:catch var="helper" >
		<c:import url="/PesquisarOrdensServico/detalharOrdemServico?acao=4" context="/SascarPortalWeb"  />
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

	<div class="cabecalho">
		<!--<fmt:message key="label.agendarAtendimento" />
		<div class="caminho">
			
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; -->
			<!-- <a href="#" class="linktres"><fmt:message key="label.servicos" /></a> &gt;  -->
		<!--  <a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC02/dv01" class="linkquatro"><fmt:message key="label.agendarAtendimento" /></a>
		</div>-->
	</div>


	<h1><fmt:message key="label.detalhamentoOrdemServico" /></h1>


	<table cellspacing="0" class="detalhe" >
		<tr class="barraazulzinha">
			<th class="barraazulzinha"><fmt:message key="label.informacoesSobreServico" />
			<%-- RETIRADO REVISAO NOMENCLATURA
			    <div class="lembretes">
			      	<a href="/cs/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC11/dv01&numeroPlaca=${ordemServico.contrato.veiculo.placa}&numeroOS=${ordemServico.numero}" class="linkum">
			    		<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/agendamento32.png" width="24" height="24" hspace="3" border="0" align="absmiddle" />
			    		<span>Alterar Agendamento</span>
			    	</a>
			    </div>
			--%>
		    </th>
		</tr>
	</table>


	<table width="100%" cellspacing="3" class="detalhe2">
		<tr>
			<th width="200" class="barraroxa"><fmt:message key="label.numDaOrdemServico" /></th>
			<td width="350" class="camposinternos5">${ordemServico.numero}&nbsp;</td>
			
			<th width="200"  rowspan="2" class="barradata">
				<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/1304960183_Calendar.png" width="32" height="32" hspace="2" align="absmiddle" /><fmt:message key="label.dataDoAgendamento" /></th>
			<td width="350" rowspan="2" class="camposinternos3">
				<c:choose>
					<c:when test="${empty ordemServico.agendamento.dataAgendamento }">
						<fmt:message key="label.naoInformado" />
						<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC11/dv01&numeroPlaca=${ordemServico.contrato.veiculo.placa}&numeroOS=${ordemServico.numero}" class="linkum">
							<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/botoes-38.png" hspace="5" align="absmiddle" border="0"/>
						</a>
					</c:when>
					<c:otherwise>
						<fmt:formatDate value="${ordemServico.agendamento.dataAgendamento}" pattern="dd/MM/yyyy HH:mm" />
							<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC11/dv01&numeroPlaca=${ordemServico.contrato.veiculo.placa}&numeroOS=${ordemServico.numero}" class="linkum">
								<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/botoes-39.png" hspace="5" align="absmiddle" border="0"/>
							</a>
					</c:otherwise>
				</c:choose>	
			</td>
		</tr>
		<tr>	
		 	<th width="200" class="barracinza"><fmt:message key="label.dataOrdemServico" /></th>
			<td width="350" class="camposinternos"><fmt:formatDate value="${ordemServico.dataGeracao}" pattern="dd/MM/yyyy" />&nbsp;</td>
		</tr>
		<tr>
			<th width="200" class="barracinza"><fmt:message key="label.prestadorServico" /></th>
			<td width="350" class="camposinternos">${ordemServico.prestadorServico}&nbsp;</td>
		</tr>
		<tr>
			<th width="200" class="barracinza"><fmt:message key="label.representacao" /></th>
			<td width="350" class="camposinternos" maxlength="30" >${ordemServico.agendamento.representacao}&nbsp;</td>
		</tr>
		<tr>
			<th width="200" class="barracinza"><fmt:message key="label.contatoRepresentacao" /></th>
			<td width="350" class="camposinternos">${ordemServico.agendamento.contatoRepresentacao}&nbsp;</td>
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
			<th width="200" class="barracinza"><fmt:message key="label.rua" /></th>
			<td width="350" class="camposinternos">${ordemServico.agendamento.endereco.descricaoLogradouro}&nbsp;</td>
		</tr>
		<tr>		
			<th width="200" class="barracinza"><fmt:message key="label.numeroComplemento" /></th>
			<td width="350" class="camposinternos">
				${ordemServico.agendamento.endereco.numero}
				<c:if test="${not empty ordemServico.agendamento.endereco.numero and not empty ordemServico.agendamento.endereco.complemento} ">
					&nbsp;/
				</c:if>
				${ordemServico.agendamento.endereco.complemento}&nbsp;
			</td>
			<th width="200" class="barracinza"><fmt:message key="label.nome" /></th>
			<td width="350" class="camposinternos">${ordemServico.agendamento.endereco.contato}&nbsp; </td>
		</tr>
		<tr>					
			<th width="200" class="barracinza"><fmt:message key="label.bairro" /></th>
			<td width="350" class="camposinternos">${ordemServico.agendamento.endereco.descricaoBairro}&nbsp;</td>
			
			<th width="200"class="barracinza"><fmt:message key="label.telefoneCelular" /></th>
			<td width="350" class="camposinternos">${ordemServico.agendamento.telefone1}&nbsp;</td>
		</tr>
		<tr>					
			<th width="200" class="barracinza"><fmt:message key="label.cidadeEstado" /></th>
			<td width="350" class="camposinternos">
				${ordemServico.agendamento.endereco.descricaoCidade}
				<c:if test="${not empty ordemServico.agendamento.endereco.descricaoCidade and not empty ordemServico.agendamento.endereco.uf}">
					&nbsp;/
				</c:if> ${ordemServico.agendamento.endereco.uf}&nbsp;
			</td>
			<th width="200" class="barracinza"><fmt:message key="label.telefoneComercial" /></th>
			<td width="350" class="camposinternos">${ordemServico.agendamento.telefone2}&nbsp;</td>	
		</tr>
		<tr>
			<th width="200" class="barracinza"><fmt:message key="label.pontoReferencia" /></th>
			<td width="350" class="camposinternos">${ordemServico.agendamento.endereco.pontoReferencia}&nbsp;</td>
		</tr>
	</table>


	<table cellspacing="0" class="detalhe" >
		<tr class="barraazulzinha">
			<th class="barraazulzinha">
				<fmt:message key="label.informacoesCliente" />
				<div class="lembretes">
					<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC08/dv01"class="linkum">
						<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/atualizardados32.png" width="24" height="24" hspace="3" border="0" align="absmiddle" />
						<span><fmt:message key="label.atualizarInformacoes" />?</span>
					</a>
				</div>
			</th>
		</tr>
	</table>


	<table width="100%" cellspacing="3" class="detalhe2">
		<tr>
			<th width="200" class="barraroxa"><fmt:message key="label.NomeCliente" /></th>
			<td width="350" class="camposinternos5" colspan="3">${ordemServico.contrato.contratante.nome}&nbsp;</td>
				<%-- RETIRADO RELEASE CRISTIANE
				<th  class="barracinza">Nº do Contrato</th>
				<td  class="camposinternos">${ordemServico.contrato.numeroContrato}&nbsp;</td>
				--%>
		</tr>
		<tr>
			<th width="200" class="barracinza"><fmt:message key="label.telefoneCelular" /></th>
			<td width="350" class="camposinternos">${ordemServico.contrato.contratante.telefone1}&nbsp;</td>
			<th width="200" class="barracinza"><fmt:message key="label.rua" /></th>
			<td width="350"class="camposinternos">${ordemServico.contrato.contratante.endereco.descricaoLogradouro}&nbsp;</td>
		</tr>
		<tr>					
			<th width="200" class="barracinza"><fmt:message key="label.telefoneComercial" /></th>
			<td width="350" class="camposinternos">${ordemServico.contrato.contratante.telefone2}&nbsp;</td>
				<%-- RETIRADO RELEASE CRISTIANE
				<th class="barracinza">Ponto de Referência</th>
				<td class="camposinternos">${ordemServico.contrato.contratante.endereco.pontoReferencia}&nbsp;</td>
				--%>
			<th width="200" class="barracinza"><fmt:message key="label.numeroComplemento" /></th>
			<td width="350" class="camposinternos">
				${ordemServico.contrato.contratante.endereco.numero}
				<c:if test="${not empty ordemServico.contrato.contratante.endereco.numero and not empty ordemServico.contrato.contratante.endereco.complemento}">
					&nbsp;/
				</c:if> 
				${ordemServico.contrato.contratante.endereco.complemento}&nbsp;
			</td>
		</tr>
		<tr>	
			<td width="200" class="camposinternos"></td>
			<td width="350" class="camposinternos"></td>			
			<th width="200" class="barracinza"><fmt:message key="label.bairro" /></th>
			<td width="350" class="camposinternos">${ordemServico.contrato.contratante.endereco.descricaoBairro}&nbsp;</td>
		</tr>
		<tr>					
			<td width="200" class="camposinternos"></td>
			<td width="350" class="camposinternos"></td>			
			<th width="200" class="barracinza"><fmt:message key="label.cidadeEstado" /></th>
			<td width="350" class="camposinternos">${ordemServico.contrato.contratante.endereco.descricaoCidade}&nbsp;/${ordemServico.contrato.contratante.endereco.uf}&nbsp;</td>
		</tr>
		<tr>					
			<td width="200" class="camposinternos"></td>
			<td width="350" class="camposinternos"></td>			
			<th width="200" class="barracinza"><fmt:message key="label.cep" /></th>
			<td width="350" class="camposinternos">${ordemServico.contrato.contratante.endereco.cep}&nbsp;</td>
		</tr>
	</table>


	<table cellspacing="0" class="detalhe" >
		<tr class="barraazulzinha">
			<th class="barraazulzinha">
				<fmt:message key="label.informacoesDoVeiculo" />
				<%-- RETIRADO RELEASE CRISTIANE 
					<div class="lembretes">
						<a href="/cs/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC08/dv01" class="linkum">
							<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/atualizardados32.png" width="24" height="24" hspace="3" border="0" align="absmiddle" />
							<span>Atualizar informações?</span>
						</a>
					</div>
				--%>
			</th>
		</tr>
	</table>


	<table width="100%" cellspacing="3" class="detalhe2">
		<tr>
			<th width="200" class="barracinza"><fmt:message key="label.placa" /></th>
			<td width="350" class="camposinternos">${ordemServico.contrato.veiculo.placa}&nbsp;</td>
			<th width="200" class="barracinza"><fmt:message key="label.chassi" /></th>
			<td width="350" class="camposinternos">${ordemServico.contrato.veiculo.chassi}&nbsp;</td>
		</tr>
		<tr>
			<th width="200" class="barracinza"><fmt:message key="label.marcaModelo" /></th>
			<td width="350" class="camposinternos">${ordemServico.contrato.veiculo.descricaoMarca}&nbsp;/&nbsp;${ordemServico.contrato.veiculo.descricaoModelo}</td>
			<th width="200" class="barracinza"><fmt:message key="label.renavam" /></th>
			<td width="350" class="camposinternos">${ordemServico.contrato.veiculo.renavan}&nbsp;</td>
		</tr>
		<tr>					
			<th width="200" class="barracinza"><fmt:message key="label.cor" /></th>
			<td width="350" class="camposinternos">${ordemServico.contrato.veiculo.cor}&nbsp;</td>
		</tr>
		<tr>
			<th width="200" class="barracinza"><fmt:message key="label.ano" /></th>
			<td class="camposinternos">${ordemServico.contrato.veiculo.anoFabricacao}&nbsp;</td>
		</tr>
		<tr>
			<%-- RETIRADO RELEASE CRISTIANE 					
			<th class="barracinza">Nº de Séries do Equipamento</th>
			<td class="camposinternos">${ordemServico.numeroSerialEquipamento}&nbsp;</td>
			--%>
			<td></td>
			<td></td>
		</tr>
	</table>


	<c:if test="${not empty ordemServico.itens}">
		<table cellspacing="0" class="detalhe">
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.servicosSeremExecutados" /></th>
			</tr>
		</table>
			
			
		<table cellspacing="0" width="70%" id="alter">
			<tr>
				<th width="30%"class="texttable_azul" ><fmt:message key="label.item" /></th>
				<th class="texttable_cinza"><fmt:message key="label.tipo" /></th>
				<th width="30%" class="texttable_cinza"><fmt:message key="label.Motivo" /></th>
			</tr>
			<c:forEach var="servico" items="${ordemServico.itens}" varStatus="contador">
				<tr <c:if test="${contador.count % 2 != 0 }">class="dif"</c:if>>
					<td class="camposinternos">${servico.descricao}&nbsp;</td>
					<td class="camposinternos">${servico.tipo}&nbsp;</td>
					<td>${servico.motivo}&nbsp;</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>


	<div class="clear"></div>


	<jsp:include page="/WEB-INF/views/icones.jsp">
		<jsp:param name="novabusca" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC02/dv01"/>
		<jsp:param name="formBack" value="formBack"/>
	</jsp:include>
	

	<form method="post" id="formBack" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC02/dv02">
		<input type="hidden" name="numeroPlaca" value="${param.numeroPlaca}"/>
		<input type="hidden" name="dataInicial" value="${param.dataInicial}"/>
		<input type="hidden" name="dataFinal" value="${param.dataFinal}"/>
		<input type="hidden" name="numeroChassi" value="${param.numeroChassi}"/>
		<input type="hidden" name="codigoMarca" value="${param.codigoMarca}"/>
		<input type="hidden" name="codigoModelo" value="${param.codigoModelo}"/>
		<input type="hidden" name="pagina" value="${param.pagina}"/>
	</form>

