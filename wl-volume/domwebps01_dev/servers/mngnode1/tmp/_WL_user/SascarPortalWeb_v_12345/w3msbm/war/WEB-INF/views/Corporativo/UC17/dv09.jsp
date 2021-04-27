<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<!-- INCLUDE TIPO OPERACAO INCLUSAO -->
<div>

	<!-- ABRE BLOCO 01 -->
	<div class="bloco" style="width: 600px; float: left; position: relative;">
	
		
		<div style="position: relative;
					float: left;
					margin: 0px 0px 0px 10px;
					width: 550px;
					height: 100px;
					padding:10px;
					border: solid #D4D4D4 1px;
					border-radius: 5px;
					-moz-border-radius: 5px;
					-webkit-border-radius: 5px">
			
			<div style="position: relative;
						float: left;
						margin: 0px 0px 0px 0px;
						width: 100px;
						height: 100px;">
					
				<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/emdesenvol.png" 
					 style="position: relative;
					 		float: left;
					 		margin: 10px 0px 0px 30px"/> 
					
			</div>
			
			<div style="position: relative;
						float: left;
						margin: 0px 0px 0px 0px;
						width: 450px;
						height: 100px;">
					
				<p style="color: #666666">${param.mensagemErro}</p>
					
			</div>
	
		<!-- ANTES DE FECHAR A DIV BLOCO -->
		<div style="clear: both"></div>			
					
		</div>
	
	</div>
	<!-- FIM BLOCO 01 -->

</div>