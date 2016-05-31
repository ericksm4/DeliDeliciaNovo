class CreateAdminAreas < ActiveRecord::Migration
  def change
    create_table :admin_areas do |t|
      t.string :nome
      t.string :url
      t.integer :ordem
      t.boolean :exibe_menu
      t.integer :status
      t.string :imagem
      t.string :imagem_url
      t.string :imagem_target_link
      t.timestamps
    end
  end
end
