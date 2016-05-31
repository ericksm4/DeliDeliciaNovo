class CreateAdminMarqueUmaVisita < ActiveRecord::Migration
  def change
    create_table :admin_marque_uma_visita do |t|
      t.string :nome, :limit => 200
      t.string :email
      t.string :telefone, :limit => 50
      t.string :bairro, :limit => 150
      t.string :cidade, :limit => 200
      t.text :comentarios
      t.timestamps
    end
  end
end
