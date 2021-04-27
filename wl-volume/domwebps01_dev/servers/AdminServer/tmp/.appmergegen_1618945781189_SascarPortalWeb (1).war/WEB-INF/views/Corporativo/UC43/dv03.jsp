<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper">
	<c:import url="/AgendarOrdemServico/validarPlacaOS?acao=12" context="/SascarPortalWeb" />
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


<style type="text/css">
.zona { display: none; }
</style>


<script type="text/javascript">

	function abrirBuscaAgenda() {

		// PEGANDO A REFERENCIA DA DIV DE MENSAGENS DE VALIDACAO
		var conteinerValidacao = $(".conteinerValidacao");
		
		// LIMPANDO AS MENSAGENS DE ERRO
		conteinerValidacao.find('li').remove();
		
		// VARIAVEL UTILIZADA PARA CONTROLAR A CHAMADA AJAX EM CASO DE ERRO DE VALIDACAO
		var erroValidacao = false;
		
		// PARAMETROS UTILIZADOS NA PESQUISA
		var paramLocalInstalacao = "";  
		var paramDataAgenda = "";  
		var paramCodigoInstaladorRepresentante = ""; 
		
		if($('#localInstalacao :selected').val() != ''){
			paramLocalInstalacao = $('#localInstalacao :selected').val();
		}
		
		if($('#instaladoresRepresentante :selected').val() != ''){
			paramCodigoInstaladorRepresentante = $('#instaladoresRepresentante :selected').val();
		}
		
		// VALIDANDO CAMPO DATA DA AGENDA
		if($("#dataAgenda").val() == ''){
			erroValidacao = true;
		    html = '<li><label><fmt:message key="mensagem.campoObrigatorio.dataAgenda" /></label></li>';
			conteinerValidacao.find('ol').append(html);
		}else{
			paramDataAgenda = $("#dataAgenda").val();
		}
		
		
		if(!erroValidacao){
				
			$.ajax({
				url : "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC43/dv04",
				data : {
					"localInstalacao" 		  		: paramLocalInstalacao,
					"dataAgenda" 			  		: paramDataAgenda,
					"codigoInstaladorRepresentante" : paramCodigoInstaladorRepresentante
				}, 
				dataType : "html",
				success : function(html) {
					$("#dialogBuscarAgenda").html(html).jOverlay({
						'closeOnEsc' : false,
						'bgClickToClose' : false,
						'css' : {
							'margin-left': -450 + 'px',
							'top' : 200 + 'px'
						}
					});
				}
			}); 
			
		}
		
	}

	function confirmarAgendamento(form){
		
		// PEGANDO A REFERENCIA DA DIV DE MENSAGENS DE VALIDACAO
		var conteinerValidacao = $(".conteinerValidacao");
		
		// LIMPANDO AS MENSAGENS DE ERRO
		conteinerValidacao.find('li').remove();
		
		// VARIAVEL UTILIZADA PARA CONTROLAR A CHAMADA AJAX EM CASO DE ERRO DE VALIDACAO
		var erroValidacao = false;
		
		if($('#localInstalacao :selected').val() == ''){
			erroValidacao = true;
		    html = '<li><label><fmt:message key="mensagem.campoObrigatorio.localInstalacao" /></label></li>';
			conteinerValidacao.find('ol').append(html);
		}
		
		if($('#instaladoresRepresentante :selected').val() == ''){
			erroValidacao = true;
		    html = '<li><label><fmt:message key="mensagem.campoObrigatorio.instalador" /></label></li>';
			conteinerValidacao.find('ol').append(html);
		}
		
		// VALIDANDO CAMPO DATA DA AGENDA
		if($("#dataAgenda").val() == ''){
			erroValidacao = true;
		    html = '<li><label><fmt:message key="mensagem.campoObrigatorio.dataAgenda" /></label></li>';
			conteinerValidacao.find('ol').append(html);
		}
		
		if($("#observacaoAgendamentoRepresentante").val() == ''){
			erroValidacao = true;
		    html = '<li><label><fmt:message key="mensagem.campoObrigatorio.observacao" /></label></li>';
			conteinerValidacao.find('ol').append(html);
		}
		
		if(!erroValidacao){
		
			var data = $(form).serialize();
			
			$.ajax({
				url: "/SascarPortalWeb/AgendarOrdemServico/submeterAgendamentoRepresentante?acao=11",
				data: data || {},
				dataType:"json",
				success: function(json){
					if (json.success) {
						
						var urlImpressaoOrdemServico = json.urlImpressaoOrdemServico;
						$("#urlImpressaoOrdemServico").val(urlImpressaoOrdemServico);
						
						showModalConfirmacaoAgendamento(form);
						
					} else {
						$(form).attr("action", "");
						$.showMessage(json.mensagem);
					}
				}
			});
			
		}
		
	}
	
	function showModalConfirmacaoAgendamento(form) {
		
		var data = $(form).serialize();
		
		$.ajax({
			url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC43/dv07",
			data: data || {
				"urlImpressaoOrdemServico" : $("#urlImpressaoOrdemServico").val()			
			},
			dataType:"html",
			success: function(html){
				$("#dialogRetorno").html(html).jOverlay({
					bgClickToClose : false, 
					closeOnEsc : false
				});
			}
		});
	}
	
	function contadorTextArea(valor) {
		   
		quantidade = 150;
		
		total = valor.length;
		
		if(total <= quantidade) {
		   resto = quantidade- total;
		   document.getElementById('contador').innerHTML = resto;
		} else {
		   document.getElementById('observacaoAgendamentoRepresentante').value = valor.substr(0, quantidade);
		}

	}
	
	$(document).ready(function() {
		
		$("#dataAgenda").datepicker({
			dateFormat: 'dd/mm/yy',
			changeMonth: true,
			changeYear: true
		});

		$('#dataAgenda').blur(function(){
			$(this).setMask('date');
		}).focus(function(){
			$(this).unsetMask();
		});
		
		$('#observacaoAgendamentoRepresentante').val('');
		$('#observacaoAgendamentoRepresentante').limit('150', '#charsLeft');
	});
		
</script>

	<div class="conteinerValidacao">
		<ol style="color: #C00;">
		</ol>
	</div>

	<jsp:useBean id="dataAtual" class="java.util.Date" scope="request" />
	<fmt:formatDate value="${dataAtual}" pattern="dd/MM/yyyy" var="dataAgenda"/>	

	<div class="cabecalho2">
		<div class="caminho" style="">
			<!--
			<a class="linktres" title="<fmt:message key="label.home" />" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}"><fmt:message key="label.home" /></a>
			&gt;
			<a class="linktres" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC43/dv01"><fmt:message key="label.servicos" /></a>
			&gt;
			<a class="linkquatro" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC43/dv01">
			<strong><fmt:message key="label.agendarAtendimento" /></strong>
			</a>
		-->
		</div>
		
		<strong><fmt:message key="label.agendarAtendimento" /></strong>
	</div>
	
	
	<p>
		<span class="titleagendar">
			<img hspace="5" height="20" align="absmiddle" width="8" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/Silver_Location.png">			
			<fmt:message key="uc43.dv03.texto.001.agendamentoParaVeiculo">
				<fmt:param><span class="text4">${param.placaAgendamento}</span></fmt:param>
			</fmt:message>
		</span>
	</p>
	
	<form id="formVoltar" 
		  method="post" 
		  action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC43/dv02" >
		  
		<input type="hidden" name="dataInicial" 		value="${param.dataInicial}" /> 
		<input type="hidden" name="dataFinal" 			value="${param.dataFinal}" /> 
		<input type="hidden" name="placa" 				value="${param.placa}" /> 
		<input type="hidden" name="chassi" 				value="${param.chassi}" /> 
		<input type="hidden" name="numeroOrdemServico"  value="${param.numeroOrdemServico}" /> 
		<input type="hidden" name="nomeCliente" 		value="${param.nomeCliente}" /> 
		<input type="hidden" name="tipoServico" 		value="${param.tipoServico}" /> 
	</form>
	
	<form id="formAgendamento" method="post" action="" >
		
		<input type="hidden" name="ordemServicoAgendamento"  value="${param.ordemServicoAgendamento}" /> 
		<input type="hidden" name="placaAgendamento" 		 value="${param.placaAgendamento}" />
		<input type="hidden" name="urlImpressaoOrdemServico" id="urlImpressaoOrdemServico" value="" />
		
		<input type="hidden" name="horaInicioAgendamento" id="horaInicioAgendamento" value="" />
		<input type="hidden" name="horaFimAgendamento"    id="horaFimAgendamento" value="" />
		
		
	
		<div id="agendarAtentimantoRepresentanteTecnico">
		
			<!-- EVITA A RENDENRIZACAO DA TABELA COM VEICULOS QUE APARECEM EM MAIS DE UMA ORDEM DE SERVICO CASO O WS 153 NAO RETORNE NENHUM RESULTADO -->
			<c:if test="${not empty listaOrdensServicoVeiculosVariasOrdemsServicosPendentes}">
			
				<span class="helpvermelho">
					<img hspace="5" height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/comment32.png">
					<fmt:message key="uc43.dv03.texto.002.placaPossuiOSPendente" />
				</span>
				
				
				<table id="alter" cellspacing="0" width="300px">
					<tbody>
						<tr>
							<th class="texttable_azul" width="26%"><fmt:message key="label.NumOS" /></th>
							<th class="texttable_cinza" width="11%"><fmt:message key="label.placa" /></th>
							<th class="texttable_cinza" width="11%"><fmt:message key="label.dataAbertura" /></th>
						</tr>
						
						<c:forEach var="ordemServico" items="${listaOrdensServicoVeiculosVariasOrdemsServicosPendentes}" varStatus="status">
							
							<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if> >
								<td class="linkazulescuro">${ordemServico.numero}</td>
								<td class="camposinternos">${ordemServico.contrato.veiculo.placa}</td>
								<td class="camposinternos"><fmt:formatDate value="${ordemServico.dataGeracao}" pattern="dd/MM/yyyy"/></td>
							</tr>
							
						</c:forEach>
						
					</tbody>
				</table>
				
			</c:if>
			
			
			<h2>
				<fmt:message key="uc43.dv03.texto.003.preenchaDadosAbaixo">
					<fmt:param>${param.ordemServicoAgendamento}</fmt:param>
				</fmt:message>
			</h2>
			
			<p>
				<label>
					<fmt:message key="label.localDoAtendimento" />:
					<select id="localInstalacao" name="localInstalacao">
						<option value=""><fmt:message key="label.selecione" /></option>
						<option value="C"><fmt:message key="label.endecoDefinidoCliente" /></option>
						<option value="R"><fmt:message key="label.enderecoRepresentante" /></option>
					</select>
				</label>
				<label>
					<fmt:message key="label.instalador" />:
					<select name="codigoInstaladorRepresentante" id="instaladoresRepresentante">
						<option value=""><fmt:message key="label.selecione" /></option>
						<c:forEach var="instalador" items="${instaladores}">
							<option value="${instalador.codigo}">${instalador.nome}</option>
						</c:forEach>
					</select>
					
				</label>
			</p>
			
			<p>
				<label>
					<fmt:message key="label.dataDaAgenda" />:
					<input type="text" 
						   maxlength="10" 
						   name="dataAgenda" 
						   id="dataAgenda" 
						   readonly="readonly"
						   value="${dataAgenda}"
						   class="required dataBR" 
						   style="*width:70px;" />
				</label>
			</p>
			
			<p>
				<label>
					<fmt:message key="label.buscarAgendaDia" />:
					<input class="button" 
						   type="button"
						   onclick="abrirBuscaAgenda();" 
						   value="<fmt:message key="label.buscar" />">
				</label>
			</p>
			
			
			<p>
				<label>
					<fmt:message key="label.horaInicio" />:
					<input id="horarioInicial" 
						   type="text" 
						   size="25" 
						   value="${param.horarioInicial}"
						   readonly="readonly" 
						   name="horarioInicial">
				</label>
				<label>
					<fmt:message key="label.horaFim" />:
					<input id="horarioFinal" 
						   type="text" 
						   size="25" 
						   value="${param.horarioFinal}"
						   readonly="readonly" 
						   name="horarioFinal">
				</label>
			</p>
			
			<p>
				<label>
					<fmt:message key="label.observacaoReferencia" />:
					<br>
					<span class="texthelp2">
						<br>
						<img height="16" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png">
						<fmt:message key="uc43.dv03.texto.004.informePontoReferenciaOuConsideracoes" />
					</span>
					
					<textarea id="observacaoAgendamentoRepresentante" 
							  name="observacaoAgendamentoRepresentante"
							  readonly="readonly" 
							  class="text" 
							  style="resize: none;"
							  onkeyup="contadorTextArea(this.value);"
							  rows="5" 
							  cols="45">
					</textarea>
					
					
				</label>
			</p>
			
			<p style="color: #666666;">				
				<fmt:message key="label.restamCaracteresSeremDigitados">
					<fmt:param><span id="contador">150</span></fmt:param>
				</fmt:message>
			</p>
			
			<br>
			
			<div id="botoesinferiores">
				<input id="button" 
					   class="button" 
					   type="button" 
					   value="<fmt:message key="label.agendar" />" 
					   name="button"
					   onclick="confirmarAgendamento('#formAgendamento');"/>
					   
				<input id="button2" class="button4" type="button" style="" value="<fmt:message key="label.limpar" />" name="button2" onclick="limparCampos('#formAgendamento');"/>
				
				<input class="button3" type="button" onclick="$('#formVoltar').submit();" style="" value="<fmt:message key="label.voltar" />" />
				
			</div>
			
		</div>
	
	</form>
	
	<div id="dialogBuscarAgenda" style="display: none; margin-top: 280px;"></div>
	
	<div id="dialogRetorno" style="display: none; margin-top: 280px;"></div>