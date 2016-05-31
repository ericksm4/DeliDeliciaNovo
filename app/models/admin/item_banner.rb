class Admin::ItemBanner < ActiveRecord::Base
  mount_uploader :imagem, AttachmentUploader

  belongs_to :banner, :class_name => 'Admin::Banner'

  def self.search(search)  
    if search  
      where('nome LIKE ?', "%#{search}%")  
    else  
      scoped  
    end  
  end  
end
