<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/RetirarEquipamentosAcessorios/carregarInformacaoesTecnicas?acao=3" context="/SascarPortalWeb"  />
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

	<form action="${pageContext.request.contextPath}/Satellite" method="get" id="formPesquisa" class="filtro">	
	      
	    <input type="hidden" name="pagename" value="SascarPortal_Corporativo/Mobile/RepresentanteTecnico" />
		<input type="hidden" name="page"     value="Corporativo/Mobile/UC34/dv04" />  
	      
	    <input type="hidden" name="numeroCPF"          value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS"           value="${param.numeroOS }" />
		<input type="hidden" name="chassiVeiculo"      value="${param.chassiVeiculo}" />
		<input type="hidden" name="placaVeiculo"       value="${param.placaVeiculo}" />
		
		<table class="detalhe" cellspacing="0">
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.informacoesTecnicasRetirada" /></th>
			</tr>
		</table>
		
		<table id="alter_extrato" width="100%" cellpadding="0" cellspacing="5" border="0" class="dados">
			<tbody>
				<tr align="center">
					<th style="background-color: rgb(204, 204, 204); color: rgb(51, 51, 51);" scope="col" colspan="5"><fmt:message key="label.equipamento" /></th>
				</tr>
				
				<c:choose>
					<c:when test="${not empty equipamento}">
					
						<tr>
							<th scope="col"><fmt:message key="label.Modelo" /></th>
							<th scope="col"><fmt:message key="label.versao" /></th>
							<th scope="col"><fmt:message key="label.serie" /></th>
							<th scope="col"><fmt:message key="label.idSascarga" /></th>
						</tr>
						<tr class="dif">
							<td>${equipamento.modelo}</td>
							<td>${equipamento.versao}</td>
							<td>${equipamento.numeroSerial}</td>
							<td>${equipamento.codigoSascarga}</td>
						</tr>
							
					</c:when>
					<c:otherwise>
					
						<tr class="dif">
							<td><fmt:message key="label.naoHaEquipamentosVinculadosContrato" /></td>
						</tr>
					
					</c:otherwise>
				</c:choose>
				
				
			</tbody>
		</table>
		
		<br/>
		<br/>
		
		<table id="alter_extrato" width="100%" cellpadding="0" cellspacing="5" border="0" class="dados">
			<tbody>
				<tr>
					<th style="background-color: rgb(204, 204, 204); color: rgb(51, 51, 51);" scope="col" colspan="6"><fmt:message key="label.servicoCadastradosContrato" /></th>
				</tr>
				<tr>
					<th scope="col"><fmt:message key="label.servico" /></th>
					<th scope="col"><fmt:message key="label.serial" /></th>
					<th scope="col"><fmt:message key="label.qtd" /></th>
					<th scope="col"><fmt:message key="label.porta" /></th>
					<th scope="col"><fmt:message key="label.dtInst" /></th>
				</tr>
				
				<c:forEach var="acessorios" items="${acessoriosSerial}" varStatus="status">
					<tr class="dif">
						<td>${acessorios.descricao}</td> 
						<td>${acessorios.numeroSerial}</td>
						<td>${acessorios.quantidade}</td>
						<td>${acessorios.codigoPorta}</td>
						<td>
							<fmt:formatDate value="${acessorios.dataInstalacao}" pattern="dd/MM/yyyy"/>
						</td>
					</tr>
				</c:forEach>
				
				<c:forEach var="acessorios" items="${acessoriosQuantidade}" varStatus="status">
					<tr class="dif">
						<td>${acessorios.descricao}</td> 
						<td>${acessorios.numeroSerial}</td>
						<td>${acessorios.quantidade}</td>
						<td>${acessorios.codigoPorta}</td>
						<td>
							<fmt:formatDate value="${acessorios.dataInstalacao}" pattern="dd/MM/yyyy"/>
						</td>
					</tr>
				</c:forEach>
				
			</tbody>
		</table>	
		
		<br />
		
		<div class="pgstabela" align="center">
			
			<c:choose>
				<c:when test="${not empty equipamento}">
					<p>
						<input type="submit" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.continuar" />" />
					</p>
				</c:when>
				<c:otherwise>
				
					<c:choose>
						<c:when test="${not empty acessoriosSerial or not empty acessoriosQuantidade }">
							
							<p>
								<input class="aButton ui-state-default ui-corner-all"
									   value="<fmt:message key="label.continuar" />" 
									   type="button" 
									   onclick="javascript: location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC34/dv06&numeroOS=${param.numeroOS}&chassiVeiculo=${param.chassiVeiculo}&placaVeiculo=${param.placaVeiculo}&numeroCPF=${param.numeroCPF}';" />
							</p>
						
						</c:when>
						<c:otherwise>
							<p>
								<input class="aButton ui-state-default ui-corner-all" 
									   value="<fmt:message key="label.continuar" />" 
									   type="button" 
									   onclick="javascript: location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC34/dv08&numeroOS=${param.numeroOS}&numeroCPF=${param.numeroCPF}';" />
							</p>
						</c:otherwise>
					</c:choose>
				
				</c:otherwise>
			</c:choose>
			
		</div>
		
	</form>
	
<jsp:include page="/WEB-INF/views/Corporativo/Mobile/icones.jsp">
	<jsp:param name="voltar" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC34/dv02&numeroOS=${param.numeroOS}&chassiVeiculo=${param.chassiVeiculo}&placaVeiculo=${param.placaVeiculo}"/>
</jsp:include>
