class Admin::DeliSazonal < ActiveRecord::Base

	mount_uploader :imagem, AttachmentUploader

	def self.search(search)  
	    if search  
	      where('titulo LIKE ?', "%#{search}%")  
	    else  
	      scoped  
	    end  
	  end 	
end
