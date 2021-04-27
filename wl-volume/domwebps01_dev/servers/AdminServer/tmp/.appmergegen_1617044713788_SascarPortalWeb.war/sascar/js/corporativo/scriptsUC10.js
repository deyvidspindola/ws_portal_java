$( document ).ready(function() {
	$('#divLoader').hide();
});

var paramNumeroOS = jQuery("#paramNumeroOS").val();
var acessorioCodigo = jQuery("#acessorioCodigo").val();
var acessorios = [];

var ppp = '';
function excluirAcessorioRestrito(idContratoServico, serial, idAcessorio) {
	var result = confirm("Deseja excluir o acessório com serial " + serial + "?");
	if(result) {
		
		var cpf = $('[name=numeroCPF').val();
		var nos = $('[name=numeroOS').val();
		var quantidade = 0;
		var codigoPorta = 4;
		var tipoSubmeter = 'D';
		var numeroRf = 'N';
		
		var params = 'acao=13' +
					'&numeroOS=' + paramNumeroOS +
					'&motivo=A' +
					'&codigoAcessorio=' + idContratoServico;
		
		if(acessorios.length <= 1) {
			$('#divPopup').dialog('close');
		}

		var urlExcluirAcessorio = '/SascarPortalWeb/AtivarEquipamentoVinculo/excluirAcessorio';
		$.ajax({
			url : urlExcluirAcessorio,
			data : params,
			type : 'POST',
			dataType : 'json',
			success : function(json){
				if (!json.success) {
					$.showMessage(json.mensagem);
				}				
			}, error : function(x,y,z) {
				console.log(x);
				console.log(y);
				console.log(z);
			}
		});
	}	
}

function cancelar() {
	document.getElementById("codigoPorta").selectedIndex=0;
	acessorios = [];
	$('#divPopup').dialog('close');
}

function criaEstruturaTabela(acc) {
	ppp += '<tr id="trof">' +
			'<td class="barracinza">Acess&oacute;rio</td><td>' + acc.obrigacaoFinanceiraDescricao + '</td></tr>';
	ppp += '<tr id="trSerial">' +
			'<td class="barracinza">Serial</td><td>' + acc.serial + '</td></tr>';
	ppp += '<tr id="trPorta">' +
			'<td  class="barracinza">Porta</td><td>' + acc.porta + '</td></tr>';
	ppp += '<tr id="trBotao">' +
			'<td colspan="2" class="btn" style="text-align:center;">' +
			'<input type="button" onclick="cancelar()" class="button4" id="cnc_' + acc.idContratoServico + '" value="Cancelar"/> ' +
			'<input type="button" onclick="excluirAcessorioRestrito(' + acc.idContratoServico + ', \'' + acc.serial + 
			'\',' + acc.idObrigacaoFinanceira + ')" class="button" id="btn_' + acc.idContratoServico + '" value="Excluir"/></td></tr>';
}

function criaTabela() {
	return '<table id="tblAcessoriosRestritos" class="tblAcessoriosRestritos">' + ppp + '</table>';
}

function recuperarTravas5aRodaInstaladas() {
	$('#divLoader').show();
	var val = $('#codigoPorta').val();
	if(null !== val && undefined !== val && val !== "") {
		var obroid = acessorioCodigo;
		var ordoid = paramNumeroOS;
		var url_ = '/SascarPortalWeb/AtivarEquipamentoVinculo/recuperarAcessorio?acao=17&obroid=' + obroid + '&ordoid=' + ordoid;
		//Abrir popup carregando
		$(window).unload();
		params = 'obroid=' + obroid + '&ordoid=' + ordoid;
		$.ajax({
			url : url_,
			data : params,
			type : 'POST',
			dataType : 'json',
				success : function(retorno){					
				$('#divLoader').hide();						
				//Chamar fechamento do carregar
				$.closeOverlay();
				if(retorno !== undefined && retorno !== null) {
					//Se o retorno for um array vazio, não existe conflito
					if(retorno.length < 1) {
						return;
					}
					
					ppp = '';
					acessorios = [];
					$('#divPopup').html('');
					for(var i = 0; i < retorno.length; i++) {
						var acc = retorno[i];
						acessorios.push(acc);
						criaEstruturaTabela(acc);
					}
					
					if(acessorios.length > 0) {
						$('#divPopup').html(criaTabela());
						$('#divPopup').css({'display' : 'block', 'overflow' : 'auto'});
						$('#divPopup').dialog({
							resizable: false,
							width:500,
							minHeight : 150,
							maxHeight : 600,
							modal: true,
							title : 'Acessórios em conflito',
							closeOnEscape: false,
							open : function(event, ui) {
								if(acessorios.length > 0) {
									$(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
								}
							}, close : function(event) {
								
							}
						}).prev(".ui-dialog-titlebar").css({"background":"red", "border" : "red"});
					}
				}
				$("input[type=submit]").show();
			}, error : function(x,y,z) {
				$('#divLoader').hide();
				$("input[type=submit]").show();
				console.log(x);
				console.log(y);
				console.log(z);
			}
		});
	}
	
	function substituiValoresAcessorio(pos) {
		var acc = acessorios[pos];
		$('#nomeAcessorio').val(acc.obrigacaoFinanceiraDescricao);
		$('#numeroSerial').val(acc.serial);
		$('#codigoPorta').val(acc.porta);
		$('#nomeAcessorio').attr('readonly', true);
		$('#numeroSerial').attr('readonly', true);
		$('#codigoPorta').attr('readonly', true);
		$('#codigoPorta').attr('disabled', 'disabled');
	}
}

$('#codigoPorta').change(function(){
	$("input[type=submit]").hide();
	recuperarTravas5aRodaInstaladas();
});