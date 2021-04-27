<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

	<div class="cabecalho">
		<fmt:message key="label.verHistoricoPendencias" />    
		<div class="caminho" style="">
			<a class="linktres" title="<fmt:message key="label.home" />" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}"><fmt:message key="label.home" /></a>
			&gt;
			<a class="linkquatro" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC36/dv01"><fmt:message key="label.verHistoricoPendencias" /></a>
		</div>
	</div>
	
	<table class="detalhe" cellspacing="0">
		<tbody>
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.listaDePendencias" /> </th>
			</tr>
		</tbody>
	</table>

	<span class="texthelp2" style="">
		<img hspace="5" height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png">
		<fmt:message key="uc36.texto.02.atualizarPendenciasIcone" />
	</span>

	<div style="clear: both;"></div>
	
	<form id="formPendencias" method="post" action="">
		
		<input type="hidden" name="indicadorAtualizacaoCadastral" value="${param.indicadorAtualizacaoCadastral}" />
		<input type="hidden" name="quantidadeAgendamentos" value="${param.quantidadeAgendamentos}" />
		<input type="hidden" name="indicadorPesquisaOpiniao" value="${param.indicadorPesquisaOpiniao}" />
		
		<table id="alter" cellspacing="0" width="850">
			<tbody>
			 
				<c:if test="${param.indicadorAtualizacaoCadastral}">
					<tr>
						<td class="debito1" width="124"><fmt:message key="label.atualizacaoCadastral" /></td>
						<td class="camposinternos" width="549"><fmt:message key="uc36.texto.03.haInformacoesParaAtualizar" /></td>
						<td class="camposinternos" width="169">
							<a class="linkazul" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC08/dv01"><fmt:message key="label.atualizarCadastro" /></a>
						</td>
					</tr>
				</c:if>
				
				<c:if test="${param.indicadorPesquisaOpiniao}">
					<tr>
						<td class="debito1"><fmt:message key="label.pesquisaOpiniao" /></td>
						<td class="camposinternos"><fmt:message key="uc36.texto.04.cliqueLinkPesquisaOpniao" /></td>
						<td class="camposinternos">
							<a class="linkazul" style="display: block !important;" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC06/dv01"><fmt:message key="label.realizarPesquisaOpiniao" /></a>
						</td>
					</tr>
				</c:if>
				
				<c:if test="${param.quantidadeAgendamentos gt 0}">
					<tr>
						<td class="debito1"><fmt:message key="label.agendamento" /></td>
						<td class="camposinternos"><fmt:message key="uc36.texto.05.haOSPendenteAgendamento" /></td>
						<td class="camposinternos">
							<a class="linkazul" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC02/dv01"><fmt:message key="label.agendarOS" /></a>
						</td>
					</tr>
				</c:if>
				
			    <c:if test="${param.listaPeriodoCarenciaQuantidade gt 0}">
				  <tr>
				    <td class="debito1"><fmt:message key="label.reinstalacao" /></td>
				 	<td class="camposinternos"><fmt:message key="uc36.texto.06.haContratosReinstalacaoPendente" /></td>
					<td class="camposinternos">
				    <a class="linkazul" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC57/dv01"><fmt:message key="label.listaContratos" /></a>
					</td>
				  </tr>			
				</c:if>
				
			</tbody>
		</table>
	</form>

	<form id="formVoltar" method="post" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC36/dv01">
		<div class="botoesvoltar">
			<input id="" class="button3" type="submit" value="<fmt:message key="label.voltar" />" name="button2">
		</div>
	</form>
