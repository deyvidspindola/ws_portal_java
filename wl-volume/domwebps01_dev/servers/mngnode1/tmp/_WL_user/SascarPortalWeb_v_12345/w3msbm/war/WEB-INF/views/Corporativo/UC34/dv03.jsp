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

	<div class="cabecalho3">
		<div class="caminho3" style="*margin-left:360px;">
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
			<a href="#" class="linktres"><fmt:message key="label.informacoes" /></a> &gt; 
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv01"  class="linkquatro"><fmt:message key="label.retiradaEquipamentoAcessorio" /></a>
		</div>
		<fmt:message key="label.retiradaEquipamentoAcessorio" />
	</div>			

	<div class="tarjaAzul">
		<label><fmt:message key="label.informacoesTecnicasRetirada" /></label>
	</div>
	
	<span class="texthelp2">
		<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" />
		<fmt:message key="dv34.dv03.texto.01" />
	</span>
	
	<div style="clear:both;"></div>
	
	<form action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv04" 
		  method="post"
	      id="formInformacoesTecnicasRemocao" >	
	      
	    <input type="hidden" name="numeroCPF"          value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS"           value="${param.numeroOS }" />
		<input type="hidden" name="chassiVeiculo"      value="${param.chassiVeiculo}" />
		<input type="hidden" name="placaVeiculo"       value="${param.placaVeiculo}" />
		
		<c:if test="${not empty equipamento and equipamento.semEquipamento}">
			<script>
				$('#formInformacoesTecnicasRemocao').attr('action', '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv06');
			</script>
		</c:if>
		
		<div class="div_table_info_equipamento" >
			<table width="960" cellpadding="1px" ID="alter_extrato" cellspacing="0px">
				
				<tr>
					<th colspan="5" scope="col" style="background-color:#CCC; color:#333"><fmt:message key="label.equipamento" /></th>
				</tr>
			
			<c:choose>
				<c:when test="${not empty equipamento}">
					<tr>
						<th width="40%"scope="col"><fmt:message key="label.modelo" /></th>
						<th width="20%" scope="col"><fmt:message key="label.versao" /></th>
						<th width="20%" scope="col"><fmt:message key="label.serie" /></th>
						<th width="20%" scope="col"><fmt:message key="label.idSascarga" /></th>
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
				
			</table>
		</div>
		
		<div class="div_table_info_servicos_cadastrados_contrato" >
			<table width="960" cellpadding="1px" ID="alter_extrato" cellspacing="0px">
				<tr>
					<th colspan="6"scope="col" style="background-color:#CCC; color:#333">
						<fmt:message key="label.servicoCadastradosContrato" />
					</th>
				</tr>
				
				<tr>
					<th width="40%"scope="col"><fmt:message key="label.servico" /></th>
					<th width="15%" scope="col"><fmt:message key="label.serial" /></th>
					<th width="15%" scope="col"><fmt:message key="label.qtde" /></th>
					<th width="15%" scope="col"><fmt:message key="label.porta" /></th>
					<th width="15%" scope="col"><fmt:message key="label.dataInstalacao" /></th>
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
				
			</table>
		</div>
		
		<div style="clear: both"></div>
		
		<div class="pgstabela">
			<p>
				<input class="button4" 
					   value="<fmt:message key="label.voltar" />"
					   type="button" 
					   onclick="javascript: location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv02&numeroOS=${param.numeroOS}&chassiVeiculo=${param.chassiVeiculo}&placaVeiculo=${param.placaVeiculo}';" />
				
				<c:choose>
					<c:when test="${not empty equipamento}">
						<input class="button" value="<fmt:message key="label.continuar" />" type="submit" />
					</c:when>
					<c:otherwise>
					
						<c:choose>
							<c:when test="${not empty acessoriosSerial or not empty acessoriosQuantidade }">
								
								<input class="button" 
									   value="<fmt:message key="label.continuar" />" 
									   type="button" 
									   onclick="javascript: location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv06&numeroOS=${param.numeroOS}&chassiVeiculo=${param.chassiVeiculo}&placaVeiculo=${param.placaVeiculo}&numeroCPF=${param.numeroCPF}';" />
							
							</c:when>
							<c:otherwise>
								
								<input class="button" 
									   value="<fmt:message key="label.continuar" />" 
									   type="button" 
									   onclick="javascript: location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv08&numeroOS=${param.numeroOS}&numeroCPF=${param.numeroCPF}';" />
							
							</c:otherwise>
						</c:choose>
						
					</c:otherwise>
				</c:choose>
				
			</p>
		</div>
	</form>
