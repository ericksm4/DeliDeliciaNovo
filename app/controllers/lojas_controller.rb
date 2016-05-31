class LojasController < ApplicationController
	def index
		@lojas = Admin::Loja.all
		render :layout => 'website'
	end
end
