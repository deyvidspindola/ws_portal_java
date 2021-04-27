<jsp:directive.include file="/WEB-INF/views/includes.jsp" />

<link
	href="${pageContext.request.contextPath}/sascar/css/css_uc/uc07.css"
	media="all" rel="stylesheet" type="text/css" />

<c:catch var="helper">
	<c:import
		url="/RealizarPesquisaSatisfacaoServlet/consultarEstruturaPesquisa?acao=3"
		context="/SascarPortalWeb" />
</c:catch>

<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$.showMessage("${mensagem }");
		setTimeout(function(){
			history.back(-1);
		}, 2000);
	</script>
</c:if>

<c:if test="${not empty helper}">
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>

<c:if test="${empty mensagem }">
	<script type="text/javascript">
		$(document).ready(function(){		
		
			var container = $('div.container2');
			$("#formPerguntas").validate({
				errorContainer: container,
				errorLabelContainer: $("ol", container),
				wrapper: 'li',
				submitHandler : function(form) {
					submeterPesquisa(form);
				}
			});
			
			$('form textarea').each(function(){
				
				this.value = '';						
			});
			
		});
		
		
		function validaOpUsuario(form) {
			
			if (validarPesquisa()) {
				
				$("#popupConfirmaPesquisaVazia").jOverlay({'color':'#ffffff', 'opacity' : '0.8', closeOnEsc : false, bgClickToClose : false});	
				return false;
			} else {
				
				submeterPesquisa(form);
			}		
		}
		
		function submeterPesquisa(form) {					
				
			if (validaCamposObrigatorios()) {
				
				var data = $(form).serialize();			
				$.ajax({
					url: "/SascarPortalWeb/RealizarPesquisaSatisfacaoServlet/submeterRespostaPesquisa?acao=4",
					data: data || {},
					dataType:"json",
					success: function(json){
						if (json.success) {
	
							var mensagem = json.mensagemRetorno;							
							$("#popupPesquisaSatisfacao").jOverlay({'color':'#ffffff', 'opacity' : '0.8', closeOnEsc : false, bgClickToClose : false});
						} else {
							$(form).attr("action", "");
							$.showMessage(json.mensagem);
						}
					}
				});				
			}
		}		
		
		function validaCamposObrigatorios() {

			var conteinerValidacao = $(".conteinerValidacao");			
			conteinerValidacao.find('li').remove();			
			
			if (checkReenvioEmail()) {
				
				var retornoValidaEmail = validaEmail();				
				if ( $.trim(retornoValidaEmail) != '' ) {
					
					html = "<li><label>"+retornoValidaEmail+"</label></li>";
					conteinerValidacao.find('ol').append(html);
					return false;
				}				
			}			

			return true;			
		}
		
		function checkReenvioEmail() {
			
			var field = $(".rad_reenv_email");			
			for (var i = 0; i < field.length; i++) {
				
				if ("N" == field[i].value && field[i].checked) {
					
					return true;
				}
			}
			
			return false;
		}
		
		function validaEmail() {

			var email = $(".email").val();
			var emailValido=/^\w+([\.]?\w+)@\w+([\.]?\w+)(\.\w{1,3})+$/; 

			if ( '' != $.trim(email)) {
				
				if (!emailValido.test(email)) {				
					
					return '<fmt:message key="mensagem.campoInvalido.email" />';
				} else {        
					
					return '';			
				}	
			} else {
				
				return '<fmt:message key="mensagem.campoObrigatorio.email" />';
			}			
		}	
		
		
		function reenvioEmail(codPergunta, op) {		
			
			if ('N' == op ){

				$('#informeEmail_'+codPergunta).show();
				$('#formulario_pesquisa input:text').attr('disabled', 'disabled');
				$('#formulario_pesquisa input:radio').attr('disabled', 'disabled');
				$('#formulario_pesquisa input:checkbox').attr('disabled', 'disabled');
				$('#formulario_pesquisa textarea').attr('disabled', 'disabled');
				$('#formulario_pesquisa select').attr('disabled', 'disabled');
				
				$('input:radio[name="'+codPergunta+'_radEnvEmail"]').removeAttr('disabled');
				$('input:text[name="'+codPergunta+'_radEnvEmail"]').removeAttr('disabled');
			} else {

				$('#informeEmail_'+codPergunta).hide();				
				$('#formulario_pesquisa input:text').removeAttr('disabled'); 
				$('#formulario_pesquisa input:radio').removeAttr('disabled'); 
				$('#formulario_pesquisa input:checkbox').removeAttr('disabled');
				$('#formulario_pesquisa textarea').removeAttr('disabled'); 
				$('#formulario_pesquisa select').removeAttr('disabled');				
			}	
		}
		
		function fecharPesquisa() {			
			
			$("#popupPesquisaSatisfacao").hide();
			window.location.href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente";
		}
		
		function cancelarPesquisa() {			
			
			window.location.href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente";
		}
		
		
		function validarPesquisa() {
						
			var allInputsRadio = $('input[type="radio"]');			
			var allInputsCkb = $('input[type="checkbox"]');
			var allInputsText = $('input[type="text"]');
			var allInputsSel = $('select');		
			var allInputsTextArea = $('textArea');

			var retorno = true;

			allInputsRadio.each(function() {				
				
				if($(this).attr('checked')) {		
				
					return retorno = false;			
				};
			});

			if (retorno) {

				allInputsCkb.each(function() {			  
					
					if($(this).attr('checked')) {
						
						return retorno = false;									
					}			  
				});

				if (retorno) {

					allInputsText.each(function() {			  
						
						if($.trim($(this).val()) != '') {
							
							return retorno = false;	
							
						}			  
					});	

					if (retorno) {
						
						allInputsTextArea.each(function() {			  
							
							if ( $.trim($(this).val()) != '') {
								
								return retorno = false;				
							}			  
						});	
						
						if (retorno) {
							
							allInputsSel.each(function() {
								
								if ( $.trim($(this).val()) != '') {
									
									return retorno = false;				
								}
							});								
						}
					}
				}				
			}	
			
			return retorno;
		}
		
	</script>
	<div class="conteinerValidacao">
		<ol style="color: #C00;"></ol>
	</div>
	<div class="cabecalho">
		<fmt:message key="label.pesquisaSatisfacao" />
		<div class="caminho">
			<a
				href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}"
				title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; <a href="#"
				class="linktres"><fmt:message key="label.informacoes" /></a> &gt;
				<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC07/dv02&codPesquisa=${formulario.codigoControleQuestionario}" class="linkquatro"><fmt:message key="label.pesquisaSatisfacao" /></a>
		</div>
	</div>

	<div class="container2">
		<ol></ol>
	</div>

	<div class="busca_branca">
		<span class="text1"><fmt:message key="label.titulo.pesquisaSatisfacao" /></span>
	</div>

	<div id="formulario_pesquisa">
		<c:choose>
			<c:when test="${empty formulario.codigo}">
				<div>
					<b><fmt:message key="mensagem.informacao.dadosPesquisaConsultada" /></b>
				</div>
				<div style="padding: 10px;">
					<input type="reset" value="<fmt:message key="label.voltar" />" class="button" onclick="fecharPesquisa()" />
				</div>									
			</c:when>
			<c:otherwise>				
				<form id="pesquisaSatisfacao" action="" method="post" >	
					<input type="hidden" name="codigoControleQuestionario" id="codigoControleQuestionario" value="${formulario.codigoControleQuestionario}">
					<input type="hidden" name="confirmaEnvioVazio" id="confirmaEnvioVazio" value="${confirmaEnvioVazio}">					
					
					<c:choose>
						<c:when test="${not empty formulario.statuspesquisa}">
							<div>
								<b>${formulario.statuspesquisa }</b>
							</div>
							<div style="padding: 10px;">
								<input type="reset" value="Cancelar" class="button" onclick="cancelarPesquisa();"/>
							</div>	
						</c:when>
						<c:otherwise>
							<!--  -->
							<ul class="formulario">
								<li class="infoGeral">
									<span class="st-titulo text5 st-titulo-pesquisa"><fmt:message key="label.pesquisaSatisfacao" /> - ${formulario.tipoPesquisa}</span>
									<c:choose>
										<c:when test="${(formulario.tipoPesquisa eq 'Pos-Vendas') || (formulario.tipoPesquisa eq 'Pós-Vendas')}">
											<span class="st-sub-titulo">
												<b><fmt:message key="label.atendimentoN" />:</b>&nbsp;${formulario.codigo}
											</span>
											<span class="st-sub-titulo">
												<b><fmt:message key="label.dataDaVisita" />:</b>&nbsp;${formulario.data}</span>
											<br />
											<span class="st-sub-titulo">
												<b><fmt:message key="label.avaliacaoAnalista" />:</b>&nbsp;${formulario.nome}</span>
										</c:when>
										<c:otherwise>
											<span class="st-sub-titulo">
												<b><fmt:message key="label.ordemServicoN" />:</b>&nbsp;${formulario.codigo}</span>
											<span class="st-sub-titulo">
												<b><fmt:message key="label.finalizadaEm" />:</b>&nbsp;${formulario.data}</span>
											<br />
											<span class="st-sub-titulo">
												<b><fmt:message key="label.avaliacaoTecnico" />:</b>&nbsp;${formulario.nome}</span>
										</c:otherwise>
									</c:choose>
									
									<br/>
									
									<span class="st-sub-titulo">
										<b><fmt:message key="label.representanteNome" />:</b>&nbsp;${formulario.representanteNome}(${formulario.representanteRazao})
									</span>
									<br/>
									<span class="st-sub-titulo">
										<b><fmt:message key="label.prestadorCidadeEstado" />:</b>&nbsp;${formulario.prestadorCidade}/${formulario.prestadorUf}
									</span>
									<br/>
									<span class="st-sub-titulo">
										<b><fmt:message key="label.placa" />:</b>&nbsp;${formulario.placa}
									</span>
									<br/>
									<span class="st-sub-titulo">
										<b><fmt:message key="label.responsavelCliente" />:</b>&nbsp;${formulario.responsavelCliente}
									</span>
									
									<br/>
									<br/>
									
								</li>
								<li style="margin-top: 25px">
									<c:forEach var="topico" items="${formulario.topicos }">
										<ul class="topicos">
											<li class="st-barra-azul-1">${topico.descricao }</li>
											<li>
												<ul class="perguntas">
													<c:forEach var="pergunta" items="${topico.perguntas }" varStatus="counter">
														<li>
															<c:choose>
																<c:when test="${counter.count mod 2 == 0}">
																	<ul class="fundo_linha_impar">
																</c:when>
																<c:otherwise>
																	<ul>
																</c:otherwise>
															</c:choose>	
																		<li class="descricao">${counter.count}. ${pergunta.descricao }															
														                	<c:if test="${ not empty pergunta.imagem}">
															                  <br>                                     
															                  <a class="linkazulescuro" style="cursor:pointer" onclick="window.open('${caminhoImagem}${pergunta.imagem}', 'blank')" >(Visualizar Imagem)</a>
															                </c:if>
																		</li>
																		<c:if test="${'readonly' ne pergunta.tipo }">
																			<li class="opcoes">
																				<!--  INICIO OPÇÕES DE CAMPOS DE FORM -->
																				<c:if test="${'text' eq pergunta.tipo }">
																					<input type="text" name="${pergunta.codigo }_txt" size="30" maxlength="${pergunta.tamanho }" />
																				</c:if>
																				<c:if test="${'textarea' eq pergunta.tipo }">
																					<textarea id="${pergunta.codigo}_txa"
																								style="resize: none" 
																								rows="4" cols="50"
																								maxlength="${pergunta.tamanho }"
																								name="${pergunta.codigo }_txa">
																					</textarea>														
																				</c:if>
																				<c:if test="${'radio' eq pergunta.tipo }">
																					<c:if test="${null != pergunta.opcoes }">
																						<ul>
																							<c:forEach var="opcao" items="${pergunta.opcoes }">
																								<li>
																									<c:choose>
																										<c:when test="${'Reenvio de E-mail' eq pergunta.ocorrencia }">
																											<c:if test="${('S' eq opcao.codigo) || ('N' eq opcao.codigo)}">
																												<input TYPE="radio" NAME="${pergunta.codigo }_radEnvEmail"
																													VALUE="${opcao.codigo}"
																													class="rad_reenv_email"																				
																													onclick="reenvioEmail(${pergunta.codigo}, '${opcao.codigo}')">${opcao.descricao }
																								         	</c:if>
																										</c:when>
																										<c:otherwise>
																											<input TYPE="radio" NAME="${pergunta.codigo }_rad" VALUE="${opcao.codigo}">${opcao.descricao }
																									    </c:otherwise>
																									</c:choose>
																								</li>
																							</c:forEach>
																							<c:if test="${('Reenvio de E-mail' eq pergunta.ocorrencia)}">
																								<li id="informeEmail_${pergunta.codigo}" style="display: none">- <fmt:message key="mensagem.campo.email" />:
																									<input type="text"
																									 	name="${pergunta.codigo }_radEnvEmail"
																										size="${pergunta.tamanho }" 
																										maxlength="${pergunta.tamanho }"
																										class="text required email"/>
																								</li>
																							</c:if>
																						</ul>
																					</c:if>
																				</c:if> <c:if test="${'checkbox' eq pergunta.tipo }">
																					<c:if test="${null != pergunta.opcoes }">
																						<ul>
																							<c:forEach var="opcao" items="${pergunta.opcoes }">
																								<li>
																									<input TYPE="checkbox" NAME="${pergunta.codigo }_ckb" VALUE="${opcao.codigo}">${opcao.descricao}
																								</li>
																							</c:forEach>
																						</ul>
																					</c:if>
																				</c:if>
																				<c:if test="${'select' eq pergunta.tipo }">
																					<select id="${pergunta.codigo }_sel" name="${pergunta.codigo }_sel">
																						<c:if test="${null != pergunta.opcoes }">
																							<c:forEach var="opcao" items="${pergunta.opcoes }">
																								<option value="${opcao.codigo}">${opcao.descricao }</option>
																							</c:forEach>
																						</c:if>
																					</select>
																				</c:if> <!--  FIM OPÇÕES DE CAMPOS DE FORM -->
																			</li>
																		</c:if>
																	</ul>
																</li>
													</c:forEach>
												</ul>
											</li>
										</ul>
									</c:forEach>
								</li>
							</ul>
							<div style="padding: 10px;">
								<input type="reset" value="Responder depois" class="button" onclick="cancelarPesquisa();"/>
								<input id="button" 
										class="button"
										type="button"
										value="<fmt:message key="label.enviar" />"
										name="button" 
									 	onclick="validaOpUsuario('#pesquisaSatisfacao');"/>
							</div>					
							<!--  -->
						</c:otherwise>
					</c:choose>				
				</form>
			</c:otherwise>
		</c:choose>		
	</div>
</c:if>
<div id="popupPesquisaSatisfacao" class="popup_padrao2" style="display: none;">
	<div id="popup_msg_modal" class="popup_padrao_pergunta">
		<fmt:message key="mensagem.sucesso.pesquisaSatisfacaoEnviada" />
	</div>	
	<div class="popup_padrao_resposta">
		<div class="st-botoes">			
			<input type="button" class="button4" value="<fmt:message key="label.fechar" />" onclick="cancelarPesquisa()"/>
		</div>	
	</div>	
</div>

<div id="popupConfirmaPesquisaVazia" class="popup_padrao2" style="display: none;">
	<div id="popup_msg_modal" class="popup_padrao_pergunta">
		<fmt:message key="mensagem.confirmacao.pesquisaSatisfacaoCamposEmBranco" />
	</div>
	<div class="popup_padrao_resposta">
		<div class="st-botoes">
			<input type="button" class="button4" value="<fmt:message key="label.nao" />" onclick="$.closeOverlay();"/>
			<input type="button" class="button4" value="<fmt:message key="label.sim" />" onclick="submeterPesquisa('#pesquisaSatisfacao');"/>			
		</div>
	</div>
</div>

