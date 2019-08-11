class CreateUserTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :user_trips do |t|
      t.references :user, foreign_key: true, null: false
      t.references :trip, foreign_key: true, null: false

      t.string :role

      t.timestamps

      t.timestamp :deleted_at
    end
  end
end
