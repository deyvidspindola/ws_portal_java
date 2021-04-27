<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<script type="text/javascript">

	$(document).ready(function(){

		var container = $('div.container2');
		$("#formTermo").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form) {
				validarCpfInstalador(form);
			}
		});
		
		$("#numeroCPF").setMask('cpf');
	});
	
	function validarCpfInstalador(form) {
	
		var data = $(form).serialize();
		$.ajax({
			url: "/SascarPortalWeb/RetirarEquipamentosAcessorios/validarCpfInstalador?acao=2",
			data: data || {},
			dataType:"json",
			success: function(json){
				if (json.success) {
					$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv03");
					$(form).unbind('submit').submit();
				} else {
					$(form).attr("action", "");
					$.showMessage(json.mensagem);
				}
			}
		});
	}
</script>

	<div class="cabecalho3">
		<div class="caminho3" style="*margin-left:360px;">
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
			<a href="#" class="linktres"><fmt:message key="label.informacoes" /></a> &gt; 
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv01"  class="linkquatro"><fmt:message key="label.retiradaEquipamentoAcessorio" /></a>
		</div>
		<fmt:message key="label.retiradaEquipamentoAcessorio" />	
	</div>				

	<div class="container2"> 
		<ol>
			<li><label for="numeroCPF" class="error"><fmt:message key="mensagem.campoObrigatorio.cpfInstalador" /></label></li>
			<li><label for="termoAceite" class="error"><fmt:message key="mensagem.selecione.concordoTermo" /></label></li>
		</ol>
	</div>

	<table class="detalhe" cellspacing="0">
		<tbody>
			<tr class="barraazulzinha">
				<th class="barraazulzinha"><fmt:message key="label.termoUso" /></th>
			</tr>
		</tbody>
	</table>

	<form action="" method="post" id="formTermo">
	
		<!-- ORIGEM DA CHAMADA : (V - VINCULO, T - TESTES, R - RETIRADA) -->
		<input type="hidden" name="origem"        value="R" />
		
		<input type="hidden" name="numeroOS"      value="${param.numeroOS}" />
		<input type="hidden" name="chassiVeiculo" value="${param.chassiVeiculo}" />
		<input type="hidden" name="placaVeiculo"  value="${param.placaVeiculo}" />
		
		
		<table class="detalhe2" width="600" cellspacing="3">
			<tbody>
				<tr>
					<th class="barracinza" width="200"><fmt:message key="label.cpfInstalador" /><span class="asterisco">*</span></th>
					
					<td class="camposinternos" width="350">
						<input id="numeroCPF" name="numeroCPF" value="" class="required" type="text">
					</td>
				</tr>
				
				<tr>
					<th class="barracinza" width="200"><fmt:message key="label.termoUso" /></th>
					
					<td class="camposinternos" width="350">
						<textarea class="valid" 
								  readonly="readonly" 
								  id="termo" 
								  style="width: 450px; height: 300px; text-align: left;">
							
							Termo para confirma&ccedil;&atilde;o de regras de Retirada de Equipamento e Acess&oacute;rios.

							Das Obriga&ccedil;&otilde;es e Responsabilidade:

							O t&eacute;cnico, desde j&aacute;, em conjunto com a empresa terceirizada que representa - devidamente homologada pela Sascar - assume todas as responsabilidades sobre os servi&ccedil;os executados no ve&iacute;culo cadastrado nesta ordem de servi&ccedil;o e tamb&eacute;m fica desde j&aacute; a disposi&ccedil;&atilde;o de efetuar as devidas vistorias no ve&iacute;culo, antes e depois da execu&ccedil;&atilde;o dos servi&ccedil;os. Fica tamb&eacute;m de acordo a comparecer novamente ao cliente no per&iacute;odo de 60 dias caso o cliente venha a ter problemas no ve&iacute;culo, frutos de m&aacute; execu&ccedil;&atilde;o de servi&ccedil;os.

							O t&eacute;cnico que est&aacute; executando este servi&ccedil;o &eacute; respons&aacute;vel pela boa pr&aacute;tica de execu&ccedil;&atilde;o, pelo bom atendimento ao cliente e pela correta finaliza&ccedil;&atilde;o do servi&ccedil;o junto ao sistema da Sascar. Caso o t&eacute;cnico não termine efetivamente a ativa&ccedil;&atilde;o do equipamento, esta ordem de servi&ccedil;o não ser&aacute; considerada "fechada", permanecendo como "aberta".

							Da Anteced&ecirc;ncia ao Atendimento e Pontualidade:

							O t&eacute;cnico &eacute; respons&aacute;vel pela chegada ao local de atendimento - seja ponto fixo ou m&oacute;vel - com 10 (dez) minutos de anteced&ecirc;ncia, se identificando junto ao cliente e demonstrando os pap&eacute;is de check-list bem como da ordem de servi&ccedil;o a ser executada.

							Da Perman&ecirc;ncia no Local:

							O t&eacute;cnico deve permanecer no local at&eacute; o t&eacute;rmino completo da ativa&ccedil;&atilde;o do equipamento, em mensagem claro visualizada no aplicado de "OS finalizada" com seus respectivos atributos.

							Do Bloqueio:

							&Eacute; de inteira responsabilidade do t&eacute;cnico instalador o teste de bloqueio caso ele tenha necessidade de ser instalado. O aplicativo far&aacute; junto com o t&eacute;cnico o teste de bloqueio, baseado no testes das sa&iacute;das dos equipamentos. Ser&aacute; usado uma legenda por meio de leds que permitem a visualiza&ccedil;&atilde;o do comportamento de ativa&ccedil;&atilde;o ou desativa&ccedil;&atilde;o de bloqueios nos ve&iacute;culos.

							Caso seja comprovada neglig&ecirc;ncia do t&eacute;cnico em instala&ccedil;&otilde;es de bloqueio, fica por completa responsabilidade do t&eacute;cnico e da empresa que representa qualquer fato que venha a acontecer com o ve&iacute;culo, inclusive problemas el&eacute;tricos/eletrônicos ou mesmo furto do ve&iacute;culo por falta de bloqueio.

							Para melhor medir a performance deste item a Sascar far&aacute; auditorias aleat&oacute;rias, assim, caso seja constatada neglig&ecirc;ncia, fica a cargo da Sascar as medidas necess&aacute;rias.

							Dos demais Itens de Instala&ccedil;&atilde;o ou Desinstala&ccedil;&atilde;o:

							O aplicativo j&aacute; ir&aacute; apresentar os itens necess&aacute;rios para instala&ccedil;&atilde;o ou desinstala&ccedil;&atilde;o, cabe ao t&eacute;cnico a verifica&ccedil;&atilde;o dos itens de instala&ccedil;&atilde;o ou desinstala&ccedil;&atilde;o, ficando os mesmos pertencentes ou não ao seu estoque e a verifica&ccedil;&atilde;o da Sascar a qualquer momento.

							Do Aceite:

							O aceite dos termos aqui visualizados deve ser feito mediante um "clique" na mensagem que aparece logo abaixo a este quadro.
						
						</textarea>
	
						<input class="required" name="termoAceite" id="termoAceite" type="checkbox">	
						<span class="termoAceite2"><fmt:message key="label.concordaTermo" /></span>
	
					</td>
				</tr>
			</tbody>
		</table>
	
		<div class="pgstabela">
			<p>
				<input class="button4"  
					   value="<fmt:message key="label.voltar" />" 
					   type="button"
					   onclick="javascript: location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC34/dv01&numeroOS=${param.numeroOS}';" >
				
				<input type="submit" class="button" value="<fmt:message key="label.continuar" />" />
			</p>
		</div>
		
	</form>
