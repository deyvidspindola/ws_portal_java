<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
	<div id="tabelaAcessoriosRestritos"></div>
	
	<script>
	var acessorios = [];
	<c:forEach items="${acessorios}" var="acc">
		var acessorio = {iof : '${acc.idObrigacaoFinanceira}',
						serial : '${acc.serial}', 
						porta : '${acc.porta}', 
						agd : '${acc.atuadorGrupoDescricao}',
						ofd : '${acc.obrigacaoFinanceiraDescricao}'};
		acessorios.push(acessorio);
	</c:forEach>
	var html = '';
	
	function excluirAcessorioRestrito(serial) {
		/*
		var urlExcluirAcessorio = '/SascarPortalWeb/AtivarEquipamentoVinculo/';
		$.ajax({
			url : urlExcluirAcessorio,
			data : params,
			dataType : 'json',
			success ; function(function(json){
				if (json.success) {
					$("#formAtualizar").submit();
				} else {
					$.showMessage(json.mensagem);
				}				
			}, error : function(x,y,z) {
				
			}
		});		*/
		alert(serial);
	}
	
	function criaEstruturaTabela(acc) {
		html += '<tr id="trof">' +
				'<td class="barracinza">Acess&oacute;rio</td><td>' + acc.ofd + '</td></tr>';
		html += '<tr id="trSerial">' +
				'<td class="barracinza">Serial</td><td>' + acc.serial + '</td></tr>';
		html += '<tr id="trPorta">' +
				'<td  class="barracinza">Porta</td><td>' + acc.porta + '</td></tr>';
		html += '<tr id="trBotao">' +
				'<td colspan="2" class="btn"><input type="button" onclick="excluirAcessorioRestrito(\'' + acc.serial + '\')" class="button" id="btn_' + acc.serial + '" value="Excluir"/></td></tr>';
	}	
	
	function criaTabela() {
		return '<table id="tblAcessoriosRestritos" class="tblAcessoriosRestritos">' + html + '</table>';
	}
	
	$(document).ready(function(){
		if(acessorios.length > 0) {
			for(var i = 0; i < acessorios.length; i++) {
				var acc = acessorios[i];
				criaEstruturaTabela(acc);
			}
			$('#tabelaAcessoriosRestritos').html(criaTabela());
		}
	});
	</script>