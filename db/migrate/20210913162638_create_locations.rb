class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.geometry :site

      t.timestamps
      t.index :site, using: :gist
    end
  end
end
