class AddNomeToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :nome, :string, :default => ''
  end
end
