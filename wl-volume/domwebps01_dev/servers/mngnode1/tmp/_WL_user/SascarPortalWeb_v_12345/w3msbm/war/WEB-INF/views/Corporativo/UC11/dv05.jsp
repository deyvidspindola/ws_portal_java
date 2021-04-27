<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper" >
	<c:import url="/AgendarOrdemServico/listarHorariosDisponiveisAgendamento?acao=8" context="/SascarPortalWeb"  />
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
		$(document).ready(function() {
		
			var container = $('#msgErrorFormBuscaAgendamento');
			$("#formListaHorariosAgendamento").validate({
				errorContainer: container,
				errorLabelContainer: $("ol", container),
				wrapper: 'li',
				submitHandler : function(){
				
					var horarioCheck = $('#formListaHorariosAgendamento :checked');
					
					var tds = horarioCheck.parents('tr').find('td');
					var selectLocalInstalacao = $('select[name="localInstalacao"]');
					
					var dataHora 	= $.trim($(tds[1]).html());
	
					if (selectLocalInstalacao.val() == "R") {
						$('input[name="nomeContato"]').attr('disabled', false);
						$('input[name="numeroTelefone"]').attr('disabled', false);
						$('textarea[name="observacao"]').attr('disabled', false);
						$('input[name="descricao"]').attr('disabled', true);
						$('input[name="descricaoEndereco"]').attr('readonly', true).val(endereco);
					}
	
					if (selectLocalInstalacao.val() == "C") {
						$('input[name="descricao"]').attr('disabled', false);
						$('input[name="descricaoEndereco"]').val('').attr('readonly', false);
						$('input[name="nomeContato"]').attr('disabled', false);
						$('input[name="numeroTelefone"]').attr('disabled', false);
						$('textarea[name="observacao"]').attr('disabled', false);
					}
	
					$('input[name="dataHora"]').val(dataHora);
	
					$.closeOverlay();
	
					return false;
				}
			});
			
		});
	</script>


	<c:if test="${not empty agendamentos}">
	
		<div class="texthelp" id="divlembretepopup_agendar_ordem_servico">
			<img src="${pageContext.request.contextPath}/sascar/images/corporativo_new/Copia de clock32.png" 
				 width="16" 
				 height="16" 
				 hspace="5" 
				 align="baseline" />
			${agendamentos[0].instrucao}
		</div>
		
		<form action="" method="post" name="formListaHorariosAgendamento" id="formListaHorariosAgendamento" style="height:325px;">
		
			<div id="divbuscapopup_popup_agendar_ordem_servico"  >
				<table width="850" border="0" cellpadding="0px" class="popup" cellspacing="0">
					<tr>
						<th width="28" class="texttable_azul">&nbsp;</th>
						<th width="240" class="texttable_azul"><fmt:message key="label.dataHora" /></th>
					</tr>
				</table>
						
				<div style="height:200px; overflow:auto;">
					<table width="838" border="0" cellpadding="0px" class="popup" cellspacing="0" style="margin:0">
						<c:forEach items="${agendamentos}" var="agendamento" varStatus="contador">
							<tr <c:if test="${contador.count % 2 != 0 }">class="dif2"</c:if>>
								<td class="linkazulescuro">
									<input type="radio" 
										   name="horarioAgendamento" 
										   id="horarioAgendamento" 
										   class="required" <c:if test="${not agendamento.disponivel }">disabled="disabled"</c:if>
										   value="${agendamento.numero}" />
								</td>
								
								<td class="camposinternos2">
									<fmt:formatDate value="${agendamento.dataAgendamento}" pattern="dd/MM/yyyy hh:mm:ss" /> 
								</td>
								
							</tr>
						</c:forEach>
					</table>
				</div>	   
				
				<% /*
				
				<render:callelement elementname="Corporativo/Paginacao">
					<render:argument name="pagina" value="${paginacao.paginaAtual}"/>
					<render:argument name="totalPaginas" value="${paginacao.totalPaginas}"/>
					<render:argument name="url" value="/cs/Satellite?pagename=SascarPortal_Corporativo/Cliente&page=Corporativo/UC11/dv03"/>
					<render:argument name="formName" value="formPesquisa"/>
				</render:callelement> 
				
				*/ %>
						
				<div class="btnConfirmar_agendarOS">
					<label>
						<input name="button" type="submit" class="button" id="button" value="<fmt:message key="label.confirmar" />" />
					</label>
				</div>
				
				
			</div>
		</form>
	</c:if>


	<c:if test="${empty agendamentos}">
		<div class="container2" id="ajaxListMsgError" style="display: block;">
			<fmt:message key="mensagem.informacao.nenhumRegisroEncontrado" />
		</div>
		<script type="text/javascript">
			$("#ajaxListMsgError").fadeIn(400).delay(2000).fadeOut(400);
		</script>
	</c:if>
	
	<div class="barraHorizontalAgendamentoOS"></div>

