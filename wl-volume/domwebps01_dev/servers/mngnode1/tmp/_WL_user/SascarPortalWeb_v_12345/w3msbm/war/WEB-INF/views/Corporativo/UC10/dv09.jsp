<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<c:catch var="helper">
	<c:import url="/AtivarEquipamentoVinculo/listarMateriaisEstoque?acao=9" context="/SascarPortalWeb"  />
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

<style type="text/css">
	label.error {
		display: block;
		color: red;
	}

	input.error {
		border: 1px solid red;
	}

	.quantidade {
		text-align: center;
	}
	
	.message {
		padding: 25px 25px 25px 60px;
		font-size: large;
		font-weight: bold;
		font-family: Arial, Helvetica, clean, sans-serif;
		text-shadow: 1px 1px 1px #ccc;
		border-radius: 10px;
		user-select:none;
		-moz-border-radius: 10px;
		-moz-user-select:none;
		-webkit-border-radius: 10px;
		-webkit-user-select:none;
		margin: 10px 0;
	}
	
	.alert {
		background: #ffefd5;
		color: #dd802e;
		border: 1px solid #e5c788;
	}
</style>

<script type="text/javascript">

function prnlimitador(campo, prdlimitamin, prdlimitamax, prdoid,prdgrupomaterial){

  if(campo.value > 0){ 
  
  	if(prdgrupomaterial == 7 || prdgrupomaterial == 10) {
  		 if(campo.value < prdlimitamin || campo.value > prdlimitamax){ 
       		 jQuery("#msg_"+prdoid).html('Baixa m\u00ednimo '+prdlimitamin+ ' m\u00e1ximo '+prdlimitamax);  
        	 jQuery("#msg_"+prdoid).css('display', 'inline');
	     }else{
	          jQuery("#msg_"+prdoid).html('');  
	     }
  	}
     
    } else{
    	jQuery("#msg_"+prdoid).html('');  
    }
}

	function verificaQuantidadeDigitada(produto) {
		for (var i=0; i<produto.length; i++) {
			if (produto[i].codigoGrupo == produto[i-1].codigoGrupo) {
				var quantidade = (produto[i].quantidade + produto[i-1].quantidade);
				if (quantidade == 0 || quantidade == ''){
					$.showMessage('<fmt:message key="uc10.dv09.qtdaPorGrupo" />');
					break;
				}
			}
		}
	}
	
	function verificaGrupoSimilar(){
		var somaGrupo = [];
		var breakOut = true;
		jQuery(".grupo_similar").each(function () {
	
			if(jQuery(this).val() == ''){
				jQuery(this).focus();
				alert('<fmt:message key="uc10.dv09.valorItensSimilares" />');
				return false;
			}else{
				if(somaGrupo[parseInt(jQuery(this).attr('grupoId'))] == undefined){
					somaGrupo[parseInt(jQuery(this).attr('grupoId'))] = 0;
				}
				somaGrupo[parseInt(jQuery(this).attr('grupoId'))] += parseInt(jQuery(this).val());	
			}
		});
	
		jQuery.each(somaGrupo, function( index, value ) {
			if(value == 0){
				//grupo = jQuery( "input[grupoId='"+index+"']").attr('grupoDesc');
				alert('<fmt:message key="uc10.dv09.incluirItensSimilares" />');
				breakOut = false;
				return false;
			}
		});
		if(breakOut) {
		    breakOut = false;
		    return false;
		} 
		return true;
	}
	
	function submeterMateriaisEstoque(form) {

		 limitador = 0;
		for(var i = 0; i < document.getElementsByName('ch_prdoid').length; i=i+1){
			var prdoid = document.getElementsByName('ch_prdoid')[i].value;
			var qtdproduto = jQuery("#produto_"+prdoid).val();
			var grupoMaterial = jQuery("#prdgrupo_material_"+prdoid).val();
			var qtdmin = jQuery("#prdlimitador_minimo_"+prdoid).val();
	    	var qtdmax = jQuery("#prdlimitador_maximo_"+prdoid).val();
	    	
	    	if(parseInt(grupoMaterial) == 7 || parseInt(grupoMaterial) == 10) {
	    		if(parseInt(qtdproduto) > parseInt(qtdmax)){
					limitador = limitador + 1; 
					jQuery("#msg_"+prdoid).html('Baixa m\u00ednimo '+qtdmin+ ' m\u00e1ximo '+qtdmax);  
        		    jQuery("#msg_"+prdoid).css('display', 'inline');
		   		}   
		   		if(parseInt(qtdproduto) != 0 && parseInt(qtdproduto) < parseInt(qtdmin) ){
					limitador = limitador + 1; 
					jQuery("#msg_"+prdoid).html('Baixa m\u00ednimo '+qtdmin+ ' m\u00e1ximo '+qtdmax);  
        		    jQuery("#msg_"+prdoid).css('display', 'inline');
		   		} 
	    	}
 
	   }
	   
		if(parseInt(limitador)){
    		alert("Verifique o limite m\u00ednimo e m\u00e1ximo de baixa de produtos!");
    	}else{
    	
    	var data = $(form).serialize();

		$(':disabled').each( function() {
			data += '&' + this.name + '=' + $(this).val();	
		});

		$.ajax({
			url: "/SascarPortalWeb/AtivarEquipamentoVinculo/submeterMateriaisEstoque?acao=10",
			data: data || {},
			dataType:"json",
			type :"POST",
			success: function(json){
				if (json.success) {
					$("#dialog_mensagem #popup_msg_modal").html(json.mensagemSucesso);
					$("#dialog_mensagem").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
				} else {
					$.showMessage(json.mensagem);
				}
			}
		});
    	}
	
	}
	
	function voltar(){
		if($(".quantidade:disabled").length) {
			$(".quantidade").removeAttr("disabled").css("backgroundColor", "");
			
			// Voltando os campos
			$('#listaEmpty').hide();
			$('table#alter').show();
			$(".quantidade").each(
				function(index){
					$(this).parent().parent().show();
				}
			);
					
			$("#loading").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
			window.setTimeout("$.closeOverlay();", 500);
		} else {
			$('#formVoltar').submit();
		}
	}

	$(document).ready(function(){
	
	/*$("#quantidadeInformada").blur(function(){
    	var minima = $("#qtdaMinima").val();
    	var maxima = $("#qtdaMaxima").val();
    	var atual = $("#quantidadeInformada").val();
    	
    	if(minima > atual || atual > maxima){
    		alert("Entoru aqui");
    		return false;
    	}
    	
	});*/
		var trs = $('table#alter tr');

		// Nenhum material em estoque
		// Apresentando a mensagem
		if (trs.length == 0) {
			$('#listaEmpty').show();
		}

		//var container = $('div.container2');
		$("#formMateriaisEstoque").validate({
			//errorContainer: container,
			//errorLabelContainer: $("ol", container),
			//wrapper: 'li',
			submitHandler : function(form) {
				
				if($(".quantidade:disabled").length == 0) {
					
					submeterMateriaisEstoque(form);
				} else if(trs.length == 0) { // Nenhum material em estoque

					if ($('#listaEmpty').is(":visible")) {
						document.location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv01';
					}

				} else {

					$(".quantidade").attr("disabled", true).css("backgroundColor", "#F0F0F0");

					// Escondendo os campos não preenchidos
					$(".quantidade").each(
						function(index){
							if (!$.trim($(this).val())) {
								$(this).parent().parent().hide();
							} 
						}
					);

					//var trs = $('table#alter tr');
					var trsHidden = $('table#alter tr:hidden');

					if (trs.length-1 == trsHidden.length) {
						$('#listaEmpty').show();
						$('table#alter').hide();
					}

					$("#loading").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
					window.setTimeout("$.closeOverlay();", 500);
				}
			}
		});
		
		$(".quantidade").setMask( { mask: '99' });
	});
</script>

	<div class="cabecalho">
		<div class="caminho">
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/${profilePath[SascarUser.perfil]}" title="<fmt:message key="label.home" />" class="linktres"><fmt:message key="label.home" /></a> &gt; 
			<a href="#" class="linktres"><fmt:message key="label.servicos" /></a> &gt; 
			<a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv01" class="linkquatro"><fmt:message key="label.ativacaoEquipamento" /></a>
		</div>
	  	<fmt:message key="label.ativacaoEquipamento" />
	</div>


	<!-- FORM VOLTAR -->
	<form method="post"	id="formVoltar"	action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv08">
		<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
	</form>


	<div class="container2">
		<ol></ol>
	</div>


	<table cellspacing="0" class="detalhe" >
		<tr class="barraazulzinha">
			<th class="barraazulzinha"><fmt:message key="label.materiaisEstoque" /></th>
		</tr>
	</table>


	<form action="" method="post" class="filtro" id="formMateriaisEstoque">
	
		<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
		<input type="hidden" name="numeroOS" value="${param.numeroOS }" />
	
		<div id="listaEmpty" class="message alert" style="display: none;"><fmt:message key="uc10.dv09.incluirListaMateriais" />!</div>
		
		<c:if test="${not empty produtos}">
			<table cellspacing="0" width="82%" id="alter">
				<tr>
		        	<th class="texttable_azul"><fmt:message key="label.qtdaEstoque" /></th>
		            <th class="texttable_azul" style="width: 278px;"><fmt:message key="label.qtdaUtilizada" /></th>
		            <th class="texttable_azul"><fmt:message key="label.produto" /></th>
		        </tr>
		        <c:set var="codigoGrupo" value="inicio"/>
		        <c:forEach var="produto" items="${produtos}" varStatus="status">
		        	<tr>
		        		<c:if test="${codigoGrupo == null && produto.codigoGrupo != null && produto.codigoGrupo != ''}">
							<th colspan="3" class="barralaranja"><fmt:message key="label.similares" /></th>
						</c:if>
					</tr>
					<tr>
						<c:if test="${codigoGrupo != produto.codigoGrupo && produto.codigoGrupo != null && produto.codigoGrupo != ''}">
							<th colspan="3" class="barralaranja">${produto.descricaoGrupo}</th>
			        	</c:if>
		        	</tr>
		        	<tr>
						<c:if test="${codigoGrupo != null && codigoGrupo != 'inicio' && produto.codigoGrupo == null}">
							<th colspan="3" class="barralaranjavazia"></th>
			        	</c:if>
		        	</tr>
					<tr <c:if test="${status.count % 2 != 0 }">class="dif"</c:if>>
			        	<td class="camposinternos">${produto.quantidadeEstoque}&nbsp;</td>
			            <td class="camposinternos" style="width: 278px;">
			           	<input type="text" id="produto_${produto.codigo }" 
			            		   class="text table number quantidade" 
			            		   name="produto_${produto.codigo }" 
			            		   value="${produto.quantidade}" 
			            		   maxlength="10" 
			            		   size="3" 
			            		   onblur="prnlimitador(this,${produto.limitadorMinimo},${produto.limitadorMaximo}, ${produto.codigo},${produto.grupoMaterial});"
			            		   />
			  		   
			         
			            <span class="msg" id="msg_${produto.codigo }" style="position: absolute; width: 120px; display: inline;"></span>
     	
     	
						
     					<input type="hidden" id="prdgrupo_material_${produto.codigo}" class="text table number quantidade" name="prdgrupo_material_${produto.codigo}" value="${produto.grupoMaterial}" maxlength="10" size="3" />
     					<input type="hidden" id="prdlimitador_minimo_${produto.codigo}" class="text table number quantidade" name="prdlimitador_minimo_${produto.codigo}" value="${produto.limitadorMinimo}" maxlength="10" size="3" />
     					<input type="hidden" id="prdlimitador_maximo_${produto.codigo}" class="text table number quantidade" name="prdlimitador_maximo_${produto.codigo}" value="${produto.limitadorMaximo}" maxlength="10" size="3" />
     					<input type="hidden" name="ch_prdoid" value="${produto.codigo}">
     
			            </td>
			            <td class="camposinternos">${produto.descricao}&nbsp;</td>
			            <c:set var="codigoGrupo" value="${produto.codigoGrupo}"/>
			            <c:set var="quantidade" value="${produto.quantidade}" />
			        </tr>
			        <input type="hidden" name="grupo_id_${produto.codigo }" value="${produto.codigoGrupo}"/>
				</c:forEach>
		    </table>
		</c:if>

	    <div class="clear"></div>
	
	
	    <div class="pgstabela">
		    <p>
		        <input type="button" class="button4" value="<fmt:message key="label.voltar" />" onclick="voltar();" />
		        <input type="submit" class="button" value="<fmt:message key="label.finalizarEnviarConfig" />"/>
		    </p>
	    </div>
	</form>


	<div id="dialog_mensagem" class="popup_padrao" style="display: none;">
		<div id="popup_msg_modal" class="popup_padrao_pergunta"></div>
		<div class="popup_padrao_resposta">
			<input type="button" class="button" value="<fmt:message key="label.fechar" />" onclick="document.location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/RepresentanteTecnico&page=Corporativo/UC10/dv01'"/>
		</div>
	</div>
