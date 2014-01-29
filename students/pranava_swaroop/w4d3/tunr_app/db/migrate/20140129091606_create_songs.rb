class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.integer :length
      t.text :description
      t.references :artist
      t.references :album

      t.timestamps
    end
  end
end
