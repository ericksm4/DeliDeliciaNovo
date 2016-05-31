class CreateAdminLaminas < ActiveRecord::Migration
  def change
    create_table :admin_laminas do |t|
      t.string :nome, :limit=> 200
      t.integer :status
      t.text :imagem_destaque
      t.datetime :data_inicio
      t.datetime :data_fim
      t.timestamps
    end
  end
end
