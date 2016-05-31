class AddNewItensToBanners < ActiveRecord::Migration
  def change
  	add_column :admin_banners, :ordem, :integer
  	add_column :admin_banners, :tempo_exibicao, :integer
  	add_column :admin_banners, :link, :string
  	add_column :admin_banners, :target_link, :string
  	add_column :admin_banners, :imagem, :string
  	add_column :admin_banners, :legenda_opacidade, :float
  	add_column :admin_banners, :legenda, :string
  	add_column :admin_banners, :legenda_cor, :string
  	add_column :admin_banners, :legenda_cor_fundo, :string
  end
end
