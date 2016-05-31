class CreateAdminBanners < ActiveRecord::Migration
  def change
    create_table :admin_banners do |t|
      t.string :nome
      t.datetime :data_inicio
      t.datetime :data_fim
      t.integer :status
      t.integer :area_id
      t.belongs_to :area
      t.timestamps
    end
  end
end
