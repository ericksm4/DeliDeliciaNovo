class Admin::ImagemLamina < ActiveRecord::Base
	mount_uploader :imagem, AttachmentUploader
	belongs_to :lamina
end
