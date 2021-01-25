class ChangeDateAndTimeToDatetimeInFlights < ActiveRecord::Migration[5.2]
  def change
    add_column :flights, :depart_time, :datetime
    remove_column :flights, :date
    remove_column :flights, :time
  end
end
