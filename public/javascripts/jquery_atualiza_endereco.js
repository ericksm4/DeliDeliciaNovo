
function atualizaEndereco(id_endereco)
{
    var id;
    var nome;
    var logradouro;
    var cep;
    var referencia;
    $('input[name="pedido[endereco_id]"]').val(id_endereco);
    $('.divBoxEntrega').each(function() {
        id = $(this).find('input[name="id_endereco_selecionado"]').val();
        if(id_endereco == id)
        {                    
            nome = ($(this).find('span.nomeEndereco').text());
            logradouro = ($(this).find('span.logradouroEndereco').text());
            cep = ($(this).find('span.cepEndereco').text());
            referencia = ($(this).find('span.referenciaEndereco').text());

            $('#enderecoEntrega div').find('span.nomeEndereco').text(nome);
            $('#enderecoEntrega div').find('span.logradouroEndereco').text(logradouro);
            $('#enderecoEntrega div').find('span.cepEndereco').text(cep);
            $('#enderecoEntrega div').find('span.referenciaEndereco').text(referencia);

        }
    });

}