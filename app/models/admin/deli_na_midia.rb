class Admin::DeliNaMidia < ActiveRecord::Base
	has_many :imagens, :class_name => "Admin::DeliNaMidiaImagem", :foreign_key => 'id_midia'

	def self.search(search)  
	    if search  
	      where('titulo LIKE ?', "%#{search}%")  
	    else  
	      scoped  
	    end  
	  end 
end
