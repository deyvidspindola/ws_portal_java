<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper">
	<c:import url="/ConsultarFAQ/carregarTela?acao=1" context="/SascarPortalWeb"  />
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

	function recuperarRespostaFaq(codigoPergunta, containerResposta) {
		$.ajax({
			url: "${pageContext.request.contextPath}/ConsultarFAQ/consultarRespostas?acao=2",
			data: {"codigoPergunta" : codigoPergunta},
			dataType:"json",
			success: function(json){
				if (json.success) {
					containerResposta.html(json.resposta);
					resizeIframeParent();
				}
			}
		});
	}

	$(document).ready(function(){
					
		$(".toggle_container").hide();
	 
		$("h2.trigger").click(function(){
			
			var self = $(this);
			// CONTROLE PARA ESCONDER UMA RESPOSTA QUANDO OUTRA FOR SELECIONADA.
			$(".trigger").each(function(){
				if (self.attr('id') != $(this).attr('id')) {
					$(this).removeClass('active').next().slideUp();
				}
			});
			
			// PEGA A REFERENCIA DO CODIGO DA PERGUNTA QUE FOI SETADO NO ATRIBUTO HREF DA TAG <a>
			var codigoPergunta = $("a", this).attr("href").substring(1);
			
			// RENDERIZA A RESPOSTA DA PERGUNTA
			$(this).toggleClass("active").next().slideToggle("slow", function(){
				
				// PEGA A REFERENCIA DA TAG <p>, QUE TERA O CONTEUDO PELO RETORNO DO WS 162 CONSULTAR RESPOSTAS.
				var containerResposta = $("p", this);
				
				// VERIFICA SE A TAG <p>, JÁ ESTÁ PREENCHDA COM UMA RESPOSTA
				var html = $.trim(containerResposta.html());
				
				// SE JÁ ESTIVER NÃO CHAMA O SERVIÇO NOVAMENTE
				if (!html) {
					recuperarRespostaFaq(codigoPergunta, containerResposta);
				} else {
					resizeIframeParent();
				}
				
			});
			
		});
	 
	});
		
</script>

	<div class="cabecalho">
		<div class="caminho" style="">
			<a class="linktres" title="<fmt:message key="label.home" />" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}"><fmt:message key="label.home" /></a>&gt;
			<a class="linktres" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC45/dv01"><fmt:message key="label.informacoes" /></a>&gt;
			<a class="linkquatro" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC45/dv01"><fmt:message key="label.perguntasFrequentes" /></a>
		</div>
		<fmt:message key="label.perguntasFrequentes" />
	</div>
	
	
	<form id="formConsultarPerguntas"  method="post" 
		  action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC45/dv01">
		
		<div class="busca_branca">
			<span class="text2"><fmt:message key="label.oqueVcProcura" /></span>
			<input type="text" name="textoConsulta" id="textoConsulta" >
		</div>
	
	
		<div class="busca_cinza">
			<select style="margin-left: 145px;" name="codAssunto" id="codAssunto">
				<option selected="selected"><fmt:message key="label.selecioneAssunto" /></option>
				<c:forEach items="${assuntosPerguntasFaq }" var="assunto">
					<c:if test="${not empty assunto.codAssunto and not empty assunto.descricaoAssunto}">
						<option value="${assunto.codAssunto}">${assunto.descricaoAssunto} </option>
					</c:if>
				</c:forEach>
					<option value="0"><fmt:message key="label.todos" /></option>
			</select>
			
			<input class="button" type="submit" value="<fmt:message key="label.buscar" />">
		</div>
	</form>

	<table class="detalhe" cellspacing="0">
		<tbody>
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.perguntasFrequentes" /></th>
			</tr>
		</tbody>
	</table>
	
	<span class="texthelp2" style="*width:380px;">
		<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" />
		<fmt:message key="uc45.dv01.text.01" />
	</span>
	
	<div style="clear: both;"></div>
	<br />

	<form id="formPerguntasFrequentes" method="post" action="">
		<!-- INICIO PERGUNTAS E RESPOSTAS -->
		<div style="margin-left:50px;"> 
			
			<c:forEach var="pergunta" items="${perguntasFrequentes}" varStatus="status">
				
				
				<h2 class="trigger" id="pergunta_${status.count }">
					<a href="#${pergunta.codPergunta}">${pergunta.pergunta}</a>
				</h2>
				
				<div class="toggle_container"> 
					<div class="block"> 
						<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/question.png" alt="" /> 
						
						<!-- PREENCHIDO PELO RETORNO DA CHAMADA AJAX DA FUNCAO recuperarRespostaFaq(codigoPergunta, resposta); -->
						<p></p> 
						
					</div> 
				</div> 
			</c:forEach>
			
		</div>
	
		<!-- FIM PERGUNTAS E RESPOSTAS -->
	</form>
