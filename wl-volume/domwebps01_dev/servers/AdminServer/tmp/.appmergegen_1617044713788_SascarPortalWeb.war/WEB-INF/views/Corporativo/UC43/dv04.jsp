<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper">
	<c:import url="/AgendarOrdemServico/consultarAgendaInstalador?acao=10" context="/SascarPortalWeb" />
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
	
	function ajustaPosicao(){
		
		// PEGANDO A REFERENCIA DA DIV DE MENSAGENS DE VALIDACAO
		var conteinerValidacao = $(".conteinerValidacao");
		
		// LIMPANDO AS MENSAGENS DE ERRO
		conteinerValidacao.find('li').remove();
		
		var arrHorariosSelecionados = new Array();
		var arrHorariosRepresentante = new Array();
		var arrValidaSelecaoAgendas = new Array();
		
		var horarioSelecionado = 0;
		var horariosSelecionados = 0;
		var codigoRepresentante = 0;
				
		// ITERANDO TODOS checkbox
		$("input[type='checkbox']").each( function() {
			
			// VALIDA SE O CHECKBOX EM QUESTAO ESTA SELECIONADO
			if($(this).is(':checked')){
				
				// RECUPERA O INDICE DO HORARIO SELECIONADO
				horarioSelecionado = Number($(this).attr('value'));
				codigoRepresentante = $(this).attr('name');
				
				// GUARDA TODOS OS HORARIOS SELECIONADOS
				arrHorariosSelecionados [horariosSelecionados] = horarioSelecionado;
				
				// ARRAY UTILIZADO PARA VALIDAR SELECAO HORARIOS EM MAIS DE UMA AGENDA
				arrValidaSelecaoAgendas [horariosSelecionados] = codigoRepresentante;
				
				horariosSelecionados ++;
				
			} 	
			
			// RECUPERA TODOS OS HORARIOS DO REPRESENTANTE
			if($(this).attr('name') == codigoRepresentante){
				arrHorariosRepresentante.push(Number($(this).val()));
			}
			
		}); 
	
		// VALIDA SE EXISTEM HORARIOS SELECIONADOS PARA MAIS DE UM INSTALADOR APENAS QUANDO FOREM SELECIONADOS 2 OU MAIS HORARIOS
		if(horariosSelecionados > 1){
		
			// RECUPERA O NUMERO TOTAL DE ELEMENTOS DO ARRAY ( HORARIOS SELECIONADOS )
			var totalHorariosSelecionados = arrHorariosSelecionados.length;
									
			var validaSelecaoAgendas = functionValidaSelecaoAgendas(arrValidaSelecaoAgendas);
										
			if(validaSelecaoAgendas){
				html = '<li><label><fmt:message key="mensagem.informacao.horariosMaisDeUmInstalador" /></label></li>';
				conteinerValidacao.find('ol').append(html);
			}else{
				
				arrHorariosSelecionados = ordenacao(arrHorariosSelecionados);
				arrHorariosRepresentante = ordenacao(arrHorariosRepresentante);
																
				// CAPTURA O INDICE DO PRIMEIRO E O ULTIMO HORARIO SELECIONADO
				var primeiroHorario = arrHorariosSelecionados[0];
				var ultimoHorario = arrHorariosSelecionados[totalHorariosSelecionados - 1];
				
				for ( var i = 0; i < arrHorariosRepresentante.length; i++) {
					if(arrHorariosRepresentante[i] >= primeiroHorario && arrHorariosRepresentante[i] <= ultimoHorario){
						$("#"+arrHorariosRepresentante[i]).attr("checked", "checked");
					}							
				}
								
			}
	
		}
	}
	
	// ALGORITIMO DE ORDENACAO 
	function ordenacao(array){
	
		for (var i = 0 ; i < array.length; i++){
			for (var j = 0; j < i; j++){
				if (array[i] < array[j]){
					var troca = array[i];
					array[i] = array[j];
					array[j] = troca;
				}
			}
		}  
		
		return array;
	}
	
	// FUNCAO UTILIZADA PARA VALIDAR SE FORAM SELECIONADOS HORARIOS DE AGENDA DIFERENTES
	function functionValidaSelecaoAgendas(arrValidaSelecaoAgendas){
						
		var codigoTeste = arrValidaSelecaoAgendas[0];
		var instaladorRepetido = false;
		
		for (var i = 0; i < arrValidaSelecaoAgendas.length; i++) {
			
			if(codigoTeste != arrValidaSelecaoAgendas[i]){
				instaladorRepetido = true;
			}
			
		}
		
		return instaladorRepetido;
		
	}
	
	function selecionaHorariosAgendamento(){
		
		// PEGANDO A REFERENCIA DA DIV DE MENSAGENS DE VALIDACAO
		var conteinerValidacao = $(".conteinerValidacao");
		
		// LIMPANDO AS MENSAGENS DE ERRO
		conteinerValidacao.find('li').remove();
		
		var arrHorariosSelecionados = new Array();
		var arrHorariosRepresentante = new Array();
		var arrValidaSelecaoAgendas = new Array();
		
		var horarioSelecionado = 0;
		var horariosSelecionados = 0;
		var codigoRepresentante = 0;
		
		var primeiroHorario = 0;
		var ultimoHorario = 0;
		
		var valuePrimeiroHorario = 0;
		var valueUltimoHorario = 0;
				
		// ITERANDO TODOS checkbox
		$("input[type='checkbox']").each( function() {
			
			// VALIDA SE O CHECKBOX EM QUESTAO ESTA SELECIONADO
			if($(this).is(':checked')){
				
				// RECUPERA O INDICE DO HORARIO SELECIONADO
				horarioSelecionado = Number($(this).attr('value'));
				codigoRepresentante = $(this).attr('name');
				
				// GUARDA TODOS OS HORARIOS SELECIONADOS
				arrHorariosSelecionados [horariosSelecionados] = horarioSelecionado;
				
				// ARRAY UTILIZADO PARA VALIDAR SELECAO HORARIOS EM MAIS DE UMA AGENDA
				arrValidaSelecaoAgendas [horariosSelecionados] = codigoRepresentante;
				
				horariosSelecionados ++;
				
			} 	
			
			// RECUPERA TODOS OS HORARIOS DO REPRESENTANTE
			if($(this).attr('name') == codigoRepresentante){
				arrHorariosRepresentante.push(Number($(this).val()));
			}
			
		}); 
		
		// VALIDA SE EXISTE MAIS DE UM HORARIO SELECIONADO
		if(horariosSelecionados > 1){
			
			// RECUPERA O NUMERO TOTAL DE ELEMENTOS DO ARRAY ( HORARIOS SELECIONADOS )
			var totalHorariosSelecionados = arrHorariosSelecionados.length;
									
			var validaSelecaoAgendas = functionValidaSelecaoAgendas(arrValidaSelecaoAgendas);
			
			if(validaSelecaoAgendas){
				html = '<li><label><fmt:message key="mensagem.informacao.horariosMaisDeUmInstalador" /></label></li>';
				conteinerValidacao.find('ol').append(html);
			}else{
				
				arrHorariosSelecionados = ordenacao(arrHorariosSelecionados);
				arrHorariosRepresentante = ordenacao(arrHorariosRepresentante);
																
				// CAPTURA O INDICE DO PRIMEIRO E O ULTIMO HORARIO SELECIONADO
				primeiroHorario = arrHorariosSelecionados[0];
				ultimoHorario = arrHorariosSelecionados[totalHorariosSelecionados - 1];
				
				// CAPTURA O VALOR DO PRIMEIRO E O ULTIMO HORARIO SELECIONADO
				valuePrimeiroHorario = $("#horarioSelecionado" + primeiroHorario).val();
				valueUltimoHorario = $("#horarioSelecionado" + ultimoHorario).val();
				
				// VALORES APRESENTADOS NA TELA
				$('input[name="horarioInicial"]').val(valuePrimeiroHorario);
				$('input[name="horarioFinal"]').val(valueUltimoHorario);
				
				// VALORES RECUPERADOS NA SERVLET
				$('input[name="horaInicioAgendamento"]').val(valuePrimeiroHorario);
				$('input[name="horaFimAgendamento"]').val(valueUltimoHorario);
				
				$("#observacaoAgendamentoRepresentante").removeAttr('readonly');

				$.closeOverlay();

				return false; 
				
			}
			
		/* VALIDACAO PARA EVITAR O PROCESSAMENTO DO SCRIPT QUANDO NENHUM HORARIO FOR SELECIONADO */
		}else if(horariosSelecionados != 0){
			
			// RECUPERA TODOS OS HORARIOS DO INSTALADOR
			var arrAux = new Array();
			
			$("input[type='checkbox']").each( function() {
				
				// RECUPERA TODOS OS HORARIOS DO REPRESENTANTE
				if($(this).attr('name') == codigoRepresentante){
					arrAux.push(Number($(this).val()));
				}
				
			}); 
			
			// ORDENA O ARRAY
			arrAux = ordenacao(arrAux);
			
			// O UNICO HORARIO SELECIONADO
			primeiroHorario = arrHorariosSelecionados[0];
			
			// RECUPERA NA LISTA DE HORARIOS DO INSTALADOR O INDICE DO PROXIMO HORARIO
			ultimoHorario = arrAux[primeiroHorario + 1];
			
			// CAPTURA O VALOR DO PRIMEIRO E O ULTIMO HORARIO SELECIONADO
			valuePrimeiroHorario = $("#horarioSelecionado" + primeiroHorario).val();
			
			/* VALIDACAO PARA SELECAO DE ULTIMO HORARIO DA AGENDA */
			if(primeiroHorario === 22){
				valueUltimoHorario = '18:30:00';
			}else{
				valueUltimoHorario = $("#horarioSelecionado" + ultimoHorario).val();
			}
			
			// VALORES APRESENTADOS NA TELA
			$('input[name="horarioInicial"]').val(valuePrimeiroHorario);
			$('input[name="horarioFinal"]').val(valueUltimoHorario);
			
			// VALORES RECUPERADOS NA SERVLET
			
			/* OBS.: POR SOLICITACAO DA ANALISTA QUANDO O USUARIO SELECIONAR APENAS UM HORARIO, DEVE SER MANDADO NO 
		             HORARIO INICIAL E FINAL DO WEBSERVICE O UNICO HORARIO SELECIONADO PELO USUARIO, POREM NA TELA APRESENTAR 2 HORARIOS
		          
		             EX.:
		            	 
		            	 - USUARIO SELECIONA APENAS 7:00
		            	 - NA TELA APRESENTA 7:00 E 7:30
		            	 - NO WEB SERVICE ENVIAR NOS CAMPOS HORA INICIO E HORA FIM APENAS 7:00.
		    
		    */
			$('input[name="horaInicioAgendamento"]').val(valuePrimeiroHorario);
			$('input[name="horaFimAgendamento"]').val(valuePrimeiroHorario);
			
			$("#observacaoAgendamentoRepresentante").removeAttr('readonly');
			
			$.closeOverlay();

			return false;   
			
		}else if(horariosSelecionados == 0){
			html = '<li><label><fmt:message key="mensagem.informacao.nenhumHorarioSelecionado" /></label></li>';
			conteinerValidacao.find('ol').append(html);
		}
	}
	
	$(document).ready(function(){
			
		// PEGANDO A REFERENCIA DA DIV DE MENSAGENS DE VALIDACAO
		var conteinerValidacao = $(".conteinerValidacao");
		
		// LIMPANDO AS MENSAGENS DE ERRO
		conteinerValidacao.find('li').remove();
		
		var container = $('div.container2');
		$("#formPopupAgendamento").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form) {
				selecionaHorariosAgendamento();
			}
		});
		
		$('#dataInicial').blur(function(){
			$(this).setMask('date');
		}).focus(function(){
			$(this).unsetMask();
		});
						
	});
	
		
</script>

	<form id="formPopupAgendamento" method="post" action="" >
	
		<div id="popup">
		
			<div id="popup_bordacima_grande"></div>
			
			<div id="popupinterior_popup_agendar_ordem_servico">
			
			<div class="conteinerValidacao">
				<ol style="color: #C00;">
				</ol>
			</div>
			
				<h3><fmt:message key="label.verifiqueDataHorarioDesejado" />:</h3>
				
				<label>
					<fmt:message key="label.dataAgendamento" />:
					<input id="dataInicial" class="" type="text" disabled="disabled" value="${param.dataAgenda}" name="dataInicial" style="80px;"/>
				</label>
			
				<!-- ABRE DIV BUSCA POPUP -->
				<div id="divbuscapopup" style="width: 870px; max-height: 420px; overflow: auto; margin-top:10px;">
				
					<!-- INICIO ITERACAO AGENDAS -->
					
					<c:forEach items="${agendas}" var="agenda" varStatus="status">
					
						<table class="popup" cellspacing="0" cellpadding="0px" border="0" width="850">
							<tbody>
								<tr>
								
									<th class="texttable_azul" 
										height="25" 
										width="20%"
										style="background-color: rgb(102, 153, 255); 
										color: rgb(255, 255, 255);" 
										colspan="3">
										<fmt:message key="label.instalador" />
									</th>
									
									<th class="texttable_cinza" 
										style="background-color: rgb(255, 255, 255); 
										text-align: left; 
										padding-left: 5px;" 
										width="80%"
										colspan="5">
										${agenda.nomeInstalador}
									</th>
								</tr>
								
								<tr>
									<th class="texttable_azul" width="22">&nbsp;</th>
									<th class="texttable_azul" width="43"><fmt:message key="label.horario" /></th>
									<th class="texttable_cinza" width="66"><fmt:message key="label.NumOS" /></th>
									<th class="texttable_cinza" width="85"><fmt:message key="label.statusOS" /></th>
									<th class="texttable_cinza" width="68"><fmt:message key="label.proposta" /></th>
									<th class="texttable_cinza" width="167"><fmt:message key="label.cliente" /></th>
									<th class="texttable_cinza" width="56"><fmt:message key="label.placa" /></th>
									<th class="texttable_cinza" width="193"><fmt:message key="label.endereco" /></th>
								</tr>
										
							</tbody>
							
							<tbody>
							
							<c:forEach items="${agenda.horariosAgendamentoOrdemServico}" var="horario" varStatus="statusHorario">
								<tr <c:if test="${statusHorario.count % 2 != 0 }">class="dif2"</c:if> >
									<td class="linkazulescuro">
										<input id="${statusHorario.index}" 
											<c:if test="${not horario.horarioDisponivel}">
											   disabled="disabled"
											 </c:if>
											   class="${agenda.codigoInstalador}" 
											   type="checkbox" 
											   value="${statusHorario.index}" 
											   name="${agenda.codigoInstalador}"
											   onclick="ajustaPosicao();" />
									</td>
									<td class="camposinternos2">
										<input type="hidden" 
											   id="horarioSelecionado${statusHorario.index}" 
											   name="${agenda.codigoInstalador}" 
											   value="<fmt:formatDate value="${horario.horarioAgendamento}" pattern="HH:mm:ss"/>" />
										<fmt:formatDate value="${horario.horarioAgendamento}" pattern="HH:mm:ss"/>
									</td>
									<td>${horario.numeroOrdemServico}</td>
									<td>${horario.statusOrdemServico}</td>
									<td>${horario.propostaAgendamento}</td>
									<td>${horario.clienteAgendamento}</td>
									<td>${horario.placaVeiculoAgendamento}</td>
									<td>${horario.enderecoServico}</td>
								</tr>
								
							</c:forEach>
							
							</tbody>
							
						</table>
						
					</c:forEach>
					
					<!-- FIM ITERACAO AGENDAS -->
					
				</div>
				<!-- FECHA DIV BUSCA POPUP -->
				
				<span>
					<label>
						<input class="button2 close" 
							   type="button" 
							   onclick="$.closeOverlay();" 
							   value="<fmt:message key="label.voltar" />" 
							   name="button4" />
					</label>
				</span>
				
				<span style="margin-left: 0px;">
					<label>
						<input class="button4" type="reset" value="<fmt:message key="label.limpar" />" name="button" />
					</label>
				</span>
				
				<label>
					<input class="button" 
						   type="submit" 
						   value="<fmt:message key="label.confirmar" />" 
						   name="button2" />
				</label>
				
			</div>
				
			<div id="popup_bordarodape_grande"></div>
			
		</div>

	</form>