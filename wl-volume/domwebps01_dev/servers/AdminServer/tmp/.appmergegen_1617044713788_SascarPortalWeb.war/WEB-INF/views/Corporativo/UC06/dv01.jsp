<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/RealizarPesquisaOpiniaoServlet/recuperarPesquisaOpiniao?acao=2" context="/SascarPortalWeb"  />
</c:catch>

<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$.showMessage("${mensagem }");
		setTimeout(function(){
			history.back(-1);
		}, 2000);
	</script>
</c:if>

<c:if test="${not empty helper}" >
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>

<c:if test="${empty mensagem }">
	<script type="text/javascript">
		$(document).ready(function(){
			
			function submeterPesquisa(form) {
				var data = $(form).serialize();
	
				$.ajax({
					url: "/SascarPortalWeb/RealizarPesquisaOpiniaoServlet/submeterPesquisaOpiniao?acao=3",
					data: data || {},
					dataType:"json",
					success: function(json){
						if (json.success) {
							$("#dialog_mensagem .popup_padrao_pergunta").html('<fmt:message key="mensagem.sucesso.pesquisa" />');
							$("#dialog_mensagem").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
						} else {
							$.showMessage(json.mensagem);
						}
					}
				});
			}
		
			var container = $('div.container2');
			$("#formPerguntas").validate({
				errorContainer: container,
				errorLabelContainer: $("ol", container),
				wrapper: 'li',
				submitHandler : function(form) {
					submeterPesquisa(form);
				}
			});
		});
	</script>
	
<div class="cabecalho">
	<fmt:message key="label.pesquisaOpiniao" />
	<div class="caminho">
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC06/dv01"  class="linkquatro"><fmt:message key="label.pesquisaOpiniao" /></a>
	</div>
</div>

<div class="container2">
	<ol></ol>
</div>

<div class="busca_branca"><span class="text1"><fmt:message key="label.deixeAquiSuaOpiniao" />:</span></div>

	<c:if test="${not empty formulario and not empty formulario.perguntas}">

		<form class="filtro" id="formPerguntas">
			<fieldset>
		
				<c:forEach var="pergunta" items="${formulario.perguntas }">
					
					<c:if test="${pergunta.tipo eq 'TEXT'}">
						<div>
							<label for="pergunta_${pergunta.codigo }">${pergunta.descricao }</label>
							<input type="text" name="pergunta_${pergunta.codigo }" id="pergunta_${pergunta.codigo }" class="text ${pergunta.requirido ? 'required' : '' }" maxlength="${pergunta.tamanho }" title="Preencha o campo ${pergunta.descricao }" />
						</div>	
					</c:if>
					
					<c:if test="${pergunta.tipo eq 'RADIO'}">
						<div>
							<label>${pergunta.descricao }</label>
							
							<br/>
							
							<c:forEach var="opcao" items="${pergunta.opcoes }" varStatus="status">
								<input class="${pergunta.requirido ? 'required' : '' }" type="radio" name="pergunta_${pergunta.codigo }" id="pergunta_${pergunta.codigo }_radio_${status.count}" value="${opcao.identifier }" title="Preencha o campo ${pergunta.descricao }" />
								<label for="pergunta_${pergunta.codigo }_radio_${status.count}">${opcao.value }</label>
							</c:forEach>
							
						</div>	
					</c:if>
					
					<c:if test="${pergunta.tipo eq 'CHECKBOX'}">
						<div>
							<label>${pergunta.descricao }</label>
							
							<br/>
							
							<c:forEach var="opcao" items="${pergunta.opcoes }" varStatus="status">
								<input class="${pergunta.requirido ? 'required' : '' }" type="checkbox" name="pergunta_${pergunta.codigo }" id="pergunta_${pergunta.codigo }_checkbox_${status.count}" value="${opcao.identifier }" title="Preencha o campo ${pergunta.descricao }" />
								<label for="pergunta_${pergunta.codigo }_checkbox_${status.count}">${opcao.value }</label>
							</c:forEach>
							
						</div>	
					</c:if>
					
					<c:if test="${pergunta.tipo eq 'TEXTAREA'}">
						<div>
							<label for="pergunta_${pergunta.codigo }_textarea">${pergunta.descricao }</label>
							<textarea id="pergunta_${pergunta.codigo }_textarea" name="pergunta_${pergunta.codigo }" class="text ${pergunta.requirido ? 'required' : '' }" title="Preencha o campo ${pergunta.descricao }"></textarea>
							<div style="font-size: 11px;"><fmt:message key="label.restamCaracteresSeremDigitados"><fmt:param><span id="pergunta_${pergunta.codigo }_textarea_charsLeft"></span></fmt:param></fmt:message></div>
							<script type="text/javascript">
								$(document).ready(function(){
									if ($("#pergunta_${pergunta.codigo }_textarea").length) {
										$('#pergunta_${pergunta.codigo }_textarea').limit(${pergunta.tamanho },'#pergunta_${pergunta.codigo }_textarea_charsLeft');
									}
								});
							</script>
						</div>	
					</c:if>
			
				</c:forEach>
				
				<input type="submit" value="<fmt:message key="label.enviar" />" class="button" />
			</fieldset>
		</form>
		
		<div id="dialog_mensagem" class="popup_padrao" style="display: none;">
			<div class="popup_padrao_pergunta"></div>
			<div class="popup_padrao_resposta">
				<input type="button" class="button" value="<fmt:message key="label.fechar" />" onclick="document.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}'"/>
			</div>
		</div>

	</c:if>

</c:if>
