<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/EnviarSolicitacaoLoteServlet/consultarListaSeguradoras?acao=1" context="/SascarPortalWeb"  />
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
	$(document).ready(function(){
		
		var container = $('div.container2');
		$("#formEnviar").validate({
			rules: {
				arquivo: {
					 //RN2
					 accept : "txt",
					 //RN1
					 required: true,
					 //RN4
					 filesize: 1048576 //1Mb (1*1024*1024)
				},
				tiposContrato: "required"
			},
			messages: {
				arquivo: {
					accept : '<fmt:message key="uc49.texto.002.extensaoTXT" />',
					required: '<fmt:message key="uc49.texto.003.campoArquivoInformado" />',
					filesize: '<fmt:message key="uc49.texto.004.tamanhoArquivoexcedeLimite" />'
				},
				tiposContrato:  '<fmt:message key="mensagem.informacao.dataFinalFechamentoValida" />'
			},
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li'			
		});
		
		$.validator.addMethod('filesize', function(value, element, param) {
		    // param = size (en bytes) 
		    // element = element to validate (<input>)
		    // value = value of the element (file name)
		    var size = 0;
		    if ('files' in element) {
		    	size = element.files[0].size;
		    }
		    return this.optional(element) || (size <= param);
		});
		
		$("input[type=file]").filestyle({ 
		     image: "/SascarPortalWeb/sascar/images/corporativo_new/botaoSelecionarArquivo.png",
		     imageheight : 24,
		     imagewidth : 127,
		     width : 250
		 });
		
	});
</script>

<div class="container2"> 
	<ol>
	</ol>
</div>
		
<div class="cabecalho">
	<fmt:message key="uc49.texto.001.enviaSolicitacaoLote" />
	<div class="caminho3" style="*margin-left:38px;">
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
		<a href="#" class="linktres"><fmt:message key="label.servicos" /></a> &gt;
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC49/dv01" class="linkquatro"><fmt:message key="uc49.texto.001.enviaSolicitacaoLote" /></a>
	</div>
</div>

<form id="formEnviar" action="<c:url value="/Satellite?pagename=SascarPortal_Corporativo/SegCorretora&page=Corporativo/UC49/dv02"/>" enctype="multipart/form-data" method="POST">
	<div class="busca_branca" style="height:40px;">
		<span class="texthelp2" style="*width:400px;*margin-top:0px;">
		<img src="/SascarPortalWeb/sascar/images/corporativo_new/lightbulb32.png" width="16" height="16" hspace="5" align="absmiddle" /><fmt:message key="uc49.texto.006.uploadDadosSolicitacao" />
		</span>
	</div>
    <div class="busca_cinza">
		<label>
			<span class="text2"><fmt:message key="label.tipoDeContrato" />:</span>
			<select id="tiposContrato" name="tiposContrato" class="required" >
				<c:if test="${fn:length(listaSeguradora) > 1}">
					<option value=""><fmt:message key="label.selecione" /></option>
				</c:if>
				<c:forEach  var="seguradora" items="${listaSeguradora}">
					<c:if test="${not empty seguradora.identifier and not empty seguradora.value}">
						<option value="${seguradora.identifier}_${seguradora.value}">${seguradora.value}</option>
					</c:if>
				</c:forEach>
			</select>
			
    	</label>

	</div>
	
	<div class="busca_branca">
		<span class="text2"><fmt:message key="label.arquivo" />:</span>  
      	<label>
      	  <input type="file" name="arquivo" id="arquivo" value="" class="file" style="height:25px;"/>
   	  	</label>
 	</div>
	  
	<div class="busca_cinza">
		<input type="submit" class="button" value="<fmt:message key="label.enviarArquivo" />" />
		<input type="reset" class="button4" value="<fmt:message key="label.limpar" />"/>
	</div>
</form>
