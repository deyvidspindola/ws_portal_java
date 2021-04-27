<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/VerificarPermissao/montarTela?acao=1" context="/SascarPortalWeb"  />
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

		function preencheCampo(nomeContratante){
			$("#nomeContratante").val(nomeContratante);
		}

		$(document).ready(function(){

			var formsf = getUrlParameter("formsf");

			if(formsf != null && formsf == 'ok'){

				$("#dialog_mensagem .popup_padrao_pergunta").html("Solicita&ccedil;&atilde;o de contato enviada com sucesso.");
				$("#dialog_mensagem").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
			}

			function submeterContato(form) {

				var tipoSelecionado = $(".tipo").val();
				console.log("Tipo selecionado: " + tipoSelecionado);

				var data = $(form).serialize();
				console.log("data: "+data);

				var motivos = $("#motivos").val();
				var placaVeiculo = $("#placaVeiculo").val();

				if(tipoSelecionado == 4){

					var nome = $("#nome").val();
					var email = $("#email").val();
					var telefone = $("#telefone").val();
					var placaVeiculo = $(".placaVeiculo").val();
					var tipo = $(".tipo").val();
					var motivo = $(".motivo").val();
					var mensagem = $("textarea#mensagem").val();

					console.log("nome: "+nome);
					console.log("email: "+email);
					console.log("telefone: "+telefone);
					console.log("placaVeiculo: "+placaVeiculo);
					console.log("tipo: "+tipo);
					console.log("motivo: "+motivo);
					console.log("mensagem: "+mensagem);

					$("#NomeCliente__c").val(nome);
					$("#EmailCliente__c").val(email);
					$("#TelefoneCliente__c").val(telefone);
					$("#Placa__c").val(placaVeiculo);
					$("#MotivoReclamacao__c").val(motivo);
					$("#descricao").val(mensagem);

					$("#submitFormSF").click();

				} else {

					$.ajax({
						url: "/SascarPortalWeb/ContatoServlet/enviarMensagem?acao=1&motivos="+motivos+"&veiculoPlaca="+placaVeiculo,
						data: data || {},
						dataType:"json",
						contentType: "application/x-www-form-urlencoded; charset=UTF-8",
						type: "POST",
						success: function(json){
							if (json.success) {
								$("#dialog_mensagem .popup_padrao_pergunta").html('<fmt:message key="uc48.dv01.texto.05.solicitacaoSucessoProtocolo" />: <font color ="red"><b>'+ json.numeroProtocolo +'</b></font>');
								$("#dialog_mensagem").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
							} else {
								$.showMessage(json.mensagem);
							}
						}
					});
				}

			}
		
			var container = $('div.container2');
			$("#formContato").validate({
				rules: {
					nome: "required",
					email: {
						required: true,
						email: true
					},
					telefone: "required",
					placaVeiculo: "required",
					mensagem: "required",
					motivos: "required",
					nomeContratante :"required"
				},
				messages: {
					nome: '<fmt:message key="mensagem.campoObrigatorio.nome" />',
					email: {
						required: '<fmt:message key="mensagem.campoObrigatorio.email" />',
						email: '<fmt:message key="mensagem.validacao.email" />'
					},
					telefone:  '<fmt:message key="mensagem.campoObrigatorio.telefone" />',
					placaVeiculo: '<fmt:message key="mensagem.campoObrigatorio.placaVeiculo" />',
					mensagem: '<fmt:message key="mensagem.campoObrigatorio.mensagem" />',
					motivos: '<fmt:message key="mensagem.campoObrigatorio.tipo" />',
					nomeContratante: '<fmt:message key="mensagem.campoObrigatorio.nomeContratante" />'
				},
				errorContainer: container,
				errorLabelContainer: $("ol", container),
				wrapper: 'li',
				submitHandler : function(form) {
					submeterContato(form);
				}
			});

			$(".tipo").change(function() {
				var opcao = this.value;
				if(opcao == 4) {
					$("#selectMotivo").show();
				} else {
					$("#selectMotivo").hide();
				}
			});

			$("#telefone").setMask({mask:'(99)9999-99999'});
			
		});

		var getUrlParameter = function getUrlParameter(sParam) {
		    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
		        sURLVariables = sPageURL.split('&'),
		        sParameterName,
		        i;

		    for (i = 0; i < sURLVariables.length; i++) {
		        sParameterName = sURLVariables[i].split('=');

		        if (sParameterName[0] === sParam) {
		            return sParameterName[1] === undefined ? true : sParameterName[1];
		        }
		    }
		};
		
	</script>

<div class="cabecalho4">
    <a class="link_titleatualizacao tooltip" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC48/dv01"  title="<fmt:message key="label.faleConosco" />"><fmt:message key="label.faleConosco" /></a>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a class="link_titleatualizacao tooltip" href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC48/dv02" title="<fmt:message key="label.historicoDeContato" />"><fmt:message key="label.historicoDeContato" /></a>
	
	<div class="caminho" style="*margin-left: 120px;">
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />"  class="linktres"><fmt:message key="label.home" /></a> 
	</div>
</div>

<div class="container2"> 
	<ol>
	</ol>
</div>


<table width="960" cellspacing="0" class="detalhe2" >
  <tr>
     <th width="150" class="barracinza"> <fmt:message key="label.nomeContratante" />: </th>
       <td>
         <input type="text" name="nome" disabled="disabled" id="nomeContratante" value="${param.nomeContatante}" class="text" value="" maxlength="100" size="60" title="Preencha o campo Nome"/>
       </td>
  </tr>
</table>				

<table width="960" cellspacing="0" class="tbatualizacao" >
	<tr class="tbatualizacao">
		<th class="tbatualizacao"><fmt:message key="label.dadosDoContato" /></th>
	</tr>
</table>
<form class="filtro" id="formContato">

	<table width="600" cellspacing="3" class="detalhe2">
			<tr>
				<th width="150" class="barracinza"><fmt:message key="label.nome" /><span class="asterisco"">*</span></th>
				<td class="camposinternos">
					<input type="text" id="nome" name="nome" class="text" value="${param.nome}" maxlength="100" size="40px" title="Preencha o campo Nome"/>
					 <span class="texthelp2" style="position:absolute; margin-left:60px; margin-top: -5px;">
						<img align="absmiddle" width="16" hspace="5" height="16" src="/SascarPortalWeb/sascar/images/corporativo_new/lightbulb32.png"><fmt:message key="uc48.dv01.texto.01.preenchaOsCampos" />
					</span>
				</td>
			</tr>	

			<tr>
				<th width="150" class="barracinza"><fmt:message key="label.email" /><span class="asterisco"">*</span></th>
				<td class="camposinternos">
					<input type="text" id="email" name="email" class="text" value="${param.email}" maxlength="250" size="40px" title="<fmt:message key="uc48.dv01.texto.03.emailDeveSerValido" />"/>
				</td>
			</tr>
			
			<tr>
				<th width="150" class="barracinza"> <fmt:message key="label.telefoneParaContato" /><span class="asterisco">*</span></th>
				<td class="camposinternos">
					<input type="text" name="telefone" id="telefone" class="text" value="${param.telefone}" maxlength="14" size="40px" title="<fmt:message key="uc48.dv01.texto.02.telContatoValido" />"/>
				</td>
			</tr>	
			
			<tr>
				<th width="150" class="barracinza"> <fmt:message key="label.placaVeiculo" /><span class="asterisco">*</span></th>
                <td> <select name="placaVeiculo" id="placaVeiculo"  class="required placaVeiculo" >
			       <option value=""><fmt:message key="label.selecione" /></option>
				     <c:forEach var="contrato" items="${contratos}">
				       <c:if test="${not empty contrato.veiculo.placa && not empty contrato.veiculo.placa}">
				 	     <option value="${contrato.veiculo.placa}">${contrato.veiculo.placa}</option>
				 	     <script> preencheCampo("${contrato.contratante.nome}")</script>
					   </c:if>
				     </c:forEach>
		  	      </select>
                </td>	
			</tr>	
		
		   	<tr>
				<th width="150" class="barracinza"><fmt:message key="label.tipo" /><span class="asterisco">*</span></th>
                <td> 
                	<select name="motivos" id="motivos"  class="required tipo" >
			       		<option value=""><fmt:message key="label.selecione" /></option>
				     	<c:forEach var="motivo" items="${motivos}">
					       	<c:if test="${not empty motivo.identifier && not empty motivo.value}">
					 	    	<option value="${motivo.identifier}">${motivo.value}</option>
					 	   	</c:if>
				    	</c:forEach>
		  	      	</select>
             	</td>
            </tr>	

			<tr id="selectMotivo" style="display:none;">
				<th width="150" class="barracinza">Motivo<span class="asterisco">*</span></th>
				<td>
					<select name="motivo" id="motivo" class="required motivo">
						<option value="Agendamento cancelado">Agendamento cancelado</option>
						<option value="Indisponibilidade de agenda">Indisponibilidade de agenda</option>
						<option value="T&eacute;cnico n&atilde;o compareceu">T&eacute;cnico n&atilde;o compareceu</option>
						<option value="Transfer&ecirc;ncia de titularidade n&atilde;o conclu&iacute;da">Transfer&ecirc;ncia de titularidade n&atilde;o conclu&iacute;da</option>
						<option value="Cancelamento/Downgrade de contrato n&atilde;o conclu&iacute;do">Cancelamento/Downgrade de contrato n&atilde;o conclu&iacute;do</option>
						<option value="Informa&ccedil;&otilde;es contratuais e comerciais">Informa&ccedil;&otilde;es contratuais e comerciais</option>
						<option value="Cobran&ccedil;a indevida">Cobran&ccedil;a indevida</option>
						<option value="N&atilde;o recebimento do boleto">N&atilde;o recebimento do boleto</option>
						<option value="Atendimento ruim">Atendimento ruim</option>
						<option value="Avaria no ve&iacute;culo">Avaria no ve&iacute;culo</option>
						<option value="Problemas t&eacute;cnicos com a solu&ccedil;&atilde;o">Problemas t&eacute;cnicos com a solu&ccedil;&atilde;o</option>
						<option value="Outros assuntos">Outros assuntos</option>
					</select>
				</td>
			</tr>
			
			<tr>
				<th width="150" class="barracinza"> <fmt:message key="label.mensagem" /><span class="asterisco">*</span></th>
				<td class="camposinternos">
					<textarea id="mensagem" name="mensagem" maxlength="32000" class="text" title="Preencha o campo Mensagem" cols="45" rows="5" ></textarea>
				</td>
			</tr>	
			
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;">
					<input type="submit" class="button" value="<fmt:message key="label.enviarMensagem" />" />
					<input type="reset" class="button4" value="<fmt:message key="label.limpar" />"/>
				</td>
			</tr>
			
	</table>

</form>

<div id="divFormSalesforce" style="display:none;">

<form id="formSalesforce" action="${salesforceURL}" method="POST">

<input type="hidden" name="orgid" value="${salesforceId}"/>
<input type="hidden" id="reURL" name="retURL" value=""/>
<input type="hidden" name="priority" id="priority" value="Alto"/>
<input type="hidden" name="SubOrigem__c" id="SubOrigem__c" value="Portal de servi&ccedil;os"/>
<input type="hidden" name="recordType" id="recordType" value="Reclamacao"/>
<input type="hidden" id="subject" maxlength="80" name="subject" size="20" type="text" value="Reclama&ccedil;&atilde;o"/>

<!--  ----------------------------------------------------------------------  -->
<!--  NOTA: Estes campos sÃ£o elementos de depuraÃ§Ã£o opcionais. Remova o       -->
<!--  comentÃ¡rio dessas linhas se quiser testar no modo de depuraÃ§Ã£o.         -->
<!-- <input type="hidden" name="debug" value=1> -->
<!--  <input type="hidden" name="debugEmail" value="mario.pereira.ext@sascar.com.br"> -->
<!--  ----------------------------------------------------------------------  -->

<textarea id="descricao" name="description"></textarea>
<input  id="Placa__c" maxlength="7" name="Placa__c" size="20" type="text" />
<input  id="CNPJ_CPF__c" maxlength="14" name="CNPJ_CPF__c" size="20" type="text" value="${cpf_cnpj}"/>
<input  id="NomeCliente__c" maxlength="100" name="NomeCliente__c" size="20" type="text" />
<input  id="TelefoneCliente__c" maxlength="40" name="TelefoneCliente__c" size="20" type="text" />
<input  id="EmailCliente__c" maxlength="80" name="EmailCliente__c" size="20" type="text" />
<input name="MotivoReclamacao__c" id="MotivoReclamacao__c" value="">

<input id="submitFormSF" type="submit" name="submit">

</form>

</div>
			
<div id="dialog_mensagem" class="popup_padrao" style="display: none;">
	<div class="popup_padrao_pergunta"></div>
	<div class="popup_padrao_resposta">
		<input type="button" class="button" value="Ok" onclick="document.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}'"/>
	</div>
</div>

<script>

$(document).ready(function(){

	var retURL = window.location.href+"&formsf=ok";
	$('input[name="retURL"]').val(retURL);
	$('input[name="retURL"]').val() = retURL;
	$('#retURL').attr('value', retURL);
	
});

</script>