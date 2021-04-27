<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<div id="popupPermissao" class="popup_padrao" style="display: none;">
	<div class="popup_padrao_pergunta">
		Permiss&atilde;o de acesso:
		<br />
		<span id="msgPermissao"></span>
	</div>
	<div class="popup_padrao_resposta">
		<input type="button" class="button close" value="Fechar" onclick="document.location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Login';"/>
	</div>
</div>

<div id="popupDefaultError" class="popup_maior" style="display: none;"> 
	<div class="popup_maior_pergunta">
		Desculpe-nos! As informa&ccedil;&otilde;es solicitadas est&atilde;o temporariamente indispon&iacute;veis.	
		<br />Por favor, tente novamente em alguns instantes.</div>
	<div class="popup_maior_resposta">
		<input type="button" class="button" value="Voltar" onclick="history.back(-1);"/>
	</div>
</div>

<div id="loading" class="carregando_padrao">
	<div class="carregando_text">
		<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/ajax-loader.gif" 
			width="16" height="16" hspace="10" border="0" align="absmiddle" />
			Carregando...
	</div>
</div>

<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-31746147-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>