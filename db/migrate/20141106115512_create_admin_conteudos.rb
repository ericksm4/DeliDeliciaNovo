class CreateAdminConteudos < ActiveRecord::Migration
  def change
    create_table :admin_conteudos do |t|
      t.string :titulo
      t.datetime :data_inicio
      t.datetime :data_fim
      t.integer :detaque
      t.integer :status
      t.string :resumo
      t.text :conteudo
      t.string :imagem_destaque
      t.string :cor_titulo
      t.belongs_to :categoria
      t.timestamps
    end
  end
end
