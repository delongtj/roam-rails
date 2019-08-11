class CreateCarRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :car_rentals do |t|
      t.string :company, null: false
      t.string :reservation_number
      t.string :pick_up_address
      t.timestamp :pick_up_at
      t.string :drop_off_address
      t.timestamp :drop_off_at
      t.integer :amount_in_cents
      t.string :amount_currency, limit: 3
      t.string :notes
      t.references :trip, foreign_key: true, null: false

      t.timestamps

      t.timestamp :deleted_at
    end
  end
end
