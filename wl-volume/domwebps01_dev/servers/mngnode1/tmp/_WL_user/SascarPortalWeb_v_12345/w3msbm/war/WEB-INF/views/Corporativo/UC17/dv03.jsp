<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

	<script type="text/javascript">
		
		function carregarComboBancos(){
			
			var bancos = $('#bancos')[0];
			
			var descricaoBusca = $("#inpitDescricaoBusca").val();
			
			$.ajax({
				"url" : "/SascarPortalWeb/AutorizarDebitoAutomaticoServlet/listarBancos",
				"data" : {
					"acao" : 2,
					"descricaoBusca" : descricaoBusca
				},
				"dataType" : "json",
				"beforeSend" : function() {
					$("option[value!='']", "#bancos").remove();
				},
				"success" : function(json) {
					if (json.success) {
						$.each(json.bancos, function(i, banco) {
							if (banco.id && banco.value) {
								var option = new Option(banco.value, banco.id);
								if ($.browser.msie) {
									bancos.add(option);
								} else {
									bancos.add(option, null);
								}
							}
						});
					} else {
						$.showMessage(json.mensagem);
					}
				}
			});
			
		}
	
		function showModalHistoricoDebitoAutomatico(){
			
			$.ajax({
				url : "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC17/dv02",
				data : {}, 
				dataType : "html",
				success :	 function(html) {
					$("#popupHistorico").html(html).jOverlay({
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
	
		function submeterPermissaoDebitoAutomatico(form){
			
			var data = $(form).serialize();
			
			$.ajax({
				url: "/SascarPortalWeb/AutorizarDebitoAutomaticoServlet/submeterPermissaoDebitoAutomatico?acao=5",
				data: data || {},
				dataType:"json",
				success: function(json){
					if (json.success) {
						
						showModalRetornoConfirmacaoInclusaoDebitoAutomatico();
						
					} else {
						$(form).attr("action", "");
						$.showMessage(json.mensagem);
					}
				}
			});
			
		}
		
		function finalizaOperacaoInclusaoDebitoAutomatico(form){
			$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC17/dv01");
			$(form).unbind('submit').submit();
		}
		
		function showModalRetornoConfirmacaoInclusaoDebitoAutomatico(){
			$.ajax({
				url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC17/dv06",
				data: {},
				dataType:"html",
				success: function(html){
					$("#popupRetornoConfirmacaoInclusaoDebitoAutomatico").html(html).jOverlay({
						bgClickToClose : false, 
						closeOnEsc : false
					});
				}
			});
		}
		
		function resetErros(){
			// PEGANDO A REFERENCIA DA DIV DE MENSAGENS DE VALIDACAO
			var conteinerValidacao = $(".conteinerValidacao");
			
			// LIMPANDO AS MENSAGENS DE ERRO
			conteinerValidacao.find('li').remove();
		}
		
		function showModalConfirmacaoInclusaoDebitoAutomatico(){
			
			// PEGANDO A REFERENCIA DA DIV DE MENSAGENS DE VALIDACAO
			var conteinerValidacao = $(".conteinerValidacao");
			
			// LIMPANDO AS MENSAGENS DE ERRO
			conteinerValidacao.find('li').remove();
			
			var erroValidacao = false;
			
			if($('#bancos :selected').val() == ''){
				erroValidacao = true;
			    html = '<li><label><fmt:message key="mensagem.campoObrigatorio.banco" />.</label></li>';
				conteinerValidacao.find('ol').append(html);
			}
			
			if($('#numeroAgencia').val() == ''){
				erroValidacao = true;
			    html = '<li><label><fmt:message key="mensagem.campoObrigatorio.numeroAgencia" />.</label></li>';
				conteinerValidacao.find('ol').append(html);
			}
			
			if($('#numeroConta').val() == ''){
				erroValidacao = true;
			    html = '<li><label><fmt:message key="mensagem.campoObrigatorio.numeroConta" />.</label></li>';
				conteinerValidacao.find('ol').append(html);
			}
			
			if(!$('#termoAceite').is(":checked")){
				erroValidacao = true;
			    html = '<li><label><fmt:message key="mensagem.selecione.concordoTermo" />.</label></li>';
				conteinerValidacao.find('ol').append(html);
			}
			
			if(!erroValidacao){
				$.ajax({
					url: "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Ajax&page=Corporativo/UC17/dv05",
					data: {},
					dataType:"html",
					success: function(html){
						$("#popupConfirmacaoInclusaoDebitoAutomatico").html(html).jOverlay({
							bgClickToClose : false, 
							closeOnEsc : false
						});
					}
				});
			}
			
		}
		
		$(document).ready(function(){
			
			carregarComboBancos();
			
			/* APENAS NUMEROS */
			$('#numeroAgencia').setMask({mask:'9999'});
			$('#numeroConta').setMask({mask:'9999999999'});
			
			$("#tipoOperacaoInclusao").attr("checked",true);
			$("#tipoOperacaoExclusao").attr("checked",false);
			
			var container = $('div.container2');
			$("#formAutorizarDebitoAutomatico").validate({
				errorContainer: container,
				errorLabelContainer: $("ol", container),
				wrapper: 'li',
				submitHandler : function(form) {
					submeterPermissaoDebitoAutomatico(form);
				}
			}); 
			
		});
		
	</script>

	<div class="conteinerValidacao">
		<ol style="color: #C00;">
		</ol>
	</div>

	<!-- INCLUDE TIPO OPERACAO INCLUSAO -->
	<div>
	
		<!-- ABRE FORM  formAutorizarDebitoAutomatico -->
		<form id="formAutorizarDebitoAutomatico" 
			  action="" 
			  method="post">
			  
			<input type="hidden" name="canalEntrada" value="P" />
			
			<!-- NA OPERACAO DE INCLUSAO ESTE PARAMETRO E PASSADO VAZIO AO WS -->
			<input type="hidden" name="motivo" value="" />
			
			<!-- ABRE BLOCO 01 -->
			<div class="bloco" style="width: 600px; float: left; position: relative;">
			
				<!-- ABRE DIV TIPO OPERACAO -->
				<div class="operacao_debito_automatico" >
							
					<fieldset>
					    <legend>
					    	<b><fmt:message key="label.operacao" /></b>
					    </legend>
					    
					    <span class="coluna_esquerda_operacao_debito_automatico">
					    	<input type="radio" name="tipoOperacao" value="I" border="0" id="tipoOperacaoInclusao" /> 
							<label><fmt:message key="label.inclusao" /></label>
					    </span>
				    	
				   </fieldset>
					
				</div>
				<!-- FECHA DIV TIPO OPERACAO -->
			
				<!-- ANTES DE FECHAR A DIV BLOCO -->
				<div style="clear: both"></div>
			
			</div>
			<!-- FIM BLOCO 01 -->
			
			<div style="clear: both; margin-bottom: 20px;"></div>
			
			<!-- ABRE DIV DADOS PESSOAIS -->
			<div class="bloco" style="width: 600px; float: left; position: relative;">
			
				<div class="celula" style="width: 600px;">
					<div class="colunaLabel" style="width: 200px;">
						<label><fmt:message key="label.nome" /></label>
					</div>
					
					<div class="colulaCamposInternos">
						<label>${contratante.nome}</label>
					</div>
				</div>
				
				<div class="celula" style="width: 600px;">
					<div class="colunaLabel" style="width: 200px;">
						<label><fmt:message key="label.cpfCnpj" /></label>
					</div>
					
					<div class="colulaCamposInternos">
						<label>${contratante.numCpfCnpj}</label>
					</div>
				</div>
				
				<div style="clear: both;"></div>
				
			</div>
			<!-- FECHA DIV DADOS PESSOAIS -->
			
			<p class="label_preencher_dados_bancarios"><fmt:message key="label.preencherDadosBancarios" /></p>
			
			<!-- ABRE DIV DADOS BANCARIOS -->
			<div class="bloco" style="width: 600px; float: left; position: relative;">
			
				<div class="celula" style="width: 600px;">
					<div class="colunaLabel" style="width: 200px;">
						<label><fmt:message key="label.nomeDoBanco" /></label>
					</div>
					
					
					
					<div class="colunaInput" > 
						<select class="colunaInputCombo" 
								id="bancos" 
								onblur="resetErros();"
								name="bancoSelecionado" 
								style="margin-top: 4px;">
							<option value="" id="" ><fmt:message key="label.selecione" /></option>
						</select>
					</div>
				</div>
				
				<div class="celula" style="width: 600px;">
					<div class="colunaLabel" style="width: 200px;">
						<label><fmt:message key="label.agencia" /></label>
					</div>
					
					<div class="colunaInput" > 
						<input type="text" class="inputCelula" name="numeroAgencia" maxlength="4" id="numeroAgencia" onblur="resetErros();" />
					</div>
				</div>	
				
				<div class="celula" style="width: 600px;">
					<div class="colunaLabel" style="width: 200px;">
						<label><fmt:message key="label.numDaConta" /></label>
					</div>
					
					<div class="colunaInput" > 
						<input type="text" class="inputCelula" name="numeroConta" maxlength="10" id="numeroConta" onblur="resetErros();" />
					</div>
				</div>
				
				<div class="celula" style="width: 600px;">
					<div class="colunaLabel" style="height: 300px; width: 200px;">
						<label class="label_termo"><fmt:message key="label.termo" /></label>
					</div>
						
					<div class="termo_aceite_debito_automatico" 
						 style="position: relative;
								float: left;
								margin: 0px 0px 0px 10px;
								width: 360px;
								height: 300px;
								max-height: 298px;
								overflow: auto;
								border: solid #D4D4D4 1px;
								border-radius: 5px;
								-moz-border-radius: 5px;
								-webkit-border-radius: 5px">
						
						<p>
							TERMO DE ACEITE/CONFIRMA&Ccedil;&Atilde;O DA AUTORIZA&Ccedil;&Atilde;O DE D&Eacute;BITO AUTOM&Aacute;TICO EM CONTA
						</p>
						
						<p>
							Autorizo (amos) a realiza&ccedil;&atilde;o dos d&eacute;bitos em minha (nossa) conta, provenientes da SASCAR.
						</p>
						
						<p>
							Estou(amos) ciente(s) de que esta autoriza&ccedil;&atilde;o possui prazo de validade indeterminado e a partir desta confirma&ccedil;&atilde;o, 
							todos os lan&ccedil;amentos enviados pela empresa ser&atilde;o agendados para d&eacute;bito em minha (nossa) conta.
						</p>
						
						<p>
							Concordo(amos) que, a partir do aceite desta autoriza&ccedil;&atilde;o, tamb&eacute;m estar&atilde;o autorizados todos os demais 
							d&eacute;bitos agendados por esta empresa conveniada.
						</p>
						
						<p>
							Estou(amos) ciente(s) que o cancelamento desta autoriza&ccedil;&atilde;o somente ocorrer&aacute; nas seguintes situa&ccedil;&otilde;es:
							Atrav&eacute;s da minha (nossa) solicita&ccedil;&atilde;o formal; Atrav&eacute;s de solicita&ccedil;&atilde;o da empresa conveniada.
						</p>
							
						<p>
							Estou(amos) ciente(s) de que os valores dos compromissos n&atilde;o ser&atilde;o debitados caso a conta n&atilde;o possua
							saldo suficiente no dia do vencimento do compromisso, ficando sob minha (nossa) responsabilidade a 
							quita&ccedil;&atilde;o do d&eacute;bito atrav&eacute;s de outros meios.
						</p>
							
						<p>
							Estou(amos) ciente(s) que o servi&ccedil;o somente estar&aacute; ativo ap&oacute;s o agendamento do primeiro d&eacute;bito pela empresa conveniada, 
							em cuja fatura/documento emitido pela mesma, ser&aacute; apresentada a informa&ccedil;&atilde;o de que o pagamento do compromisso 
							ser&aacute; efetuado automaticamente atrav&eacute;s do d&eacute;bito em conta.
						</p>
							
						<p>
							Estou(amos) ciente(s) de que caso o d&eacute;bito autorizado n&atilde;o venha a ser efetuado por qualquer motivo ou circunst&acirc;ncia, 
							fica sob minha (nossa) responsabilidade a quita&ccedil;&atilde;o do d&eacute;bito atrav&eacute;s de outros meios.
						</p>
							
						<p>
							Declaro(amos) que tive(vemos) pr&eacute;vio conhecimento do conte&uacute;do do presente conv&ecirc;nio, conforme determina&ccedil;&atilde;o do art. 
							46 da lei 8.078, de 11 de Setembro de 1990.
						</p>
						
						
					</div>
					
					<div style="clear: both;"></div>
				</div>
				
				<div class="checkbox_termo_aceite_autorizar_debito_automatico">
					<input name="termoAceite" id="termoAceite" type="checkbox" border="none" onblur="resetErros();" />	
					<label><fmt:message key="label.concordaTermo" /></label>
				</div>
				
				<div style="clear: both;"></div>
				<br />
				
				<!-- DIV BOTOES -->
				<div class="posicaoBotoes" style="width: 590px;"> 
				     <div class="botoes" style="width: 350px;">
					    <p>
					    	
					    	<c:if test="${param.renderizaBtnHistorico}">
					    		 <input type="button" 
						        	    class="button"  
						        	    style="*margin-right:70px; display:inline-block;" 
						        	    value="<fmt:message key="label.historico" />" 
						        	    onclick="showModalHistoricoDebitoAutomatico();"/>
					    	</c:if>
					    	
					        <input type="reset" 
					        	   class="btnBranco"  
					        	   value="<fmt:message key="label.limpar" />"  />
					        
					        <input type="button" 
					        	   class="btnBranco" 
					        	   onclick="window.location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente';"
					        	   value="<fmt:message key="label.voltar" />"  />
					        
					        <input type="button" 
					        	   onclick="showModalConfirmacaoInclusaoDebitoAutomatico();"
					        	   class="button"  
					        	   value="<fmt:message key="label.continuar" />" />
					        
					    </p>
				    </div>
				    
			    	<div style="clear: both;" ></div>
			    </div>
				
				<div style="clear: both;"></div>
				
			</div>
			<!-- FECHA DIV DADOS BANCARIOS -->
			
		</form>
		<!-- FECHA FORM  formAutorizarDebitoAutomatico -->
	
	</div>