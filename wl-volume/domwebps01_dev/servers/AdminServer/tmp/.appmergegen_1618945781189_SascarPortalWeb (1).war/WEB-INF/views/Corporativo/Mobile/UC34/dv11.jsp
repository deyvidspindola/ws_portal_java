<jsp:directive.include file="/WEB-INF/views/includes.jsp"/>

<div class="window modal">
	<div class="topo"></div>
	<div class="middle" style="text-align: center;">
	
		<h3><fmt:message key="mensagem.sucesso.operacao" /></h3>
		
		<br/>
		
		<span style="color:#666;"><fmt:message key="label.numeroDaOS" />:</span>
		<span style="color:#F00;">${param.ordemServicoReinstalacao}</span><br />
		
		<br/><br/>
		
		<table width="100%" cellspacing="0">
			<tr>
				<td align="center">
				
					<input class="button" 
					       value="<fmt:message key="label.fechar" />" 
					       type="button" 
					       onclick="concluirGerarNovaOS('#formPesquisa');"/>
					       
				</td>
			</tr>
		</table>
	</div>
	<div class="bottom"></div>
</div>

