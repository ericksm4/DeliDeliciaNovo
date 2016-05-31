class MarqueUmaVisitaController < ApplicationController
	
	skip_before_filter :verify_authenticity_token

	def index
		render :layout => 'website'
	end

	def marcaVisita
		visita = Admin::MarqueUmaVisita.new
		visita.nome = params[:nome]
		visita.email = params[:email]
		visita.telefone = params[:telefone]
		visita.bairro = params[:bairro]
		visita.cidade = params[:cidade]
		visita.comentarios = params[:comentarios]

		if visita.save
			EnviaEmail.visita(params[:nome], params[:email], params[:telefone], params[:bairro], params[:cidade], params[:comentarios]).deliver
			render :json => visita
		end
	end
end
