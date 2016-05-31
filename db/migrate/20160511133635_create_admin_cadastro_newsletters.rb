class CreateAdminCadastroNewsletters < ActiveRecord::Migration
  def change
    create_table :admin_cadastro_newsletters do |t|
      t.string :email, :limit => 200
      t.string :loja_mais_proxima, :limit => 100 
      t.timestamps
    end
  end
end
