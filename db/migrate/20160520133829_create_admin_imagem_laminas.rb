class CreateAdminImagemLaminas < ActiveRecord::Migration
  def change
    create_table :admin_imagem_laminas do |t|
      t.text :imagem
      t.integer :id_lamina
      t.timestamps
    end
  end
end
