class Admin::ImagemEncarte < ActiveRecord::Base
	mount_uploader :imagem, AttachmentUploader
	belongs_to :encarte
end
