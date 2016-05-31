class CreateAdminCategoria < ActiveRecord::Migration
  def change
    create_table :admin_categorias do |t|
      t.string :nome
      t.string :url
      t.string :target_url
      t.integer :ordem
      t.integer :status
      t.string :imagem
      t.string :imagem_url
      t.string :imagem_target_link
      t.belongs_to :area
      t.timestamps
    end
  end
end
