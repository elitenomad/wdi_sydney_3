class AddColumnsToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :urlpath, :string
  end
end
