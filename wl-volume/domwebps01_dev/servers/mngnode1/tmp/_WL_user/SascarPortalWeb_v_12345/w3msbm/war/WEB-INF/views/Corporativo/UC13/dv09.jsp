<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper">
	<c:import url="/AtivarEquipamentoTestes/consultarTestesProgramados?acao=8" context="/SascarPortalWeb"  />
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
	function submeterObservacao(form) {
		var data = $(form).serialize();
		
		var qtdeCaract = $("#observacao").val().length;
		if (qtdeCaract < 20) {
			$.showMessage('<fmt:message key="mensagem.informacao.peloMenos20Caracteres" />');
		}else{
		
			//configuracoes para tirar os caches - IE
		$.support.cors = true; //  cross-site scripting
        $.ajaxSetup({ cache: false }); 
		
		//Recupera defeitos conforme OS
		$.ajax({
				type: "POST",
				sync: false,
				crossDomain: true,
				url: "/SascarPortalWeb/AtivarEquipamentoTestes/submeterObservacao?acao=2",
				data: data || {},
				dataType:"json",
				success: function(json){
					if (json.success) {
						$("#observacao").val("");
						$("#dialog_mensagem .popup_padrao_pergunta").html('<fmt:message key="mensagem.sucesso.observacaoEnviada" />');
						$("#dialog_mensagem").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
					} else {
						$.showMessage(json.mensagem);
					}
				}
			});
		}
	}
	
	//Validar se redireciona para o formulário de laudo ou tela de conclusão de O.S
	function validaMotivoETipoEquipamento(){
		var gerarLaudo = "${equipamento.gerarLaudo}";
		if(gerarLaudo == "true"){
			$('#formConcluirTestes').attr('action', '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv14');
		}
		else{
			$('#formConcluirTestes').attr('action', '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv05');
		}
	
	}
	
	$(document).ready(function(){
	
		validaMotivoETipoEquipamento();
		
		$('#id-teste > div:gt(1)').bind('click', function(){
			
		});
		
		if ($("#observacao").length) {
			$('#observacao').limit('150','#charsLeft');
		}
	});
	
	function exibePopUpDependencia(descricaoTesteRealizado){
		
		var str = '<fmt:message key="uc13.dv09.texto.001.realizarOTeste"><fmt:param>' + descricaoTesteRealizado + '</fmt:param></fmt:message>';
		
		$("#testeDependencia").html(str);
		$("#dialog_mensagem_teste_dependencia").jOverlay({'onSuccess' : function(){
			
		}});
	}

</script>

	<!-- FORM VOLTAR TIPO EQUIPAMENTO CASCO 'S' -->
	<form method="post"	id="formVoltarTipoEquipamentoCasco"	action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv01">
		<input type="hidden" name="numeroOS"        value="${param.numeroOS}" />          
		<input type="hidden" name="numeroPlaca" 	value="${param.numeroPlaca}" />	
		<input type="hidden" name="motivo"			value="${param.motivo}" />	  
	</form>
	
	<!-- FORM VOLTAR TIPO EQUIPAMENTO CARGA  'C' -->
	<form method="post"	id="formVoltarTipoEquipamentoCarga"	action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv02">
		<input type="hidden" name="numeroOS"  		value="${param.numeroOS }" />        
		<input type="hidden" name="numeroPlaca" 	value="${param.numeroPlaca}" />		  
		<input type="hidden" name="origem" 			value="${param.origem}" />			 
		<input type="hidden" name="reiniciarTestes" value="${param.reiniciarTestes}" />	  
		<input type="hidden" name="numeroCPF" 		value="${param.numeroCPF }" />        
		<input type="hidden" name="tipoEquipamento" value="${param.tipoEquipamento }" /> 
		<input type="hidden" name="motivo"			value="${param.motivo}" />
	</form>
	
	<form id="formAtualizar" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv09" method="post">
		<input type="hidden" name="numeroOS"  		value="${param.numeroOS }" />        
		<input type="hidden" name="numeroPlaca" 	value="${param.numeroPlaca}" />		  
		<input type="hidden" name="origem" 			value="${param.origem}" />			 
		<input type="hidden" name="reiniciarTestes" value="${param.reiniciarTestes}" />	  
		<input type="hidden" name="numeroCPF" 		value="${param.numeroCPF }" />        
		<input type="hidden" name="tipoEquipamento" value="${param.tipoEquipamento }" />  
		<input type="hidden" name="numeroCPF_testeEquipamento" value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS_testeEquipamento" value="${param.numeroOS }" />
		<input type="hidden" name="motivo"			value="${param.motivo}" />
	</form>
	
	<!--  A action deste form, e inserida conforme o motivo da os e o tipo de equipamento. Verificacao no $(document).ready do javascript -->
	<form method="post" id="formConcluirTestes" action="">
		
		<input type="hidden" name="numeroOS"  		value="${param.numeroOS }" />        
		<input type="hidden" name="numeroPlaca" 	value="${param.numeroPlaca}" />		  
		<input type="hidden" name="origem" 			value="${param.origem}" />			 
		<input type="hidden" name="reiniciarTestes" value="${param.reiniciarTestes}" />	  
		<input type="hidden" name="numeroCPF" 		value="${param.numeroCPF }" />        
		<input type="hidden" name="tipoEquipamento" value="${param.tipoEquipamento }" />  
		<input type="hidden" name="numeroCPF_testeEquipamento" value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS_testeEquipamento" value="${param.numeroOS }" />
		<input type="hidden" name="motivo"			value="${param.motivo}" />
	
		<div class="principal">
			
			<div class="barraTituloPagina">
				<div class="textoTituloPagina"><fmt:message key="label.testesProgramados" /></div>
			</div>
			
			<c:if test="${not empty equipamento}">	
			<table cellspacing="0" class="detalhe" >
				<tr class="barraazulzinha">
					<th class="barraazulzinha"><fmt:message key="label.testeAtivacaoEquipamento" /></th>
				</tr>
			</table>
			
		    <table width="900" cellspacing="3" class="detalhe2">
		        <tbody>
		            <tr>
		            	<th width="200px" class="barracinza"><fmt:message key="label.dataHora" /></th>
		                <td width="350px" class="camposinternos">
		                	<fmt:formatDate value="${equipamento.dataHoraPosicao }" pattern="dd/MM/yyyy HH:mm"/>
		                </td>
		            	<th width="200px" class="barracinza"><fmt:message key="label.latitude" /></th>
		                <td width="350px" class="camposinternos">${equipamento.latitude }</td>
		            </tr>
		            <tr>
		            	<th width="200px" class="barracinza"><fmt:message key="label.longitude" /></th>
		                <td width="350px" class="camposinternos">${equipamento.longitude }</td>
		                <th width="200px" class="barracinza"><fmt:message key="label.endereco" /></th>
		                <td width="350px" class="camposinternos">${equipamento.descricaoEndereco }</td>
		            </tr>
		            <tr>
		                <th width="200px" class="barracinza"><fmt:message key="label.satelites" /></th>
		                <td width="350px" class="camposinternos">${equipamento.quantidadeSatelites }</td>
						<th width="200px" class="barracinza"><fmt:message key="label.hdop" /></th>
		                <td width="350px" class="camposinternos">${equipamento.hdop }</td>
		            </tr>
		            <tr>
		                <th width="200px" class="barracinza"><fmt:message key="label.velocidade" /></th>
		                <td width="350px" class="camposinternos">${equipamento.velocidade } km/h</td>
						<th width="200px" class="barracinza"><fmt:message key="label.tensao" /></th>
		                <td width="350px" class="camposinternos">${equipamento.tensao }</td>
		            </tr>
		            <tr>
		                <th width="200px" class="barracinza"><fmt:message key="label.ignicao" /></th>
		                <td width="350px" class="camposinternos">
		                	<img src="${pageContext.request.contextPath}/sascar/images/corporativo/bullet_${equipamento.statusIgnicao }.gif" alt="bullet" />
		                </td>
		                <th width="200px" class="barracinza"><fmt:message key="label.statusGps" /></th>
		                <td width="350px" class="camposinternos"><img src="${pageContext.request.contextPath}/sascar/images/corporativo/bullet_${equipamento.statusGPS }.gif" alt="bullet" /></td>
		            </tr>
		            <tr>
		                <th width="200px" class="barracinza"><fmt:message key="label.alimentacaoPrincipal" /></th>
		                <td width="350px" class="camposinternos">
		                	<img src="${pageContext.request.contextPath}/sascar/images/corporativo/bullet_${equipamento.statusAlimentacao }.gif" alt="bullet" />
		                </td>
		                <th width="200px" class="barracinza"><fmt:message key="label.statusPosicaoOnline" /></th>
		                <td width="350px" class="camposinternos">
		               		<img src="${pageContext.request.contextPath}/sascar/images/corporativo/bullet_${equipamento.statusPosicaoOnline }.gif" alt="${equipamento.statusPosicaoOnline }" title="Online - ${equipamento.statusPosicaoOnline }" />
		                </td>
		            </tr>
		            <tr>
		                <th width="200px" class="barracinza"><fmt:message key="label.statusPosicaoMemoria" /></th>
		                <td width="350px" class="camposinternos">
		                	<img src="${pageContext.request.contextPath}/sascar/images/corporativo/bullet_${equipamento.statusPosicaoMemoria }.gif" alt="${equipamento.statusPosicaoMemoria }" title="Memoria - ${equipamento.statusPosicaoMemoria }" />
		                </td>
		                <td></td>
		                <td></td>
		            </tr>
		        </tbody>
		    </table>
		    
		    <div class="pgstabela">
		        <input type="button" onclick="$('#formAtualizar').submit();"class="button" value="<fmt:message key="label.atualizar" />" />
		    </div>
		    
		    <div id="relato-box">
		        <div>
		        	<label class="text3" for="relato"><fmt:message key="mensagem.informacao.insiraInformacoesAlimentarHistContrato" /></label>
		        </div>
		        <div>
		        	<textarea name="observacao" id="observacao" class="text required"></textarea>
		        </div>
		     	<div class="charsLeft2">Resta(m) 
		     			<span id="charsLeft"></span>&nbsp;caracter(es).
		     	</div>
		     	<div class="pgstabela">
			        <input type="button" onclick="submeterObservacao('#formConcluirTestes');"class="button" value="<fmt:message key="label.enviarObservacao" />" />
				</div>
			    
		    </div>
		    
		    <div class="clear"></div>
		    </c:if>
	
			<c:forEach items="${grupos }" var="grupo">
				<div class="barraSubtitulos" style="margin-top: 15px">
					<div class="textoBarraSubtitulo">${grupo.descricao }</div>
				</div>
			
				<div class="resultadosTestes">
					<table width="750" border="0" cellpadding="0" cellspacing="0">
						<c:forEach items="${grupo.testes }" var="teste" varStatus="status">
		
							<c:set var="bgColor" value="#efefef"/>
							<c:if test="${status.count % 2 != 0 }">
								<c:set var="bgColor" value="#d8d8d8"/>
							</c:if>
		
							<tr style="background-color: ${bgColor}">
								<td width="80%" >${teste.nome}</td>
								
								<td width="15%" align="center">									
									<c:choose>
										<c:when test="${teste.exibePopUpRealizarTesteDep}">
											<!-- Exibe PopUp -->
												<a href="#" onclick="exibePopUpDependencia('${teste.descricaoTesteRealizado}')"><fmt:message key="label.realizarTeste" /></a>
										</c:when>
										<c:otherwise> 
											<!-- Não exibe PopUp - Condição Normal -->
											<c:choose>
												<c:when test="${teste.tipoTeste eq 'ET' }">
													<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv03&numeroCPF=${param.numeroCPF}&numeroOS=${param.numeroOS}&codigoTeste=${teste.codigo}&tipoEquipamento=${param.tipoEquipamento}&motivo=${param.motivo}&reiniciarTestes=${param.reiniciarTestes}&origem=${param.origem}&numeroPlaca=${param.numeroPlaca}&idTipoTeste=${teste.idTipoTeste}"><fmt:message key="label.realizarTeste" /></a>
												</c:when>
												<c:when test="${teste.tipoTeste eq 'RE' }">
													<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv03&numeroCPF=${param.numeroCPF}&numeroOS=${param.numeroOS}&codigoTeste=${teste.codigo}&tipoEquipamento=${param.tipoEquipamento}&motivo=${param.motivo}&reiniciarTestes=${param.reiniciarTestes}&origem=${param.origem}&numeroPlaca=${param.numeroPlaca}&idTipoTeste=${teste.idTipoTeste}"><fmt:message key="label.reconfigurar" /></a>
												</c:when>
											</c:choose>												
											<!--  -->
										</c:otherwise>
									</c:choose>									
								</td>
									<td width="5%">
									<c:choose>
										<c:when test="${teste.executado}">
											<img alt="" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/tick.png" class="imgCheckDelete" />					
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${teste.testeExecucao}">
													<img alt="" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/hourglass.png" class="imgCheckDelete" />
												</c:when>
												<c:otherwise>
													<img alt="" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/delete.png" class="imgCheckDelete" />
												</c:otherwise>
											</c:choose>											
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</c:forEach>
		
			<div style="text-align: center;">
				
				<c:choose>
					<c:when test="${param.tipoEquipamento eq 'S' }">
						<input type="button" class="button4" value="<fmt:message key="label.voltar" />" onclick="$('#formVoltarTipoEquipamentoCasco').submit();" />
					</c:when>
					<c:when test="${param.tipoEquipamento eq 'C'}">
						<input type="button" class="button4" value="<fmt:message key="label.voltar" />" onclick="$('#formVoltarTipoEquipamentoCarga').submit();" />
					</c:when>
				</c:choose>
				
				<c:if test="${testesRealizados }">
					<input type="submit" class="button" value="<fmt:message key="label.concluirTestes" />" />
				</c:if>
			</div>
		</div>

	</form>
	
	<div id="dialog_mensagem" class="popup_padrao" style="display: none;">
		<div class="popup_padrao_pergunta"></div>
		<div class="popup_padrao_resposta">
			<input type="button" class="button" value="Ok" onclick="javascript:$.closeOverlay();"/>
		</div>
	</div>
	
	<div id="dialog_mensagem_teste_dependencia" class="popup_padrao" style="display: none;">
		<div class="popup_padrao_pergunta">
			<div id="testeDependencia"></div>
		</div>
		<div class="popup_padrao_resposta">
			<input type="button" class="button" value="Ok" onclick="javascript:$.closeOverlay();"/>
		</div>
	</div>