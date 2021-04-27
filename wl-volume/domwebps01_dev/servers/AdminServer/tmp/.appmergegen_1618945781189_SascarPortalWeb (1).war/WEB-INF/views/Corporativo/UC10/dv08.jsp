<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/AtivarEquipamentoVinculo/listarAcessorios?acao=8" context="/SascarPortalWeb"  />
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
		$("div.breadcrumb").html('<fmt:message key="mensagem.informacao.atendimentoAtivacaoAutomaticaEquipamento" />');
	});
</script>


	<div class="cabecalho">
		<div class="caminho" style="*margin-left:400px;">
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
			<a href="#" class="linktres"><fmt:message key="label.servicos" /></a> &gt; 
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv01" class="linkquatro"><fmt:message key="label.ativacaoEquipamento" /></a>
		</div>
	  	<fmt:message key="label.ativacaoEquipamento" />
	</div>


	<!-- FORM VOLTAR -->
	<form method="post"	id="formVoltar"	action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv07">
		<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
		<input type="hidden" name="tipoSubmeter" value="A" />
	</form>


	<table cellspacing="0" class="detalhe" >
		<tr class="barraazulzinha">
			<th class="barraazulzinha"><fmt:message key="uc10.dv08.tabelaServicoContratadosSerial" /></th>
		</tr>
	</table>


	<form action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv09" method="post" class="filtro">
		
		<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
		<input type="hidden" name="codigoItem" value="${acessorio.codigoItem }" />
		<input type="hidden" name="codigoAcessorio" value="${acessorio.codigo }" />
		
		<table cellspacing="0" width="70%" id="alter">
			<tr>
				<th width="20%" class="texttable_azul"><fmt:message key="label.acessorio" /></th>
				<th width="20%" class="texttable_cinza"><fmt:message key="label.serial" /></th>
				<th width="20%" class="texttable_cinza"><fmt:message key="label.porta" /></th>
				<th width="20%" class="texttable_cinza"><fmt:message key="label.localInstalacao" /></th>
				<th width="20%" class="texttable_cinza"><fmt:message key="label.posicaoSensorPneu"/></th>
			</tr>
			<c:if test="${not empty acessoriosSerial}">
			   	<c:forEach var="acessorio" items="${acessoriosSerial}">
			    	<tr>
			        	<td class="camposinternos">${acessorio.descricao}&nbsp;</td>
						<td class="camposinternos">${acessorio.numeroSerial}&nbsp;</td>
						<td class="camposinternos">${acessorio.codigoPorta}&nbsp;</td>
						<td class="camposinternos">${acessorio.descricaoLocalInstalacao}&nbsp;</td>
						<c:if test="${acessorio.posicaoSensorPneu gt (-1)}">
							<c:forEach items="${combosPosicaoSensorPneu}" var="opcaoPosicaoSensorPneu">
								<c:if test="${opcaoPosicaoSensorPneu.id eq acessorio.posicaoSensorPneu}">
									<td class="camposinternos">${opcaoPosicaoSensorPneu.descricao}&nbsp;</td>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${acessorio.posicaoSensorPneu lt (0)}">
							<td class="camposinternos">&nbsp;</td>
						</c:if>
			        </tr>
				</c:forEach>
		    </c:if>
		</table>
	
	
	   	<table cellspacing="0" class="detalhe" >
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="uc10.dv08.tabelaServicosContratadosSemSerial" /></th>
			</tr>
		</table>
		
		
		<table cellspacing="0" width="70%" id="alter">
			<tr>
		    	<th width="20%" class="texttable_azul"><fmt:message key="label.acessorio" /></th>
			  	<th width="20%" class="texttable_cinza"><fmt:message key="label.quantidade" /></th>
				<th width="20%" class="texttable_cinza"><fmt:message key="label.porta" /></th>
				<th width="20%" class="texttable_cinza"><fmt:message key="label.localInstalacao" /></th>
				<th width="20%" class="texttable_cinza"><fmt:message key="label.posicaoSensorPneu"/></th>
		    </tr>
			<c:if test="${not empty acessoriosQuantidade}">
				<c:forEach var="acessorio" items="${acessoriosQuantidade}">
			    	<tr>
			        	<td class="camposinternos">${acessorio.descricao}&nbsp;</td>
						<td class="camposinternos">${acessorio.quantidade}&nbsp;</td>
						<td class="camposinternos">${acessorio.codigoPorta}&nbsp;</td>
						<td class="camposinternos">${acessorio.descricaoLocalInstalacao}&nbsp;</td>
						<c:if test="${acessorio.posicaoSensorPneu gt (-1)}">
							<c:forEach items="${combosPosicaoSensorPneu}" var="opcaoPosicaoSensorPneu">
								<c:if test="${opcaoPosicaoSensorPneu.id eq acessorio.posicaoSensorPneu}">
									<td class="camposinternos">${opcaoPosicaoSensorPneu.descricao}&nbsp;</td>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${acessorio.posicaoSensorPneu lt (0)}">
							<td class="camposinternos">&nbsp;</td>
						</c:if>
			        </tr>
				</c:forEach>
			</c:if>
		</table>
	
	
	    <div class="clear"></div>
	
	
	    <div class="pgstabela">
		    <p>
		        <input type="button" class="button4" value="<fmt:message key="label.voltar" />" onclick="$('#formVoltar').submit();" />
		        <input type="submit" class="button" value="<fmt:message key="label.continuar" />" />
		    </p>
	    </div>
	</form>
