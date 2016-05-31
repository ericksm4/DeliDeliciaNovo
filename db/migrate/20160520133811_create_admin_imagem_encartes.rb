class CreateAdminImagemEncartes < ActiveRecord::Migration
  def change
    create_table :admin_imagem_encartes do |t|
      t.text :imagem
      t.integer :id_encarte
      t.timestamps
    end
  end
end
