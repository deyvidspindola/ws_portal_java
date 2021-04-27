<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<div class="window modal">
	<div class="topo"></div>
	<div class="middle" style="text-align: center;">
	
		<h3><fmt:message key="label.confirmacaoDeRetirada" /></h3>
		
		<br/>
		<span style="color:#666;"><fmt:message key="mensagem.confirmacao.retiradaEquipamento" /> </span>
		<span style="color:#F00;">${param.serialEquipamento}</span>?<br />
		
		<br/><br/>
		
		<table width="100%" cellspacing="0">
			<tr>
				<td align="center">
				
					<input class="button" 
					       value="<fmt:message key="label.sim" />" 
					       type="button" 
					       onclick="confirmarRemocaoEquipameno('#formPesquisa');"/>
					
					<input class="button4 close"
					       value="<fmt:message key="label.nao" />" 
					       type="button" 
					       onclick="$.closeOverlay();" />
				</td>
			</tr>
		</table>
	</div>
	<div class="bottom"></div>
</div>