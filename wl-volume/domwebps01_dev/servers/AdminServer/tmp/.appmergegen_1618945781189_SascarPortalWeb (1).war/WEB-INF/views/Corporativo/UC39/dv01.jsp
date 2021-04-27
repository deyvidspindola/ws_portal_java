<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/RealizarPedidoEstoque/inicializaCombos?acao=4" context="/SascarPortalWeb"  />
</c:catch>
 
<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$.showMessage('${mensagem}');
	</script>
</c:if>

<c:if test="${not empty helper}">
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>


	<script type="text/javascript">
	
		function continuar(){
			
			// PEGANDO A REFERENCIA DA DIV DE MENSAGENS DE VALIDACAO
			var conteinerValidacao = $(".conteinerValidacao");
			
			// LIMPANDO AS MENSAGENS DE ERRO
			conteinerValidacao.find('li').remove();
			
			// VARIAVEL UTILIZADA NO CONTROLE DE VALIDAÇÃO DOS CAMPOS
			var erroValidacao = false;
			
			var quantidadeEquipamentosAdicionados = $(".tabelaEquipamentos tr").not("tr:first").length;
			var quantidadeMateriaisAdicionados = $(".tabelaMateriais tr").not("tr:first").length;
			
			if(quantidadeEquipamentosAdicionados == 0 && quantidadeMateriaisAdicionados == 0){
				
				erroValidacao = true;
				
				html = '<li><label><fmt:message key="mensagem.informacao.incluirEquipamentoMaterialConfirmarPedido" /></label></li>';
				conteinerValidacao.find('ol').append(html);
			}
			
			if(!erroValidacao){
				
				$("#divBtnContinuar").removeClass("visivel").addClass("invisivel");
				$("#divBtnConfirmarPedido").removeClass("invisivel").addClass("visivel");
				$(".colunaExcluir").removeClass("visivel").addClass("invisivel");
				$("#formInclusaoMaterial").removeClass("visivel").addClass("invisivel");
				$("#formInclusaoEquipamento").removeClass("visivel").addClass("invisivel");
				
				if(quantidadeEquipamentosAdicionados == 0){
					$("#labelEquipamentoNaoSelecionadoPedido").removeClass("invisivel").addClass("visivel");
					$("#labelSelecionarEquipamentosInclusao").removeClass("visivel").addClass("invisivel");
				}
				
				if(quantidadeMateriaisAdicionados == 0){
					$("#labelMaterialNaoSelecionadoPedido").removeClass("invisivel").addClass("visivel");
					$("#labelSelecionarMateriaisInclusao").removeClass("visivel").addClass("invisivel");
				}
			}
			
		}
	
		function voltar(){
			$("#divBtnContinuar").removeClass("invisivel").addClass("visivel");
			$("#divBtnConfirmarPedido").removeClass("visivel").addClass("invisivel");
			$(".colunaExcluir").removeClass("invisivel").addClass("visivel");
			$("#formInclusaoMaterial").removeClass("invisivel").addClass("visivel");
			$("#formInclusaoEquipamento").removeClass("invisivel").addClass("visivel");
			
			var quantidadeEquipamentosAdicionados = $(".tabelaEquipamentos tr").not("tr:first").length;
			var quantidadeMateriaisAdicionados = $(".tabelaMateriais tr").not("tr:first").length;
			
			if(quantidadeEquipamentosAdicionados == 0){
				$("#labelEquipamentoNaoSelecionadoPedido").removeClass("visivel").addClass("invisivel");
				$("#labelSelecionarEquipamentosInclusao").removeClass("invisivel").addClass("visivel");
			}
			
			if(quantidadeMateriaisAdicionados == 0){
				$("#labelMaterialNaoSelecionadoPedido").removeClass("visivel").addClass("invisivel");
				$("#labelSelecionarMateriaisInclusao").removeClass("invisivel").addClass("visivel");
			}			
		}
		
		function confirmarPedido(){
			
			var dataEquipamentosAdicionados = "";
			var dataMateriaisAdicionados = "";
			
			// ITERA TODOS OS CAMPOS INPUT HIDDEN COM AS INDORMAÇÕES DOS EQUIPAMENTOS ADICIONADOS 
			$("input[name=equipamentoAdicionado]").each(function(i, value) {
				dataEquipamentosAdicionados = dataEquipamentosAdicionados + $(this).val() + "|";
			});
			
			// ITERA TODOS OS CAMPOS INPUT HIDDEN COM AS INDORMAÇÕES DOS MATERIAIS ADICIONADOS 
			$("input[name=materialAdicionado]").each(function(i, value) {
				dataMateriaisAdicionados = dataMateriaisAdicionados + $(this).val() + "|";
			});
			
			 $.ajax({
				url: "/SascarPortalWeb/RealizarPedidoEstoque/submeterPedidos",
				data: {"listaEquipamentos" : dataEquipamentosAdicionados, "listaMateriais" : dataMateriaisAdicionados, "acao" : 3},
				method: "post",
				dataType:"json",
				success: function(json){
					if (json != null && json.success) {
						var numeroPedido = json.pedido;
						abrirModalConfirmacaoPedido(numeroPedido);
					} 
				}
			});   
			
		}
		
		function abrirModalConfirmacaoPedido(numeroPedido){
			
			$.ajax({
				url : "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC39/dv03",
				data: {"numeroPedido" : numeroPedido},
				dataType:"html",
				success: function(html){
					$("#popupConfirmacaoPedido").html(html).jOverlay({
						bgClickToClose : false, 
						closeOnEsc : false
					});
				}
			});
		}
		
		function incluirEquipamentoLista(){
			
			// PEGANDO A REFERENCIA DA DIV DE MENSAGENS DE VALIDACAO
			var conteinerValidacao = $(".conteinerValidacao");
			
			// LIMPANDO AS MENSAGENS DE ERRO
			conteinerValidacao.find('li').remove();
			
			/* RECUPERANDO INFORMAÇÕES DO EQUIPAMENTO SELECIONADO PARA INCLUSÃO */
			var equipamento 		  = $('#equipamento :selected').val();
			var codEquipamento 		  = $('#equipamento :selected').attr('id');
			
			var observacao			  = $('#observacaoRemessaEstoque').val();
			
			var quantidadeEquipamento = $('#quantidadeEquipamento').val();
			var operadora 			  = $('#operadora :selected').val();
			
			// VARIAVEL UTILIZADA PARA CONCATENAR AS INFORMACOES DO EQUIPAMENTO ADICIONADO
			var hidden = "";
			
			// VARIAVEL UTILIZADA PARA MOSTRAR O NOME DA OPERADORA NA LISTA DE EQUIPAMENTOS ADICIONADOS
			var labelOperadora = "";
			
			// VARIAVEL UTILIZADA NO CONTROLE DE VALIDAÇÃO DOS CAMPOS
			var erroValidacao = false;
			
			// VALIDANDO
			if($('#equipamento :selected').val() == ''){
				erroValidacao = true;
				
				html = '<li><label><fmt:message key="mensagem.campoObrigatorio.equipamento" /></label></li>';
				conteinerValidacao.find('ol').append(html);
			}
			
			if($('#quantidadeEquipamento').val() == ''){
				erroValidacao = true;

				html = '<li><label><fmt:message key="mensagem.campoObrigatorio.quantidade" /></label></li>';
				conteinerValidacao.find('ol').append(html);
				
			}
			
			if($('#quantidadeEquipamento').val() == '0'){
				erroValidacao = true;
				
				html = '<li><label><fmt:message key="mensagem.informacao.qtdeEquipamentoInvalida" /></label></li>';
				conteinerValidacao.find('ol').append(html);
			}
			
			if(!erroValidacao){
				
				// SELECIONANDO A TABELA QUE O EQUIPAMENTO SERÁ INCLUÍDO
				var tabelaEquipamentos = $(".tabelaEquipamentos");
				
				// VARIAVEL UTILIZADA PARA ZEBRAR A TABELA
				var css = $(".tabelaEquipamentos tr:last").attr("class");
				css = (css == '') ? 'dif' : '';
				
				// CONTROLANDO O NOME DA OPERADORA QUE SERÁ APRESENTADO NA TABELA
				if(operadora == '1'){
					labelOperadora = "Tim";
				}else if(operadora == '2'){
					labelOperadora = "Claro";
				}else if(operadora == ''){
					labelOperadora = '<fmt:message key="label.naoInformada" />';
				}
				
				hidden = codEquipamento + "'" + operadora + "'" + quantidadeEquipamento + "'" + observacao;
				
				// MONTANDO HTML COM O EQUIPAMENTO A SER ADICIONADO NA LISTA
				var html = '<tr class='+ css +'>'
						 		+ '<td class="linkazulescuro">' 
						 			+ equipamento 
						 			+ ' <input type="hidden" value="' + hidden + '" name="equipamentoAdicionado" />'
						 		+ '</td>'
						 		+ '<td>' + quantidadeEquipamento + '</td>'
						 		+ '<td>' 
						 				+ labelOperadora
						 				+ ' <input type="hidden" value="' + operadora + '" name="operadora"/>'
						 			+ '</td>'
						 			+ '<td>' + observacao + '</td>'
						 		+ '<td class="visivel colunaExcluir">'
						 			+ '<a href="#" onclick="removerEquipamentoLista(this);">'
						 				+ '<img height="16" width="16" border="0" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/excluir16-10.png" />'
						 			+ '</a>'
								+ '</td>'
							+ '</tr>';
						
				// VALIDAÇÃO PARA RENDERIZAR A TABELA APOS A INSERÇÃO DO PRIMEIRO EQUIPAMENTO
				if($("#equipamentosIncluidos").hasClass("invisivel")){
					
					// CONTROLE DE RENDERIZAÇÃO DA TABELA
					$("#equipamentosIncluidos").removeClass("invisivel").addClass("visivel");
					$("#labelEquipamentosIncluidos").removeClass("invisivel").addClass("visivel");
					$("#labelSelecionarEquipamentosInclusao").removeClass("visivel").addClass("invisivel");
					$("#labelEquipamentoNaoSelecionadoPedido").removeClass("visivel").addClass("invisivel");
					
				}
				
				// Pegando o tbody da tabela e adicionando uma <tr>
				tabelaEquipamentos.find('tbody').append(html);
				
				// LIMPANDO CAMPOS DE INPUT
				$('#equipamento').val('');
				$('#observacaoRemessaEstoque').val('');
				$('#quantidadeEquipamento').val('');
				$('#operadora').val('');
				
				// CONTADOR DO TEXTAREA
				document.getElementById('contador').innerHTML = 200;
				
				// FUNCAO UTILIZADA PARA REDIMENCIONAR A TELA NO PORTAL EM ADF
				resizeIframeParent();
			}
			
		}
		
		function removerEquipamentoLista(element){
			
			// PEGANDO A REFERENCIA DA DIV DE MENSAGENS DE VALIDACAO
			var conteinerValidacao = $(".conteinerValidacao");
			
			// LIMPANDO AS MENSAGENS DE ERRO
			conteinerValidacao.find('li').remove();
			
			// CAPTURANDO A LINHA SELECIONADA PARA REMOÇÃO
			var elem = $(element);
			elem.parents('tr').remove();
			
			//reposiciona o css da linha
			$(".tabelaEquipamentos tr").each(function(i, value) {
				if (i % 2 == 0) {
					$(this).attr("class", "dif");
				} else {
					$(this).removeAttr("class");
				}
			});
			
			//Esconde a tabela se nao tive elementos
			var qtdeAdd = $(".tabelaEquipamentos tr").not("tr:first").length;
			
			if(qtdeAdd == 0){

				$("#equipamentosIncluidos").removeClass("visivel").addClass("invisivel");
				$("#labelEquipamentosIncluidos").removeClass("visivel").addClass("invisivel");
				$("#labelSelecionarEquipamentosInclusao").removeClass("invisivel").addClass("visivel");
				
			}
			
			// FUNCAO UTILIZADA PARA REDIMENCIONAR A TELA NO PORTAL EM ADF
			resizeIframeParent();
			
		}
		
		function incluirMaterialLista(){
			
			// PEGANDO A REFERENCIA DA DIV DE MENSAGENS DE VALIDACAO
			var conteinerValidacao = $(".conteinerValidacao");
			
			// LIMPANDO AS MENSAGENS DE ERRO
			conteinerValidacao.find('li').remove();
			
			/* RECUPERANDO INFORMAÇÕES DO EQUIPAMENTO SELECIONADO PARA INCLUSÃO */
			var material 		   = $('#material :selected').val();
			var codMaterial		   = $('#material :selected').attr('id');
			
			var quantidadeMaterial = $('#quantidadeMaterial').val();
			
			// VARIAVEL UTILIZADA PARA CONCATENAR AS INFORMACOES DO MATERIAL ADICIONADO
			var hidden = "";
			
			// VARIAVEL UTILIZADA NO CONTROLE DE VALIDAÇÃO DOS CAMPOS
			var erroValidacao = false;
			
			// VALIDANDO
			if($('#material :selected').val() == ''){
				erroValidacao = true;
				
				html = '<li><label><fmt:message key="mensagem.campoObrigatorio.material" /></label></li>';
				conteinerValidacao.find('ol').append(html);
			}
			
			if($('#quantidadeMaterial').val() == ''){
				erroValidacao = true;

				html = '<li><label><fmt:message key="mensagem.campoObrigatorio.quantidade" /></label></li>';
				conteinerValidacao.find('ol').append(html);
				
			}
			
			if($('#quantidadeMaterial').val() == '0'){
				erroValidacao = true;
				
				html = '<li><label><fmt:message key="mensagem.informacao.qtdeMaterialInvalida" /></label></li>';
				conteinerValidacao.find('ol').append(html);
			}
			
			if(!erroValidacao){
				
				// SELECIONANDO A TABELA QUE O EQUIPAMENTO SERÁ INCLUÍDO
				var tabelaMateriais = $(".tabelaMateriais");
				
				// VARIAVEL UTILIZADA PARA ZEBRAR A TABELA
				var css = $(".tabelaMateriais tr:last").attr("class");
				css = (css == '') ? 'dif' : '';
				
				hidden = codMaterial + "," + quantidadeMaterial;
				
				// MONTANDO HTML COM O EQUIPAMENTO A SER ADICIONADO NA LISTA
				var html = "<tr class="+ css +" >"
						 		+ "<td class='linkazulescuro'>" 
						 			+ material 
						 			+ " <input type='hidden' value="+hidden+" name='materialAdicionado'/>"
						 		+ "</td>"
						 		+ "<td>" + quantidadeMaterial + "</td>"
						 		+ "<td class='visivel colunaExcluir'>"
						 			+ "<a href='#' onclick='removerMaterialLista(this);'>"
						 				+"<img height='16' width='16 'border='0' src='${pageContext.request.contextPath}/sascar/images/corporativo_new/excluir16-10.png' />"
						 			+ "</a>"
								+ "</td>"
							+ "</tr>";
				
				// VALIDAÇÃO PARA RENDERIZAR A TABELA APOS A INSERÇÃO DO PRIMEIRO MATERIAL
				if($("#materiaisIncluidos").hasClass("invisivel")){
					
					// CONTROLE DE RENDERIZAÇÃO DA TABELA
					$("#materiaisIncluidos").removeClass("invisivel").addClass("visivel");
					$("#labelMateriaisIncluidos").removeClass("invisivel").addClass("visivel");
					$("#labelSelecionarMateriaisInclusao").removeClass("visivel").addClass("invisivel");
					$("#labelMaterialNaoSelecionadoPedido").removeClass("visivel").addClass("invisivel");
					
				}
				
				// Pegando o tbody da tabela e adicionando uma <tr>
				tabelaMateriais.find('tbody').append(html);
				
				// LIMPANDO CAMPOS DE INPUT
				$('#material').val('');
				$('#quantidadeMaterial').val('');
				
				// FUNCAO UTILIZADA PARA REDIMENCIONAR A TELA NO PORTAL EM ADF
				resizeIframeParent();
				
			}
			
		}
		
		function removerMaterialLista(element){
			
			// PEGANDO A REFERENCIA DA DIV DE MENSAGENS DE VALIDACAO
			var conteinerValidacao = $(".conteinerValidacao");
			
			// LIMPANDO AS MENSAGENS DE ERRO
			conteinerValidacao.find('li').remove();
			
			// CAPTURANDO A LINHA SELECIONADA PARA REMOÇÃO
			var elem = $(element);
			elem.parents('tr').remove();
			
			//reposiciona o css da linha
			$(".tabelaMateriais tr").each(function(i, value) {
				if (i % 2 == 0) {
					$(this).attr("class", "dif");
				} else {
					$(this).removeAttr("class");
				}
			});
			
			//Esconde a tabela se nao tive elementos
			var qtdeAdd = $(".tabelaMateriais tr").not("tr:first").length;
			
			if(qtdeAdd == 0){

				$("#materiaisIncluidos").removeClass("visivel").addClass("invisivel");
				$("#labelMateriaisIncluidos").removeClass("visivel").addClass("invisivel");
				$("#labelSelecionarMateriaisInclusao").removeClass("invisivel").addClass("visivel");
				
			}
			
		}
		
		function contadorTextArea(valor) {
		   
			quantidade = 200;
			
			total = valor.length;
			
			if(total <= quantidade) {
			   resto = quantidade- total;
			   document.getElementById('contador').innerHTML = resto;
			} else {
			   document.getElementById('observacao').value = valor.substr(0, quantidade);
			}

		}
		
		$(document).ready(function(){
			$('#quantidadeMaterial').setMask({mask:'99999'});
			$('#quantidadeEquipamento').setMask({mask:'99999'});
			
			$('#observacaoRemessaEstoque').limit('200');
			$('#observacaoRemessaEstoque').val('');
			
		});
		
	</script>
	
	<div class="conteinerValidacao">
		<ol style="color: #C00;">
		</ol>
	</div>
	
	<div class="cabecalho3">
		<div class="caminho" >
			<a class="linktres" title="<fmt:message key="label.home" />" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}"><fmt:message key="label.home" /></a>
			&gt;
			<a class="linktres" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC39/dv01"><fmt:message key="label.servicos" /></a>
			&gt;
			<a class="linkquatro" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC39/dv01">
				<strong><fmt:message key="label.solicitarNovoPedidoDeEstoque" /></strong>
			</a>
		</div>
		<strong><fmt:message key="label.solicitarNovoPedidoDeEstoque" /></strong>
	</div>
	
	<form id="formFinalizarPedido" method="post" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC39/dv01">
	
	</form>
	
	<table class="detalhe" cellspacing="0">
		<tbody>
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.equipamentos" /></th>
			</tr>
		</tbody>
	</table>
	
	<div class="div_inclusao_equipamento visivel" id="formInclusaoEquipamento">
	
		<div class="busca_cinza">
		
			<span class="text2"><fmt:message key="label.equipamento" />:</span>
			
			<select id="equipamento" name="equipamento">
				<option value=""><fmt:message key="label.selecione" /></option>
				<c:forEach var="equipamento" items="${equipamentos}">
					<c:if test="${not empty equipamento.identifier && not empty equipamento.value}">
						<option id="${equipamento.identifier}" value="${equipamento.value}">${equipamento.value}</option>
					</c:if>
				</c:forEach>
			</select>
			
			<span class="text2" style="margin-left: 5px;"><fmt:message key="label.quantidade" />:</span>
			<input id="quantidadeEquipamento" type="text" style="width: 40px;" maxlength="5" name="quantidadeEquipamento" />
			
			<span class="text2" style="margin-left: 5px;"><fmt:message key="label.operadora" />:</span>
			<select id="operadora" name="operadora">
				<option value=""><fmt:message key="label.selecione" /></option>
				<option value="1">Tim</option>
				<option value="2">Claro</option>
			</select>
			
		</div>
		
		<div class="bloco">
		
			<div class="celula">
				<div class="colunaLabel" style="background-color: #FAFAFA !important; width: 75px !important;">
					<label><fmt:message key="label.observacao" />:</label>
				</div>
				
				<div class="colunaInput" > 
					<textarea id="observacaoRemessaEstoque" 
							  name="observacaoRemessaEstoque"
							  class="text"
							  style="margin-left: 11px !important; resize: none;" 
							  rows="5"
							  onkeyup="contadorTextArea(this.value);"
							  cols="50">
					</textarea>
					
					<p style="margin-left: 10px; color: #666666;">
						<fmt:message key="label.restamCaracteresSeremDigitados"><fmt:param><span id="contador">200</span></fmt:param> </fmt:message> 
					</p>
					
				</div>
			</div>
			
			<div style="clear: both"></div>
		
		</div>
		
		<span>
			<input class="button" type="button" value="<fmt:message key="label.incluirEquipamento" />" style="margin-left: 100px;" onclick="incluirEquipamentoLista();" />
		</span>
	
	</div>
	
	<div style="clear:both;"></div>
	<br />
	
	<h1 class="invisivel labelInfoSolicitarPedidoEstoque" id="labelEquipamentosIncluidos"><fmt:message key="label.equipamentosPIncluidos" /></h1>
	<h1 class="visivel labelInfoSolicitarPedidoEstoque"   id="labelSelecionarEquipamentosInclusao" ><fmt:message key="mensagem.selecione.equipamentoAdicionarLista" /></h1>
	<h1 class="invisivel labelInfoSolicitarPedidoEstoque" id="labelEquipamentoNaoSelecionadoPedido"><fmt:message key="mensagem.informacao.nenhumEquipamentoSelecionadoPedido" /></h1>
	
	<div id="equipamentosIncluidos" class="invisivel">
		<table class="tabelaEquipamentos" id="alter" cellspacing="0" cellpadding="1" >
			<tbody>
				<tr>
					<th class="texttable_azul" width="20%" 	scope="col"><fmt:message key="label.equipamento" /></th>
					<th class="texttable_cinza" width="10%" scope="col"><fmt:message key="label.quantidade" /></th>
					<th class="texttable_cinza" width="10%" scope="col"><fmt:message key="label.operadora" /></th>
					<th class="texttable_cinza" width="45%" scope="col"><fmt:message key="label.observacao" /></th>
					<th class="texttable_cinza visivel colunaExcluir" width="15%" scope="col"><fmt:message key="label.excluirEquipamento" /></th>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div style="clear: both;"></div>
	<br />
	
	<table class="detalhe" cellspacing="0">
		<tbody>
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.materiais" /></th>
			</tr>
		</tbody>
	</table>
	
	<div class="busca_cinza visivel" id="formInclusaoMaterial" style="padding-left: 20px; width: 930px; padding-right: 10px;">
		<span class="text2" style="margin-left: 5px;">
			<span class="busca_cinza">
			
				<span class="text2" style="margin-left: 5px;"><fmt:message key="label.material" />:</span>
				
				<select id="material" name="material">
					<option value="">Selecione...</option>
					<c:forEach var="material" items="${materiais}">
						<c:if test="${not empty material.identifier && not empty material.value}">
							<option id="${material.identifier}" value="${material.value}">${material.value}</option>
						</c:if>
					</c:forEach>
				</select>
			
			</span>
			<fmt:message key="label.quantidade" />:
		</span>
		
		<input id="quantidadeMaterial" type="text" style="width: 40px;" maxlength="5" name="quantidadeMaterial" />
		
		
		<span>
			<input class="button" type="button" value="<fmt:message key="label.incluirMaterial" />" style="margin-left: 20px;" onclick="incluirMaterialLista();" />
		</span>
		
	</div>
	
	<div style="clear:both;"></div>
	<br />
	
	<h1 class="invisivel labelInfoSolicitarPedidoEstoque" id="labelMateriaisIncluidos"><fmt:message key="label.MateriaisPIncluidos" /></h1>
	<h1 class="visivel labelInfoSolicitarPedidoEstoque"   id="labelSelecionarMateriaisInclusao"><fmt:message key="mensagem.selecione.materialAdicionarLista" /></h1>
	<h1 class="invisivel labelInfoSolicitarPedidoEstoque" id="labelMaterialNaoSelecionadoPedido"><fmt:message key="mensagem.informacao.nenhumMaterialSelecionadoPedido" /></h1>
	
	<!-- INCLUIR AQUI HTML DE MATERIAIS INCLUIDOS -->
	<div id="materiaisIncluidos" class="invisivel">
		<table class="tabelaMateriais" id="alter" cellspacing="0" cellpadding="1" >
			<tbody>
				<tr>
					<th class="texttable_azul"  width="75%" scope="col"><fmt:message key="label.material" /></th>
					<th class="texttable_cinza" width="10%" scope="col"><fmt:message key="label.quantidade" /></th>
					<th class="texttable_cinza visivel colunaExcluir" width="15%" scope="col"><fmt:message key="label.excluirMaterial" /></th>
				</tr>
			</tbody>
		</table>
	</div>

	<div style="clear: both;"></div>
	<br />
		
	<!-- AO INICIALIZAR A TELA RENDERIZA O BOTAO CONTINUAR -->	
	<div id="divBtnContinuar" class="pgstabela visivel">
		<input id="btnContinuar" class="button" type="button" value="<fmt:message key="label.continuar" />" onclick="continuar();"/>
	</div>
	
	<!-- SERAO RENDERIZADOS APOS O USUARIO SELECIONAR A OPCAO CONTINUAR -->
	<div id="divBtnConfirmarPedido" 
		 class="pgstabela invisivel" 
		 style="*text-align:left;" >
		 
		<input id="btnVoltar" 
			   class="button3" 
			   value="<fmt:message key="label.voltar" />" 
			   type="button"
			   onclick="voltar();" />
			   
		<input id="btnConfirmarPedido" 
			   class="button"  
			   value="<fmt:message key="label.confirmarPedido" />" 
			   type="button" 
			   onclick="confirmarPedido();"
			   style="*margin-left:350px;" />
	
	</div>	
	
	
	<!-- DIV MODAL DV03 - TELA DE CONFIRMAÇÃO DE REALIZAÇÃO DE PEDIDO -->
	<div id="popupConfirmacaoPedido" style="display: none;"></div>