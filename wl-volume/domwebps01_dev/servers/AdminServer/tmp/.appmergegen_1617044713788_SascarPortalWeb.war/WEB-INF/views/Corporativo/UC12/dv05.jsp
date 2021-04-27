<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<script type="text/javascript">
	function submeterEmailNFe(form) {
		var data = $(form).serialize();
		$.ajax({
			url : "${pageContext.request.contextPath}/LoginUsuarioServlet?acao=10",
			data : data || {},
			cache : false,
			dataType : "json",
			success : function(json) {
				if (json.success) {
					window.parent.location.reload();
				} else {
					$.showMessage(json.mensagem);
				}
			}
		});
	}
			
	$(document).ready(function() {
		var container = $('#popupEmailNFe div.container2');
		$("#formCadastroEmailNFe").validate({
			errorContainer : container,
			errorLabelContainer : $("ol", container),
			wrapper : 'li',
			rules : {
				email : {
					required : true,
					email : true
				},
				confirmacaoEmail : {
					required : true,
					email : true,
					equalTo : "#email"
				}
			},
			messages : {
				email : {
					required : '<fmt:message key="mensagem.campoObrigatorio.email" />',
					email : '<fmt:message key="mensagem.campoInvalido.email" />'
				},
				confirmacaoEmail : {
					required : '<fmt:message key="mensagem.campoObrigatorio.confirmacaoEmail" />',
					email : '<fmt:message key="mensagem.campoInvalido.confirmacaoEmail" />',
					equalTo : '<fmt:message key="mensagem.campoInvalido.confirmacaoEmailNotEquals" />'
				}
			},
			submitHandler : function(form) {
				submeterEmailNFe(form);
				return false;
			}
		});
	});
</script>

<div id="popupEmailNFe">
	<div id="popup_bordacima"></div>
  	
	<div id="popupEmailNFeinterior">
			
  		<div class="container2">
			<ol></ol>
		</div>

		<form action="" name="formCadastroEmailNFe" id="formCadastroEmailNFe" method="post">
			  
			<input type="hidden" name="acao" value="10" />

			<b><fmt:message key="label.comunicadoImportante" /></b>

			<p><fmt:message key="label.prezadoCliente" />,</p>
			
			<p>
				Em cumprimento da legisla&ccedil;&atilde;o da Escritura&ccedil;&atilde;o Fiscal Digital, a SASCAR TECNOLOGIA E 
				SEGURAN&Ccedil;A AUTOMOTIVA S/A passar&aacute; a emitir a Nota Fiscal Eletr&ocirc;nica (NF-e) a partir  
				de Agosto de 2011. 
			</p>
			<p>
				O arquivo eletr&ocirc;nico gerado com a emiss&atilde;o de NF-e ser&aacute; disponibilizada a todos os nossos 
				clientes via e-mail, para isso, &eacute; indispens&aacute;vel que tenhamos em m&atilde;os o endere&ccedil;o de e-mail do 
				respons&aacute;vel pelo recebimento da NF-e em sua empresa.
			</p>
			
			<b><fmt:message key="label.informeSeuEmail" /></b>
			
			<table width="100%" cellspacing="3" class="detalhe2">
				<tr>
					<th style="font-size: 12px; text-align: right; width: 140px;"><fmt:message key="label.email" />*</th>
					<td style="text-align: left;" class="camposinternos">
						<input style="width: 280px;" type="text" name="email" id="email" class="text required email" maxlength="50"/>
					</td>
				</tr>
				
				<tr>
					<th style="font-size: 12px; text-align: right; width: 140px;"><fmt:message key="label.confirmacaoEmail" />*</th>
					<td class="camposinternos">
						<input style="width: 280px;" type="text" name="confirmacaoEmail" id="confirmacaoEmail" class="text required email" maxlength="50"/>
					</td>
				</tr>
				
				<tr>
					<td colspan="2" style="text-align: right;">
						<input name="enviar" type="submit" class="buttonEmailNF" style="*margin-left:25px; *width:60px;" value="<fmt:message key="label.enviar" />" />
					<td>
				</tr>
				
			</table>
			
		</form>
		
	</div>
  <div id="popupEmailNFe_bordarodape"></div>
  	
</div>	