class CreateAccommodations < ActiveRecord::Migration[5.2]
  def change
    create_table :accommodations do |t|
      t.string :name, null: false
      t.string :accommodation_type, limit: 10, null: false
      t.string :address
      t.timestamp :check_in_at
      t.timestamp :check_out_at
      t.integer :amount_in_cents
      t.string :amount_currency, limit: 3, default: 'USD'
      t.string :notes
      t.references :trip, foreign_key: true, null: false

      t.timestamps

      t.timestamp :deleted_at
    end
  end
end
