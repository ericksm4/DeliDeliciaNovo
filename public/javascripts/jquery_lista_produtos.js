        //lista os produtos que estão no cookie
        function listaProdutos()
        {
            $("div#mask").show();
            $("span#loader").show();
            var cookieArmazenado = ($.cookie('listaComprasDeliDelicia').split(','));
            var itens_carrinho = [];
            var valor_total_produto = 0;
            var qtd_itens_produto;
            var id_produto_linha;

            for (i = 0; i < cookieArmazenado.length; i++) 
            {
                var a = cookieArmazenado[i]; //guarda a string 'i'
                var sub = a.indexOf('-');
                if(sub != -1)
                {
                    var id_cookie = parseInt(a.substring(3, sub), 10); //salva o id do cookie
                    var qtd_cookie = parseInt(a.substring(sub + 6), 10); //salva a qtd que tem no cookie
                    itens_carrinho.push(id_cookie);
                }
            }

            if (itens_carrinho == "")
            {
                $("div#mask").hide();
                $("span#loader").hide();
                $('#finalizacaoPedido a.finalizarCompra, #finalizacaoPedido span').remove();
                $('#listaTodosProdutos').append('<p class="carrinhoVazio">O seu carrinho de compras está vazio.</p>');
            } 
            else
            {
                $.ajax({
                    type: "GET",
                    url: "/carrinho/json/" + itens_carrinho,
                    dataType: "json",
                    success: function (data){

                        $(data).each(function () {
                            if (this.imagem.url == null)
                                this.imagem.url = "/images/website/sem-imagem-sem-texto.jpg";
                            $("#listaTodosProdutos").append(
                                '<div class="linhaProduto">' + 

                                    '<input type="hidden" name="id_produto" value="'+this.id+'">' +
                                    '<input type="hidden" name="valor_unitario_produto" value="'+this.preco+'">' +
                                    '<input type="hidden" name="nome_produto" value="'+this.nome+'">' +
                                    '<input type="hidden" name="codigo_interno" value="'+this.codigo_interno+'">' +

                                    '<div class="linhaProdutoDetalheProduto">' + 
                                        '<img src="'+this.imagem.url+'" alt="'+this.nome+'" title="'+this.nome+'">' +
                                        '<h4 id="'+this.id+'">'+this.nome+'</h4>'+
                                    '</div>' + 
                                    '<div class="linhaProdutoQuantidade">' +
                                        '<div class="divAlteraQtdInput">' +
                                            '<span class="alterarQtd alterarQtdMenos">-</span>' + 
                                            '<input type="text" name="qtd_produto" value="" min="'+this.quantidade_minima+'">' +
                                            '<span class="alterarQtd alterarQtdMais">+</span>' +
                                        '</div>' +
                                    '</div>' + 
                                    '<div class="linhaProdutoValorUnitario">' + 
                                        '<span>R$ <label>'+this.preco+'</label></span>' + 
                                    '</div>' + 
                                    '<div class="linhaProdutoValorTotal">' +
                                        '<span>R$ <label></label> </span>' +
                                    '</div>' +
                                    '<div class="linhaProdutoCancelarItem">' +
                                        '<span class="excluirProduto"></span>' +
                                    '</div>' +

                                '</div>'
                            );

                        });


                    },
                    error: function (data){
                        console.log("Erro ao carregar ajax lista produtos.");
                    }
                }).done(function (){
                    
                    $('.linhaProduto').each(function() {

                        //calcular o valor total do produto (de cada linha)
                        valor_total_produto = parseFloat($(this).find('.linhaProdutoValorUnitario label').text());

                        //coloca a qtd de produtos no input o valor que esta armazenado no cookie
                        id_produto_linha = $(this).find('.linhaProdutoDetalheProduto h4').attr('id');
                        for (i = 0; i < cookieArmazenado.length; i++) 
                        {
                            var a = cookieArmazenado[i]; //guarda a string 'i'
                            var sub = a.indexOf('-');
                            var id_cookie = parseInt(a.substring(3, sub), 10); //salva o id do cookie
                            var qtd_cookie = parseInt(a.substring(sub + 6), 10); //salva a qtd que tem no cookie
                            if (id_produto_linha == id_cookie) 
                            {         
                                qtd_itens_produto = $(this).find('.divAlteraQtdInput input').val(qtd_cookie);
                            }
                        }
                        $(this).find('.linhaProdutoValorTotal label').text((valor_total_produto * qtd_itens_produto.val()).toFixed(2));

                    });

                    calculaValorTotalPedido();
                    $("div#mask").hide();
                    $("span#loader").hide();
                });
            }

        }