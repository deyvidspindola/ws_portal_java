<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/AtivarEquipamentoVinculo/recuperarInformacoesTecnicas?acao=11" context="/SascarPortalWeb"  />
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
	function abrirExcluirAcessorio(codigoAcessorio){
		$("#dialog_excluir").jOverlay({'onSuccess' : function(){
			$("#codigoAcessorio").val(codigoAcessorio);
		}});
	}

	function excluirAcessorio() {
		var codigoAcessorio = $("#codigoAcessorio").val();
		$.ajax({
			url: "/SascarPortalWeb/AtivarEquipamentoVinculo/excluirAcessorio?acao=13",
			data: {"numeroOS" : $("#numeroOS").val(), "codigoAcessorio" : codigoAcessorio},
			dataType:"json",
			success: function(json){
				if (json.success) {
					$("#formAtualizar").submit();
				} else {
					$.showMessage(json.mensagem);
				}
			}
		});
	}
	
	$(document).ready(function(){
		$('#ativar_equipamento').addClass('active');
	});
</script>

	<h1><fmt:message key="label.ativacaoDesativacaoEquipamento" /></h1>

	<form id="formPesquisa" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv06" method="post" class="filtro">
	
		<input type="hidden" name="numeroCPF" id="numeroCPF" value="${param.numeroCPF }"/>
		<input type="hidden" name="numeroOS" id="numeroOS" value="${param.numeroOS }"/>
	
	
		<table class="detalhe" cellspacing="0">
			<tbody>
				<tr class="barraazulzinha">
					<th class="barraazulzinha"><fmt:message key="label.informacaoTecnica" /></th>
				</tr>
			</tbody>
		</table>
	
		<c:if test="${not empty equipamento}">
			<table id="alter_extrato" width="100%" cellpadding="0" cellspacing="5" border="0" class="dados">
				<tbody>
					<tr align="center">
						<th style="background-color: rgb(204, 204, 204); color: rgb(51, 51, 51);" scope="col" colspan="5"><fmt:message key="label.equipamento" /></th>
					</tr>
					<tr>
						<th scope="col"><fmt:message key="label.modelo" /></th>
						<th scope="col"><fmt:message key="label.versao" /></th>
						<th scope="col"><fmt:message key="label.serie" /></th>
						<th scope="col"><fmt:message key="label.idSascarga" /></th>
						<c:if test="${not empty equipamento.numeroSerial}">
							<th scope="col"><fmt:message key="label.retirar" /></th>
						</c:if>
					</tr>
					<tr class="dif">
						<td>${equipamento.modelo}</td>
						<td>${equipamento.versao}</td>
						<td>${equipamento.numeroSerial}</td>
						<td>${equipamento.codigoSascarga}</td>
						<c:if test="${not empty equipamento.numeroSerial}">
							<td align="center">
								<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv13&numeroCPF=${param.numeroCPF}&numeroOS=${param.numeroOS}&numeroSerial=${equipamento.numeroSerial}">
									<img height="48" border="0" align="absmiddle" width="48" src="/SascarPortalWeb/sascar/images/mobile/X.png" />
								</a>
							</td>
						</c:if>
					</tr>
				</tbody>
			</table>
			<br/>
			<br/>
		</c:if>
		
		<table id="alter_extrato" width="100%" cellpadding="0" cellspacing="5" border="0" class="dados">
			<tbody>
				<tr>
					<th style="background-color: rgb(204, 204, 204); color: rgb(51, 51, 51);" scope="col" colspan="6"><fmt:message key="label.servicoCadastradosContrato" /></th>
				</tr>
				<tr>
					<th scope="col"><fmt:message key="label.servicos" /></th>
					<th scope="col"><fmt:message key="label.serial" /></th>
					<th scope="col"><fmt:message key="label.qtde" /></th>
					<th scope="col"><fmt:message key="label.porta" /></th>
					<th scope="col"><fmt:message key="label.dataInstalacao" /></th>
					<th scope="col"><fmt:message key="label.retirar" /></th>
				</tr>
				<c:forEach var="acessorio" items="${acessorios}" varStatus="status">
					<tr class="dif">
						<td>${acessorio.descricao}</td>
						<td>${acessorio.numeroSerial}</td>
						<td>${acessorio.quantidade}</td>
						<td>${acessorio.codigoPorta}</td>
						<td><fmt:formatDate value="${acessorio.dataInstalacao}" pattern="dd/MM/yyyy"/></td>
						<td align="center">
							<c:if test="${acessorio.excluir}">
								<img height="48" style="cursor:pointer;" border="0" align="absmiddle" width="48" onclick="abrirExcluirAcessorio('${acessorio.codigo}');" src="/SascarPortalWeb/sascar/images/mobile/X.png">
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<br />
		
		<div class="pgstabela" align="center">
			<p>
				<input class="aButton ui-state-default ui-corner-all" type="button" onclick="window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv12&numeroCPF=${param.numeroCPF}&numeroOS=${param.numeroOS}'" value="<fmt:message key="label.incluirServico" />">
				<input class="aButton ui-state-default ui-corner-all" type="submit" value="<fmt:message key="label.continuar" />">
			</p>
		</div>
			
	</form>

	<form action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv05" method="post" id="formAtualizar">
		<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
	</form>
	
	<jsp:include page="/WEB-INF/views/Corporativo/Mobile/icones.jsp">
		<jsp:param name="voltar" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv04&numeroOS=${param.numeroOS }&numeroCPF=${param.numeroCPF}"/>
	</jsp:include>
	
	<div id="dialog_excluir" class="window modal" style="display: none;">
		<div class="topo"></div>
		<div class="middle">
			<span>
				<b><fmt:message key="mensagem.confirmarExclusaoAcessorio" /></b>
			</span>
			<br/><br/>
			<form action="" id="formExcluirAcessorio">
				<input type="hidden" id="codigoAcessorio" name="codigoAcessorio" />
				<table width="100%" cellspacing="0">
					<tr>
						<td align="center">
							<input type="button" style="cursor:pointer;" onclick="excluirAcessorio();" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.sim" />"/>
							<input type="button" style="cursor:pointer;" onclick="$.closeOverlay();" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.nao" />" />
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div class="bottom"></div>
	</div>