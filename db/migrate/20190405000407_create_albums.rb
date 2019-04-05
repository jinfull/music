class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.integer :band_id
      t.string :title
      t.integer :year
      t.timestamps
    end
  end
end
