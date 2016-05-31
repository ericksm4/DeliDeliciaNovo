class DeliSazonalController < ApplicationController
	def index
		@sazonal = Admin::DeliSazonal.order('data_inicio DESC').first()
		render :layout => 'website'
	end
end
