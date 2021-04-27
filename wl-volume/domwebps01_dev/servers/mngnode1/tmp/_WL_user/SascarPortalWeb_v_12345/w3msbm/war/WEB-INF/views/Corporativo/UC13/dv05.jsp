<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/AtivarEquipamentoTestes/listarTestesExecutados?acao=5" context="/SascarPortalWeb"  />
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
	function finalizarTestes(form) {
	
		var bloquearPorFoto = $("#bloquearPorFoto").val();
			
		if(bloquearPorFoto == 'false'){
			var data = $(form).serialize();
			$.ajax({
				url: "/SascarPortalWeb/AtivarEquipamentoTestes/finalizarTestes?acao=6",
				data: data || {},
				dataType:"json",
				success: function(json){
											
					if (json.success) {											
						$("#dialog_mensagem").find('h4').html('<fmt:message key="mensagem.sucesso.efetuarOperacao" />');
						$("#dialog_mensagem").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});						
					}
					else
						{
						if(json.codigoErro == "445")
						{
						    //var motivo 	  = "${param.motivo}";
							//var equipamento = "${param.tipoEquipamento}" ;
							//Não fechar Os, pois motivo == "A" && (equipamento == "C" || equipamento == "S") 
							$("#dialog_mensagem2").find('strong').html(json.mensagem);
							$("#dialog_mensagem2").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
						}
						else{
							
							if(json.codigoErro == "252")
							{	//Refazer os testes
								$("#dialog_mensagem3").find('strong').html(json.mensagem);
								$("#dialog_mensagem3").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
							}
							else{
								$("#dialog_mensagem").find('h4').html(json.mensagem);
								$("#dialog_mensagem").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
							}
						}
					}
				}
			});
		}else {
			$(form).attr("action", "");
			$.showMessage('<fmt:message key="mensagem.informacao.envioFotoObrigatorio" />');
		}
	}
	
	function redirecionarFinalizarTestes(form){
		$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv01");
		$(form).unbind('submit').submit();
	}
	
	function redirecionarRefazerTestes(form){
		var motivo 		= "${param.motivo}";
		var equipamento = "${param.tipoEquipamento}";
		var login = "${SascarUser.login}";
		var acessoPiloto = ${SascarUser.acessoPiloto};
		
		if(motivo == "A" && equipamento == "C" ){
			if(acessoPiloto == true) {
				$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv09Piloto");
			} else {
				$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv09");
			}
		}
		else{
			$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv02");		
		}
		
		$(form).unbind('submit').submit();
	}	

	$(document).ready(function(){
		$("#formTesteEquipamento").submit(function(){
			finalizarTestes(this);
			return false;
		});
	});
</script>

	<!-- FORM VOLTAR -->
	<form method="post" id="formVoltar" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv04">
		<input type="hidden" name="numeroCPF" 	value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS" 	value="${param.numeroOS }" />
		<input type="hidden" name="codigoTeste" value="${param.codigoTeste }" />
		<input type="hidden" name="indiceTeste" value="${param.indiceTeste }" />
		<input type="hidden" name="numeroPlaca" value="${param.numeroPlaca}" />		  
		<input type="hidden" name="origem" 		value="${param.origem}" />
		<input type="hidden" name="motivo"			value="${param.motivo}" />
	</form>
	
	<!-- FORM REEXECUTAR -->
	<form name="formReexecutar" id="formReexecutar" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv02" method="post" class="filtro">
		<input type="hidden" name="numeroCPF"       value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS"        value="${param.numeroOS }" />
		<input type="hidden" name="numeroPlaca" 	value="${param.numeroPlaca}" />		  
		<input type="hidden" name="origem" 			value="${param.origem}" />
		<input type="hidden" name="reiniciarTestes" value="S" />
		<input type="hidden" name="motivo"			value="${param.motivo}" />
		<input type="hidden" name="tipoEquipamento"	value="${param.tipoEquipamento}" />
	</form>

	<div class="cabecalho3">
		<fmt:message key="label.testesAtivacaoEquipamento" />
		<div class="caminho3" style="*margin-left:100px;">
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a>&gt; 
			<a href="#" class="linktres"><fmt:message key="label.informacoes" /></a> &gt; 
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC13/dv01"  class="linkquatro"><fmt:message key="label.testesAtivacaoEquipamento" /></a>
		</div>
	</div>

	<table cellspacing="0" class="detalhe" >
		<tr class="barraazulzinha">
			<th class="barraazulzinha"><fmt:message key="label.testeAtivacaoEquipamento" /></th>
		</tr>
	</table>

	<form name="formTesteEquipamento" id="formTesteEquipamento" action="" method="post" class="filtro">
		<input type="hidden" name="numeroCPF_testeEquipamento" value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS_testeEquipamento" value="${param.numeroOS }" />
		<input type="hidden" id="bloquearPorFoto" name="bloquearPorFoto" value="${equipamento.bloquearPorFoto }" />
	
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
	
	
	 	<c:if test="${not empty testes }">
			<table cellspacing="0" class="detalhe" >
				<tr class="barraazulzinha">
					<th class="barraazulzinha"><fmt:message key="label.testesAutomaticos" /></th>
				</tr>
			</table>
			
			
			<table cellspacing="0" width="70%" ID="alter">
			     <tbody>
			         <tr>
			             <th  width="30%"class="texttable_azul"><fmt:message key="label.descricao" /></th>
			             <th  width="30%" class="texttable_cinza"><fmt:message key="label.resultadoDoTeste" /></th>
			         </tr>
			         <c:forEach items="${testes }" var="teste">
				         <tr>
				             <td class="camposinternos">${teste.nome }</td>
				             <td class="camposinternos">${teste.resultado }</td>
				         </tr>
				     </c:forEach>
			     </tbody>
			</table>
	 	</c:if>
	
		 <div class="pgstabela">
		 	<!-- <input type="button" onclick="$('#formVoltar').submit();" value="Voltar" class="button4" /> -->
			<input type="button" onclick="$('#formReexecutar').submit();" class="button4" value="<fmt:message key="label.reexecutarTestes" />" />
			<input type="submit" class="button" value="<fmt:message key="label.concluir" />" />
		 </div>
	</form>

	<div id="dialog_mensagem" class="popup_padrao" style="display: none;">
		<div class="popup_padrao_resposta">
			<h4>${mensagem }</h4>
		</div>
		<div class="popup_padrao_resposta_concluir_testes">
			<input type="button" class="button close" value="<fmt:message key="label.concluir" />" onclick="redirecionarFinalizarTestes('#formTesteEquipamento');"/>
		</div>
	</div>

	
	<div id="dialog_mensagem2" class="popup_padrao" style="display: none;">
		<div class="popup_padrao_resposta3">
			<span>
				<strong></strong>
			</span>
		</div>
		<div style="margin-top: 5px;" class="popup_padrao_resposta_concluir_testes">
			<input type="button" class="button close" value="<fmt:message key="label.concluir" />" onclick="redirecionarFinalizarTestes('#formTesteEquipamento');"/>
		</div>
	</div>

	<div id="dialog_mensagem3" class="popup_padrao" style="display: none;">
		<div class="popup_padrao_resposta3">
			<span>
				<strong></strong>
			</span>
		</div>
		<div style="margin-top: 5px;" class="popup_padrao_resposta_concluir_testes">
			<input type="button" class="button close" value="<fmt:message key="label.reexecutarTestes" />" onclick="redirecionarRefazerTestes('#formReexecutar');"/>
		</div>
	</div>