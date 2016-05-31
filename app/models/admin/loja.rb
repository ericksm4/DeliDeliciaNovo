class Admin::Loja < ActiveRecord::Base
	mount_uploader :imagem, AttachmentUploader

	def self.search(search)  
	    if search  
	      where('nome LIKE ?', "%#{search}%")  
	    else  
	      scoped  
	    end  
  	end 
end
