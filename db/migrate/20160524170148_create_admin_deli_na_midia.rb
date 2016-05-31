class CreateAdminDeliNaMidia < ActiveRecord::Migration
  def change
    create_table :admin_deli_na_midia do |t|
      t.string :titulo, :limit=> 200
      t.datetime :data_inicio
      t.datetime :data_fim
      t.timestamps
    end
  end
end
