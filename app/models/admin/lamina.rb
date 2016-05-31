class Admin::Lamina < ActiveRecord::Base
	
	mount_uploader :imagem_destaque, AttachmentUploader
	
	has_many :imagens, :class_name => 'Admin::ImagemLamina', :foreign_key => 'id_lamina'

	def self.search(search)  
	    if search  
	      where('nome LIKE ?', "%#{search}%")  
	    else  
	      scoped  
	    end  
  	end 
end
