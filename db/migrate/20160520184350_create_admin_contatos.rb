class CreateAdminContatos < ActiveRecord::Migration
  def change
    create_table :admin_contatos do |t|
      t.string :nome, :limit => 200
      t.string :email
      t.string :telefone, :limit => 40
      t.string :bairro, :limit => 200
      t.string :cidade, :limit => 200
      t.text :sugestoes
      t.integer :receber_news
      t.datetime :data_cadastro
    end
  end
end
