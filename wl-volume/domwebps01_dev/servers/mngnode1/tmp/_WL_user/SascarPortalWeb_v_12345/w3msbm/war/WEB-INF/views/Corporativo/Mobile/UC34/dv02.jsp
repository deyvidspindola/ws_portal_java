<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<script type="text/javascript">

	$(document).ready(function(){
		
		$('#remover_equipamento').addClass('active');
		
		var container = $('div.container-error');
		
		$("#formTermo").validate({
			errorContainer: container,
			errorLabelContainer: $("ol", container),
			wrapper: 'li',
			submitHandler : function(form) {
				validarCpfInstalador(form);
			}
		});
		
		$("#numeroCPF").setMask('cpf');
		$('input[name="termoAceite"]').jqTransRadioCheck();
		
		//Cache
		if (document.images) {
			var tick = new Image();
			tick.src = "${pageContext.request.contextPath}/sascar/images/mobile/tick.png";
		}
		
	});
	
	function validarCpfInstalador(form) {
	
		var data = $(form).serialize();
		$("input[type='submit']").attr('disabled', 'disabled');
		$.ajax({
			url: "/SascarPortalWeb/RetirarEquipamentosAcessorios/validarCpfInstalador?acao=2",
			data: data || {},
			type: "GET",
			dataType:"json",
			success: function(json){
				if (json.success) {
					$(form).attr("action", "${pageContext.request.contextPath}/Satellite");
					$(form).unbind('submit').submit();
				} else {
					$(form).attr("action", "");
					$.showMessage(json.mensagem);
					$("input[type='submit']").removeAttr('disabled');
				}
			}
		});
	}
	
</script>

	<!-- CACHE  -->
	<img src="${pageContext.request.contextPath}/sascar/images/mobile/tick.png" alt="" style="display: none;"/>
	
	<div class="container-error">
		<ol>
			<li><label for="numeroCPF" class="error"><fmt:message key="mensagem.campoObrigatorio.cpfInstalador" /></label></li>
			<li><label for="termoAceite" class="error"><fmt:message key="mensagem.campoObrigatorio.euAceitoTermos" /></label></li>
		</ol>
	</div>
	
	<form action="" method="get" id="formTermo">
		
		<input type="hidden" name="pagename" value="SascarPortal_Corporativo/Mobile/RepresentanteTecnico" />
		<input type="hidden" name="page"     value="Corporativo/Mobile/UC34/dv03" />
	
		<!-- ORIGEM DA CHAMADA : (V - VINCULO, T - TESTES, R - RETIRADA) -->
		<input type="hidden" name="origem"        value="R" />
		
		<input type="hidden" name="numeroOS"      value="${param.numeroOS}" />
		<input type="hidden" name="chassiVeiculo" value="${param.chassiVeiculo}" />
		<input type="hidden" name="placaVeiculo"  value="${param.placaVeiculo}" />
	
		<fieldset>
			
			<legend><strong><fmt:message key="label.termosDeUso" /></strong></legend>
			
			<p class="input">
				<label for="numeroCPF">
					<span><fmt:message key="label.cpfDoInstalador" />:</span><br />
					<input id="numeroCPF" name="numeroCPF" value="" class="required" type="text">
				</label>
			</p>
			
			<p class="input">
				<label><span><fmt:message key="label.termosDeUso" />:</span></label>
			</p>
			
			<div style="text-align: justify;">
				Termo para confirma&ccedil;&atilde;o de regras de Retirada de Equipamento e Acess&oacute;rios.
				<br/><br/>
				Das Obriga&ccedil;&otilde;es e Responsabilidade:
				<br/><br/>
				O t&eacute;cnico, desde j&aacute;, em conjunto com a empresa terceirizada que representa - devidamente homologada pela Sascar - assume todas as responsabilidades sobre os servi&ccedil;os executados no ve&iacute;culo cadastrado nesta ordem de servi&ccedil;o e tamb&eacute;m fica desde j&aacute; a disposi&ccedil;&atilde;o de efetuar as devidas vistorias no ve&iacute;culo, antes e depois da execu&ccedil;&atilde;o dos servi&ccedil;os. Fica tamb&eacute;m de acordo a comparecer novamente ao cliente no per&iacute;odo de 60 dias caso o cliente venha a ter problemas no ve&iacute;culo, frutos de m&aacute; execu&ccedil;&atilde;o de servi&ccedil;os.
				<br/><br/>			
				O t&eacute;cnico que est&aacute; executando este servi&ccedil;o &eacute; respons&aacute;vel pela boa pr&aacute;tica de execu&ccedil;&atilde;o, pelo bom atendimento ao cliente e pela correta finaliza&ccedil;&atilde;o do servi&ccedil;o junto ao sistema da Sascar. Caso o t&eacute;cnico n&atilde;o termine efetivamente a ativa&ccedil;&atilde;o do equipamento, esta ordem de servi&ccedil;o n&atilde;o ser&aacute; considerada "fechada", permanecendo como "aberta".
				<br/><br/>
				Da Anteced&ecirc;ncia ao Atendimento e Pontualidade:
				<br/><br/>
				O t&eacute;cnico &eacute; respons&aacute;vel pela chegada ao local de atendimento - seja ponto fixo ou m&oacute;vel - com 10 (dez) minutos de anteced&ecirc;ncia, se identificando junto ao cliente e demonstrando os pap&eacute;is de check-list bem como da ordem de servi&ccedil;o a ser executada.
				<br/><br/>
				Da Perman&ecirc;ncia no Local:
				<br/><br/>
				O t&eacute;cnico deve permanecer no local at&eacute; o t&eacute;rmino completo da ativa&ccedil;&atilde;o do equipamento, em mensagem claro visualizada no aplicado de "OS finalizada" com seus respectivos atributos.
				<br/><br/>
				Do Bloqueio:
				<br/><br/>
				&Eacute; de inteira responsabilidade do t&eacute;cnico instalador o teste de bloqueio caso ele tenha necessidade de ser instalado. O aplicativo far&aacute; junto com o t&eacute;cnico o teste de bloqueio, baseado no testes das sa&iacute;das dos equipamentos. Ser&aacute; usado uma legenda por meio de leds que permitem a visualiza&ccedil;&atilde;o do comportamento de ativa&ccedil;&atilde;o ou desativa&ccedil;&atilde;o de bloqueios nos ve&iacute;culos.
				<br/><br/>
				Caso seja comprovada neglig&ecirc;ncia do t&eacute;cnico em instala&ccedil;&otilde;es de bloqueio, fica por completa responsabilidade do t&eacute;cnico e da empresa que representa qualquer fato que venha a acontecer com o ve&iacute;culo, inclusive problemas el&eacute;tricos/eletrônicos ou mesmo furto do ve&iacute;culo por falta de bloqueio.
				<br/><br/>
				Para melhor medir a performance deste item a Sascar far&aacute; auditorias aleat&oacute;rias, assim, caso seja constatada neglig&ecirc;ncia, fica a cargo da Sascar as medidas necess&aacute;rias.
				<br/><br/>
				Dos demais Itens de Instala&ccedil;&atilde;o ou Desinstala&ccedil;&atilde;o:
				<br/><br/>
				O aplicativo j&aacute; ir&aacute; apresentar os itens necess&aacute;rios para instala&ccedil;&atilde;o ou desinstala&ccedil;&atilde;o, cabe ao t&eacute;cnico a verifica&ccedil;&atilde;o dos itens de instala&ccedil;&atilde;o ou desinstala&ccedil;&atilde;o, ficando os mesmos pertencentes ou n&atilde;o ao seu estoque e a verifica&ccedil;&atilde;o da Sascar a qualquer momento.
				<br/><br/>
				Do Aceite:
				<br/><br/>
				O aceite dos termos aqui visualizados deve ser feito mediante um "clique" na mensagem que aparece logo abaixo a este quadro.
			</div>
			
			<br/><br/><br/>
					
			<p>
				<input type="checkbox" class="check required" name="termoAceite" id="checkbox0" />
				<label><fmt:message key="label.euAceitoTermos" /></label>
			</p>
		
			<p class="input" style="padding:10px; margin-top:10px; text-align: center;">
				<input type="submit" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.continuar" />" />
			</p>
	
		</fieldset>
		
	</form>
	
<jsp:include page="/WEB-INF/views/Corporativo/Mobile/icones.jsp">
	<jsp:param name="voltar" value="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC34/dv01&numeroOS=${param.numeroOS}"/>
</jsp:include>