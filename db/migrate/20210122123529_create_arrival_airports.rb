class CreateArrivalAirports < ActiveRecord::Migration[5.2]
  def change
    create_table :arrival_airports do |t|
        t.text :name
        t.text :city
        t.decimal :longitude
        t.decimal :latitude
    end
  end
end
