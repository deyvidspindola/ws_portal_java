<jsp:directive.include file="/WEB-INF/views/includes.jsp" />

<script>
function submeterContratante() {
	$.ajax({
		url:  "/SascarPortalWeb/EfetuarAtualizacaoCadastral/submeterContratante",
		data: {"acao" : 10, "dados_atualizados" : "true"},
		dataType:"json",
		type :"POST",
		success: function(json){
			window.location='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&usuarioIndicadorId=indicadorAtualizacaoCadastral&from_link=yes';
		}
	});
}

function atualizarMaisTarde() {
	$.ajax({
		url:  "/SascarPortalWeb/EfetuarAtualizacaoCadastral/submeterAdiarAtualizao",
		data: {"acao" : 13, "dados_atualizados" : "true"},
		dataType:"json",
		type :"POST",
		success: function(json){
			window.location='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&usuarioIndicadorId=indicadorAtualizacaoCadastral&from_link=yes';
		}
	});
}

$(document).ready(function() {
	<c:if test="${not param.adiarAtualizacao}">
		$("#btnAdiarAtualizacao").hide();
	</c:if>
});




</script>

<div id="popupAtualizacaoCadastral" >
	<div id="popup_bordacima"></div>

	<div id="popupAtualizacaoCadastralinterior" style="height:403px;*height: 478px">
			<b><fmt:message key="label.comunicadoImportante" />:</b>		
		<p>
		
		Identificamos que seus dados cadastrais n&atilde;o foram atualizados nos &uacute;ltimos 
		90 dias. Para garantir que a Sascar tenha uma comunica&ccedil;&atilde;o &aacute;gil e eficiente
		mantenha seus dados atualizados.	
		
		</p>
		<p>
		
		<!--
		    
		    NOVO TEXTO:
		
		    Os dados cadastrais s&atilde;o importantes para comunica&ccedil;&atilde;o:

            Telefones de pessoas de emerg&ecirc;ncia: acionamento de bot&atilde;o de p&acirc;nico e ocorr&ecirc;ncia.

            Telefones de pessoas de autorizadas: valida&ccedil;&atilde;o de acesso de entrada na Central de Atendimento.

            Email: informar agendamento de ordem de servi&ccedil;o e comunicado de altera&ccedil;&otilde;es de sistema.
        
            Email NFe: envio de Nota Fiscal Eletr&ocirc;nica.
	
		 -->
		 
		Os dados cadastrais s&atilde;o importantes para comunica&ccedil;&atilde;o:
       
        </p>		
		<p>
		<font color= red><b>Telefones de pessoas de emerg&ecirc;ncia:</b> </font>acionamento de bot&atilde;o de p&acirc;nico e ocorr&ecirc;ncia.
		</p>
		<p>
		<font color= red><b>Telefones de pessoas autorizadas:</b></font> valida&ccedil;&atilde;o de acesso de entrada na Central de Atendimento.
		</p>
		<p>
		<font color= red><b> Email:</b></font> informar agendamento de ordem de servi&ccedil;o e comunicado de altera&ccedil;&otilde;es de sistema.
		</p>
		<p>
		<font color= red><b> Email NFe:</b></font> envio de Nota Fiscal Eletr&ocirc;nica.
		</p>
		<p>
		<font color= red><b> Fatura:</b></font> recebimento da fatura somente por e-mail.
		</p>
	<c:if test="${param.placaFicticia eq 'Show'}" >
		<p>
		 <font color= red><b>Importante: </b></font>Existe(m) placa(s) de ve&iacute;culo(s) com dados fict&iacute;cios que precisam ser atualizados.
		</p>
	</c:if>
	
		<p>
		
		    <input type="button" 
					class="button" 
					value="<fmt:message key="label.atualizarMaisTarde" />" id="btnAdiarAtualizacao"
					onclick="atualizarMaisTarde();">
			<input type="button" 
					class="button" 
					value="<fmt:message key="label.atualizarDados" />"
				    onclick="window.location='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC08/dv01&usuarioIndicadorId=indicadorAtualizacaoCadastral&from_link=yes'">
		</p>
	</div>

	<div id="popupAtualizacaoCadastral_bordarodape"></div>
</div>


