class CreateAdminDeliNaMidiaImagems < ActiveRecord::Migration
  def change
    create_table :admin_deli_na_midia_imagems do |t|
      t.text :imagem
      t.integer :id_midia
      t.timestamps
    end
  end
end
