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
				Termo para confirma��o de regras de ativa��o.
				<br/><br/>
				Da Aplica��o:
				<br/><br/>
				Este aplicativo foi desenvolvido para permitir agilidade na ativa��o ou desativa��o de equipamentos via portal de atendimento ou dispositivo m�vel. Est� dispon�vel 24 (vinte e quatro) horas por dia para permitir a execu��o de servi�os de maneira r�pida ao t�cnico credenciado na Rede T�cnica da Sascar.
				A correta utiliza��o do aplicativo � de total responsabilidade do t�cnico que o utiliza e da empresa terceirizada que o t�cnico representa, cabendo a Sascar a obrigatoriedade de disponibiliza��o do aplicativo a sua Rede T�cnica.
				<br/><br/>
				Das Obriga��es e Responsabilidade:
				<br/><br/>
				O t�cnico, desde j�, em conjunto com a empresa terceirizada que representa - devidamente homologada pela Sascar - assume todas as responsabilidades sobre os servi�os executados no ve�culo cadastrado nesta ordem de servi�o e tamb�m fica desde j� a disposi��o de efetuar as devidas vistorias no ve�culo, antes e depois da execu��o dos servi�os. Fica tamb�m de acordo a comparecer novamente ao cliente no per�odo de 60 dias caso o cliente venha a ter problemas no ve�culo, frutos de m� execu��o de servi�os.
				O t�cnico que est� executando este servi�o � respons�vel pela boa pr�tica de execu��o, pelo bom atendimento ao cliente e pela correta finaliza��o do servi�o junto ao sistema da Sascar. Caso o t�cnico n�o termine efetivamente a ativa��o do equipamento, esta ordem de servi�o n�o ser� considerada "fechada", permanecendo como "aberta".
				<br/><br/>
				Da Anteced�ncia ao Atendimento e Pontualidade:
				<br/><br/>
				O t�cnico � respons�vel pela chegada ao local de atendimento - seja ponto fixo ou m�vel - com 10 (dez) minutos de anteced�ncia, se identificando junto ao cliente e demonstrando os pap�is de check-list bem como da ordem de servi�o a ser executada.
				<br/><br/>
				Da Perman�ncia no Local:
				<br/><br/>
				O t�cnico deve permanecer no local at� o t�rmino completo da ativa��o do equipamento, em mensagem claro visualizada no aplicado de "OS finalizada" com seus respectivos atributos.
				<br/><br/>
				Do Bloqueio:
				<br/><br/>
				� de inteira responsabilidade do t�cnico instalador o teste de bloqueio caso ele tenha necessidade de ser instalado. O aplicativo far� junto com o t�cnico o teste de bloqueio, baseado no testes das sa�das dos equipamentos. Ser� usado uma legenda por meio de leds que permitem a visualiza��o do comportamento de ativa��o ou desativa��o de bloqueios nos ve�culos.
				Caso seja comprovada neglig�ncia do t�cnico em instala��es de bloqueio, fica por completa responsabilidade do t�cnico e da empresa que representa qualquer fato que venha a acontecer com o ve�culo, inclusive problemas el�tricos/eletr�nicos ou mesmo furto do ve�culo por falta de bloqueio.
				Para melhor medir a performance deste item a Sascar far� auditorias aleat�rias, assim, caso seja constatada neglig�ncia, fica a cargo da Sascar as medidas necess�rias.
				<br/><br/>
				Dos demais Itens de Instala��o ou Desinstala��o:
				<br/><br/>
				O aplicativo j� ir� apresentar os itens necess�rios para instala��o ou desinstala��o, cabe ao t�cnico a verifica��o dos itens de instala��o ou desinstala��o, ficando os mesmos pertencentes ou n�o ao seu estoque e a verifica��o da Sascar a qualquer momento.
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