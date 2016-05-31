class ConteudosController < ApplicationController
	def index
		@conteudo = Admin::Conteudo.where("id = ? and status = 1", params[:id]).first()
		render :layout => 'website'
	end
end
