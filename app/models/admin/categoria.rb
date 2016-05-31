class Admin::Categoria < ActiveRecord::Base  
  mount_uploader :imagem, AttachmentUploader

  has_many :conteudos, :class_name => 'Admin::Conteudo', :dependent => :restrict_with_error
  
  belongs_to :area, :class_name => 'Admin::Area'

  belongs_to :categoria, :class_name => 'Admin::Categoria'

  has_many :categorias, :class_name => 'Admin::Categoria', :foreign_key => "categoria_id", :dependent => :restrict_with_error



  def self.search(search)  
    if search  
      where('nome LIKE ?', "%#{search}%")  
    else  
        scoped  
    end  
  end
end
