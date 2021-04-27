<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<script type="text/javascript">

</script>

	<div class="cabecalho">
		<div class="caminho" style="*margin-left:400px;">
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="Home" class="linktres">Home</a> &gt; 
			<a href="#" class="linktres">Informações</a> &gt; 
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/testeLayout/testeLayout" class="linkquatro">Teste Layout</a>
		</div>
	  	Teste Layout
	</div>
	
	<form action="" id="formTeste">
	
		<div class="principal">
		
			<!-- INICIO BLOCO 01 -->
			<div class="tarjaAzul">
				<label>Título Bloco 01</label>
			</div>
				
			<!-- A DIV BLOCO ENGLOBA OS CAMPOS DO FORMULARIO ( LABEL E INPUT  ) -->	
			<div class="bloco">
			
				<!-- A DIV CELULA ENGLOBA A LABEL ( BARRA CINZA ) E O CAMPO DE APRESENTÇÃO DE DADOS DA SERVLET OU DE PARAMETROS DO FORM DA PAGINA ANTERIOR -->
				<div class="celula">
					<div class="colunaLabel">
						<label>Label 01</label>
					</div>
				
					<div class="colulaCamposInternos">
						<!-- EXEMPLO DE USO -->
						<!-- <label>${ordemServicoResumida.contrato.veiculo.placa}</label> -->				
						<label>Apresentação de Label 01</label>
					</div>
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label>Label 02</label>
					</div>
					
					<div class="colulaCamposInternos">
						<label>Apresentação de Label 02</label>
					</div>
				</div>
				
				
				<div class="celula">
					<div class="colunaLabel">
						<label>Label 03</label>
					</div>
					
					<div class="colulaCamposInternos">
						<label>Apresentação de Label 03</label>
					</div>
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label>Label 04</label>
					</div>
					
					<div class="colulaCamposInternos">
						<label>Apresentação de Label 04</label>
					</div>
				</div>
				
				<!-- ANTES DE FECHAR A DIV BLOCO -->
				<div style="clear: both"></div>
				
			</div>
			<!-- FIM BLOCO 01 -->
			
			<!-- INICIO BLOCO 2 -->
			<div class="tarjaAzul">
				<label>Título Bloco 02</label>
			</div>
			
			<div class="bloco">
				
				<div class="celula">
					<div class="colunaLabel">
						<label>Label Campo 05</label>
					</div>
					
					<div class="colunaInput" > 
						<!-- EXEMPLO DE USO -->
						<!-- <input type="text" name="nomeAcessorio" id="nomeAcessorio" class="inputCelula" value="${acessorio.descricao }" maxlength="50" /> -->
						<input type="text" class="inputCelula"/>
					</div>
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label>Label Campo 06:</label>
					</div>
					
					<div class="colunaInput" > 
						<!-- EXEMPLO DE USO -->
						<!-- <input type="text" name="nomeAcessorio" id="nomeAcessorio" class="inputCelula" value="${acessorio.descricao }" maxlength="50" /> -->
						<input type="text" class="inputCelula"/>
					</div>
				</div>		
		
				<div class="celula">
					<div class="colunaLabel">
						<label>Label Campo 07</label>
					</div>
					
					<div class="colunaInput" > 
						<select class="colunaInputCombo" >
							<option value="opacao01">Opção 01</option>
							<option value="opacao02">Opção 02</option>
							<option value="opacao03">Opção 03</option>
							<option value="opacao04">Opção 04</option>
							<option value="opacao05">Opção 05</option>
						</select>
					</div>
					
				</div>
				
				<div class="celula">
					<div class="colunaLabel">
						<label>Label Campo 08</label>
					</div>
					
					<div class="colunaInput" > 
						<select class="colunaInputCombo" >
							<option value="opacao01">Opção 01</option>
							<option value="opacao02">Opção 02</option>
							<option value="opacao03">Opção 03</option>
							<option value="opacao04">Opção 04</option>
							<option value="opacao05">Opção 05</option>
						</select>
					</div>
					
				</div>
				
				<!-- ANTES DE FECHAR A DIV BLOCO -->
				<div style="clear: both"></div>
				
			</div>
			<!-- FIM BLOCO 2-->
			
			<!-- DIV BOTOES -->
			<div class="posicaoBotoes">
			     <div class="botoes">
				    <p>
				        <input type="button" class="button4"  style="*margin-right:70px;" value="Voltar"  />
				        <input type="submit" class="button" value="Continuar" />
				    </p>
			    </div>
			    
		    	<div style="clear: both;" ></div>
		    </div>
		    
		</div>	   
	</form>