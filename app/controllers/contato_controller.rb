class ContatoController < ApplicationController
	
	skip_before_filter :verify_authenticity_token

	def index
		render :layout => 'website'
	end

	def enviaContato

		contato = Admin::Contato.new
		contato.nome = params[:nome]
		contato.email = params[:email]
		contato.telefone = params[:telefone]
		contato.bairro = params[:bairro]
		contato.cidade = params[:cidade]
		contato.sugestoes = params[:sugestoes]
		contato.receber_news = params[:news]
		contato.data_cadastro = DateTime.now 

		if contato.save
			EnviaEmail.contato(params[:nome], params[:email], params[:telefone], params[:bairro], params[:cidade], params[:sugestao], params[:newsletter]).deliver
			render :json => contato
		end
	end
end
