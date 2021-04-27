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

	$(document).ready(function(){
		$('#acessoriosInclusao').change(function(){
			if($('#acessoriosInclusao option:selected').val() == ""){
				$('#bota-troca-acessorio').attr('disabled', 'disabled');
			}else{
				$('#bota-troca-acessorio').removeAttr('disabled');
			}
		});
	});
	
	function alterarAcessorio(codigo, nome){
		$('#js-idServico').val(codigo);
		$('#js-nomeAcessorio').val(nome);
		$('#formAlterarAcessorio').submit();
	}
	
	function submterAcessorio(codigoAcessorio) {
		$.ajax({
			url: "/SascarPortalWeb/AtivarEquipamentoVinculo/submeterAcessorio?acao=7",
			data: {"codigoAcessorio": codigoAcessorio, "numeroOS": $("#numeroOS").val(), "numeroCPF": $("#numeroCPF").val(), "tipoSubmeter" : "I"},
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
	
	function abrirRetirarEquipamento() {
	
		var numeroSerial = $("#numeroSerial").val();
	
		$.ajax({
			url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC10/dv13",
			data: {"numeroCPF" : $("#numeroCPF").val(), "numeroOS" : $("#numeroOS").val(), "numeroSerial" : numeroSerial },
			dataType:"html",
			success: function(html) {
				$("#dialog").html(html);
				$("#dialog").jOverlay();
			}
		});
	}
	
	// Funcao chamada ao clicar no botão vermelho
	// Exclusão do acessório
	function abrirExcluirAcessorio(codigoAcessorio, descricaoAcessorio, numSerialAcessorio){
		$("#dialog_excluir").jOverlay({'onSuccess' : function(){
			$("#formExcluirAcessorio #codigoAcessorio").val(codigoAcessorio);
			$("#formExcluirAcessorio #descricaoAcessorio").val(descricaoAcessorio);
			$("#formExcluirAcessorio #numSerialAcessorio").val(numSerialAcessorio);
			$("#formExcluirAcessorio #descAcessorio").html(descricaoAcessorio);
			$("#formExcluirAcessorio #nSerialAcessorio").html(numSerialAcessorio).hide();
			$("#formExcluirAcessorio #textoSerial").hide();
			
			//Se o acessório tiver numero de serie, ira mostrar
			//Casso não tenha ele esconde a label que iria mostrar
			if(numSerialAcessorio != ""){
				$("#formExcluirAcessorio #nSerialAcessorio").show();
				$("#formExcluirAcessorio #textoSerial").show();
			}else{
				$("#formExcluirAcessorio #nSerialAcessorio").hide();
				$("#formExcluirAcessorio #textoSerial").hide();
			}
			
		}});
	}
	
	// Funcao chamada ao clicar no botão amarelo
	// Troca do acessório
	function abrirTrocarAcessorio(codigoAcessorio, descricaoAcessorio, numSerialAcessorio){
		$("#dialog_trocar").jOverlay({'onSuccess' : function(){
			$("#formTrocarAcessorio #codigoAcessorio").val(codigoAcessorio);
			$("#formTrocarAcessorio #descricaoAcessorio").val(descricaoAcessorio);
			$("#formTrocarAcessorio #numSerialAcessorio").val(numSerialAcessorio);
			$("#formTrocarAcessorio #descAcessorio").html(descricaoAcessorio);
			$("#formTrocarAcessorio #nSerialAcessorio").html(numSerialAcessorio).hide();
			$("#formTrocarAcessorio #textoSerial").hide();
			
			//Se o acessório tiver numero de serie, ira mostrar
			//Casso não tenha ele esconde a label que iria mostrar
			if(numSerialAcessorio != ""){
				$("#formTrocarAcessorio #nSerialAcessorio").show();
				$("#textoSerial").show();
			}else{
				$("#formTrocarAcessorio #nSerialAcessorio").hide();
				$("#formTrocarAcessorio #textoSerial").hide();
			}
			
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
	
	//Função que exclui acessório e ja direciona tela para inclusão
	function trocarAcessorio() {
		var codigoAcessorio = $("#codigoAcessorio").val();
 		$.ajax({
			url: "/SascarPortalWeb/AtivarEquipamentoVinculo/excluirAcessorio?acao=13",
			data: {"numeroOS" : $("#numeroOS").val(), "codigoAcessorio" : codigoAcessorio},
			dataType:"json",
			success: function(json){
				if (json.success) {
					//Após exclusão do acessório chamar metodo de inclusão de acessório selecionado.
					submterAcessorio($('#acessoriosInclusao option:selected').val());					
				} else {
					//Caso tenha erro, somente mostra a mensagem
					$.showMessage(json.mensagem);
				}
			}
		});
	}
</script>

<div class="cabecalho">
	<div class="caminho" style="*margin-left:400px;">
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="Home" class="linktres"><fmt:message key="label.home" /></a> &gt; 
		<a href="#" class="linktres"><fmt:message key="label.servicos" /></a> &gt; 
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv01" class="linkquatro"><fmt:message key="label.ativacaoEquipamento" /></a>
	</div>
  	<fmt:message key="label.ativacaoEquipamento" />
</div>

<form id="formAlterarAcessorio" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv14" method="post">
	<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
	<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
	<input type="hidden" name="idServico" id="js-idServico" value="" />
	<input type="hidden" name="nomeAcessorio" id="js-nomeAcessorio" value="" />
	<input type="hidden" name="tipoSubmeter" value="D" />
</form>
	
<form id="formPesquisa" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv06" method="post" class="filtro">

	<input type="hidden" name="numeroCPF" id="numeroCPF" value="${param.numeroCPF }" />
	<input type="hidden" name="numeroOS" id="numeroOS" value="${param.numeroOS }" />
	
	<!-- INFORMACOES NECESSARIAS PARA REMOCAO DE EQUIPAMENTO -->
	<input type="hidden" value="${equipamento.numeroSerial}" name="numeroSerial" id="numeroSerial"  />

	<table class="detalhe" cellspacing="0">
		<tbody>
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.informacaoTecnica" /></th>
			</tr>
		</tbody>
	</table>

	<c:if test="${not empty equipamento}">
		<c:if test="${equipamento.semEquipamento}">
			<script>
				//Incluindo campo tipoSubmeter como "A" de acessório
				$('#formPesquisa').append('<input type="hidden" value="A" name="tipoSubmeter"/>');
				$('#formPesquisa').append('<input type="hidden" value="1" name="semEquipamento"/>');
				$('#formPesquisa').attr('action', '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv07');
			</script>
		</c:if>
		<table id="alter_extrato" cellspacing="0" cellspacing="1" width="960">
			<tbody>
				<tr>
					<th style="background-color: rgb(204, 204, 204); color: rgb(51, 51, 51);" scope="col" colspan="5"><fmt:message key="label.equipamento" /></th>
				</tr>
				<tr>
					<th width="10%" scope="col"><fmt:message key="label.modelo" /></th>
					<th width="10%" scope="col"><fmt:message key="label.versao" /></th>
					<th width="10%" scope="col"><fmt:message key="label.serie" /></th>
					<th width="10%" scope="col"><fmt:message key="label.idSascarga" /></th>
					<c:if test="${not empty equipamento.numeroSerial}">
						<th width="10%" scope="col"><fmt:message key="label.retiradaEquipamento" /></th>
					</c:if>
				</tr>
				<tr class="dif">
					<td>${equipamento.modelo}</td>
					<td>${equipamento.versao}</td>
					<td>${equipamento.numeroSerial}</td>
					<td>${equipamento.codigoSascarga}</td>
					<c:if test="${not empty equipamento.numeroSerial}">
						<td align="center">
							<a href="#retirarEquipamento" onclick="abrirRetirarEquipamento()">
								<img height="16" border="0" align="middle" width="16" src="/SascarPortalWeb/sascar/images/corporativo_new/excluir16-10.png" />
							</a>
						</td>
					</c:if>
				</tr>
			</tbody>
		</table>
		<p></p>
	</c:if>
	
	<table id="alter_extrato" cellspacing="0px" cellpadding="1px" width="960">
		<tbody>
			<tr>
				<th style="background-color: rgb(204, 204, 204); color: rgb(51, 51, 51);" scope="col" colspan="6"><fmt:message key="uc10.dv05.servicoCadastradosContrato" /></th>
			</tr>
			<tr>
				<th width="46%" scope="col"><fmt:message key="label.servicos" /></th>
				<th width="16%" scope="col"><fmt:message key="label.serial" /></th>
				<th width="6%" scope="col"><fmt:message key="label.quantidade" /></th>
				<th width="6%" scope="col"><fmt:message key="label.porta" /></th>
				<th width="13%" scope="col"><fmt:message key="label.dataInstalacao" /></th>
				<th width="13%" scope="col"><fmt:message key="label.retiraTrocaServico" /></th>
			</tr>

			<c:forEach var="acessorio" items="${acessorios}" varStatus="status">
				<tr class="dif">
					<td>${acessorio.descricao}</td>
					<td>${acessorio.numeroSerial}</td>
					<td>${acessorio.quantidade}</td>
					<td>${acessorio.codigoPorta}</td>
					<td><fmt:formatDate value="${acessorio.dataInstalacao}" pattern="dd/MM/yyyy"/></td>
					<td align="center">
						<label style="float: left; margin-left: 44px;">
							<c:if test="${acessorio.excluir}">
								<img height="16" border="0" align="middle" style="cursor: pointer;" width="16" onclick="abrirExcluirAcessorio('${acessorio.codigo}' , '${acessorio.descricao}' ,'${acessorio.numeroSerial}');" src="/SascarPortalWeb/sascar/images/corporativo_new/excluir16-10.png" />
							</c:if>
						</label>
						<label style="float: right; margin-right: 42px; ">
							<c:if test="${acessorio.dataInstalacao != null}">
								<img height="16" border="0" align="middle" style="cursor: pointer;" width="16" onclick="alterarAcessorio('${acessorio.codigo}' , '${acessorio.descricao}')" src="/SascarPortalWeb/sascar/images/corporativo_new/troca_acessorio.png" />
							</c:if>
						</label>
							
							

					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<div class="pgstabela" align="center">
		<p>
			<input class="button4" type="button" onclick="window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv04&numeroOS=${param.numeroOS}'" value="<fmt:message key="label.voltar" />">
			<input class="button" type="button" onclick="window.location.href ='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv12&numeroOS=${param.numeroOS}&numeroCPF=${param.numeroCPF}'" value="<fmt:message key="label.incluirServico" />">
			<input class="button" type="submit" value="<fmt:message key="label.continuar" />">
		</p>
	</div>

</form>

<form id="formAtualizar" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv05" method="post">
	<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
	<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
</form>

<div id="dialog" style="display: none;">&nbsp;</div>

<div id="dialog_excluir" class="popup_padrao" style="display: none;">
	<form action="" id="formExcluirAcessorio">
		<input type="hidden" id="codigoAcessorio" name="codigoAcessorio" />
		<input type="hidden" id="descricaoAcessorio" name="descricaoAcessorio" />
		<input type="hidden" id="numSerialAcessorio" name="numSerialAcessorio" />

		<div class="popup_padrao_pergunta" style="margin-top: -12px;"><fmt:message key="mensagem.informacao.confirmacaoRetiradaAcessorio" /> 
			<label id="descAcessorio" style="color: red; font-weight: bold; text-transform: uppercase;"></label>
			<label id="textoSerial"><fmt:message key="label.serial" /></label><label id="nSerialAcessorio" style="color: red; font-weight: bold; text-transform: uppercase;"></label> ?
		</div>
	
		<div class="popup_padrao_resposta">
			<input type="button" class="button close" value="<fmt:message key="label.sim" />" onclick="excluirAcessorio();"/>
			<input type="button" class="button4 close" value="<fmt:message key="label.nao" />" onclick="$.closeOverlay();" />
		</div>
	</form>
</div>
<div id="dialog_trocar" class="popup_padrao3" style="display: none;">
	<form action="" id="formTrocarAcessorio">
		<input type="hidden" id="codigoAcessorio" name="codigoAcessorio" />
		<input type="hidden" id="descricaoAcessorio" name="descricaoAcessorio" />
		<input type="hidden" id="numSerialAcessorio" name="numSerialAcessorio" />

		<div class="popup_padrao_pergunta" style="margin-top: -12px;"><fmt:message key="mensagem.informacao.confirmacaoTroca" /></div>
		<div class="popup_padrao_pergunta" style="text-align: left; height: auto;">
			<fmt:message key="label.acessorio" />:</br>
			<label id="descAcessorio" style="color: red; font-weight: bold; text-transform: uppercase;"></label>
			<label id="textoSerial"><fmt:message key="label.serial" /></label><label id="nSerialAcessorio" style="color: red; font-weight: bold; text-transform: uppercase;"></label>
		</div>
		<p>
		<p>
		<p>
		<div class="popup_padrao_pergunta" style="text-align: left;  height: auto;">
			<fmt:message key="uc10.dv05.alteraAcessorio" />:
			<select id="acessoriosInclusao" style=" width: 290px;">
				<option value=""><fmt:message key="label.selecione" /></option>
				<c:forEach var="acessorioInclusao" items="${acessoriosInclusao}">
					<option value="${acessorioInclusao.identifier}">${acessorioInclusao.value}</option>
				</c:forEach>
			</select>

		</div>
	
		<div style="margin-top: 20px; text-align: center;">
			<input id="bota-troca-acessorio" disabled="disabled" type="button" class="button close" value="<fmt:message key="label.sim" />" onclick="trocarAcessorio();"/>
			<input type="button" class="button4 close" value="<fmt:message key="label.nao" />" onclick="$.closeOverlay();" />
		</div>
	</form>
</div>
