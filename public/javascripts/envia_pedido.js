
function envia_pedido()
{
    //Cria objeto com os valores dos produtos pra salvar
    
        var id_produto;
        var qtd_produto;
        var codigo_interno;
        var produtos = [];
        var obj_produtos = {};
        var valor_entrega;
        
        //preenche produtos do pedido
        $('.linhaProduto').each(function() {
            id_produto = $(this).find('input[name=id_produto]').val();
            qtd_produto = $(this).find('.divAlteraQtdInput input[name=qtd_produto]').val();
            valor_unitario_produto = $(this).find('input[name=valor_unitario_produto]').val();
            nome_produto = $(this).find('input[name=nome_produto]').val();
            codigo_interno = $(this).find('input[name=codigo_interno]').val();
            if(codigo_interno == "null")
              codigo_interno = ""

            obj_produtos = {id_produto: parseInt(id_produto, 10), qtd_produto: parseInt(qtd_produto, 10), valor_unitario_produto: valor_unitario_produto, nome_produto: nome_produto, codigo_interno: codigo_interno }

            produtos.push(obj_produtos);
        });

        //preenche valor da entrega
        valor_entrega = $('#valorEntrega label#entrega').text();
        if (valor_entrega == "Entrega grátis")
            valor_entrega = 0;
        else
            valor_entrega = parseFloat(valor_entrega.replace(',','.'));

        obj_produtos = {valor_entrega: valor_entrega};

    	  produtos.push(obj_produtos);

        //preenche se edita ou cria um novo pedido
        var cookieArmazenado = ($.cookie('listaComprasDeliDelicia').split(','));
      	var i;
      	var contem_pedido;
      	var sub;
      	var edit = false;
      	var editar_pedido;
        var id_do_pedido;

      	for (i = 0; i < cookieArmazenado.length; i++) 
      	{
            var a = cookieArmazenado[i]; //guarda a string 'i'
            sub = a.indexOf(':');
            contem_pedido = a.substring(0, sub);
            if($.trim(contem_pedido) == 'pedido_id')
            {
                id_do_pedido = a.substring(sub + 1);
                edit = true;
            }
      	}

      	if (edit)
      		editar_pedido = id_do_pedido;
      	else
      		editar_pedido = false;

        obj_produtos = {editar_pedido: editar_pedido};

    	  produtos.push(obj_produtos);
        produtos = JSON.stringify(produtos);

        // console.log(produtos);
        // return false;


	$.ajax({
		type: "POST",
		url: "/pedido_produtos/json/pedido",
		dataType: "json",
		data: {pedido: produtos},
 	    success: function( data ) {
 	   //  	console.log('Sucesso');
			  // console.log(data);
        if (edit)
        {
            window.location.replace('/carrinho-passo-2?pedido_id=' + id_do_pedido);
        } else
        {
            window.location.replace('/carrinho-passo-2?pedido_id=' + data.id);
        }
		}, 
		error: function(){
			  console.log("Erro ao enviar o pedido");
			// return false;
		}
	});

}
