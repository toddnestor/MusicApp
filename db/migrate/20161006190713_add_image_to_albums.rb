class AddImageToAlbums < ActiveRecord::Migration[5.0]
  def change
    add_column :albums, :featured_image, :text, default: 'http://placehold.it/242x200'
  end
end
