class CreateAdminLojas < ActiveRecord::Migration
  def change
    create_table :admin_lojas do |t|
      t.string :nome, :limit => 200
      t.string :endereco, :limit => 150
      t.string :cidade, :limit => 200
      t.string :horario_funcionamento, :limit => 50
      t.string :telefone, :limit => 30
      t.text :imagem
      t.text :url_tour
      t.text :url_maps
      t.timestamps
    end
  end
end
