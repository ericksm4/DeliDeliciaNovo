class Admin::ListagemAcontece < ActiveRecord::Base
	belongs_to :evento, :class_name => 'Admin::Acontece', :foreign_key => 'id_acontece'
end
