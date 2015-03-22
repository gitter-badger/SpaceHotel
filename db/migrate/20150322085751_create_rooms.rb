class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.float :price
      t.float :size
      t.text :description
      t.integer :occupancy
      t.references :specification, index: true

      t.timestamps
    end
  end
end
