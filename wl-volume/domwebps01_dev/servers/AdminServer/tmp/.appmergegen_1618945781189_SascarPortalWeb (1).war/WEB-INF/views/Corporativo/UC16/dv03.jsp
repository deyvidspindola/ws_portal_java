<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

	<c:catch var="helper" >
		<c:import url="/VisualizarFaturasServlet/detalharFatura?acao=2" context="/SascarPortalWeb"  />
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


	<c:choose>
		<c:when test="${param.menu eq 1}">
			<c:set var="titulo"><fmt:message key="label.2ViaDeBoleto" /></c:set>
		</c:when>
		<c:when test="${param.menu eq 2}">
			<c:set var="titulo"><fmt:message key="label.2ViaNotaFiscal" /></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="titulo"><fmt:message key="label.consultas" /></c:set>			
		</c:otherwise>
	</c:choose>


	<script type="text/javascript">
		
		function validaUrlDanfe(url, mensagemDanfe){
			
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

	<div class="cabecalho">
		<div class="caminho">
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> 
			<a href="#" class="linktres">&gt; <fmt:message key="label.informacoes" /> &gt;</a>
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC16/dv01&menu=${param.menu}" class="linkquatro"> ${titulo}</a>
		</div>
		 ${titulo }
	</div>


		<table cellspacing="0" class="detalhe" >
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.detalheDaNF" /></th>
			</tr>
		</table>


		<table width="100%" cellspacing="3" class="detalhe2">
			<tr>
				<th width="200" class="barracinza"><fmt:message key="label.NomeCliente" /></th>
				<td width="350" class="camposinternos">${notaFiscal.nomeCliente}</td>
				<th width="200" class="barracinza"><fmt:message key="label.dataDeEmissao" /></th>
				<td width="350" class="camposinternos">
					<fmt:formatDate value="${notaFiscal.dataEmissao}" pattern="dd/MM/yyyy"/>
				</td>
			</tr>
			<tr>
				<th width="200"  class="barracinza"><fmt:message key="label.numeroDaNF" /></th>
				<td width="350" class="camposinternos">${notaFiscal.numeroReferencia}</td>
				<th width="200" class="barracinza"><fmt:message key="label.valorDaNF" /></th>
				<td width="350" class="camposinternos">
					<fmt:formatNumber value="${notaFiscal.valor}" type="currency"/>
				</td>
			</tr>
			<tr>					
				<th width="200" class="barracinza"><fmt:message key="label.serieDaNF" /></th>
				<td width="350" class="camposinternos">${notaFiscal.serie}</td>
				<th width="200" class="barracinza"><fmt:message key="label.impostosRetidos" /></th>
				<td width="350" class="camposinternos">
					<fmt:formatNumber value="${notaFiscal.impostosRetidos}" type="currency"/>
				</td>
			</tr>
			<tr>					
				<th  class="barracinza"><fmt:message key="label.naturezaDaOperacao" /></th>
				<td class="camposinternos">${notaFiscal.natureza}</td>
				<th class="barracinza"><fmt:message key="label.valorDoDesconto" /></th>
				<td class="camposinternos">
					<fmt:formatNumber value="${notaFiscal.desconto}" type="currency"/>
				</td>
			</tr>
		</table>


		<table cellspacing="0" class="detalhe" >
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.listaItensFaturadosNF" /></th>
			</tr>
		</table>


	<div class="hr"></div>
	
	
		<table cellspacing="0" width="70%" id="alter">
			<tr>
				<th width="15%" class="texttable_cinza"><fmt:message key="label.veiculo" /></th>
				<th width="50%" class="texttable_azul"><fmt:message key="label.itemFaturado" /></th>
				<th width="18%" class="texttable_cinza"><fmt:message key="label.valor" /></th>
			</tr>
			<c:forEach var="contrato" items="${contratos}" varStatus="contador">		
				<tr <c:if test="${contador.count % 2 != 0}">class="dif"</c:if>>
					<td class="camposinternos">${contrato.veiculo.placa}&nbsp;</td>
					<td class="linkazulescuro">${contrato.fatura.descricao }&nbsp;</td>
			        <td>
			        	<fmt:formatNumber value="${contrato.fatura.valor}" type="currency"/>&nbsp;
			        </td>
				</tr>
			</c:forEach>
		</table>
		

	<div class="pgstabela">
		<form action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC16/dv02" 
			  method="post">
			
			<input type="hidden" value="${param.menu}" name="menu"/>
			<input type="hidden" value="${param.numeroPlaca}" name="numeroPlaca"/>
			<input type="hidden" value="${param.dataVencimentoInicial}" name="dataVencimentoInicial"/>
			<input type="hidden" value="${param.dataVencimentoFinal}" name="dataVencimentoFinal"/>
			<input type="hidden" value="${param.dataEmissaoInicial}" name="dataEmissaoInicial"/>
			<input type="hidden" value="${param.dataEmissaoFinal}" name="dataEmissaoFinal"/>
			<input type="hidden" value="${param.pagina}" name="pagina"/>
			<input type="hidden" value="${param.opcaoBoleto1}" name="opcaoBoleto1"/>
			<input type="hidden" value="${param.opcaoBoleto2}" name="opcaoBoleto2"/>
			<input type="hidden" value="${param.opcaoBoleto3}" name="opcaoBoleto3"/>		
			<div class="pgstabela" style="*text-align:left;">
			
				<input type="submit" class="button3" value="<fmt:message key="label.voltar" />"/>
				
				<!-- VALIDAÇÃO PARA MOSTRAR A POPUP INFORMANDO AO USUARIO QUE A O WS NÃO RETORNOU A URL DA NOTA FISCAL TIPO DANFE -->
				<c:if test="${param.menu eq 2}">
				
					<c:choose>
										
						<c:when test="${notaFiscal.danfeNFE}">
								
							<input type="button" 
								   class="button" 
								   style="*margin-left:150px;" 
								   value="<fmt:message key="label.download2ViaDANFE" />" 
								   onclick="validaUrlDanfe('${notaFiscal.urlNotaFiscal}', '${notaFiscal.mensagemDanfe}');" />
						
						</c:when>
						
						<c:otherwise>
						
							<c:if test="${not empty notaFiscal.urlNotaFiscal}">
								<input type="button" 
									   class="button" 
									   style="*margin-left:150px;" 
									   value="<fmt:message key="label.imprimir2ViaNF" />" 
									   onclick="window.open('${notaFiscal.urlNotaFiscal }');"/>
							</c:if>
						
						</c:otherwise>
						
					</c:choose>	
				
				</c:if>
				
			</div>
		</form>
	</div>

	<div id="dialog_url_danfe_vazia" class="popup_maior" style="display: none;" >
		<div class="popup_maior_pergunta">
			
		</div>
		
		<div class="popup_maior_resposta">
			
		</div>
	</div>
