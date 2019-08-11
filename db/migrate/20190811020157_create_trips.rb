class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :name, null: false
      t.text :description
      t.integer :budget_in_cents
      t.string :budget_currency, limit: 3

      t.timestamps

      t.timestamp :deleted_at
    end
  end
end
