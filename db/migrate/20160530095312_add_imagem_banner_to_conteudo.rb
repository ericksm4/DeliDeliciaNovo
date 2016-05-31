class AddImagemBannerToConteudo < ActiveRecord::Migration
  def change
  	add_column :admin_conteudos, :imagem_banner, :text
  end
end
