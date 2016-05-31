class Admin::Banner < ActiveRecord::Base
  belongs_to :area, :class_name => 'Admin::Area'

  mount_uploader :imagem, AttachmentUploader
  
  def self.search(search)  
    if search  
      where('nome LIKE ?', "%#{search}%")  
    else  
      scoped  
    end  
  end  
end
