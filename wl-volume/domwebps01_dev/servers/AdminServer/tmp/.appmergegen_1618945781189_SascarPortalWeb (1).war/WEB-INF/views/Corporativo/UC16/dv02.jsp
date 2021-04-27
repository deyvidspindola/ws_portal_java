<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/VisualizarFaturasServlet/pesquisarNotasFiscais?acao=1" context="/SascarPortalWeb"  />
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

	function validarDataBoleto(diasVencido, url, classeContrato, codigoMensagemBoleto, mensagemBoleto, valor, codigoFormaPagamento, codigoRegistrarBoleto){
				
		/*if (codigoFormaPagamento !== "84" && codigoRegistrarBoleto == 1) {
			var onclick = "javascript:$.closeOverlay();";
			var html = '<input type="button" class="button" value="OK" onclick="'+onclick+'" />';
			$("#dialog_mensagem_boleto .popup_maior_pergunta").html("Solicite o boleto registrado atrav\u00E9s do telefone 0800 648 6004");
			$("#dialog_mensagem_boleto .popup_maior_resposta").html(html);
			$("#dialog_mensagem_boleto").jOverlay();
		} else {*/
			if (codigoMensagemBoleto == 1) {
					var onclick = "javascript:$.closeOverlay();";
					var html = '<input type="button" class="button" value="OK" onclick="'+onclick+'" />';
					$("#dialog_mensagem_boleto .popup_maior_pergunta").html(mensagemBoleto);
					$("#dialog_mensagem_boleto .popup_maior_resposta").html(html);
					$("#dialog_mensagem_boleto").jOverlay();
			} else {
				//E2.  	Boleto com data de vencimento anterior a data atual                          
				if(diasVencido > 0){
					
					if((diasVencido > 30) && (classeContrato.toLowerCase() == "siggo seguro"))
					{
						var onclick = "javascript:$.closeOverlay();";
						var html = '<input type="button" class="button" value="OK" onclick="'+onclick+'" />';
						$("#dialog_siggo_mais_de_30_dias_atraso .popup_maior_resposta").html(html);
						$("#dialog_siggo_mais_de_30_dias_atraso").jOverlay(); 
					}
					else
					{
						//Só Mostra a mensagem para boletos diferentes de Santander
						if (codigoFormaPagamento !== "84"){
							var onclick = "javascript:$.closeOverlay(); window.open('"+url+"','_blank')";
							var html = '<input type="button" class="button" value="OK" onclick="'+onclick+'" />';
							$("#dialog_confirm .popup_maior_resposta").html(html);
							$("#dialog_confirm").jOverlay(); 
						} else {
							window.open(url,'_blank');
						}
					}
				}else{
					window.open(url, '_blank'); 
					/* REMOCAO PARA O AMBIENTE DE HOMOLOGACO */
					enviarHistorico();
			     }		
			}
		//}
			
		  //Mandar para url
		  
		
	}

	
	function enviarHistorico(){
		
		//Gravar no histórico
		var itemMenu = '${param.menu}';
		
	    $.ajax({
	      "url": "/SascarPortalWeb/VisualizarFaturasServlet/submeteHistoricoImpressaoFaturas?acao=3",
		  "data":  {"itemMenu" : itemMenu},
		  "dataType":"json",				   
		  type:"POST"
  
        });	
	}
	
	function validaUrlDanfe(url, mensagemDanfe){
		
		/* REMOCAO PARA O AMBIENTE DE HOMOLOGACO */
		
		enviarHistorico();
 		
		if(url == ''){
			
			var onclick = "javascript:$.closeOverlay();";
			
			/* INSERINDO O BOTAO PARA FECHAR A POPUP */
			var html = '<input type="button" class="button" value="OK" onclick="'+onclick+'" />';
			$("#dialog_url_danfe_vazia .popup_maior_resposta").html(html);
		
			/* RECUPERANDO MENSAGEM DE AVISOD E URL DE IMPRESSAO DE DANFE VAZIA E INSERINDO NA POPUP */
			var htmlMensagemDanfe = '<p>'+ mensagemDanfe +'</p>';
			$("#dialog_url_danfe_vazia .popup_maior_pergunta").html(htmlMensagemDanfe);
			
			$("#dialog_url_danfe_vazia").jOverlay(); 
			
		}else{
						
			//Mandar para url
			window.open(url, '_blank');
			
		}
		
	}
	
</script>

	<jsp:include page="/WEB-INF/views/Corporativo/UC16/dv01.jsp"/>

	<c:if test="${not empty notasFiscais}" >
	
		<h1><fmt:message key="label.resultadoDaBusca" /></h1>
		
		<table width="850px" cellpadding="1px" ID="alter" cellspacing="0px" style="*border-collapse:collapse">
			<tr>
				<th width="80" class="texttable_azul" scope="col"><fmt:message key="label.numDaNota" /></th>
				<th width="44" class="texttable_cinza" scope="col"><fmt:message key="label.serie" /></th>
				<th width="85" class="texttable_azul" scope="col"><fmt:message key="label.naturezaDaOperacao" /></th>
				<th width="50" class="texttable_cinza" scope="col"><fmt:message key="label.valor" /></th>
				<th width="50" class="texttable_azul" scope="col"><fmt:message key="label.desconto" /></th>
				<th width="50" class="texttable_cinza" scope="col"><fmt:message key="label.impostosRetidos" /></th>
				<th width="100" class="texttable_azul" scope="col"><fmt:message key="label.dataDeVencimento" /></th>
				<th width="57" class="texttable_cinza" scope="col"><fmt:message key="label.Status" /></th>
				<th width="100" class="texttable_azul" scope="col"><fmt:message key="label.dataDePagamento" /></th>
				<th width="148" class="texttable_cinza" scope="col"><fmt:message key="label.formaDePagamento" /></th>
				<c:if test="${param.menu eq 1}">
					<th width="64" class="texttable_azul" scope="col"><fmt:message key="label.impressao2ViaBoleto" /></th>
				</c:if>
				<c:if test="${param.menu eq 2}">
					<th width="64" class="texttable_azul" scope="col"><fmt:message key="label.impressao2ViaNotaFDanfe" /></th>
				</c:if>
			</tr>
			<c:forEach items="${notasFiscais}" var="notaFiscal"  varStatus="contador">
				<tr <c:if test="${contador.count % 2 != 0 }">class="dif"</c:if>>
					<td>
						<form style="display: inline;" id="formNext_${notaFiscal.numeroReferencia }" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC16/dv03" method="post">
							<input type="hidden" value="${param.menu}" name="menu" />
							<input type="hidden" value="${param.numeroPlaca}" name="numeroPlaca" />
							<input type="hidden" value="${param.dataVencimentoInicial}" name="dataVencimentoInicial" />
							<input type="hidden" value="${param.dataVencimentoFinal}" name="dataVencimentoFinal" />
							<input type="hidden" value="${param.dataEmissaoInicial}" name="dataEmissaoInicial" />
							<input type="hidden" value="${param.dataEmissaoFinal}" name="dataEmissaoFinal" />
							<input type="hidden" value="${param.pagina}" name="pagina" />
							<input type="hidden" value="${notaFiscal.numeroReferencia}" name="numeroReferencia" />
							<input type="hidden" value="${notaFiscal.serie}" name="serieNota" />
							<input type="hidden" value="${param.dataEmissaoFinal}" name="dataEmissaoFinal" />
							<input type="hidden" value="${param.opcaoBoleto1}" name="opcaoBoleto1"/>
			                <input type="hidden" value="${param.opcaoBoleto2}" name="opcaoBoleto2"/>
			                <input type="hidden" value="${param.opcaoBoleto3}" name="opcaoBoleto3"/>	
								<a href="#" title="<fmt:message key="label.cliqueVerDetalhaNF" />." class="linkcinco tooltip" onclick="$('#formNext_${notaFiscal.numeroReferencia }').submit();">${notaFiscal.numeroReferencia }</a>
						</form>
						&nbsp;
					</td>
					<td>${notaFiscal.serie }&nbsp;</td>
					<td class="linkazulescuro">${notaFiscal.natureza }&nbsp;</td>
					<td nowrap="nowrap">
						<fmt:formatNumber value="${notaFiscal.valor }" type="currency"/>&nbsp;
					</td>
					<td class="linkazulescuro">
						<fmt:formatNumber value="${notaFiscal.desconto }" type="currency"/>&nbsp;
					</td>
					<td>
						<fmt:formatNumber value="${notaFiscal.impostosRetidos }" type="currency"/>&nbsp;
					</td>
					<td class="linkazulescuro">
						<fmt:formatDate value="${notaFiscal.dataVencimento }" pattern="dd/MM/yyyy"/>
					</td>
					<td>${notaFiscal.status }&nbsp;</td>
					<td class="linkazulescuro">
						<fmt:formatDate value="${notaFiscal.dataPagamento }" pattern="dd/MM/yyyy"/>
					</td>
					<td>${notaFiscal.formaPagamento }&nbsp;</td>
								
					<c:if test="${param.menu eq 1 or param.menu eq 2}">
						<td nowrap="nowrap" class="linkazulescuro">
							<c:if test="${not empty notaFiscal.urlBoleto}">
								 <a class="tooltip" 
								 	href="#" 
								 	onclick="validarDataBoleto('${notaFiscal.diasVencido}' , '${notaFiscal.urlBoleto }', '${notaFiscal.classeContrato }', '${notaFiscal.codigoMensagemBoleto}', '${notaFiscal.mensagemBoleto}', '${notaFiscal.valor}', '${notaFiscal.codigoFormaPagamento}', '${notaFiscal.codigoRegistrarBoleto}');" 
								 	title="<fmt:message key="label.cliqueImprimir2viaBoleto" />">
									
									<img border="0" 
										 src="${pageContext.request.contextPath}/sascar/images/corporativo_new/1304528228_monotone_printer_hardware.png"  
										 width="24" 
										 height="24" 
										 align="absmiddle" 
										 hspace="5" 
										 alt="<fmt:message key="label.emitirBoleto" />">
								
								</a>
							</c:if>
							
						    <!-- VALIDAÇÃO PARA MOSTRAR A POPUP INFORMANDO AO USUARIO QUE A O WS NÃO RETORNOU A URL DA NOTA FISCAL TIPO DANFE -->
							<c:if test="${param.menu eq 2}">
							
								<c:choose>
									
									<c:when test="${notaFiscal.danfeNFE eq 'true'}">
									
										<a class="tooltip" 
										   href="#" 
										   onclick="validaUrlDanfe('${notaFiscal.urlNotaFiscal}', '${notaFiscal.mensagemDanfe}');" 
										   title="<fmt:message key="label.cliqueImprimir2viaBoleto" />">
											
											<img border="0" 
												 src="${pageContext.request.contextPath}/sascar/images/corporativo_new/1304528228_monotone_printer_hardware.png"  
												 width="24" 
												 height="24" 
												 align="absmiddle" 
												 hspace="5" 
												 alt="<fmt:message key="label.emitirBoleto" />">
										
										</a>
									
									</c:when>
									
									<c:otherwise>
									
										<c:if test="${not empty notaFiscal.urlNotaFiscal}">
											<a target="_blank" 
											   class="tooltip" 
										   	   href="${notaFiscal.urlNotaFiscal }" 
											   title="<fmt:message key="label.cliqueImprimir2ViaNF" />">
												<img border="0" 
													 src="${pageContext.request.contextPath}/sascar/images/corporativo_new/1304528228_monotone_printer_hardware.png" 
													 width="24" 
													 height="24" 
													 align="absmiddle" 
													 hspace="5" alt="<fmt:message key="label.2viaFatura" />">
											</a>
										</c:if>
									
									</c:otherwise>
									
								</c:choose>
								
							</c:if>
							
						</td>
					</c:if>
					
				</tr>
			</c:forEach>
		</table>
		
		
		<jsp:include page="/WEB-INF/views/paginacao.jsp">
			<jsp:param name="pagina" value="${paginacao.paginaAtual}"/>
			<jsp:param name="totalPaginas" value="${paginacao.totalPaginas}"/>
			<jsp:param name="formName" value="formPesquisa"/>
			<jsp:param name="url" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC16/dv02"/>
		</jsp:include>
		
		<jsp:include page="/WEB-INF/views/icones.jsp">
			<jsp:param name="novabusca" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC16/dv01"/>
		</jsp:include>
	</c:if>


	<div id="dialog_confirm" class="popup_maior" style="display: none;" >
		<div class="popup_maior_pergunta"><fmt:message key="uc16.dv02.texto.001.boletoAtualizado" /></div>
		<div class="popup_maior_resposta">
			
		</div>
	</div>
	
	<div id="dialog_mensagem_boleto" class="popup_maior" style="display: none;" >
		<div class="popup_maior_pergunta">
		
		</div>
		<div class="popup_maior_resposta">
			
		</div>
	</div>

	<div id="dialog_siggo_mais_de_30_dias_atraso" class="popup_maior" style="display: none;" >
		<div class="popup_maior_pergunta"><fmt:message key="uc16.dv02.texto.002.contratoPossuiFaturaEmAberto" /></div>
		<div class="popup_maior_resposta">
			
		</div>
	</div>
	
	<div id="dialog_url_danfe_vazia" class="popup_maior" style="display: none;" >
		<div class="popup_maior_pergunta">
			
		</div>
		
		<div class="popup_maior_resposta">
			
		</div>
	</div>	
