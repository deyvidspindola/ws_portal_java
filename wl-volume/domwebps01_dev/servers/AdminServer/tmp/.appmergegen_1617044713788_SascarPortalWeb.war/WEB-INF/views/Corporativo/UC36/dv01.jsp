<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/ConsultarPendenciasUsuario/carregarInformacoesTela?acao=1" context="/SascarPortalWeb"  />
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
	
	function showModalSaibaMais(){
		$.ajax({
			url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC36/dv06",
			dataType:"html",
			success: function(html){
				$("#popupSaibaMais").html(html).jOverlay({
					bgClickToClose : false, 
					closeOnEsc : false
				});
			}
		});
	}
		
</script>

	<div class="cabecalho">
		<fmt:message key="label.verHistoricoPendencias" />   
		<div class="caminho" style="">
			<a class="linktres" title="<fmt:message key="label.home" />" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}"><fmt:message key="label.home" /></a>
			&gt;
			<a class="linkquatro" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC36/dv01"><fmt:message key="label.verHistoricoPendencias" /></a>
		</div>
	</div>
	
	<div class="busca_branca">
		<span class="text1"><fmt:message key="label.resuladoOpcaoDetalhemtno" />:</span>
		<span class="texthelp2" style="">
			<img hspace="5" height="16" align="absmiddle" width="16" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" />
			<fmt:message key="label.vcMaisInformacoesBtnVerDeatalhes" />
		</span>
	</div>
	
	<div class="containerPendencias">
	
		<form id="formDetalharInformacoes" method="post" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC36/dv03">
			<input type="hidden" name="tipoConsulta" value="I" />
			
			<div class="pendencias">
				<div class="pendencias_bordacima">					
					<fmt:message key="label.informacoes" />
					<br>
					<span class="text_dias">
					
					</span>
				</div>
				
				<div class="pendenciasinterior">
					
					<c:forEach var="pendencias" items="${historicoPendencias}">
						<c:if test="${pendencias.tipoPendencia eq 'I'}">
							<c:choose>
								<c:when test="${pendencias.quantidadePendencias eq 0}">
									<span style="color: #0099FF; font-size: 12px; font-weight: bold;">${pendencias.quantidadePendencias}</span>
										${pendencias.descricao}
									<br>
								</c:when>
								<c:otherwise>
									<span style="color: #CC0000; font-size: 12px; font-weight: bold;">${pendencias.quantidadePendencias}</span>
										${pendencias.descricao}
									<br>
								</c:otherwise>
							</c:choose>
						</c:if>
					</c:forEach>
				
					<div class="pendencias_botao" style="">
						<input class="button" type="submit" value="<fmt:message key="label.verDetalhe" /> >" />
					</div>
				</div>
				
				<div class="pendencias_bordarodape"></div>
			</div>
		</form>
		
 		
<div id="formDetalharServicos">			<input type="hidden" name="tipoConsulta" value="S" />
			
			<div class="pendencias">
				<div class="pendencias_bordacima">
					<fmt:message key="label.servicos"  />
					<br>
					<span class="text_dias">
						<img height="26" align="absmiddle" width="21" src="${pageContext.request.contextPath}/sascar/images/corporativo_new/Black_5_Bars.png">
						<fmt:message key="uc36.texto.01.ultimosDias" />
					</span>
				</div>
				
				<div class="pendenciasinterior">
					
					<c:forEach var="pendencias" items="${historicoPendencias}">
						<c:if test="${pendencias.tipoPendencia eq 'S' and pendencias.descricao ne 'Direcionamento de Sinal'}">
							<c:choose>
								<c:when test="${pendencias.quantidadePendencias eq 0}">
									<span style="color: #0099FF; font-size: 12px; font-weight: bold;">${pendencias.quantidadePendencias}</span>
										${pendencias.descricao}
									<br>
								</c:when>
								<c:otherwise>
									<span style="color: #CC0000; font-size: 12px; font-weight: bold;">${pendencias.quantidadePendencias}</span>
										${pendencias.descricao}
									<br>
								</c:otherwise>
							</c:choose>
						</c:if>
					</c:forEach>
					
					<form id="formLogDirecionamento" method="post" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC36/dv08">
						<div class="pendencias_botao">
							<input class="button" type="submit" value="<fmt:message key="label.relatorioDirecionamento" /> >" />					
						</div>
					</form>
					<form id="formDetalharServicos" method="post" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC36/dv03">
						<input type="hidden" name="tipoConsulta" value="S" />
						<div class="pendencias_botao">
							<input class="button" type="submit" value="<fmt:message key="label.verDetalhe" /> >" />					
						</div>
					</form>
					
				</div>
				
				<div class="pendencias_bordarodape"></div>
			</div>
		</div>
		
		<form id="formDetalharPagamentos" method="post" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC36/dv03">
			<input type="hidden" name="tipoConsulta" value="P" />
		
			<div class="pendencias">
				<div class="pendencias_bordacima">
					<fmt:message key="label.pagamentos" />
					<br>
					<span class="text_dias">
						
					</span>
				</div>
				
				<div class="pendenciasinterior">
				
					<c:forEach var="pendencias" items="${historicoPendencias}">
						<c:if test="${pendencias.tipoPendencia eq 'P'}">
							<c:choose>
								<c:when test="${pendencias.quantidadePendencias eq 0}">
									<span style="color: #0099FF; font-size: 12px; font-weight: bold;">${pendencias.quantidadePendencias}</span>
										${pendencias.descricao}
									<br>
								</c:when>
								<c:otherwise>
									<span style="color: #CC0000; font-size: 12px; font-weight: bold;">${pendencias.quantidadePendencias}</span>
										${pendencias.descricao}
									<br>
								</c:otherwise>
							</c:choose>
						</c:if>
					</c:forEach>
					
					<div class="pendencias_botao" >
						<input class="button" type="submit" value="<fmt:message key="label.verDetalhe" /> >" />		
					</div>
				</div>
				
				<div class="pendencias_bordarodape"></div>
			</div>
		</form>
		
		<form id="formDetalharPendencias" method="post" 
			  action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC36/dv02">
			
			<input type="hidden" name="indicadorAtualizacaoCadastral" value="${pendenciasUsuario.indicadorAtualizacaoCadastral}" />
			<input type="hidden" name="quantidadeAgendamentos" value="${pendenciasUsuario.quantidadeAgendamentos}" />
			<input type="hidden" name="indicadorPesquisaOpiniao" value="${pendenciasUsuario.indicadorPesquisaOpiniao}" />
			<input type="hidden" name="listaPeriodoCarenciaQuantidade" value="${listaPeriodoCarenciaQuantidade}" />
			
			<div class="pendencias">
				<div class="pendencias_bordacima">
					<fmt:message key="label.pendencias" />
				<br>
					
				</div>
				
				<div class="pendenciasinterior">
					
					<c:choose>
						<c:when test="${not pendenciasUsuario.indicadorAtualizacaoCadastral and 
										not pendenciasUsuario.indicadorPesquisaOpiniao and
										pendenciasUsuario.quantidadeAgendamentos eq 0 and
										listaPeriodoCarenciaQuantidade eq 0}">
										
							<fmt:message key="mensagem.informacao.naoHaPendencias" />
							
						</c:when>
						<c:otherwise>
						
							<c:if test="${pendenciasUsuario.indicadorAtualizacaoCadastral}">
								<fmt:message key="label.atualizacaoCadastral" />
							</c:if>
							
							<br>
							
							<c:choose>
								<c:when test="${pendenciasUsuario.quantidadeAgendamentos eq 0}">
									<span style="color: #0099FF; font-size: 12px; font-weight: bold;">${pendenciasUsuario.quantidadeAgendamentos}</span>
										<fmt:message key="label.agendamentos" />
									<br>
								</c:when>
								<c:otherwise>
									<span style="color: #CC0000; font-size: 12px; font-weight: bold;">${pendenciasUsuario.quantidadeAgendamentos}</span>
										<fmt:message key="label.agendamentos" />
									<br>
								</c:otherwise>
							</c:choose>
							
							<c:if test="${pendenciasUsuario.indicadorPesquisaOpiniao}">
								<fmt:message key="label.pesquisaOpiniao" />
							</c:if>						
								<br>
							<c:choose>
							   <c:when test="${listaPeriodoCarenciaQuantidade eq 0 or empty listaPeriodoCarenciaQuantidade}">
							    <span style="color: #0099FF; font-size: 12px; font-weight: bold;">${listaPeriodoCarenciaQuantidade}</span>
										
							    <br>
							   </c:when>
							  <c:otherwise>
								<span style="color: #0099FF; font-size: 12px; font-weight: bold;">
								  ${listaPeriodoCarenciaQuantidade}
								</span> 
								  <fmt:message key="label.contratosPendentesReinstalacao" />
							  </c:otherwise>
							</c:choose>
							
							<br>
							
							<div class="pendencias_botao" >
								<input class="button" type="submit" value="<fmt:message key="label.verDetalhe" /> >" />		
							</div>
						
						</c:otherwise>
					</c:choose>
					
				</div>
				<div class="pendencias_bordarodape"></div>
			</div>
		</form>
	
		<div style="clear: both"></div>
	</div>
	
	<div style="text-align: right;">
		<input type="button" class="botaosaibamais" value="<fmt:message key="label.saibaMSobreFerramenta" />" onclick="showModalSaibaMais();"  />
	</div>
	
	<!-- CHAMA A PAGINA DV06-->
	<div id="popupSaibaMais" style="display: none;"></div>