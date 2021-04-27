<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/EfetuarAtualizacaoCadastral/detalharContrato?acao=3" context="/SascarPortalWeb"  />
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

	function abrirExcluirContato(codigoContato, tipoContato){
		$("#dialog_excluir").jOverlay({'onSuccess' : function(){
			$("#codigoContato").val(codigoContato);
			$("#tipoContato").val(tipoContato);
		}});
	}
	
	function excluirContato(tipoContato) {
		var codigoContato 	= $("#codigoContato").val();
		var tipoContato 	= $("#tipoContato").val();
		var numeroContrato 	= $("input[name='numeroContrato']").val();
		$.ajax({
			url: "/SascarPortalWeb/EfetuarAtualizacaoCadastral/excluirContato?acao=9",
			data: {"codigoContato" : codigoContato, "tipoContato" : tipoContato, "numeroContrato" : numeroContrato},
			dataType:"json",
			success: function(json){
				$("#dialog_mensagem .popup_padrao_pergunta").html(json.mensagem);
				$("#dialog_mensagem").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
			}
		});
	}

	function abrirGerenciarPessoaAutorizada(codigoContato, numeroContrato) {
		$.ajax({
			url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC08/dv06",
			data: {"codigoContato" : codigoContato, "numeroContrato" : numeroContrato},
			dataType:"html",
			success: function(html){
				$("#dialog_editarPessoa").html(html).jOverlay({onSuccess: function(html){
					carregarContatoAutorizado(codigoContato, html);
				}});
			}
		});
	}

	function abrirGerenciarPessoaEmergencia(codigoContato, numeroContrato) {
		$.ajax({
			url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC08/dv07",
			data: {"codigoContato" : codigoContato, "numeroContrato" : numeroContrato},
			dataType:"html",
			success: function(html){
				$("#dialog_editarPessoa").html(html).jOverlay({onSuccess: function(html){
					//carregarContatoEmergencia(codigoContato, html);
				}});
			}
		});
	}

	function carregarContatoAutorizado(codigoContato, html) {
		var tds = $("#contato_autorizado_" + codigoContato).find("td");
		
		if (codigoContato && tds.length > 6) {
			var nome 		= $.trim($(tds[0]).html());
			var cpf 		= $.trim($(tds[1]).html());
			var rg 			= $.trim($(tds[2]).html());
			var telefone1 	= $.trim($(tds[3]).html());
			var telefone2 	= $.trim($(tds[4]).html());
			var telefone3 	= $.trim($(tds[5]).html());
			
			$(html).find('#nomePessoaAutorizada').val(nome.replace(/&[^;]+;/g, ''));
			$(html).find('#cpfPessoaAutorizada').val(cpf.replace(/&[^;]+;/g, ''));
			$(html).find('#numRGPessoaAutorizada').val(rg.replace(/&[^;]+;/g, ''));
			$(html).find('#telefone1PessoaAutorizada').val(telefone1.replace(/&[^;]+;/g, ''));
			$(html).find('#telefone2PessoaAutorizada').val(telefone2.replace(/&[^;]+;/g, ''));
			
			if (telefone3 && $(telefone3).find('img').length) {
				$(html).find('#telefone3PessoaAutorizada').val('');
			} else {
				$(html).find('#telefone3PessoaAutorizada').val(telefone3.replace(/&[^;]+;/g, ''));
			}
			
		}
	}

	function submeterVeiculo(form) {
		var data = $(form).serialize();
		
		  if($("#numeroPlaca").val().length  == 7){
		    $.ajax({
			  url: "/SascarPortalWeb/EfetuarAtualizacaoCadastral/submeterVeiculo?acao=12",
			  data: data || {},
			  dataType:"json",
			  success: function(json){
				$("#dialog_mensagem .popup_padrao_pergunta").html(json.mensagem);
				$("#dialog_mensagem").jOverlay();
			}
		  });
		}else{
			 $.showMessage("Placa inválida.");
		}
	}
	
	$(document).ready(function(){
	
		var container = $('div.container2');
		$("#formDadosVeiculo").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form){
				submeterVeiculo(form);
				return false;
			}
		});
		
				
		
		$("#numeroPlaca").setMask({mask:'aaa9999'});
	});
		
</script>

<div class="cabecalho">
	<fmt:message key="label.atualizacaoCadastral" />
	<div class="caminho">
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
		<a href="#" class="linktres"><fmt:message key="label.informacoes" /></a> &gt;
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC08/dv01" class="linkquatro"><fmt:message key="label.atualizacaoCadastral" /></a>
	</div>
</div>

<jsp:include page="/WEB-INF/views/Corporativo/UC08/MenuAbas.jsp">
	<jsp:param name="ativo" value="dv02" />
</jsp:include>

<div class="container2">
	<ol>
		<li><label for="numeroPlaca" class="error"><fmt:message key="label.campoPlacaInformado" /></label></li>
	</ol>
</div>

<table width="1026" cellspacing="0" class="tbatualizacao">
	<tr class="tbatualizacao">
		<th class="barraazulzinha"><fmt:message key="label.dadosVeiculo" /></th>
	</tr>
</table>

<table width="100%" cellspacing="3" class="detalhe2">	
	<tr>	
	
		<th width="200" class="barracinza"><fmt:message key="label.placa" /></th>
		<td width="350" class="camposinternos">
			<c:choose>		                       
				<c:when test="${contrato.veiculo.placaFicticia && !contrato.tipoEquipamentoMovel }">
					
					<form id="formDadosVeiculo" action="" method="post">
						<input type="hidden" value="${contrato.numeroContrato }" name="numeroContrato" />
					
								<input type="text" value="${contrato.veiculo.placa}" name="numeroPlaca" id="numeroPlaca" class="required text" maxlength="7" size="8" />
				
						<input type="button" class="button" value="Salvar" onclick="$('#formDadosVeiculo').submit();"/>
					</form>
				</c:when>
				<c:otherwise>
					${contrato.veiculo.placa}
				</c:otherwise>
			</c:choose>
		</td>
		
		<th>&nbsp;</th>
		<td  class="camposinternos">&nbsp;</td>
	</tr>
	<tr>
		<th width="200" class="barracinza"><fmt:message key="label.marcaModelo" /></th>
		<td width="350" class="camposinternos">${contrato.veiculo.descricaoMarca}/${contrato.veiculo.descricaoModelo}</td>

		<th width="200" class="barracinza"><fmt:message key="label.chassi" /></th>
		<td width="350" class="camposinternos">${contrato.veiculo.chassi}</td>
		
	</tr>
	<tr>					
		<th width="200" class="barracinza"><fmt:message key="label.cor" /></th>
		<td width="350" class="camposinternos">${contrato.veiculo.cor}</td>

		<th width="200" class="barracinza"><fmt:message key="label.renavam" /></th>
		<td width="350" class="camposinternos">${contrato.veiculo.renavan}</td>
	</tr>
	<tr>					
		<th width="200" class="barracinza"><fmt:message key="label.ano" /></th>
		<td width="350" class="camposinternos">${contrato.veiculo.anoFabricacao}</td>

	</tr>
</table>

<table cellspacing="0" class="detalhe" >
	<tr class="barraazulzinha">
		<th class="barraazulzinha"><fmt:message key="label.listaPessoasAutorizadas" />
			<div class="lembretes">
				<c:if test="${fn:length(contrato.pessoasAutorizadas) < 10 }">
					<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/icon_arrow_down.png" width="16" height="16" />
					<a href="javascript:abrirGerenciarPessoaAutorizada(0, '${contrato.numeroContrato }');" title="Incluir" class="linkum"><fmt:message key="label.incluirNovoContato" /></a>
				</c:if>
			</div>
		</th>
	</tr>
</table>

<span class="text4" style="margin-left:20px"><fmt:message key="uc04.texto.001.contatosAutorizadosCentralAtendimento" />:</span>
<span class="texthelp2">
	<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" /><fmt:message key="uc04.texto.002.incluirMinimo10Pessoas" />.
</span>

<c:if test="${not empty contrato.pessoasAutorizadas}">

	<table width="850" cellpadding="1" cellspacing="0" id="alter">
		
		<tr>
			<th width="350" class="texttable_azul" scope="col"><fmt:message key="label.nome" /></th>
		    <th width="100" class="texttable_cinza" scope="col"><fmt:message key="label.cpf" /></th>
		    <th width="100" class="texttable_cinza" scope="col"><fmt:message key="label.rg" /></th>
		    <th width="100" class="texttable_cinza" scope="col"><fmt:message key="label.telefoneResidencial" /></th>
		    <th width="100" class="texttable_cinza" scope="col"><fmt:message key="label.telefoneComercial" /></th>
		    <th width="100" class="texttable_cinza" scope="col"><fmt:message key="label.telefoneCelular" /></th>
		    <th width="50" class="texttable_cinza" scope="col"><fmt:message key="label.atualizar" /></th>
		    
		    <c:if test="${fn:length(contrato.pessoasAutorizadas) > 1 }">
		    	<th class="texttable_cinza" scope="col"><fmt:message key="label.excluir" /></th>
		    </c:if>
		    
		</tr>
		
		<c:forEach var="pessoaAutorizada" items="${contrato.pessoasAutorizadas}" varStatus="status">
		
			<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if> id="contato_autorizado_${pessoaAutorizada.codigo}">
			    <td class="linkazul">${pessoaAutorizada.nome}&nbsp;</td>
			    <td>${pessoaAutorizada.numCpfCnpj}&nbsp;</td>
			    <td>${pessoaAutorizada.numRG}&nbsp;</td>
			    <td>${pessoaAutorizada.telefone1}&nbsp;</td>
				<td>${pessoaAutorizada.telefone2}&nbsp;</td>
				<td>
					<c:choose>
					
						<c:when test="${not empty pessoaAutorizada.telefone3}">
							${pessoaAutorizada.telefone3}&nbsp;
						</c:when>
						
						<c:otherwise>
							<a href="javascript:abrirGerenciarPessoaAutorizada('${pessoaAutorizada.codigo}', '${contrato.numeroContrato }');" title="<fmt:message key="label.editar" />">
					    		<img border="0" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/incluir-13.png" alt="<fmt:message key="label.incluir" />" />
					    	</a>
						</c:otherwise>
						
					</c:choose>
				</td>
			    <td>
			    	<a href="javascript:abrirGerenciarPessoaAutorizada('${pessoaAutorizada.codigo}', '${contrato.numeroContrato }');" title="<fmt:message key="label.editar" />">
			    		<img border="0" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/editar16-12.png" alt="<fmt:message key="label.editar" />" />
			    	</a>
			    </td>
			    
			    <c:if test="${fn:length(contrato.pessoasAutorizadas) > 1 }">
				
				    <td>
				    	<a href="javascript:abrirExcluirContato('${pessoaAutorizada.codigo}', 'A');" title="<fmt:message key="label.excluir" />">
				    		<img border="0" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/excluir16-10.png" width="16" height="16" alt="<fmt:message key="label.excluir" />" />
				    	</a>
				    </td>
				    
				</c:if>
				
			</tr>
			
		</c:forEach>
		
	</table>
</c:if>


<table cellspacing="0" class="detalhe" >
	<tr class="barraazulzinha">
		<th class="barraazulzinha"><fmt:message key="label.listaPessoasEmergencia" />
		
			<div class="lembretes">
				<c:if test="${fn:length(contrato.pessoasEmergencia) < 10 }">
					<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/icon_arrow_down.png" width="16" height="16" />
					<a href="javascript:abrirGerenciarPessoaEmergencia(0, '${contrato.numeroContrato }');" title="<fmt:message key="label.incluir" />" class="linkum"><fmt:message key="label.incluirNovoContato" /></a>
				</c:if>
			</div>
			
		</th>
	</tr>
</table>

<span class="text4" style="margin-left:20px"><fmt:message key="mensagem.informacao.varificaPessoasComunicadasAlerta" /></span>
<span class="texthelp2">
	<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" /><fmt:message key="uc04.texto.002.incluirMinimo10Pessoas" />.
</span>

<c:if test="${not empty contrato.pessoasEmergencia}">

	<table width="850" cellpadding="1" cellspacing="0" id="alter">
		
		<tr>
			<th width="350" class="texttable_azul" scope="col"><fmt:message key="label.nome" /></th>
		    <th width="250" class="texttable_cinza" scope="col"><fmt:message key="label.telefoneResidencial" /></th>
		    <th width="250" class="texttable_cinza" scope="col"><fmt:message key="label.telefoneComercial" /></th>
		    <th width="150" class="texttable_cinza" scope="col"><fmt:message key="label.telefoneCelular" /></th>
		    
		    <c:if test="${fn:length(contrato.pessoasEmergencia) > 1 }">
		    	<th class="texttable_cinza" scope="col"><fmt:message key="label.excluir" /></th>
		    </c:if>
		</tr>
		
		<c:forEach var="pessoaEmergencia" items="${contrato.pessoasEmergencia}" varStatus="status">
		
			<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if> id="contato_emergencia_${pessoaEmergencia.codigo}">
			    <td class="linkazul">${pessoaEmergencia.nome}&nbsp;</td>
			    <td>${pessoaEmergencia.telefone1}&nbsp;</td>
				<td>${pessoaEmergencia.telefone2}&nbsp;</td>
				<td>${pessoaEmergencia.telefone3}&nbsp;</td>
			    
			    <c:if test="${fn:length(contrato.pessoasEmergencia) > 1 }">
				
				    <td>
				    	<a href="javascript:abrirExcluirContato('${pessoaEmergencia.codigo}', 'E');" title="<fmt:message key="label.excluir" />">
				    		<img border="0" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/excluir16-10.png" width="16" height="16" alt="<fmt:message key="label.excluir" />" />
				    	</a>
				    </td>
				    
				</c:if>
				
			</tr>
			
		</c:forEach>
		
	</table>
</c:if>

<jsp:include page="/WEB-INF/views/icones.jsp">
	<jsp:param name="formBack" value="formBack"/>
</jsp:include>

<form method="post" id="formBack" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC08/dv03">
	<input type="hidden" name="numeroPlaca" value="${param.numeroPlaca }" />
	<input type="hidden" name="pagina" value="${param.pagina }" />
</form>

<div id="dialog_editarPessoa" class="window modal_big" style="display: none;"></div>

<div id="dialog_excluir" class="popup_padrao" style="display: none;">
	<form action="" id="formExcluirContato">
		<input type="hidden" value="" id="tipoContato" name="tipoContato" />
		<input type="hidden" value="" id="codigoContato" name="codigoContato" />
		<input type="hidden" value="${contrato.numeroContrato }" name="numeroContrato" />
		
		<div class="popup_padrao_pergunta"><fmt:message key="mensagem.confirmarExclusaoContato" /></div>
		<div class="popup_padrao_resposta">
			<input name="" type="button" class="button close" value="<fmt:message key="label.sim" />" onclick="excluirContato();"/>
			<input type="button" class="button4 close" value="<fmt:message key="label.nao" />" onclick="$.closeOverlay();" />
		</div>
	</form>
</div>

<div id="dialog_mensagem" class="popup_padrao" style="display: none;">
	<div class="popup_padrao_pergunta"></div>
	<div class="popup_padrao_resposta">
		<input type="button" class="button" value="<fmt:message key="label.fechar" />" onclick="window.location.reload();"/>
	</div>
</div>
