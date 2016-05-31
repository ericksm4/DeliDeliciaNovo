class Admin::DeliNaMidiaImagem < ActiveRecord::Base
	mount_uploader :imagem, AttachmentUploader
end
