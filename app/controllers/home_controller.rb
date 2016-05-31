class HomeController < ApplicationController
	def index

		@banners = Admin::Banner.where('status = 1')
		@encarte = Admin::Encarte.where('status = 1 AND (data_inicio < NOW() and data_fim > NOW())').order('data_inicio').first()
		@lamina = Admin::Lamina.where('status = 1 AND (data_inicio < NOW() and data_fim > NOW())').order('data_inicio').first()

		render :layout => 'website'
	end
end
