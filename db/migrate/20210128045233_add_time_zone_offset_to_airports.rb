class AddTimeZoneOffsetToAirports < ActiveRecord::Migration[5.2]
  def change
      add_column :departure_airports, :timezone_offset, :decimal
      add_column :arrival_airports, :timezone_offset, :decimal
  end
end
