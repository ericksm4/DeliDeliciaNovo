class CreateAdminNovidades < ActiveRecord::Migration
  def change
    create_table :admin_novidades do |t|
      t.string :titulo, :limit => 200
      t.text :imagem
      t.text :imagem_listagem
      t.float :preco
      t.string :unidade
      t.string :categoria, :limit => 50
      t.string :sumario
      t.text :conteudo
      t.datetime :data_inicio
      t.datetime :data_fim
      t.timestamps
    end
  end
end
