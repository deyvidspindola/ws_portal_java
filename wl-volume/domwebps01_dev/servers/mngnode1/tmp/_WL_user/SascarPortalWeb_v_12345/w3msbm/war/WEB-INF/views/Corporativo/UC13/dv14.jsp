<jsp:directive.include file="/WEB-INF/views/includes.jsp"/> 
 
<c:catch var="helper" >
	<c:import url="/AtivarEquipamentoTestes/listarServicoCadastrado?acao=17" context="/SascarPortalWeb"  />
</c:catch>
 
<c:if test="${not empty mensagem }">
	<script type="text/javascript">
		$.showMessage("${mensagem}");
	</script>
</c:if>

<c:if test="${not empty helper}" >
	<script type="text/javascript">
		openDefaultErroPage('${helper}');
	</script>
</c:if>

<script type="text/javascript">	

	function validarItensBloqueados()
	{
		var termo = '<fmt:message key="label.naoPreenchido" />';
		var totalItens = -1;
		var totalKit = 0;
		var totalNaoPreenchido = 0;
		
		$("table#alter > tbody > tr").each(function(){
			totalItens++;
			var achouKit = false;
			$(this).find("td").each(function(){
				
				if($(this).text().toLowerCase().trim() == "kit")
				{
					totalKit++;
					achouKit = true;		
				}else{	
					if(!achouKit && $(this).text().toLowerCase().trim() == termo)
					{
						totalNaoPreenchido ++;
					}
				}				
			});
		});
		
		if(totalItens > 0 && totalNaoPreenchido == 0)
		{
			$("#button").attr("disabled", "");
		}
	}
	
	function alterarStatusLinha(idLaudo)
	{
		var encontrou = false;
		
		$("table#alter > tbody > tr").each(function(){

			$(this).find("td input").each(function(){
			   if($(this).val() == idLaudo){
			   	encontrou = true;			
			   }
			});
		
		    if(encontrou){
			    $(this).find("td").each(function(){
				   	if($(this).text().toLowerCase().trim() == '<fmt:message key="label.naoPreenchido" />' )
					{
						$(this).text("Preenchido");
						encontrou = false;
					}
				});
			}			
		});
	}

	function bloquearCamposEdicao()
	{
		//Resetar os campos
		$("#defeitoConstatado option[value='']").attr("selected", true);
		$("#causas option[value='']").attr("selected", true);
		$("#ocorrencias option[value='']").attr("selected", true);
		$("#solucao option[value='']").attr("selected", true);
		$("#componenteAfetado option[value='']").attr("selected", true);
		$('#observacao').val("");
		//FIM RESET
		
		//DESBLOQUEIA
		$("#defeitoConstatado").attr('disabled', 'disabled');
		$("#causas").attr('disabled', 'disabled');
		$("#ocorrencias").attr('disabled', 'disabled');
		$("#solucao").attr('disabled', 'disabled');
		$("#componenteAfetado").attr('disabled', 'disabled');
		$('#observacao').attr('disabled', 'disabled');
		$('#btnLaudo').attr('disabled', 'disabled');
		
		//Seta valor no campo observacao
		$('#observacao').val("");	
		
		//FIM DESBLOQUEIA
	
		//Mostra campos para laudo
	 	//$('#js-dados-laudo').attr('style', 'display: inline-block');
	 	
	 	//Seta true e campo que referencia 'Edicao' - Diz que algo esta sendo editado
	 	$('#editar').val(false);
	}

	//Metodo responsavel por abrir laudo na tela e chamar os metodos referente as informacoes necessarioas, setando os valores corretos.
	function verificaLaudo(selecionado, codMotivo, idLaudo, idDefeito, idCausa, idOcorrencia, idComponente, idSolucao, observacao){
					
		//Resetar os campos
		$("#defeitoConstatado option[value='']").attr("selected", true);
		$("#causas option[value='']").attr("selected", true);
		$("#ocorrencias option[value='']").attr("selected", true);
		$("#solucao option[value='']").attr("selected", true);
		$("#componenteAfetado option[value='']").attr("selected", true);
		$('#observacao').val("");
		//FIM RESET
		
		//DESBLOQUEIA
		$("#defeitoConstatado").attr('disabled', '');
		$("#causas").attr('disabled', '');
		$("#ocorrencias").attr('disabled', '');
		$("#solucao").attr('disabled', '');
		$("#componenteAfetado").attr('disabled', '');
		$('#observacao').attr('disabled', '');
		$('#btnLaudo').attr('disabled', '');
		
		//FIM DESBLOQUEIA
	
		//Mostra campos para laudo
	 	//$('#js-dados-laudo').attr('style', 'display: inline-block');
	 	
	 	//Seta true e campo que referencia 'Edicao' - Diz que algo esta sendo editado
	 	$('#editar').val(true);
	 	
	 	//Seta o valor do idlaudo para um campo hidden, para ser persistido
	 	$('#idlaudo').val(idLaudo);
	 	
	 	//var verificaLaudo = true;  //Variavel para saber que as chamadas sao oriundas da verificacao se tem laudo, caso verificaLaudo== true, nao vai mostrar os erros
		
		//Chama metodo recuperarDefeitos, para buscar defeitos referentes ao item selecionado
		recuperarDefeitos(codMotivo, idLaudo, idDefeito);
		
		//Chama metodo de carregarCausas, para buscar causas
		carregarCausas(idDefeito, idCausa);
		
		carregarOcorrencias(idCausa, idOcorrencia);
		
		recuperarComponentesAfetados(idComponente);
		
		carregarSolucoes(idSolucao);
		
		//Seta valor no campo observacao
		$('#observacao').val(observacao);		
	};

	 function recuperarDefeitos(codMotivo, idlaudo, idDefeito){
		//LIMPA SELECT		
		$('#defeitoConstatado').children('option:not(:first)').remove();
		
		var def = $('#defeitoConstatado')[0];
		
		//configuracoes para tirar os caches - IE
		$.support.cors = true; //  cross-site scripting
        $.ajaxSetup({ cache: false }); 
		
		//Recupera defeitos conforme OS
		$.ajax({
				type: "POST",
				sync: false,
				crossDomain: true,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				url: "/SascarPortalWeb/AtivarEquipamentoTestes/recuperarDefeitos?acao=18",
				data: {'idMotivo' : codMotivo},
				dataType:"json",
				success: function(json){
					if (json.success) {
					$.each(json.defeitos, function(i, defeito) {
						
						if (defeito.value && defeito.id) {
							if(defeito.id == idDefeito){//Valida qual o valor a ficar selecionado
								var option = new Option(defeito.value, defeito.id, true, true);
							}else{
								var option = new Option(defeito.value, defeito.id);
							}
							
							if ($.browser.msie) {
								def.add(option);
							} else {
								def.add(option, null);
							}
							
						}
					});
					
				} else {
					$.showMessage(json.mensagem);
				}
				}
			});		
	};
	 
	function carregarCausas(defeitoSelecionado, idCausa){
		//LIMPA SELECT		
		$('#causas').children('option:not(:first)').remove();
	
		//ELEMENTO SELECIONADO NA COMBO DE DEFEITOS
		var codDefeito = defeitoSelecionado;
		var cau = $('#causas')[0];
		
		//configuracoes para tirar os caches - IE
		$.support.cors = true; //  cross-site scripting
        $.ajaxSetup({ cache: false }); 
		
		$.ajax({
				type: "POST",
				sync: false,
				crossDomain: true,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				url: "/SascarPortalWeb/AtivarEquipamentoTestes/recuperarCausas?acao=19",
				data: {'idDefeito' : codDefeito},
				dataType:"json",
				success: function(json){
					if (json.success) {
						$.each(json.causas, function(i, causa) {
							
							if (causa.value && causa.id) {
								if(causa.id == idCausa){//Valida qual o valor a ficar selecionado
									var option = new Option(causa.value, causa.id, true, true);
								}else{
									var option = new Option(causa.value, causa.id);
								}
								if ($.browser.msie) {
									cau.add(option);
								} else {
									cau.add(option, null);
								};
							};
						});
					
					} else {
						
					};
				}
			});			
		
	} ;
	
	function carregarOcorrencias(idCausa, idOcorrencia){
		//codCausa RECEBE ELEMENTO SELECIONADO NA COMBO DE CAUSAS		
		//var codCausa = $('#causas option:selected').attr('value');
		var elemOcorrencia = $('#ocorrencias')[0];
		
		//LIMPA SELECT		
		$('#ocorrencias').children('option:not(:first)').remove();
		
		
			//configuracoes para tirar os caches - IE
			$.support.cors = true; //  cross-site scripting
	        $.ajaxSetup({ cache: false }); 
			
			$.ajax({
				type: "POST",
				sync: false,
				crossDomain: true,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				url: "/SascarPortalWeb/AtivarEquipamentoTestes/recuperarOcorrencias?acao=20",
				data: {'idCausa' : idCausa},
				dataType:"json",
				success: function(json){
					if (json.success) {
						if(json.erro != true){
							$.each(json.ocorrencias, function(i, ocorrencia) {
								
								if (ocorrencia.value && ocorrencia.id) {
									if(ocorrencia.id == idOcorrencia){//Valida qual o valor a ficar selecionado
										var option = new Option(ocorrencia.value, ocorrencia.id, true, true);
									}else{
										var option = new Option(ocorrencia.value, ocorrencia.id);
									}							
									
									if ($.browser.msie) {
										elemOcorrencia.add(option);
									} else {
										elemOcorrencia.add(option, null);
									};
								};
							});
						}else{
							/* if(verificaLaudo){
							// NAO MOSTRA MENSAGENS DE ERRO POIS ESTAVA SOMENTE VERIFICANDO SE TINHA ALGUM ITEM SELECIONADO
						}else{
							$.showMessage(json.mensagem);
						}*/
						}
					
					} else {
						/* if(verificaLaudo){
							// NAO MOSTRA MENSAGENS DE ERRO POIS ESTAVA SOMENTE VERIFICANDO SE TINHA ALGUM ITEM SELECIONADO
						}else{
							$.showMessage(json.mensagem);
						}*/
					};
				}
			});			
		
	} ;
	
	function carregarSolucoes(idSolucao){
		//LIMPA SELECT		
		$('#solucao').children('option:not(:first)').remove();
	
		var elemSolucao = $('#solucao')[0];
		
			//configuracoes para tirar os caches - IE
			$.support.cors = true; //  cross-site scripting
	        $.ajaxSetup({ cache: false }); 
			
			$.ajax({
				type: "POST",
				sync: false,
				crossDomain: true,
				url: "/SascarPortalWeb/AtivarEquipamentoTestes/recuperarSolucoes?acao=21",
				dataType:"json",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				success: function(json){
					if (json.success) {
						if(json.erro != true){
							$.each(json.solucoes, function(i, solucao) {
								
								if (solucao.value && solucao.id) {
									if(solucao.id == idSolucao){//Valida qual o valor a ficar selecionado
										var option = new Option(solucao.value, solucao.id, true, true);	
									}else{
										var option = new Option(solucao.value, solucao.id);	
									}									
									if ($.browser.msie) {
										elemSolucao.add(option);
									} else {
										elemSolucao.add(option, null);
									};
								};
							});
						}else{
							/* if(verificaLaudo){
							// NAO MOSTRA MENSAGENS DE ERRO POIS ESTAVA SOMENTE VERIFICANDO SE TINHA ALGUM ITEM SELECIONADO
							}else{
								$.showMessage(json.mensagem);
							}*/
						}
					
					} else {
						/* if(verificaLaudo){
							// NAO MOSTRA MENSAGENS DE ERRO POIS ESTAVA SOMENTE VERIFICANDO SE TINHA ALGUM ITEM SELECIONADO
						}else{
							$.showMessage(json.mensagem);
						}*/
					};
				}
			});			
		
	} ;
	
	function recuperarComponentesAfetados(idComponente){
		//LIMPA SELECT		
		$('#componenteAfetado').children('option:not(:first)').remove();
	
		var compAfetado = $('#componenteAfetado')[0];
		
			//configuracoes para tirar os caches - IE
			$.support.cors = true; //  cross-site scripting
	        $.ajaxSetup({ cache: false }); 
			
			$.ajax({
				type: "POST",
				sync: false,
				crossDomain: true,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				url: "/SascarPortalWeb/AtivarEquipamentoTestes/recuperarComponentesAfetados?acao=22",
				dataType:"json",
				success: function(json){
					if (json.success) {
						if(json.erro != true){
							$.each(json.componentes, function(i, componente) {
								
								if (componente.value && componente.id) {
									if(componente.id ==idComponente){//Valida qual o valor a ficar selecionado
										var option = new Option(componente.value, componente.id, true, true);
									}else{
										var option = new Option(componente.value, componente.id);
									}									
									if ($.browser.msie) {
										compAfetado.add(option);
									} else {
										compAfetado.add(option, null);
									};
								};
							});
						}else{
							/* if(verificaLaudo){
							// NAO MOSTRA MENSAGENS DE ERRO POIS ESTAVA SOMENTE VERIFICANDO SE TINHA ALGUM ITEM SELECIONADO
						}else{
							$.showMessage(json.mensagem);
						}*/
						}
					
					} else {
						/* if(verificaLaudo){
							// NAO MOSTRA MENSAGENS DE ERRO POIS ESTAVA SOMENTE VERIFICANDO SE TINHA ALGUM ITEM SELECIONADO
						}else{
							$.showMessage(json.mensagem);
						}*/
					};
				}
			});		
	
	};
	
	function persistirLaudo(){	
		
		var numOs = $('#numeroOS').val();
		var idLaudo = $('#idlaudo').val();
		var defeitoConstatado = $('#defeitoConstatado option:selected').attr('value');
		var causa = $('#causas option:selected').attr('value');
		var ocorrencia = $('#ocorrencias option:selected').attr('value');
		var solucao = $('#solucao option:selected').attr('value');
		var componente = $('#componenteAfetado option:selected').attr('value');
		var observacao = $('#observacao').val();
	
					
		//SE ALGUM DOS CAMPOS VIER VAZIO, RETORNAR MENSAGEM NA TELA
		if(numOs == "" || idLaudo == "" || defeitoConstatado == "" || causa == "" || ocorrencia == "" || solucao == "" || componente == ""){
			$.showMessage('<fmt:message key="mensagem.camposObrigatorios" />');
		}else{		
		//configuracoes para tirar os caches - IE
			$.support.cors = true; //  cross-site scripting
	        $.ajaxSetup({ cache: false }); 
			
			$.ajax({
				type: "POST",
				sync: false,
				crossDomain: true,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				url: "/SascarPortalWeb/AtivarEquipamentoTestes/persistirLaudo?acao=23",
				data: {'numOs'		: numOs,
					  'idLaudo' 	: idLaudo,
					  'defeitoConstatado' : defeitoConstatado,
					  'causa'			  : causa,
					  'ocorrencia'		  : ocorrencia,
					  'solucao'			  : solucao,
					  'componente'		  : componente,
					  'observacao'		  : observacao				  
					  },
				dataType:"json",
				success: function(json){
					if(json.erro != "true"){
						//$('#formLaudo').attr('action', '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv05');
						//$('#formLaudo').submit();
						$.closeOverlay();
						bloquearCamposEdicao();
						alterarStatusLinha(idLaudo);
						validarItensBloqueados();
						alert(json.mensagem);
						window.location.reload();
					}else{						
						$.showMessage(json.mensagem);
					}
				}
			});	
		}
	};
	
	//Define para qual o procedimento a tela irá fazer
	function salvarTela(){
		var editar = $('#editar').val();
		
		//Valida se existe alguma edicao iniciada
		if(editar == "true"){
			persistirLaudo();
		}else{
			$('#formLaudo').attr('action', '${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv05');
			$('#formLaudo').submit();
		}
	}
	
	function limparEdicao(){

		$('#editar').val(false);	
	};
	
   $(document).ready(function(){

		$('#editar').val(false);		
		window.onerror = function(){  return true;};		
		$('#iframeContent', window.document.parent).attr('height', 350);
		
		validarItensBloqueados();
	});
	
</script>
	
	<div class="cabecalho3"><fmt:message key="label.ativacaoDeEquipamento" />
		<div class="caminho3" style="*margin-left:100px;">
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a>&gt; 
			<a href="#" class="linktres"><fmt:message key="label.informacoes" /></a> &gt; 
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv01"  class="linkquatro"><fmt:message key="label.testesAtivacaoEquipamento" /></a>
		</div>
	</div>
	
	<div class="busca_branca">		
		<span class="text1"><fmt:message key="label.resultadoDaBusca" />:</span>
	</div>	
	
	<!-- TABBLE -->
	
	<form name="formReexecutar" id="formReexecutar" action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC13/dv02" method="post" class="filtro">
		<input type="hidden" name="numeroCPF"       value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS"        value="${param.numeroOS }" />
		<input type="hidden" name="numeroPlaca" 	value="${param.numeroPlaca}" />		  
		<input type="hidden" name="origem" 			value="${param.origem}" />
		<input type="hidden" name="reiniciarTestes" value="S" />
		<input type="hidden" name="motivo"			value="${param.motivo}" />
		<input type="hidden" name="tipoEquipamento" value="${param.tipoEquipamento }" />  
	</form>
	
	<div style="height: 700px; display: inline;"> 
		<form action="" method="post">
	
			<table width="850" cellpadding="1" id="alter" cellspacing="0" style="margin-top: 15px; margin-left:50px;">
				
				<tr>
				    <th class="texttable_azul" scope="col"><fmt:message key="label.item" /></th>
				    <th class="texttable_cinza" scope="col"><fmt:message key="label.tipo" /></th>
				    <th class="texttable_cinza" scope="col"><fmt:message key="label.Motivo" /></th>
				    <th class="texttable_cinza" scope="col"><fmt:message key="label.defeitoAlegado" /></th>
				    <th class="texttable_cinza" scope="col"><fmt:message key="label.statusDoLaudo" /></th>
				    <th class="texttable_cinza" scope="col"><fmt:message key="label.acao" /></th>
				</tr>
				
				<c:forEach var="itens" items="${itens}">
					<tr style="height: 50px;">
						<td>${itens.item}&nbsp;</td>
						<td>${itens.tipo} &nbsp;<input type="hidden" value="${itens.idlaudo}" ></td>
						<td>${itens.motivo} &nbsp;</td>
						<td>${itens.defeitoAlegado} &nbsp;</td>
						<td>${itens.statusLado} &nbsp;</td>
						<td class="linkazulescuro" style="width:70px;" nowrap="nowrap">
							<c:if test="${itens.item ne 'KIT'}">
								<a onclick="verificaLaudo(this, ${itens.idmotivo}, ${itens.idlaudo}, ${itens.iddefeito}, ${itens.idcausa}, ${itens.idocorrencia}, ${itens.idcomponente}, ${itens.idsolucao}, '${fn:trim(itens.observacao)}');" class="linkcinco tooltip" id="editarItem" title="<fmt:message key="label.cliqueParaEditar" />">
									<fmt:message key="label.editar" />
								</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</table>
		</form>	
		<div id="js-dados-laudo">
		 	<form id="formLaudo"  method="post"  action="">		
				
				<div style="padding-left: 0 !important;" class="busca_branca">
					<span style="text-align: right; display: inline-block; width: 185px;" class="text2"><fmt:message key="label.defeitoConstatado" /> : </span>
					<select  disabled="disabled" onchange="carregarCausas(this.value, '');" style="width: 260px;" id="defeitoConstatado" name="defeitoConstatado"  style="margin-left: 110px;">
						<option id="" value=""><fmt:message key="label.selecione" /></option>
		   			</select>
				</div>
		
				
				<div style="padding-left: 0 !important;" class="busca_cinza">		
					<span style="text-align: right; display: inline-block; width: 185px;" class="text2"><fmt:message key="label.causa" />:</span>
					<select disabled="disabled" onchange="carregarOcorrencias(this.value, '');" style="display: inline-block; width: 260px;" id="causas" name="causas"  style="margin-left: 110px;">
						<option id="" value=""><fmt:message key="label.selecione" /></option>
		   			</select>
				</div>
						
				<div style="padding-left: 0 !important;" class="busca_branca">		
					<span style="text-align: right; display: inline-block; width: 185px;" class="text2"><fmt:message key="label.ocorrencia" />:</span>
					<select disabled="disabled" onchange="carregarSolucoes();" style="width: 260px;" id="ocorrencias" name="ocorrencias"  style="margin-left: 110px;">
						<option id="" value=""><fmt:message key="label.selecione" /></option>
		   			</select>
				</div>
				
				<div style="padding-left: 0 !important;" class="busca_cinza">
					<span style="text-align: right; display: inline-block; width: 185px;" class="text2"><fmt:message key="label.solucao" />:</span>
					<select disabled="disabled" onchange="recuperarComponentesAfetados();" style="width: 260px;" id="solucao" name="solucao"  style="margin-left: 110px;">
						<option id="" value=""><fmt:message key="label.selecione" /></option>
		   			</select>
				</div>
				
				<div style="padding-left: 0 !important;" class="busca_branca">		
					<span style="text-align: right; display: inline-block; width: 185px;" class="text2"><fmt:message key="label.comprometimentoAfetado" />:</span>
					<select disabled="disabled" style="width: 260px;" id="componenteAfetado" name="componenteAfetado"  style="margin-left: 110px;">
						<option id="" value=""><fmt:message key="label.selecione" /></option>
		   			</select>
				</div>
				
				<div style="background-color: #E4E4E4;
							display: flex;
							height: 105px;
							background-color: #E4E4E4;
							display: flex;
							height: 105px;padding-left: 0 !important;
							padding: 5px;
							width: 855px;" class="">
					<span style="text-align: right; display: inline-block; width: 185px;" class="text2"><fmt:message key="label.observacao" />:</span>
					<textarea  disabled="disabled" id="observacao" name="observacao" style="resize:none; width: 500px;" rows="6" cols="10"></textarea>				
			</div>
				<div style="padding-left: 0 !important;" class="busca_branca">		
					<span style="text-align: right; display: inline-block; width: 185px;" class="text2"></span>
					<input id="btnLaudo" onclick="persistirLaudo();" class="button" type="button" disabled="disabled" value="<fmt:message key="label.salvarLaudo" />" />
				</div>
			<input type="hidden" name="idlaudo" id="idlaudo" value=""/>
			<input type="hidden" name="numeroOS" id="numeroOS"  value="${param.numeroOS}" />
			<input type="hidden" name="numeroCPF"       value="${param.numeroCPF }" />
			<input type="hidden" name="motivo"			value="${param.motivo}" />
			<input type="hidden" name="editar" 	id="editar" value="false" />
			<input type="hidden" name="tipoEquipamento" value="${param.tipoEquipamento }" />  	 		
		</form>
		</div>
		<div class="busca_branca">
			<input type="button" class="button4" value="<fmt:message key="label.voltar" />" onclick="$('#formReexecutar').submit();" />
			<input id="button"  disabled="disabled" onclick="salvarTela();" class="button" type="button"  value="<fmt:message key="label.salvar" />" />			
		</div>
	</div>
	