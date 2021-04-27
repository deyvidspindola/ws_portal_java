<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<script type="text/javascript">
	function validarCPF(form) {
		var data = $(form).serialize();
		var possuiRede= $('#isPossuiRedeAcessorio').val();
		console.log('possui rede:' + possuiRede);
		$.ajax({
			url: "/SascarPortalWeb/AtivarEquipamentoVinculo/validarCpfInstalador?acao=3",
			data: data || {},
			dataType:"json",
			success: function(json){
				if (json.success) {
					if(possuiRede === 'true'){
						$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv05_rede");
					}else{
						$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv05");
					}
					$(form).unbind('submit').submit();
				} else {
					$(form).attr("action", "");
					$.showMessage(json.mensagem);
				}
			}
		});
	}

	$(document).ready(function(){

		var container = $('div.container2');
		$("#formTermo").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form) {
				validarCPF(form);
			}
		});
		
		$("#numeroCPF").setMask('cpf');
	});
</script>


<div class="cabecalho">
	<div class="caminho" style="*margin-left:400px;">
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
		<a href="#" class="linktres"><fmt:message key="label.servicos" /></a> &gt; 
		<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv01" class="linkquatro"><fmt:message key="label.ativacaoEquipamento" /></a>
	</div>
  	<fmt:message key="label.ativacaoEquipamento" />
</div>
 
 
<div class="container2"> 
	<ol>
		<li><label for="numeroCPF" class="error"><fmt:message key="mensagem.informacao.campoCPFInstalador" /></label></li>
		<li><label for="termoAceite" class="error"><fmt:message key="mensagem.aviso.campoLiAcordo" /></label></li>
	</ol>
</div>


<table cellspacing="0" class="detalhe" >
	<tr class="barraazulzinha">
		<th class="barraazulzinha"><fmt:message key="label.termoUso" /></th>
	</tr>
</table>


<form action="" method="post" id="formTermo">
	<input type="hidden" name="origem" value="V" />
	<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
	<input type="hidden" name="numeroContrato" value="${param.numeroContrato }" />
	<input type="hidden" id="isPossuiRedeAcessorio" name="isPossuiRedeAcessorio" value="${param.isPossuiRedeAcessorio }" />
	
	<table width="600" cellspacing="3" class="detalhe2">
		<tr>
			<th width="200" class="barracinza"><fmt:message key="label.cpfInstalador" /><span class="asterisco">*</span></th>
			<td width="350" class="camposinternos">
				<input type="text" id="numeroCPF" name="numeroCPF" value="${param.numeroCPF }" class="required" maxlength="11"/>
			</td>
		</tr>
	    <tr>
			<th width="200" class="barracinza"><fmt:message key="label.termoUso" /></th>
			<td width="350" class="camposinternos">
				<textarea readonly="readonly" id="termo" style="width: 450px; height: 300px; text-align:left;" >Termo para confirma&ccedil;&atilde;o de regras de ativa&ccedil;&atilde;o.
	
Da Aplica&ccedil;&atilde;o:
					 
Este aplicativo foi desenvolvido para permitir agilidade na ativa&ccedil;&atilde;o ou desativa&ccedil;&atilde;o de equipamentos via portal de atendimento ou dispositivo m&oacute;vel. Est&aacute; dispon&iacute;vel 24 (vinte e quatro) horas por dia para permitir a execu&ccedil;&atilde;o de servi&ccedil;os de maneira r&aacute;pida ao t&eacute;cnico credenciado na Rede T&eacute;cnica da Sascar.

A correta utiliza&ccedil;&atilde;o do aplicativo &eacute; de total responsabilidade do t&eacute;cnico que o utiliza e da empresa terceirizada que o t&eacute;cnico representa, cabendo a Sascar a obrigatoriedade de disponibiliza&ccedil;&atilde;o do aplicativo a sua Rede T&eacute;cnica.
					
Das Obriga&ccedil;&otilde;es e Responsabilidade:
					
O t&eacute;cnico, desde j&aacute;, em conjunto com a empresa terceirizada que representa - devidamente homologada pela Sascar - assume todas as responsabilidades sobre os servi&ccedil;os executados no ve&iacute;culo cadastrado nesta ordem de servi&ccedil;o e tamb&eacute;m fica desde j&aacute; a disposi&ccedil;&atilde;o de efetuar as devidas vistorias no ve&iacute;culo, antes e depois da execu&ccedil;&atilde;o dos servi&ccedil;os. Fica tamb&eacute;m de acordo a comparecer novamente ao cliente no per&iacute;odo de 60 dias caso o cliente venha a ter problemas no ve&iacute;culo, frutos de m&aacute; execu&ccedil;&atilde;o de servi&ccedil;os.

O t&eacute;cnico que est&aacute; executando este servi&ccedil;o &eacute; respons&aacute;vel pela boa pr&aacute;tica de execu&ccedil;&atilde;o, pelo bom atendimento ao cliente e pela correta finaliza&ccedil;&atilde;o do servi&ccedil;o junto ao sistema da Sascar. Caso o t&eacute;cnico n&atilde;o termine efetivamente a ativa&ccedil;&atilde;o do equipamento, esta ordem de servi&ccedil;o n&atilde;o ser&aacute; considerada "fechada", permanecendo como "aberta".
					
Da Anteced&ecirc;ncia ao Atendimento e Pontualidade:
					
O t&eacute;cnico &eacute; respons&aacute;vel pela chegada ao local de atendimento - seja ponto fixo ou m&oacute;vel - com 10 (dez) minutos de anteced&ecirc;ncia, se identificando junto ao cliente e demonstrando os pap&eacute;is de check-list bem como da ordem de servi&ccedil;o a ser executada.
					
Da Perman&ecirc;ncia no Local:
					
O t&eacute;cnico deve permanecer no local at&eacute; o t&eacute;rmino completo da ativa&ccedil;&atilde;o do equipamento, em mensagem claro visualizada no aplicado de "OS finalizada" com seus respectivos atributos.
					
Do Bloqueio:
					
&Eacute; de inteira responsabilidade do t&eacute;cnico instalador o teste de bloqueio caso ele tenha necessidade de ser instalado. O aplicativo far&aacute; junto com o t&eacute;cnico o teste de bloqueio, baseado no testes das sa&iacute;das dos equipamentos. Ser&aacute; usado uma legenda por meio de leds que permitem a visualiza&ccedil;&atilde;o do comportamento de ativa&ccedil;&atilde;o ou desativa&ccedil;&atilde;o de bloqueios nos ve&iacute;culos.

Caso seja comprovada neglig&ecirc;ncia do t&eacute;cnico em instala&ccedil;&otilde;es de bloqueio, fica por completa responsabilidade do t&eacute;cnico e da empresa que representa qualquer fato que venha a acontecer com o ve&iacute;culo, inclusive problemas el&eacute;tricos/eletr&ocirc;nicos ou mesmo furto do ve&iacute;culo por falta de bloqueio.

Para melhor medir a performance deste item a Sascar far&aacute; auditorias aleat&oacute;rias, assim, caso seja constatada neglig&ecirc;ncia, fica a cargo da Sascar as medidas necess&aacute;rias.
					
Dos demais Itens de Instala&ccedil;&atilde;o ou Desinstala&ccedil;&atilde;o:
					
O aplicativo j&aacute; ir&aacute; apresentar os itens necess&aacute;rios para instala&ccedil;&atilde;o ou desinstala&ccedil;&atilde;o, cabe ao t&eacute;cnico a verifica&ccedil;&atilde;o dos itens de instala&ccedil;&atilde;o ou desinstala&ccedil;&atilde;o, ficando os mesmos pertencentes ou n&atilde;o ao seu estoque e a verifica&ccedil;&atilde;o da Sascar a qualquer momento.
					
Do Aceite:
					
O aceite dos termos aqui visualizados deve ser feito mediante um "clique" na mensagem que aparece logo abaixo a este quadro.
				</textarea>
				
				<input type="checkbox" class="required" name="termoAceite" id="termoAceite" />
				<span class="termoAceite2"> <fmt:message key="label.concordaTermo" /></span>
			</td>
		</tr>
	</table>
	
	<div class="pgstabela">
		<p>
			<input type="button" class="button4" value="<fmt:message key="label.voltar" />" onclick="window.location.href = '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv03&numeroOS=${param.numeroOS }'" />
	        <input type="submit" class="button" value="<fmt:message key="label.continuar" />" />
		</p>
	</div>
</form>
