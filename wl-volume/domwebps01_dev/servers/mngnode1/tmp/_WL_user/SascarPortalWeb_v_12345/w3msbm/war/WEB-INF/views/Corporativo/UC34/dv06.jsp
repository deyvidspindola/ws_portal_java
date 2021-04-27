<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/RetirarEquipamentosAcessorios/recuperarAcessorioEquipamento?acao=6" context="/SascarPortalWeb"  />
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

	function submeterDadosAcessorio(form) {
		
		var data = $(form).serialize();
		
		$.ajax({
			url: "/SascarPortalWeb/RetirarEquipamentosAcessorios/submeterDadosAcessorio?acao=7",
			data: data || {},
			dataType:"json",
			success: function(json){
			
				if (json.success) {
					
					var quantidadeRestanteAcessorios = json.acessoriosRestantesAtual;		
					var quantidadeTotalAcessorios = json.totalAcessoriosAtual;		
					
					if(quantidadeRestanteAcessorios == 0 && quantidadeTotalAcessorios != 0 ){
						$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv08&numeroOS=${param.numeroOS }");
						$(form).unbind('submit').submit();
					}else{
						$("#formAtualizar").submit();
					}
					
				} else {
					$(form).attr("action", "");
					$.showMessage(json.mensagem);
				}
				
			}
		});
	}
	
	function showModalConfirmarRetiradaAcessorio() {
		$.ajax({
			type : "POST",
			url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC34/dv07",
			data: {
				"descricaoAcessorio" : $("#descricaoAcessorio").val(),
				"numeroSerialAcessorio" : $("#numeroSerialAcessorio").val()
			},
			dataType:"html",
			success: function(html){
				$("#popupConfirmacaoRetiradaAcessorioSerial").html(html).jOverlay({
					bgClickToClose : false, 
					closeOnEsc : false
				});
			}
		});
		
	}
		
</script>

	<!-- FORM VOLTAR -->
	<form method="post"	id="formVoltar"	action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv03">
		<input type="hidden" name="numeroOS"      value="${param.numeroOS}" />
		<input type="hidden" name="numeroCPF"     value="${param.numeroCPF }" />
		<input type="hidden" name="chassiVeiculo" value="${param.chassiVeiculo}" />
		<input type="hidden" name="placaVeiculo"  value="${param.placaVeiculo}" />
		<input type="hidden" name="numeroCPF"     value="${param.numeroCPF }" />
	</form>


	<!-- FORM ATUALIZAR -->
	<form method="post"	id="formAtualizar"	action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv06">
		<input type="hidden" name="numeroOS"         value="${param.numeroOS}" />
		<input type="hidden" name="numeroCPF"          value="${param.numeroCPF }" />
		<input type="hidden" name="chassiVeiculo"    value="${param.chassiVeiculo}" />
		<input type="hidden" name="placaVeiculo"     value="${param.placaVeiculo}" />
		<input type="hidden" name="numeroCPF"        value="${param.numeroCPF }" />
	</form>

	<form action="" id="formRetiradaAcessorio" method="post">
		
		<input type="hidden" name="numeroOS"                 value="${param.numeroOS}" />
		<input type="hidden" name="numeroContratoOS"         value="${param.numeroContratoOS}" />
		<input type="hidden" name="numeroCPF"                value="${param.numeroCPF }" />
		<input type="hidden" name="codigoItem"               value="${acessorio.codigoItem}" />
		<input type="hidden" name="quantidadeAcessorio"      value="${acessorio.quantidade}" />
		<input type="hidden" name="descricaoLocalInstalacao" value="${acessorio.descricaoLocalInstalacao}" />
		<input type="hidden" name="codigoPorta"              value="${acessorio.codigoPorta}" />
		<input type="hidden" name="acessorioId"              value="${acessorio.codigo}" />
		<input type="hidden" id="numeroSerialAcessorio"      name="numeroSerialAcessorio" value="${acessorio.numeroSerial}" />
		<input type="hidden" id="descricaoAcessorio"         name="descricaoAcessorio"    value="${acessorio.descricao}" />
		<input type="hidden" name="chassiVeiculo"            value="${param.chassiVeiculo}" />
		<input type="hidden" name="placaVeiculo"             value="${param.placaVeiculo}" />	
	
		<div class="cabecalho3">
			<div class="caminho3" style="*margin-left:360px;">
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
				<a href="#" class="linktres"><fmt:message key="label.informacoes" /></a> &gt; 
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv01"  class="linkquatro"><fmt:message key="label.retiradaEquipamentoAcessorio" /></a>
			</div>
			<fmt:message key="label.retiradaEquipamentoAcessorio" />
		</div>			
	
		<table cellspacing="0" class="detalhe" >
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.dadosVeiculo" /></th>
			</tr>
		</table>			
	
		<table width="900" cellspacing="3" class="detalhe2">
			<tr>
				<th width="400" class="barracinza"><fmt:message key="label.NumOS" /></th>
				<td width="350" class="camposinternos">${param.numeroOS}</td>
	
				<th width="200" class="barracinza"><fmt:message key="label.placa" /></th>
				<td  width="350" class="camposinternos">${param.placaVeiculo}</td>
			</tr>
	
			<tr>
				<th width="400" class="barracinza"><fmt:message key="label.chassi" /></th>
				<td width="350" class="camposinternos">${param.chassiVeiculo}</td> 
			</tr> 
		</table>
	
	
		<table cellspacing="0" class="detalhe" >
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.retiradaDeAcessorio" /></th>
			</tr>
		</table>			
	
		<table width="900" cellspacing="3" class="detalhe2">
			<tr>
				<th width="400" class="barracinza"><fmt:message key="label.acessorio" /></th>
				<td width="350" class="camposinternos">${acessorio.descricao}</td>
	
				<c:choose>
					<c:when test="${acessorio.indicadorSerial}">
						<th width="200" class="barracinza"><fmt:message key="label.serial" /></th>
						<td  width="350" class="camposinternos">${acessorio.numeroSerial}</td>
					</c:when>
					<c:otherwise>
						<th width="200" class="barracinza"><fmt:message key="label.quantidade" /></th>
						<!-- <td  width="350" class="camposinternos">${acessorio.quantidade}</td> -->
						<!-- POR SOLICITACAO DA SASCAR A QUANTIDADE DE ACESSORIOS DEVERA FICAR FIXA -->
						<td  width="350" class="camposinternos">${acessorio.quantidade}</td>
					</c:otherwise>
				</c:choose>
			</tr>
		</table>
		
		<div class="pgstabela">
			<p>
				<input type="button" 
					   class="button4" 
					   value="<fmt:message key="label.voltar" />" 
					   onclick="$('#formVoltar').submit();" />
				
				<input type="button" 
				       class="button" 
				       value="<fmt:message key="label.continuar" />" 
				       onclick="showModalConfirmarRetiradaAcessorio()" />
			</p>
		</div>
	</form>
	
	<!-- DIV MODAL DV7 - TELA RETIRADA DE ACESSORIO SERIAL -->
	<div id="popupConfirmacaoRetiradaAcessorioSerial" style="display: none;"></div>
