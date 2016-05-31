# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$.rails.allowAction = (link) ->
  if(link.attr('tipo') == "copianews")
    #return true unless link.attr('data-confirm')
    $.rails.confirmaCopiaNewsletter(link)
  else
    return true unless link.attr('data-confirm') # look bellow for implementations
    $.rails.showConfirmDialog(link)
  
  false # always stops the action since code runs asynchronously
 
$.rails.confirmed = (link) ->
  if(link.attr('tipo') == "copianews")
    link.removeAttr('tipo')
    link.trigger('click.rails')
  else
    link.removeAttr('data-confirm')
    link.trigger('click.rails')
  
$.rails.showConfirmDialog = (link) ->
  html = """
         <div id="dialog-confirm" title="Exclusão">
                <div class="confirmacaoExcluir">
                    <div class="confirmacaoExcluirDescricao">
                        <span>Você tem certeza que deseja excluir?</span>
                    </div>
                </div>
         </div>
         """
  $(html).dialog
    resizable: false
    modal: true
    closeText: false
    buttons:
      Sim: ->
        type: 'btn btn-primary'
        $.rails.confirmed link
        $(this).dialog "close"
      Não: ->
        $(this).dialog "close"

$.rails.confirmaCopiaNewsletter = (link) ->
  html = """
         <div id="dialog-confirm" title="Duplicar Newsletter">
                <div class="confirmacaoExcluir">
                    <div class="confirmacaoExcluirDescricao">
                        <span>Tem certeza que deseja duplicar essa newsletter?</span>
                    </div>
                </div>
         </div>
         """
  $(html).dialog
    resizable: false
    modal: true
    closeText: false
    buttons:
      Sim: ->
        type: 'btn btn-primary'
        $.rails.confirmed link
        $(this).dialog "close"
      Não: ->
        $(this).dialog "close"

