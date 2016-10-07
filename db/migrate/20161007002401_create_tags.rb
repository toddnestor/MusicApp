class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :taggings do |t|
      t.integer :tag_id, null: false
      t.string :tagable_type, null: false
      t.integer :tagable_id, null: false
      t.timestamps
    end

    create_table :tags do |t|
      t.string :name, null: false

      t.timestamps
    end
    
    add_index :tags, :name
    add_index :taggings, :tag_id
    add_index :taggings, :tagable_type
    add_index :taggings, :tagable_id
    add_index :taggings, [:tag_id, :tagable_type, :tagable_id], unique: true
  end
end
