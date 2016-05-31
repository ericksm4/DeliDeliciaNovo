class CreateAdminDeliSazonals < ActiveRecord::Migration
  def change
    create_table :admin_deli_sazonals do |t|
      t.string :titulo, :limit => 200
      t.text :conteudo
      t.text :imagem
      t.datetime :data_inicio
      t.datetime :data_fim
      t.timestamps
    end
  end
end
