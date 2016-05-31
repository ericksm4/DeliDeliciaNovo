class AddCategoriaIdToCategoria < ActiveRecord::Migration
  def change
  	add_column :admin_categorias, :categoria_id, :integer
  end
end
