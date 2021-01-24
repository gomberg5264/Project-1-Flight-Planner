class CreateFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :flights do |t|
      t.string :code
      t.date :data
      t.time :time
      t.integer :seats
      t.integer :departure_airport_id
      t.integer :arrival_airport_id
    end
  end
end
