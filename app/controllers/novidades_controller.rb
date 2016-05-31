class NovidadesController < ApplicationController
	def index
			
		if params[:id].blank?
			@novos = Admin::Novidade.where('(data_inicio < NOW() and data_fim > NOW()) AND categoria = "novos"')
			@lancamentos = Admin::Novidade.where('(data_inicio < NOW() and data_fim > NOW()) AND categoria = "lancamentos"')
			@conceitos = Admin::Novidade.where('(data_inicio < NOW() and data_fim > NOW()) AND categoria = "conceitos"')
		else
			@novidade = Admin::Novidade.find(params[:id])
		end

		render :layout => 'website'
	end
end
