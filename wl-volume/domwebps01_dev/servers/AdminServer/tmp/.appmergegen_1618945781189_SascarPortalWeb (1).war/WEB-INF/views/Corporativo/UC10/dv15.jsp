<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		var errosValidacao = $("#errosValidacao").val();
		
		$(".conteinerMensagensValidacaoErrosValidacaoGerarBordero").find('ol').append(errosValidacao);
		
	});

</script>

<form id="formErrosValidacao" action="">


	
	<div id="popupErrosValidacaoGerarBordero">
		
		<div id="popup_bordacima"></div>
	  	
		<div id="popupInteriorErrosValidacaoGerarBordero">
		
			<div class="popup_maior_pergunta" style="text-align: left; height: 25px; width: 600px;">
				<fmt:message key="uc42.texto.01.inventarioAndamento" />
			</div>
		  	
		  	<div style="clear:both;"></div>
				
	  		<div class="conteinerMensagensValidacaoErrosValidacaoGerarBordero">
				<ol>
				</ol>
			</div>
		
			<div style="clear:both;"></div>
		
			<div class="popup_maior_resposta" style="text-align: right;">
				<input class="button4 close" type="button" style="" value="<fmt:message key="label.fechar" />" onclick="javascript:$.closeOverlay();">
			</div>
		
		</div>
		
		<div id="popupErrosValidacaoGerarBordero_bordarodape"></div>
	  	
	</div>

</form>