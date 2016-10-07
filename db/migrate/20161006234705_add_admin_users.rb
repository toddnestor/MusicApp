class AddAdminUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :admin, :boolean, default: false, null: false, index: true
    add_column :bands, :user_id, :integer, default: 1, null: false, index: true
    add_column :albums, :user_id, :integer, default: 1, null: false, index: true
    add_column :tracks, :user_id, :integer, default: 1, null: false, index: true
  end
end
