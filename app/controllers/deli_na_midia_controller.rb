class DeliNaMidiaController < ApplicationController

	skip_before_filter :verify_authenticity_token

	def index
		@midias = Admin::DeliNaMidia.where('data_inicio < NOW() and data_fim > NOW()').order('data_inicio')
		render :layout => 'website'
	end

	def carregaImagens
		img = Admin::DeliNaMidiaImagem.where('id_midia = ?', params[:id])

		render :json => img
	end
  
end
