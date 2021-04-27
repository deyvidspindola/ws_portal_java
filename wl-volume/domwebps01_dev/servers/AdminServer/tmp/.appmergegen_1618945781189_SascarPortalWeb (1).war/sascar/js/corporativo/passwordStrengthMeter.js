// Password strength meter
// This jQuery plugin is written by firas kassem [2007.04.05]
// Firas Kassem  phiras.wordpress.com || phiras at gmail {dot} com
// for more information : http://phiras.wordpress.com/2007/04/08/password-strength-meter-a-jquery-plugin/

var shortPass = 'Muito Curta'
var badPass = 'Ruim'
var goodPass = 'Bom'
var strongPass = 'Forte'

var minlength = 8;
var maxlength = 20;

function passwordStrength(password, username, login)
{
    var score = 0;
    var meter = $('.meter');
    
    //password < minlength
    if (password.length < minlength ) {
    	meter.addClass('week');
    	return shortPass; 
    }
    
    //password == username
    if (password.toLowerCase()==username.toLowerCase()){
    	meter.addClass('week');
    	return badPass;
    }
    
    //password == login
    if (password.toLowerCase()==login.toLowerCase()){
    	meter.addClass('week');
    	return badPass;
    }
    
    //password length
    score += password.length * minlength;
    score += ( checkRepetition(1,password).length - password.length ) * 1;
    score += ( checkRepetition(2,password).length - password.length ) * 1;
    score += ( checkRepetition(3,password).length - password.length ) * 1;
    score += ( checkRepetition(4,password).length - password.length ) * 1;

    //password has 3 numbers
    if (password.match(/(.*[0-9].*[0-9].*[0-9])/))  score += 5; 
    
    //password has 2 sybols
    if (password.match(/(.*[!,@,#,$,%,^,&,*,?,_,~].*[!,@,#,$,%,^,&,*,?,_,~])/)) score += 5; 
    
    //password has Upper and Lower chars
    if (password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/))  score += 10; 
    
    //password has number and chars
    if (password.match(/([a-zA-Z])/) && password.match(/([0-9])/))  score += 15; 
    //
    //password has number and symbol
    if (password.match(/([!,@,#,$,%,^,&,*,?,_,~])/) && password.match(/([0-9])/))  score += 15; 
    
    //password has char and symbol
    if (password.match(/([!,@,#,$,%,^,&,*,?,_,~])/) && password.match(/([a-zA-Z])/))  score += 15; 
    
    //password is just a nubers or chars
    if (password.match(/^\w+$/) || password.match(/^\d+$/) )  score -= 10; 
    
    //verifing 0 < score < 100
    if ( score < 0 )  score = 0; 
    if ( score > 100 )  score = 100; 
    
    
    if (password.length < maxlength)
        meter.removeClass('strong').removeClass('medium').removeClass('week');
    
    if (score < 34 )  {
    	 meter.addClass('week');
         return badPass;
    }else if (score < 68 )  {
    	meter.addClass('medium');
        return goodPass;
    }else{
    	 meter.addClass('strong');
         return strongPass;
    }
    
}


// checkRepetition(1,'aaaaaaabcbc')   = 'abcbc'
// checkRepetition(2,'aaaaaaabcbc')   = 'aabc'
// checkRepetition(2,'aaaaaaabcdbcd') = 'aabcd'

function checkRepetition(pLen,str) {
    res = ""
    for ( i=0; i<str.length ; i++ ) {
        repeated=true
        for (j=0;j < pLen && (j+i+pLen) < str.length;j++)
            repeated=repeated && (str.charAt(j+i)==str.charAt(j+i+pLen))
        if (j<pLen) repeated=false
        if (repeated) {
            i+=pLen-1
            repeated=false
        }
        else {
            res+=str.charAt(i)
        }
    }
    return res
}