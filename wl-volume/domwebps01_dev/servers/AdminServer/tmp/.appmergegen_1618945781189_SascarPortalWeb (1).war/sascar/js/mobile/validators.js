$.validator.addMethod("dateBR", function(value, element) {
	if(!value) {
		return true;
	}
	 //contando chars
	if(value.length!=10) return false;
	// verificando data
	var data 		= value;
	var dia 		= data.substr(0,2);
	var barra1		= data.substr(2,1);
	var mes 		= data.substr(3,2);
	var barra2		= data.substr(5,1);
	var ano 		= data.substr(6,4);
	if(data.length!=10||barra1!="/"||barra2!="/"||isNaN(dia)||isNaN(mes)||isNaN(ano)||dia>31||mes>12)return false;
	if((mes==4||mes==6||mes==9||mes==11)&& dia==31)return false;
	if(mes==2 && (dia>29||(dia==29 && ano%4!=0)))return false;
	if(ano < 1900)return false;
	return true;
}, "Informe uma data válida");

$.validator.addMethod("notEqualTo", function(value, element, param) {
	return this.optional(element) || value != $(param).val();
}, "Os campos devem ser diferentes.");

$.validator.addMethod("dateHigher", function(value, element, param) {
	var dateStart		= new Date();
	var dateEnd		= new Date();

	var dStart	= $(param).val().split('/');
	dateStart.setFullYear(dStart[2], dStart[1]-1, dStart[0]);

	var dEnd	= value.split('/');
	dateEnd.setFullYear(dEnd[2], dEnd[1]-1, dEnd[0]);

	if (dateEnd < dateStart) {
		return false;
	}

	return true;
}, "Por favor, digite uma data maior que a data anterior.");

$.validator.addMethod("dateHigherNow", function(value, element) {
	var dateStart	= new Date();
	var dateEnd	= new Date();

	var dEnd	= value.split('/');
	dateEnd.setFullYear(dEnd[2], dEnd[1]-1, dEnd[0]);

	if (dateStart > dateEnd)	{
		return false;
	}

	return true;
}, "Por favor, digite uma data maior que a data de hoje.");