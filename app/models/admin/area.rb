class Admin::Area < ActiveRecord::Base
  
  mount_uploader :imagem, AttachmentUploader
  
  has_many :categorias, :class_name => 'Admin::Categoria'
  has_many :banners, :class_name => 'Admin::Banner'
  
  validates_uniqueness_of :nome, :message => "O nome da área não pode estar em branco"
  
  def self.search(search)
    if search  
      where('nome LIKE ?', "%#{search}%")  
    else        
        scoped  
    end  
  end  
end
