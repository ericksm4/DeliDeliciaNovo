class EncarteController < ApplicationController
	def index
		@encarte = Admin::Encarte.where('status = 1 AND (data_inicio < NOW() and data_fim > NOW())').order('data_inicio').first()
		render :layout => 'website'
	end
end
