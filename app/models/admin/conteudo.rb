class Admin::Conteudo < ActiveRecord::Base
  mount_uploader :imagem_destaque, AttachmentUploader
  mount_uploader :imagem_banner, AttachmentUploader
  
  belongs_to :categoria, :class_name => 'Admin::Categoria'
    
  def self.search(search)  
    if search  
      where('titulo LIKE ?', "%#{search}%")  
    else  
      scoped  
    end  
  end 
end
