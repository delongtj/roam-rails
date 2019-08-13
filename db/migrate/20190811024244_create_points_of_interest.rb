class CreatePointsOfInterest < ActiveRecord::Migration[5.2]
  def change
    create_table :points_of_interest do |t|
      t.string :name, null: false
      t.date :visit_date, null: false
      t.string :address
      t.integer :amount_in_cents
      t.string :amount_currency, limit: 3, default: 'USD'
      t.string :notes
      t.integer :order, limit: 1, null: false
      t.references :trip, foreign_key: true, null: false

      t.timestamps

      t.timestamp :deleted_at
    end
  end
end
