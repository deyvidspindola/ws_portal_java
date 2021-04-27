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
</style>

<script type="text/javascript">
	
function prnlimitador(campo, prdlimitamin, prdlimitamax, prdoid,prdgrupomaterial){

  if(campo.value > 0){ 
  	if(prdgrupomaterial == 7 || prdgrupomaterial == 10) {
	      if(campo.value < prdlimitamin || campo.value > prdlimitamax){ 
	        alert("Verifique o limite m\u00ednimo e m\u00e1ximo de baixa de produtos!");
	      }
      }
   } 
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
		   		}   
		   		if(parseInt(qtdproduto) != 0 && parseInt(qtdproduto) < parseInt(qtdmin) ){
					limitador = limitador + 1;  
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
					$("#dialog_mensagem #popup_msg_modal").html('<fmt:message key="mensagem.sucesso.operacao" />');
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

		var trs = $('table.list tr');

		$('#ativar_equipamento').addClass('active');
		
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
				if($(".quantidade:disabled").length) {
					submeterMateriaisEstoque(form);
				} else if(trs.length == 0) { // Nenhum material em estoque

					if ($('#listaEmpty').is(":visible")) {
						document.location.href='${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv01';
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

					//var trs = $('table.list tr');
					var trsHidden = $('table.list tr:hidden');

					if (trs.length-1 == trsHidden.length) {
						$('#listaEmpty').show();
						$('table.list').hide();
					}

					$("#loading").jOverlay({'closeOnEsc' : false, 'bgClickToClose': false});
					window.setTimeout("$.closeOverlay();", 500);
				}
			}
		});

		$(".quantidade").setMask( { mask: '99' });
	});
</script>

<!-- FORM VOLTAR -->
<form method="post"	id="formVoltar"	action="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv08">
	<input type="hidden" name="numeroCPF" 	value="${param.numeroCPF }" />
	<input type="hidden" name="numeroOS" 	value="${param.numeroOS }" />
</form>

<div class="container2"> 
	<ol></ol>
</div>

<h1><fmt:message key="label.ativarEquipamento" /></h1>

<h2><fmt:message key="label.materiaisEstoque" /></h2>

<form action="" method="post" class="filtro" id="formMateriaisEstoque">

	<input type="hidden" name="numeroCPF" value="${param.numeroCPF }" />
	<input type="hidden" name="numeroOS" value="${param.numeroOS }" />

	
	<div id="listaEmpty" class="message msg-alert" style="display: none;"><fmt:message key="uc10.dv09.incluirListaMateriais" /></div>
	
	<c:if test="${not empty produtos}">	
	    <table cellspacing="1" width="100%" cellpadding="2" class="list left">
	        <tbody>
	            <tr>
	                <th>
	                    <fmt:message key="label.qtdaEstoque" />
	                </th>
	                <th>
	                    <fmt:message key="label.qtdaUtilizada" />
	                </th>
	                <th>
	                    <fmt:message key="label.produto" />
	                </th>
	            </tr>

	            <c:forEach var="produto" items="${produtos}">
		            <tr>
		                <td>${produto.quantidadeEstoque}&nbsp;</td>
		                <td>
		                    <input type="text" id="produto_${produto.codigo }"  class="text table number quantidade" name="produto_${produto.codigo }" value="${produto.quantidade}" maxlength="2"
		                         		   onblur="prnlimitador(this,${produto.limitadorMinimo},${produto.limitadorMaximo}, ${produto.codigo},${produto.grupoMaterial});" style=" width: 30px;"/>
		                         		   
			          <input type="hidden" id="prdgrupo_material_${produto.codigo}" class="text table number quantidade" name="prdgrupo_material_${produto.codigo}" value="${produto.grupoMaterial}" maxlength="10" size="3" />
     					<input type="hidden" id="prdlimitador_minimo_${produto.codigo}" class="text table number quantidade" name="prdlimitador_minimo_${produto.codigo}" value="${produto.limitadorMinimo}" maxlength="10" size="3" />
     					<input type="hidden" id="prdlimitador_maximo_${produto.codigo}" class="text table number quantidade" name="prdlimitador_maximo_${produto.codigo}" value="${produto.limitadorMaximo}" maxlength="10" size="3" />
     					<input type="hidden" name="ch_prdoid" value="${produto.codigo}">
		                </td>
		                <td>${produto.descricao}&nbsp;</td>
		            </tr>
				</c:forEach>

	        </tbody>
	    </table>
	</c:if>
    
    <table width="100%">
    	<tr><td colspan="2">&nbsp;</td></tr>
    	<tr>
			<td align="right" valign="middle">&nbsp;</td>
			<td align="right">
                <input type="button" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.voltar" />" onclick="voltar();" />
       			<input type="submit" class="aButton ui-state-default ui-corner-all" value="<fmt:message key="label.finalizarEnviarConfig" />" />
			</td>
		</tr>
    </table>

</form>


<div id="dialog_mensagem" class="window modal" style="display: none;">
	<div class="topo"></div>
	<div class="middle">
		<h4></h4>
		<br />
		<table width="100%" cellspacing="0">
			<tr>
				<td width="99"></td>
				<td><a href="${pageContext.request.contextPath}/Satellite?pagename=SascarPortal_Corporativo/Mobile/RepresentanteTecnico&page=Corporativo/Mobile/UC10/dv01" title="Fechar"><img src="${pageContext.request.contextPath}/sascar/images/corporativo/ico_voltar_modal.png" class="ico" align="left" alt=" Fechar" /> <fmt:message key="label.fechar" /></a></td>
			</tr>
		</table>
	</div>
	<div class="bottom"></div>
</div>