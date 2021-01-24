class CreateFlightsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :flights_users do |t|
      t.integer :user_id
      t.integer :flight_id
    end
  end
end
