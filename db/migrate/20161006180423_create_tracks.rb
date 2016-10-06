class CreateTracks < ActiveRecord::Migration[5.0]
  def change
    create_table :tracks do |t|
      t.text :lyrics
      t.integer :album_id, null: false
      t.string :track_type, null: false, default: 'regular'

      t.timestamps
    end
    add_index :tracks, :album_id
  end
end
