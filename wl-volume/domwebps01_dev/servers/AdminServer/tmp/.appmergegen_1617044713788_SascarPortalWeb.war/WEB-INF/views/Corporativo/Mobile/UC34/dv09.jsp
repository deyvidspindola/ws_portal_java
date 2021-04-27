<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<div class="window modal">
	<div class="topo"></div>
	<div class="middle" style="text-align: center;">
	
		<h3><fmt:message key="mensagem.sucesso.operacao" /></h3>
		
		<br/>
		
		<table width="100%" cellspacing="0">
			<tr>
				<td align="center">
				
					<input class="button" 
					       value="<fmt:message key="label.fechar" />" 
					       onclick="finalizarProcesso('#formPesquisa');"
					       type="button" />
					       
					<input class="button4 close" 
					       type="button" 
					       onclick="gerarNovaOrdemServico('#formGerarOSReisntalacao');"
					       value="<fmt:message key="label.gerarOsReinstalacao" />">
					       
				</td>
			</tr>
		</table>
	</div>
	<div class="bottom"></div>
</div>