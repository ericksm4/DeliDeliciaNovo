//calcula e exibe o valor total do pedido
function calculaValorTotalPedido()
{
    var valor_total_pedido = 0;
    var valor_entrega = $('#valorEntrega label#entrega').text();
 
    if (valor_entrega == "Entrega grátis")
        valor_entrega = 0;
    else
        valor_entrega = parseFloat(valor_entrega.replace(',','.'));

    $('.linhaProduto').each(function() {
        valor_total_pedido += parseFloat($(this).find('.linhaProdutoValorTotal label').text());
    });

    valor_total_pedido += valor_entrega;
    $('#finalizacaoPedido label').text("R$ " + valor_total_pedido.toFixed(2).replace('.', ','));
}
