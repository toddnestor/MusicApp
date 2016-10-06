class CreateBands < ActiveRecord::Migration[5.0]
  def change
    create_table :bands do |t|
      t.string :name, null: false
      t.text :featured_image, default: 'http://az616578.vo.msecnd.net/files/2016/07/11/6360384265838540902094315765_band.jpg'

      t.timestamps
    end
    add_index :bands, :name
  end
end
