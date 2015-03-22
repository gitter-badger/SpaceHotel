class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.date :arrival
      t.date :departure

      t.references :user, index: true
      t.references :room, index: true
      t.references :status, index: true

      t.timestamps
    end
  end
end
