<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<script type="text/javascript">

	$(document).ready(function(){
	
		$('#ativar_equipamento').addClass('active');
		
		function validarCPF(form) {
			var data = $(form).serialize();
			$("input[type='submit']").attr('disabled', 'disabled');
			$.ajax({
				url: "/SascarPortalWeb/AtivarEquipamentoVinculo/validarCpfInstalador?acao=3",
				data: data || {},
				dataType:"json",
				success: function(json){
					if (json.success) {
						$(form).attr("action", "${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv05&numeroOS=${param.numeroOS }&origem=V");
						$(form).unbind('submit').submit();
					} else {
						$(form).attr("action", "");
						$.showMessage(json.mensagem);
						$("input[type='submit']").removeAttr('disabled');
					}
				}
			});
		}

		var container = $('div.container-error');
		$("#formPesquisa").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form) {
				validarCPF(form);
			}/*,
			showErrors: function(errorMap, errorList) {
				this.defaultShowErrors();
				if (errorList.length) {
					document.location.href = "#top";
				}
		    }*/
		});
		
		//$("#numeroCPF").setMask('cpf');
		
		$('input[name="termoAceite"]').jqTransRadioCheck();
		
		//Cache
		if (document.images) {
			var tick = new Image();
			tick.src = "${pageContext.request.contextPath}/sascar/images/mobile/tick.png";
		}
	});
	
</script>

	<!-- CACHE  -->
	<img src="${pageContext.request.contextPath}/sascar/images/mobile/tick.png" alt="" style="display: none;"/>
	
	<div class="container-error">
		<ol>
			<li><label for="numeroCPF" class="error"><fmt:message key="mensagem.campoObrigatorio.cpfInstalador" /></label></li>
			<li><label for="termoAceite" class="error"><fmt:message key="mensagem.campoObrigatorio.euAceitoTermos" /></label></li>
		</ol>
	</div>

	<form action="" method="post" id="formPesquisa">
		
		<input type="hidden" name="origem" value="V" />
		<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
	
		<fieldset>
			
			<legend><strong><fmt:message key="label.termoUso" /></strong></legend>
			
			<p class="input">
				<label for="numeroCPF">
					<span><fmt:message key="label.cpfInstalador" />:</span><br />
					<input type="text" id="numeroCPF" name="numeroCPF" class="" maxlength="11" value="${param.numeroCPF }"/>
				</label>
			</p>
			
			<p class="input">
				<label><span><fmt:message key="label.termoUso" />:</span></label>
			</p>
			
			<div style="text-align: justify;">
				Termo para confirmação de regras de ativação.
				<br/><br/>
				Da Aplicação:
				<br/><br/>
				Este aplicativo foi desenvolvido para permitir agilidade na ativação ou desativação de equipamentos via portal de atendimento ou dispositivo móvel. Está disponível 24 (vinte e quatro) horas por dia para permitir a execução de serviços de maneira rápida ao técnico credenciado na Rede Técnica da Sascar.
				A correta utilização do aplicativo é de total responsabilidade do técnico que o utiliza e da empresa terceirizada que o técnico representa, cabendo a Sascar a obrigatoriedade de disponibilização do aplicativo a sua Rede Técnica.
				<br/><br/>
				Das Obrigações e Responsabilidade:
				<br/><br/>
				O técnico, desde já, em conjunto com a empresa terceirizada que representa - devidamente homologada pela Sascar - assume todas as responsabilidades sobre os serviços executados no veículo cadastrado nesta ordem de serviço e também fica desde já a disposição de efetuar as devidas vistorias no veículo, antes e depois da execução dos serviços. Fica também de acordo a comparecer novamente ao cliente no período de 60 dias caso o cliente venha a ter problemas no veículo, frutos de má execução de serviços.
				O técnico que está executando este serviço é responsável pela boa prática de execução, pelo bom atendimento ao cliente e pela correta finalização do serviço junto ao sistema da Sascar. Caso o técnico não termine efetivamente a ativação do equipamento, esta ordem de serviço não será considerada "fechada", permanecendo como "aberta".
				<br/><br/>
				Da Antecedência ao Atendimento e Pontualidade:
				<br/><br/>
				O técnico é responsável pela chegada ao local de atendimento - seja ponto fixo ou móvel - com 10 (dez) minutos de antecedência, se identificando junto ao cliente e demonstrando os papéis de check-list bem como da ordem de serviço a ser executada.
				<br/><br/>
				Da Permanência no Local:
				<br/><br/>
				O técnico deve permanecer no local até o término completo da ativação do equipamento, em mensagem claro visualizada no aplicado de "OS finalizada" com seus respectivos atributos.
				<br/><br/>
				Do Bloqueio:
				<br/><br/>
				É de inteira responsabilidade do técnico instalador o teste de bloqueio caso ele tenha necessidade de ser instalado. O aplicativo fará junto com o técnico o teste de bloqueio, baseado no testes das saídas dos equipamentos. Será usado uma legenda por meio de leds que permitem a visualização do comportamento de ativação ou desativação de bloqueios nos veículos.
				Caso seja comprovada negligência do técnico em instalações de bloqueio, fica por completa responsabilidade do técnico e da empresa que representa qualquer fato que venha a acontecer com o veículo, inclusive problemas elétricos/eletrônicos ou mesmo furto do veículo por falta de bloqueio.
				Para melhor medir a performance deste item a Sascar fará auditorias aleatórias, assim, caso seja constatada negligência, fica a cargo da Sascar as medidas necessárias.
				<br/><br/>
				Dos demais Itens de Instalação ou Desinstalação:
				<br/><br/>
				O aplicativo já irá apresentar os itens necessários para instalação ou desinstalação, cabe ao técnico a verificação dos itens de instalação ou desinstalação, ficando os mesmos pertencentes ou não ao seu estoque e a verificação da Sascar a qualquer momento.
				<br/><br/>
				Do Aceite:
				<br/><br/>
				O aceite dos termos aqui visualizados deve ser feito mediante um "clique" na mensagem que aparece logo abaixo a este quadro.
			</div>
		
			<p>
				<input type="checkbox" class="check required" name="termoAceite" id="checkbox0" /><label><fmt:message key="label.concordoTermoCondicoes" /></label>
			</p>
		
			<p class="input" style="padding:10px; margin-top:10px; text-align: center;">
				<input type="submit" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.continuar" />" />
			</p>
	
		</fieldset>
		
	</form>