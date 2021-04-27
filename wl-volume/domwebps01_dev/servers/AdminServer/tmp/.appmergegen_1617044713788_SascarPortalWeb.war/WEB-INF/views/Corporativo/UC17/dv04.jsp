<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

	<div class="conteinerValidacao">
		<ol style="color: #C00;">
		</ol>
	</div>
	
	<!-- INCLUDE TIPO OPERACAO INCLUSAO -->
	
	<!-- ABRE FORM  formAutorizarDebitoAutomatico -->
	<form id="formAutorizarRemocaoDebitoAutomatico" 
		  action="" 
		  method="post">
		  
		<input type="hidden" name="canalEntrada" value="P" />
		
		<input type="hidden" name="bancoSelecionado" value="${ultimoHistorico.codigoBancoPosterior}" /> 
		<input type="hidden" name="numeroAgencia" 	 value="${ultimoHistorico.agenciaPosterior}" />
		<input type="hidden" name="numeroConta"		 value="${ultimoHistorico.contaCorrentePosterior}" />
		
		<div style="clear: both; margin-bottom: 20px;"></div>
		
		<!-- ABRE DIV DADOS PESSOAIS -->
		<div class="bloco" style="width: 600px;">
		
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
		<div class="bloco" style="width: 600px;">
			
			<div class="celulaAutorizacaoDebitoAutomatico">
				<div class="colunaLabelAutorizacaoDebitoAutomatico">
					<label><fmt:message key="label.nomeDoBanco" /></label>
				</div>
				
				<div class="colunaInput" > 
					<input type="text" 
						   class="inputCelula" 
						   value="${ultimoHistorico.bancoPosterior}" 
						   disabled="disabled" />
				</div>
			</div>
			
			<div class="celula" style="width: 600px;">
				<div class="colunaLabel" style="width: 200px;">
					<label><fmt:message key="label.agencia" /></label>
				</div>
				
				<div class="colunaInput" > 
					<input type="text" 
						   class="inputCelula" 
						   value="${ultimoHistorico.agenciaPosterior}"
						   disabled="disabled" />
				</div>
			</div>	
			
			<div class="celula" style="width: 600px;">
				<div class="colunaLabel" style="width: 200px;">
					<label><fmt:message key="label.numDaConta" /></label>
				</div>
				
				<div class="colunaInput" > 
					<input type="text" 
						   class="inputCelula" 
						   value="${ultimoHistorico.contaCorrentePosterior}"
						   disabled="disabled" />
				</div>
			</div>
			
			<div style="clear: both;"></div>
			<br />
			
			<!-- DIV BOTOES -->
			<div class="posicaoBotoes" style="width: 590px;"> 
		     	<div class="botoes" style="width: 350px;">
				    <p>
				        
			    		 <input type="button" 
				        	    class="button"  
				        	    style="*margin-right:70px;" 
				        	    value="<fmt:message key="label.historico" />" 
				        	    onclick="showModalHistoricoDebitoAutomatico();"/>
				        				        
				        <input type="button" 
				        	   class="btnBranco" 
				        	   onclick="window.location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente';"
				        	   value="<fmt:message key="label.voltar" />"  />
				        
				        
				    </p>
			    </div>
			    
		    	<div style="clear: both;" ></div>
		    </div>
			
			<div style="clear: both;"></div>
			
		</div>
		<!-- FECHA DIV DADOS BANCARIOS -->
		
	</form>
	<!-- FECHA FORM  formAutorizarDebitoAutomatico -->