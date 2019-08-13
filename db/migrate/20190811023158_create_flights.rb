class CreateFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :flights do |t|
      t.string :airline, null: false
      t.integer :flight_number, limit: 2
      t.string :depart_airport, limit: 3
      t.timestamp :depart_at
      t.string :arrive_airport, limit: 3
      t.timestamp :arrive_at
      t.integer :amount_in_cents
      t.string :amount_currency, limit: 3, default: 'USD'
      t.string :notes
      t.references :trip, foreign_key: true, null: false

      t.timestamps

      t.timestamp :deleted_at
    end
  end
end
