class CreateAdminListagemAconteces < ActiveRecord::Migration
  def change
    create_table :admin_listagem_aconteces do |t|
      t.integer :id_acontece
      t.string :nome
      t.string :email
      t.string :telefone
      t.string :bairro
      t.string :cidade
      t.text :comentario
      t.timestamps
    end
  end
end
