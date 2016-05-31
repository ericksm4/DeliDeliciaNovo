$(function () {            
    //alterar quantidade qdo clicar no btn e calcula o valor total do produto
    var qtdInput;
    var possuiClasse;
    var valor_unitario;
    var id_produto;

    $(document).on('click', '.divAlteraQtdInput .alterarQtd', function(e) {
        e.stopPropagation();
        var aqui = $(this);
        valor_unitario = parseFloat($(aqui).closest('div.linhaProduto').find('div.linhaProdutoValorUnitario label').text());//valor_unitario do produto
        qtdInput = parseInt($(aqui).parent().find('input').val()); //qtd do produto no input
        possuiClasse = $(aqui).closest('.qtdAddCarrinho').find('span.adicionarCarrinho').hasClass('btnAdicionado');
        qtdMinima = parseInt($(aqui).parent().find('input').attr('min')); //qtd minima do produto
        id_produto = parseInt($(this).closest('div.linhaProduto').find('.linhaProdutoDetalheProduto').find('h4').attr('id'), 10);

        if(possuiClasse)
            qtdMinima = 1;
        if ($(aqui).hasClass('alterarQtdMenos')) 
        {
            if(qtdInput > qtdMinima)
            {
                $(aqui).parent().find('input').val(qtdInput - 1);
                qtdInput -= 1;
            }
        }
        else
        {
            $(aqui).parent().find('input').val(qtdInput + 1);
                qtdInput += 1;
        }
        //exibe o valor total do produto
        $(aqui).closest('div.linhaProduto').find('.linhaProdutoValorTotal label').text((qtdInput * valor_unitario).toFixed(2));
        alteraQtdCookie(id_produto, qtdInput);
        calculaValorTotalPedido();
    });

    //altera qtd se segurar o botão de '+' ou '-' e calcula o valor total do produto
    var int00;
    var btn_clicado_altera_qtd;
    $(document).on('mousedown', '.divAlteraQtdInput .alterarQtd', function(e) {
        e.stopPropagation();
        btn_clicado_altera_qtd = $(this);
        valor_unitario = parseFloat($(btn_clicado_altera_qtd).closest('div.linhaProduto').find('div.linhaProdutoValorUnitario label').text());//valor_unitario do produto 
        qtdInput = parseInt($(btn_clicado_altera_qtd).parent().find('input').val()); //qtd do produto no input
        qtdMinima = parseInt($(btn_clicado_altera_qtd).parent().find('input').attr('min')); //qtd minima do produto
        possuiClasse = $(this).closest('.qtdAddCarrinho').find('span.adicionarCarrinho').hasClass('btnAdicionado');

        if(possuiClasse)
            qtdMinima = 1;
        int00 = setInterval(function() {
            if ($(btn_clicado_altera_qtd).hasClass('alterarQtdMenos')) 
            {
                if(qtdInput > qtdMinima)
                {
                    $(btn_clicado_altera_qtd).parent().find('input').val(qtdInput -= 1);
                    qtdInput -= 1;
                }
            } 
            else
            {
                $(btn_clicado_altera_qtd).parent().find('input').val(qtdInput += 1);
                qtdInput += 1;
            }
            //exibe o valor total do produto
            $(btn_clicado_altera_qtd).closest('div.linhaProduto').find('.linhaProdutoValorTotal label').text((qtdInput * valor_unitario).toFixed(2));
            calculaValorTotalPedido();
        }, 80);

    }).mouseup(function() {
        clearInterval(int00);
    });

    //Altera a qtd se for menor que o mínimo
    $(document).on('blur', '.divAlteraQtdInput input', function(e) {
        e.stopPropagation();
        var aqui = $(this);
        valor_unitario = parseFloat($(aqui).closest('div.linhaProduto').find('div.linhaProdutoValorUnitario label').text());//valor_unitario do produto
        qtdInput = parseInt($(aqui).val()); //qtd do produto no input
        possuiClasse = $(aqui).closest('.qtdAddCarrinho').find('span.adicionarCarrinho').hasClass('btnAdicionado');
        qtdMinima = parseInt($(aqui).attr('min')); //qtd minima do produto
        id_produto = parseInt($(this).closest('div.linhaProduto').find('.linhaProdutoDetalheProduto').find('h4').attr('id'), 10);

        if(qtdInput < qtdMinima)
        {
            $(aqui).val(qtdMinima);
            qtdInput = qtdMinima;
        }

        //exibe o valor total do produto
        $(aqui).closest('div.linhaProduto').find('.linhaProdutoValorTotal label').text((qtdInput * valor_unitario).toFixed(2));
        alteraQtdCookie(id_produto, qtdInput);
        calculaValorTotalPedido();
    });


});