class AconteceController < ApplicationController

	skip_before_filter :verify_authenticity_token

	def index
		@eventos = Admin::Acontece.where('data_inicio < NOW() and data_fim > NOW()')

		render :layout => 'website'
	end

	def realizaReserva
		evento = Admin::Acontece.where('titulo = ?', params[:nome_evento]).first()

		unless evento.blank?
			registro = Admin::ListagemAcontece.new

			registro.evento = evento
			registro.nome = params[:nome]
			registro.email = params[:email]
			registro.telefone = params[:telefone]
			registro.bairro = params[:bairro]
			registro.cidade = params[:cidade]
			registro.comentario = params[:comentario]

			if registro.save
				EnviaEmail.reserva(evento.titulo).deliver
				render :json => registro
			end
		end
		
	end
end
