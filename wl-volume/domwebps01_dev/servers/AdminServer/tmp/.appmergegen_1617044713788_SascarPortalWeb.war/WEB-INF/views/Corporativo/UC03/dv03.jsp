<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/EfetuarTrocaVeiculoRetirada/detalharContrato?acao=2" context="/SascarPortalWeb"  />
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
		var container = $('div.container2');
		$("#formTrocaVeiculo").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form){
				efetuarTroca(form);
				return false;
			}
		});

		$("#anoFabricacao").setMask({mask:'9999'});
		$("#numeroRenavan").setMask({mask:'9999999999999'});
	});

	function carregarModelos(codigoMarca) {

		if (codigoMarca == '') {
			$("option[value!='']","#modelos").remove();
			return;
		}

		var selectModelos = $('#modelos')[0];

		$.ajax({
			"url": "/SascarPortalWeb/EfetuarTrocaVeiculoRetirada/listarModeloPorMarca",
			"data" : { "codigoMarca": codigoMarca, "acao" : 4 },
			"dataType" : "json",
			"beforeSend": function(){
				$("option[value!='']","#modelos").remove();
			},
			"success": function(json){
				if (json.success) {
					$.each(json.modelos, function(i, modelo){
						var option = new Option(modelo.value, modelo.id);
						if ($.browser.msie) {
							selectModelos.add(option);
						} else {
							selectModelos.add(option,null);
						}
					});
				} else {
					$.showMessage(json.mensagem);
				}
			}
		});
	}

	function reinstalarVeiculo(element) {
		if ($(element).is(':checked')) {
			$('.reinstalar :disabled').removeAttr('disabled');
			checkPlaca("#veiculoZero");
	    } else {
	    	$('.reinstalar :enabled').attr('disabled', true);
	    }
	}

	function checkPlaca(element) {
		if ($(element).is(':checked')) {
			$('#numeroPlaca').attr('disabled', true).val('').removeClass("error");
	    } else {
	    	$('#numeroPlaca').removeAttr('disabled');
	    }
	}

	function efetuarTroca(form) {
		var data = $(form).serialize();
		$.ajax({
			url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC03/dv04",
			data: data || {},
			dataType:"html",
			success: function(html){
				$("#dialog").html(html).jOverlay();
			}
		});
	}
</script>

	<div class="container2">
		<ol>
			<li><label for="codigoMarca" class="error"><fmt:message key="mensagem.selecione.marca" /></label></li>
			<li><label for="anoFabricacao" class="error"><fmt:message key="mensagem.informacao.anoFabricacao" /></label></li>
			<li><label for="modelos" class="error"><fmt:message key="mensagem.selecione.modelo" /></label></li>
			<li><label for="numeroChassi" class="error"><fmt:message key="mensagem.informacao.numeroChassi" /></label></li>
			<li><label for="numeroPlaca" class="error"><fmt:message key="mensagem.informacao.placa" /></label></li>
			<li><label for="numeroRenavan" class="error"><fmt:message key="mensagem.informacao.numeroRenavam" /></label></li>
			<li><label for="cor" class="error"><fmt:message key="mensagem.informacao.cor" /></label></li>
		</ol>
	</div>


	<div class="cabecalho2">
		<fmt:message key="label.solicitarRetiradaReinstalacao" />
		<div class="caminho">
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
			<a href="#" class="linktres"><fmt:message key="label.servicos" /></a> &gt;
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC03/dv01" class="linkquatro"><fmt:message key="label.solicitarRetiradaReinstalacao" /></a>
		</div>
	</div>


	<table cellspacing="0" class="tbatualizacao">
		<tr class="tbatualizacao">
			<th class="barraazulzinha"><fmt:message key="label.informacoesCliente" /></th>
		</tr>
	</table>


	<table width="100%" cellspacing="3" class="detalhe2">
		<tr>
			<th width="200" class="barracinza"><fmt:message key="label.cliente" /></th>
			<td width="350" class="camposinternos">${contrato.contratante.nome}</td>
			<th>&nbsp;</th>
			<td class="camposinternos">&nbsp;</td>
		</tr>
		<tr>
			<th width="200" class="barracinza"><fmt:message key="label.cpfCnpj" /></th>
			<td width="350" class="camposinternos">${contrato.contratante.numCpfCnpj}</td>
		</tr>
	</table>


	<table cellspacing="0" class="detalhe">
		<tr class="barraazulzinha">
			<th class="barraazulzinha"><fmt:message key="label.informacoesVeiculoRetirada" /></th>
		</tr>			
	</table>


	<form action="" method="post" id="formTrocaVeiculo">
		
		<input type="hidden" name="numeroContrato" value="${contrato.numeroContrato}" />
	
		<table width="100%" cellspacing="3" class="detalhe2">
			<tr>
				<th width="200" class="barracinza"><fmt:message key="label.placa" /></th>
				<td width="350" class="camposinternos">
					<input type="text" name="placa" disabled="disabled" value="${contrato.veiculo.placa}" />
		      	</td>
				<th width="200" class="barracinza"><fmt:message key="label.chassi" /></th>
				<td width="350" class="camposinternos">
				    <input type="text" name="chassi" disabled="disabled" value="${contrato.veiculo.chassi}" />
			    </td>
			</tr>
			<tr>
				<th width="200" class="barracinza"><fmt:message key="label.marcaModelo" /></th>
				<td width="350" class="camposinternos">
				    <input type="text" name="marca" value="${contrato.veiculo.descricaoMarca} / ${contrato.veiculo.descricaoModelo}" disabled="disabled" />
			    </td>
				<th width="200" class="barracinza"><fmt:message key="label.renavam" /></th>
				<td width="350" class="camposinternos">
				    <input type="text" name="renavam" value="${contrato.veiculo.renavan}" disabled="disabled" />
				</td>
			</tr>
			<tr>					
				<th width="200" class="barracinza"><fmt:message key="label.cor" /></th>
				<td  width="350"class="camposinternos">
					<input type="text" name="cor" disabled="disabled" value="${contrato.veiculo.cor}" />
			    </td>
			</tr>	
			<tr>					
				<th width="200" class="barracinza"><fmt:message key="label.ano" /></th>
				<td width="350" class="camposinternos">
					<input type="text" name="ano" disabled="disabled" value="${contrato.veiculo.anoFabricacao}" />
				</td>
			</tr>
		</table>
		
		
		<label style="margin-left:20px" class="checkboxReinstalacao">
			<input type="checkbox" name="reinstalacao" value="1" onclick="reinstalarVeiculo(this);" /><span><fmt:message key="label.possuoVeiculoReinstalacaoEquipamento" /></span>
		</label>
		
		
		<table cellspacing="0" class="detalhe" >
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.informacoesVeiculoASerInstalado" /></th>
			</tr>
		</table>
		
		
		<span class="texthelp2">
				<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" /><fmt:message key="uc03.dv03.texto.01" />  
		</span>
		
		
		<table width="100%" cellspacing="3" class="detalhe2">
			<tbody class="reinstalar">
				<tr>
					<th width="200" class="barracinza"><fmt:message key="label.placa" /></th>
					<td width="350" class="camposinternos">
						<input type="text" name="numeroPlaca" id="numeroPlaca" class="required" disabled="disabled" maxlength="7"/>
						<input type="checkbox" name="veiculoZero" id="veiculoZero" value="true" class="checkbox" disabled="disabled" onclick="checkPlaca(this);" checked="checked" />
						<span><fmt:message key="label.veiculo0km" /></span>
					</td>
					<th width="200" class="barracinza"><fmt:message key="label.chassi" /></th>
					<td width="350" class="camposinternos">
						<input type="text" name="numeroChassi" id="numeroChassi" class="required" disabled="disabled" maxlength="17"/>
						</td>
				</tr>
				<tr>
					<th width="200" class="barracinza"><fmt:message key="label.marcaModelo" /></th>
					<td width="350" class="camposinternos">
						<select name="codigoMarca" id="codigoMarca" disabled="disabled" onchange="carregarModelos(this.value);" class="required">
							<option value=""><fmt:message key="label.selecione" /></option>
							<c:forEach var="marca" items="${marcas}">
								<c:if test="${not empty marca.identifier && not empty marca.value}">
									<option value="${marca.identifier}">${marca.value}</option>
								</c:if>
							</c:forEach>
						</select>
						<select name="codigoModelo" disabled="disabled" id="modelos" class="required">
							<option value=""><fmt:message key="label.selecione" /></option>
						</select>
					</td>
					<th width="200" class="barracinza"><fmt:message key="label.renavam" /></th>
					<td width="350" class="camposinternos">
						<input type="text" name="numeroRenavan" id="numeroRenavan" disabled="disabled" class="required" />
					</td>
				</tr>
				<tr>					
					<th width="200" class="barracinza"><fmt:message key="label.cor" /></th>
					<td width="350" class="camposinternos">
						<input type="text" name="cor" id="cor" class="required" disabled="disabled" maxlength="10"/>
			        </td>
				</tr>
				<tr>
					<th width="200" class="barracinza"><fmt:message key="label.ano" /></th>
					<td width="350" class="camposinternos">
						<input type="text" name="anoFabricacao" id="anoFabricacao" disabled="disabled" class="required" />
					</td>
				</tr>
			</tbody>
		</table>
	
	
		<div class="pgstabela">
			<input type="button" class="button3" value="<fmt:message key="label.voltar" />" onclick="$('#formBack').submit();"/>
			<div class="botoesatualizacao">
				<input type="submit" class="button" value="<fmt:message key="label.finalizar" />" />
				<input type="button" class="button4" value="<fmt:message key="label.limpar" />" onclick="limparCampos('#formPesquisa');"/>
			</div>
		</div>
	</form>


	<form method="post" id="formBack" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC03/dv02">
		<input type="hidden" name="numeroPlaca" value="${param.numeroPlaca }" />
		<input type="hidden" name="numeroChassi" value="${param.numeroChassi }" />
		<input type="hidden" name="pagina" value="${param.pagina }" />
		<input type="hidden" name="valida_contrato" value="true" id="valida_contrato" />
	</form>
	

	<div id="dialog" class="window modal" style="display: none;">
	</div>

