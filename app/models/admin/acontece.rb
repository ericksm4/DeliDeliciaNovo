class Admin::Acontece < ActiveRecord::Base
	has_many :itens, :class_name => 'Admin::ListagemAcontece'

	mount_uploader :imagem, AttachmentUploader
end
