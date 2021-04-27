<jsp:directive.include file="/WEB-INF/views/includes.jsp" />

<c:catch var="helper">
	<c:import url="/LoginUsuarioServlet?acao=6" context="/SascarPortalWeb" />
</c:catch>

<c:if test="${not empty helper}">
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>

<script type="text/javascript">
	function doLogin() {
		if ($.trim(document.formLogin.password.value) != '') {
			document.formLogin.senha.value = MD5($.trim(document.formLogin.password.value.toUpperCase()));
		}

		document.formLogin.logon.value = $.trim(document.formLogin.logon.value.toUpperCase());
		if (document.formLogin.usuario != undefined) {
			document.formLogin.usuario.value = $.trim(document.formLogin.usuario.value.toUpperCase());
		}

		document.formLogin.page.value = '';
		document.formLogin.plataform.value = navigator.platform;
		document.formLogin.action = '/SascarPortalWeb/LoginUsuarioServlet?acao=1';
		document.formLogin.submit();
	}

	function mudarTipoCliente(img) {
		// Imagem Clicada
		var img = $(img);
		var srcClick = img.attr('src');
		var campos = img.attr('campos');

		// Mudar a imagem de todos que nao foram clicados
		$("#loginnavtopo img").each(function() {
			var src = $(this).attr('src');
			if (img.attr('src') != src) {
				$(this).attr('src', src.replace("on", "off"));
			}
		});

		img.attr('src', srcClick.replace('off', 'on'));
		$("input[name='tipoUsuario']").val(img.attr('userType'));
		$('#loginnav').css('background', img.attr('color'));
		$('#loginform2 label').hide();
		$(campos).show();
	}

	$(document).ready(function() {
		$("form #password").keypress(function(e) {
			if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)) {
				doLogin();
				return false;
			}
			return true;
		});

		$("#loginnavtopo img").click(function() {
			mudarTipoCliente(this);
		});

		<c:if test="${not empty msgError}">
		$.showMessage("${msgError}");
		</c:if>
		
		if($("#operacaoNaoPermitida").val()){
			$.showMessage("<fmt:message key="mensagem.funcionalidadeNaoDisponivelPerfil" />");
		}
		
	});
</script>

<div id="divlogin">

	<form name="formLogin" id="formLogin" method="post">
		<div id="login">
			<input type="hidden" name="tipoUsuario" value="CL" /> 
			<input type="hidden" name="page" value="" /> 
			<input type="hidden" name="plataform" value="" /> 
			<input type="hidden" name="senha" value="" />
			<input type="hidden" name="operacaoNaoPermitida" id="operacaoNaoPermitida" value="${param.operacaoNaoPermitida}" />
			

			<div id="loginnavtopo">
				<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/login_cliente_on.png" border="0" userType="CL" color="#CCCCCC" style="cursor: pointer;" campos="#usuarioLabel, #loginLabel, #passwordLabel" /> 
				<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/login_representante_off.png" border="0" style="margin-left: -5px; cursor: pointer;" userType="RT" color="#4083CB" campos="#loginLabel, #passwordLabel" />
				<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/login_seguradora_off.png" border="0" style="margin-left: -5px; cursor: pointer;" userType="SC" color="#005084" campos="#loginLabel, #passwordLabel" />
			</div>

			<div id="loginnav"></div>
			<div id="loginform">

				<div id="loginform2">
					<label id="usuarioLabel" class="login">
						<fmt:message key="label.usuario" />
						<input class="login" type="text" name="usuario" id="usuario" value="" maxlength="40" style="text-transform: uppercase" />
					</label> 
					<br />
					<label id="loginLabel" class="login">
						<fmt:message key="label.login" /> <input class="login" type="text" name="login" id="logon" value="" maxlength="20" style="text-transform: uppercase" />
					</label> 
					<br />
					<label id="passwordLabel" class="login">
						<fmt:message key="label.senha" /> <input class="login" type="password" name="password" id="password" value="" maxlength="20" style="text-transform: uppercase; *width:149px;" /> <br />
						<span><a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Login&page=Corporativo/UC12/dv02" class="esquecersenha"><fmt:message key="uc12.dv01.label.esqueceuSuaSenha" /></a></span> 
					</label>
				</div>

				<div id="divBotaologin">
					<input type="submit" class="btnLogin" value="<fmt:message key="label.entrar"/>" onclick="doLogin()" />
				</div>

			</div>
			<span class="texthelp2" style="text-align:justify;"  ><br /> 
				<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/lightbulb32.png" width="13" height="13" />
				<fmt:message key="uc12.dv01.label.atencao" />			
			</span>
		</div>
	</form>

	<div id="userncadastrado">
		<span class="text_nouser"><fmt:message key="uc12.dv01.label.voceTemAcesso" /></span>
		<div id="userimg"></div>
		<p class="text_nouser2"><fmt:message key="uc12.dv01.label.cadastreAqui" /></p>
		<div id="botaocadastro">
			<form method="post" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Login">
				<input type="hidden" name="page" value="Corporativo/UC12/dv03" /> 
				<input name="button2" type="submit" class="button" id="button2" value="<fmt:message key="label.cadastrar"/>" />
			</form>
		</div>
	</div>
</div>


