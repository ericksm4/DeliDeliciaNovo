
//salva e exclui do cookie o id e quantidade do produto
function salvaCookie() 
{

      if ($.cookie('listaComprasDeliDelicia') == null || $.cookie('listaComprasDeliDelicia') == "") 
      {
          $.cookie("listaComprasDeliDelicia", "");
      }

      //CARRINHO
      var cookieArmazenado = ($.cookie('listaComprasDeliDelicia').split(','));
      var divItensListaCookie = "listaComprasDeliDelicia";
      var listaItensExp = 15;
      var itens_do_carrinho = [];
      var difference = [];
      var qtdeItensCarrinho = 0;
      var cookieArray = [];

      //verifica se já existe o id do produto no cookie e adiciona a classe 'produtoAdicionado'
      $('.boxProduto').each(function () {
            var i;
            var id_prod= ($(this).find('h4').attr('id'));                  
            for (i = 0; i < cookieArmazenado.length; i++) 
            {
                  var sub = cookieArmazenado[i].indexOf('-');
                  var id_cookie = parseInt(cookieArmazenado[i].substring(3, sub), 10);
                  if (id_prod == id_cookie) 
                  {
                        $(this).find('h4').addClass('produtoAdicionado');
                        $(this).find('.adicionarCarrinho').addClass('btnAdicionado');
                        // $(this).parent().find('.listaProdutosBannerBtn').children().text('Remover da lista');
                  }
            }
      });

      //Remove do cookie se clicar no botão remover da lista
      $(document).on('click', 'span.excluirProduto', function(e) {
            e.stopPropagation();
            

            if (confirm("Você deseja realmente excluir este item?"))
            {
                  var este = $(this);
                  var id_produto = parseInt($(this).closest('div.linhaProduto').find('.linhaProdutoDetalheProduto').find('h4').attr('id'), 10);
                  
                  var i;
                  for (i = 0; i < cookieArmazenado.length; i++) 
                  {
                        var a = cookieArmazenado[i]; //guarda a string 'i'
                        var sub = a.indexOf('-');
                        var id_cookie = parseInt(a.substring(3, sub), 10); //salva o id do cookie
                        var qtd_cookie = parseInt(a.substring(sub + 6), 10); //salva a qtd que tem no cookie
                        prodCookie = "id:" + id_cookie + " - qtd:" + qtd_cookie; //salva uma string identica a do cookie
                        if (id_produto == id_cookie) 
                        {         
                              cookieArmazenado.splice($.inArray(prodCookie, cookieArmazenado), 1); //remove do array o produto com a qtd antiga
                              $.cookie(divItensListaCookie, cookieArmazenado, { expires: listaItensExp, path: "/" }); //salva o cookie com a qtd atualizada
                              geraValorTotal();
                              $(este).closest('div.linhaProduto').remove();
                              calculaValorTotalPedido();
                              if ($('#listaTodosProdutos').find('.linhaProdutoDetalheProduto').children('h4').length == 0)
                              {
                                    $('#finalizacaoPedido a.finalizarCompra').remove();
                                    $('#listaTodosProdutos').append('<p class="carrinhoVazio">O seu carrinho de compras está vazio.</p>');
                              }
                              return false;
                        }
                  }
            }


      });

      var entrar_funcao_add = true;
      var produto;
      var idProduto; //id do produto clicado
      var qtdProduto;
      var qtdSomada = 0;
      $('span.adicionarCarrinho').click(function (e) {
            e.stopPropagation();
            cookieArray = [];
            if ($.cookie('listaComprasDeliDelicia') == null || $.cookie('listaComprasDeliDelicia') == "") 
            {
                  // console.log('cookie vazio');
                  cookieArmazenado = [];
            } else {
                  // console.log('cookie armazenado');
                  cookieArmazenado = ($.cookie('listaComprasDeliDelicia').split(','));
            } 
            produto = $(this).closest('div.boxProduto').find('h4');
            idProduto = parseInt($(produto).attr('id'), 10); //id do produto clicado
            qtdProduto = parseInt($(this).parent().find('input').val(), 10);
            
            var produtoCarrinho;
            qtdSomada = 0;
            var prodCookie;
            var adicionar_carrinho = false;
          
            if ($(produto).hasClass('produtoAdicionado')) 
            { 
                  $('div#mask').show();
                  $('div#boxConfirmacaoAddCarrinho').show();
                  if (entrar_funcao_add)
                  {
                        $('span.btnConfirmacaoAddCarrinhoSim').click(function (e){
                              e.stopPropagation();
                              entrar_funcao_add = false;
                              qtdSomada = 0;
                              adicionar_carrinho = true;

                              $('div#boxConfirmacaoAddCarrinho').hide();
                              $('div#mask').hide();

                              if(adicionar_carrinho)
                              {
                                    //se o produto ja estiver adicionado, ele atualiza a quantidade de produto no cookie
                                    for (i = 0; i < cookieArmazenado.length; i++) 
                                    {
                                          var a = cookieArmazenado[i]; //guarda a string 'i'
                                          var sub = a.indexOf('-');
                                          var id_cookie = parseInt(a.substring(3, sub), 10); //salva o id do cookie
                                          var qtd_cookie = parseInt(a.substring(sub + 6), 10); //salva a qtd que tem no cookie
                                          prodCookie = "id:" + id_cookie + " - qtd:" + qtd_cookie; //salva uma string identica a do cookie
                                          if (idProduto == id_cookie) 
                                          {
                                                qtdSomada = qtd_cookie + qtdProduto;// qtd somada = qtd que ja possui no cookie + a qtd que quer adicionar          
                                                cookieArmazenado.splice($.inArray(prodCookie, cookieArmazenado), 1); //remove do array o produto com a qtd antiga
                                                prodCookie = "id:" + id_cookie + " - qtd:" + qtdSomada; //prod com a qtd atualizada
                                                cookieArmazenado.push(prodCookie); //atualiza o array com o prod de quantidade nova no array
                                                $.cookie(divItensListaCookie, cookieArmazenado, { expires: listaItensExp, path: "/" }); //salva o cookie com a qtd atualizada
                                                showMsgAddCarrinho();
                                                geraValorTotal();
                                                return false;
                                          }
                                    }
                              }
                        });
                  }

            } 
            else 
            {
                  $(produto).addClass('produtoAdicionado'); //adiciona classe para o produto clicado
                  $(this).addClass('btnAdicionado');
                  cookieArray = cookieArmazenado;
                  cookieArray.push("id:" + parseInt(idProduto, 10) + " - qtd:" + parseInt(qtdProduto, 10));
                  $.cookie(divItensListaCookie, cookieArray, { expires: listaItensExp, path: "/" });
                  showMsgAddCarrinho();
                  geraValorTotal();
            }
      });




}

//altera a qtd no cookie se clicar ou segurar o botao de alterar quantidade (pág. meu carrinho)
function alteraQtdCookie(id_produto, qtdInput)
{
      var cookieArmazenado = ($.cookie('listaComprasDeliDelicia').split(','));
      var divItensListaCookie = "listaComprasDeliDelicia";
      var listaItensExp = 15;
      var i;
      for (i = 0; i < cookieArmazenado.length; i++) 
      {
            var a = cookieArmazenado[i]; //guarda a string 'i'
            var sub = a.indexOf('-');
            var id_cookie = parseInt(a.substring(3, sub), 10); //salva o id do cookie
            var qtd_cookie = parseInt(a.substring(sub + 6), 10); //salva a qtd que tem no cookie
            prodCookie = "id:" + id_cookie + " - qtd:" + qtd_cookie; //salva uma string identica a do cookie
            if (id_produto == id_cookie) 
            {                 
                  cookieArmazenado.splice($.inArray(prodCookie, cookieArmazenado), 1); //remove do array o produto com a qtd antiga
                  prodCookie = "id:" + id_cookie + " - qtd:" + qtdInput; //prod com a qtd atualizada
                  cookieArmazenado.push(prodCookie); //atualiza o array com o prod de quantidade nova no array
                  $.cookie(divItensListaCookie, cookieArmazenado, { expires: listaItensExp, path: "/" }); //salva o cookie com a qtd atualizada

                  geraValorTotal();
                  return false;
            }
      } 
}

//adiciona id do pedido no cookie
function adicionaIdPedido(pedido_id)
{
      var cookieArmazenado = ($.cookie('listaComprasDeliDelicia').split(','));
      var divItensListaCookie = "listaComprasDeliDelicia";
      var listaItensExp = 15;
      var i;
      var insere_pedido = "pedido_id:" + pedido_id;
      var contem_pedido;
      var sub;
      var adiciona_id = true;

      for (i = 0; i < cookieArmazenado.length; i++) 
      {
            var a = cookieArmazenado[i]; //guarda a string 'i'
            sub = a.indexOf(':');
            contem_pedido = a.substring(0, sub);
            if($.trim(contem_pedido) == 'pedido_id')
            {
                  adiciona_id = false;
            }
      }

      if (adiciona_id)
      {
            cookieArmazenado.push(insere_pedido); //atualiza o array com o prod de quantidade nova no array
            $.cookie(divItensListaCookie, cookieArmazenado, { expires: listaItensExp, path: "/" }); //salva o cookie com a qtd atualizada
      }
      
}

//exibe mensagem quando adiciona ao carrinho
function showMsgAddCarrinho()
{
      $('#msgAddCarrinho').stop().animate({ //animate para box subir
          bottom: '0px',
          opacity: 1},
          400, function() { 
            setTimeout(function() { //callback para esconder a mensagem com animate e setTimeOut
                $('#msgAddCarrinho').stop().animate({
                bottom: '-100px',
                opacity: 1},
                400)
            }, 2000);
      })
}