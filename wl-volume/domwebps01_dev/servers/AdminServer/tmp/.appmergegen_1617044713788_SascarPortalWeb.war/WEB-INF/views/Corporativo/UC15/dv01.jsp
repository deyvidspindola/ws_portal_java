<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

	<script type="text/javascript">
	
		function validarCaptcha(form) {
			var data = $(form).serialize();
			$.ajax({
				url: "/SascarPortalWeb/VisualizarDeclaracaoServlet/validarCaptcha?acao=1",
				data: data || {},
				dataType:"json",
				success: function(json){
					if (json.success) {
						validarCodigo(form);
					} else {
						$.showMessage(json.mensagem);
					}
				}
			});
		}
	
		function validarCodigo(form){
			var data = $(form).serialize();
			$.ajax({
				url: "/SascarPortalWeb/VisualizarDeclaracaoServlet/verificarCodigoValidador?acao=2&formato=JSON",
				data: data || {},
				dataType:"json",
				success: function(json){
					if (json.success) {
						$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Imprimir&page=Corporativo/UC15/dv02");
						$(form).unbind('submit').submit();
					} else {
						$.showMessage(json.mensagem);
					}
				}
			});
		}
	
		$(document).ready(function(){
			var container = $('div.container2');
			$("#formPesquisa").validate({
				errorContainer: container,
				errorLabelContainer: $("ol", container),
				wrapper: 'li',
				submitHandler : function(form) {
					validarCaptcha(form);
					return false;
				}
			});
		});
	</script>

		<div class="cabecalho">
			<fmt:message key="label.vizualizarDeclaracao" />
		</div>
	
		<div class="container2"> 
			<ol>
				<li><label for="codigoValidador" class="error"><fmt:message key="mensagem.error.informeCodigoChave" /></label></li>
				<li><label for="codigoVerificador" class="error"><fmt:message key="mensagem.error.informeCodigoVerificador" /></label></li>
			</ol>
		</div>

	<form id="formPesquisa" action="" method="post" class="filtro">
		<div class="busca_cinza">
			<span class="text3">
				<label for="codigoValidador"><fmt:message key="label.digiteCodigoChave" /></label>				
			</span>
			<label>
				<input type="text" name="codigoValidador" id="codigoValidador" class="required" maxlength="22"/>
			</label>
		</div>
		
		<div class="busca_branca">
			<span class="text3"> 
				<label for="codigoVerificador"><fmt:message key="label.digiteTextoImagem" /></label> 
			</span>
			<label>
			  <input type="text" name="codigoVerificador" id="codigoVerificador" class="required" maxlength="6"/>
			</label>
		</div>
		
		<div class="busca_cinza3">
			<div class="captcha"><img src="/SascarPortalWeb/captcha?width=150" alt="" /></div>
		</div>
		
		<div class="busca_branca">
		  <input type="submit" class="button" id="buscar" value="Buscar" />
		  <input type="reset" class="button4" value="Limpar" />
		</div>
	</form>
 
