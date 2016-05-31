	
function geraValorTotal()
{
	var cookieArmazenado = ($.cookie('listaComprasDeliDelicia').split(','));

	if ($.cookie('listaComprasDeliDelicia') == null || $.cookie('listaComprasDeliDelicia') == "") 
	{
		cookieArmazenado = [];
	} else {
		cookieArmazenado = ($.cookie('listaComprasDeliDelicia').split(','));
	} 

	var id_cookie_json;
	var qtd_cookie_json;
	var cookie_array = [];
	var cookieObj= {};
	for (i = 0; i < cookieArmazenado.length; i++) 
	{
	    var a = cookieArmazenado[i]; //guarda a string 'i'
	    var sub = a.indexOf('-');
	    if(sub != -1)
	    {
		    id_cookie_json = parseInt(a.substring(3, sub), 10); //salva o id do cookie
		    qtd_cookie_json = parseInt(a.substring(sub + 6), 10); //salva a qtd que tem no cookie
		    cookieObj = {id: id_cookie_json, quantidade: qtd_cookie_json};
		    cookie_array.push(cookieObj);
	    }
	}
	// console.log("id_cookie_array: ", cookie_array);
	// console.log(JSON.stringify(cookie_array));
	cookie_array = JSON.stringify(cookie_array);

	$.ajax({
		type: "POST",
		url: "/produtos/json/cookie_array",
		dataType: "json",
		data: {cookie: cookie_array},
 	    success: function( data ) {
 	    	// alert(data);
 	    	var total = data.toFixed(2).replace('.', ',');
	 	    $('#valorTotalCarrinho').text(total);
		}, 
		error: function(){
			// alert("erro");
	 	    $('#valorTotalCarrinho').text(' - ');
		}
	}).done(function() {});
}