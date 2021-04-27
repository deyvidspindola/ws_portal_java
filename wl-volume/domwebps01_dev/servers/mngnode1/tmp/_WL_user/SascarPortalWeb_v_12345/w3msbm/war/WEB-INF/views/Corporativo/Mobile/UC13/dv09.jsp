<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
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
						$("#dialog_mensagem").find('h4').html('<fmt:message key="mensagem.sucesso.observacaoEnviada" />');
						$("#dialog_mensagem").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
					} else {
						$.showMessage(json.mensagem);
					}
				}
			});
		}
	}
	
	$(document).ready(function(){
		if ($("#observacao").length) {
			$('#observacao').limit('150','#charsLeft');
		}
	});
	
	function atualizar(){
		document.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC13/dv09&numeroCPF=${param.numeroCPF }&numeroOS=${param.numeroOS }&tipoEquipamento=${param.tipoEquipamento }';
	}

</script>
	<form id="formPesquisa" method="get" action="${pageContext.request.contextPath}/Satellite" >
		
		<input type="hidden" name="pagename"      value="SascarPortal_Corporativo/Mobile/RepresentanteTecnico" /> 
		<input type="hidden" name="page"          value="Corporativo/Mobile/UC13/dv05" />
		
		<input type="hidden" name="numeroOS"  		value="${param.numeroOS }" />        
		<input type="hidden" name="numeroPlaca" 	value="${param.numeroPlaca}" />		  
		<input type="hidden" name="origem" 			value="${param.origem}" />			 
		<input type="hidden" name="reiniciarTestes" value="${param.reiniciarTestes}" />	  
		<input type="hidden" name="numeroCPF" 		value="${param.numeroCPF }" />        
		<input type="hidden" name="tipoEquipamento" value="${param.tipoEquipamento }" />  
		
		<h1><fmt:message key="label.testesProgramados" /></h1>
		
		<c:if test="${not empty equipamento}">	
			<div class="barraSubtitulos" style="margin-top: 15px">
				<table id="alter_extrato" width="100%" cellpadding="0" cellspacing="5" border="0" class="dados">
					<tr align="center">
						<th class="barraGruposTesteCarga" scope="col" colspan="5" ><fmt:message key="label.testeAtivacaoEquipamento" /></th>
					</tr>
				</table>
			</div>
			
			<fieldset>
			
				<div class="inputData"><fmt:message key="label.dataHora" /></div>
				<p class="font130" ><fmt:formatDate value="${equipamento.dataHoraPosicao }" pattern="dd/MM/yyyy HH:mm"/></p>
				
				<div class="inputData"><fmt:message key="label.latitude" /></div>
				<p class="font130">${equipamento.latitude }</p>
				
				<div class="inputData"><fmt:message key="label.longitude" /></div>
				<p class="font130">${equipamento.longitude }</p>
				
				<div class="inputData"><fmt:message key="label.endereco" /></div>
				<p class="font130">${equipamento.descricaoEndereco }</p>
				
				<div class="inputData"><fmt:message key="label.satelites" /></div>
				<p class="font130">${equipamento.quantidadeSatelites }</p>
				
				<div class="inputData"><fmt:message key="label.hdop" /></div>
				<p class="font130">${equipamento.hdop }</p>
	
				<div class="inputData"><fmt:message key="label.velocidade" /></div>
				<p class="font130">${equipamento.velocidade } km/h</p>
				
				<div class="inputData"><fmt:message key="label.tensao" /></div>
				<p class="font130">${equipamento.tensao }</p>
		
				<div class="inputData"><fmt:message key="label.ignicao" /></div>
				<p><img width="48" height="48" src="${pageContext.request.contextPath}/sascar/images/mobile/bullet_${equipamento.statusIgnicao }.png" alt="${equipamento.statusIgnicao }" title="${equipamento.statusIgnicao }" /></p>
		
				<div class="inputData"><fmt:message key="label.statusGps" /></div>
				<p><img width="48" height="48" src="${pageContext.request.contextPath}/sascar/images/mobile/bullet_${equipamento.statusGPS }.png" alt="${equipamento.statusGPS }" title="${equipamento.statusGPS }" /></p>
		
				<div class="inputData"><fmt:message key="label.alimentacaoPrincipal" /></div>
				<p><img width="48" height="48" src="${pageContext.request.contextPath}/sascar/images/mobile/bullet_${equipamento.statusAlimentacao }.png" alt="${equipamento.statusAlimentacao }" title="${equipamento.statusAlimentacao }" /></p>
		
				<div class="inputData"><fmt:message key="label.statusPosicaoMemoria" /></div>
				<p><img width="48" height="48" src="${pageContext.request.contextPath}/sascar/images/mobile/bullet_${equipamento.statusPosicaoMemoria }.png" alt="${equipamento.statusPosicaoMemoria }" title="${equipamento.statusPosicaoMemoria }" /></p>
		
				<div class="inputData"><fmt:message key="label.statusPosicaoOnline" /></div>
				<p><img width="48" height="48" src="${pageContext.request.contextPath}/sascar/images/mobile/bullet_${equipamento.statusPosicaoOnline }.png" alt="${equipamento.statusPosicaoOnline }" title="${equipamento.statusPosicaoOnline }" /></p>
		
				<p class="input" style="padding:10px; margin-top:10px; text-align: center;">
					<input type="button" onclick="atualizar();" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.atualizar" />" />
				</p>
		
		    	<p class="input">
					<label for="observacao">
						<span><fmt:message key="mensagem.informacao.insiraInformacoesAlimentarHistContrato" /></span><br />
						<textarea name="observacao" id="observacao" class="required" style="height: 250px;"></textarea>
					</label>
				</p>
				
				
				<h3><fmt:message key="label.restamCaracteresSeremDigitados"><fmt:param><span id="charsLeft"></span></fmt:param> </fmt:message> </h3>
	
				<p class="input" style="padding:10px; margin-top:10px; text-align: center;">
					<input class="aButton ui-state-default ui-corner-all"  value="<fmt:message key="label.enviarObservacao" />" type="button"  onclick="submeterObservacao('#formPesquisa');" />
				</p>
			</fieldset>
		</c:if>
	
		
		<c:forEach items="${grupos }" var="grupo">
				<div class="barraSubtitulos" style="margin-top: 15px">
					<table id="alter_extrato" width="100%" cellpadding="0" cellspacing="5" border="0" class="dados">
						<tr align="center">
							<th class="barraGruposTesteCarga" scope="col" colspan="5" >${grupo.descricao}</th>
						</tr>
					</table>
				</div>
			
				<div class="resultadosTestesMobile">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<c:forEach items="${grupo.testes }" var="teste" varStatus="status">
		
							<c:set var="bgColor" value="#efefef"/>
							<c:if test="${status.count % 2 != 0 }">
								<c:set var="bgColor" value="#d8d8d8"/>
							</c:if>
		
							<tr style="background-color: ${bgColor}">
								<td width="80%" >${teste.nome}</td>
								
								<td width="15%" align="center">
									<c:choose>
										<c:when test="${teste.tipoTeste eq 'ET' }">
											<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC13/dv03&numeroCPF=${param.numeroCPF}&numeroOS=${param.numeroOS}&codigoTeste=${teste.codigo}&tipoEquipamento=${param.tipoEquipamento}&reiniciarTestes=${param.reiniciarTestes}&origem=${param.origem}&numeroPlaca=${param.numeroPlaca}"><fmt:message key="label.realizarTeste" /></a>
										</c:when>
										<c:when test="${teste.tipoTeste eq 'RE' }">
											<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC13/dv03&numeroCPF=${param.numeroCPF}&numeroOS=${param.numeroOS}&codigoTeste=${teste.codigo}&tipoEquipamento=${param.tipoEquipamento}&reiniciarTestes=${param.reiniciarTestes}&origem=${param.origem}&numeroPlaca=${param.numeroPlaca}"><fmt:message key="label.reconfigurar" /></a>
										</c:when>
									</c:choose>
								</td>
									<td width="5%">
									<c:choose>
										<c:when test="${teste.executado }">
											<img alt="" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/tick.png" class="imgCheckDelete" />					
										</c:when>
										<c:otherwise>
											<img alt="" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/delete.png" class="imgCheckDelete" />
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</c:forEach>
			
			<c:if test="${testesRealizados}">
				<p class="input" style="padding:10px; margin-top:10px; text-align: center;">
					<input class="aButton ui-state-default ui-corner-all"  value="<fmt:message key="label.concluirTestes" />" type="submit"  />
				</p>
			</c:if>
	
	</form>
	
	<c:choose>
		<c:when test="${param.tipoEquipamento eq 'S' }">
			<jsp:include page="/WEB-INF/views/Corporativo/Mobile/icones.jsp">
				<jsp:param name="voltar" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC13/dv01&numeroCPF=${param.numeroCPF }&numeroOS=${param.numeroOS }&numeroPlaca=${param.numeroPlaca}"/>
			</jsp:include>
		</c:when>
		<c:when test="${param.tipoEquipamento eq 'C'}">
			<jsp:include page="/WEB-INF/views/Corporativo/Mobile/icones.jsp">
				<jsp:param name="voltar" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC13/dv02&numeroCPF=${param.numeroCPF }&numeroOS=${param.numeroOS }&numeroPlaca=${param.numeroPlaca}&origem=${param.origem}&reiniciarTestes=${param.reiniciarTestes}&tipoEquipamento=${param.tipoEquipamento}"/>
			</jsp:include>
		</c:when>
	</c:choose>
		
	
	<div id="dialog_mensagem" class="window modal" style="display: none;">
	<div class="topo"></div>
	<div class="middle">
		<h4></h4>
		<br />
		<table width="100%" cellspacing="0">
			<tr>
				<td width="99"></td>
				<td><a href="#fechar" title="Ok" onclick="javascript:$.closeOverlay();"><img src="${pageContext.request.contextPath}/sascar/images/corporativo/ico_voltar_modal.png" class="ico" align="left" alt="<fmt:message key="label.fechar" />" /> OK</a></td>
			</tr>
		</table>
	</div>
	<div class="bottom"></div>
</div>
	
	
	
	