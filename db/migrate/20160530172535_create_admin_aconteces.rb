class CreateAdminAconteces < ActiveRecord::Migration
  def change
    create_table :admin_aconteces do |t|
      t.string :titulo
      t.text :imagem
      t.text :conteudo
      t.datetime :data_inicio
      t.datetime :data_fim
      t.timestamps
    end
  end
end
