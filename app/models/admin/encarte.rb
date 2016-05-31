class Admin::Encarte < ActiveRecord::Base

	mount_uploader :imagem_destaque, AttachmentUploader

	has_many :imagens, :class_name => 'Admin::ImagemEncarte', :foreign_key => 'id_encarte'
	
	def self.search(search)  
	    if search  
	      where('nome LIKE ?', "%#{search}%")  
	    else  
	      scoped  
	    end  
  	end 
end
