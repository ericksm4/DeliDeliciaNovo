class Admin::Novidade < ActiveRecord::Base

	mount_uploader :imagem, AttachmentUploader
	mount_uploader :imagem_listagem, AttachmentUploader

	def self.search(search)  
	    if search  
	      where('titulo LIKE ?', "%#{search}%")  
	    else  
	      scoped  
	    end  
	  end 	
end
