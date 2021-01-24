class RenameDataToDate < ActiveRecord::Migration[5.2]
  def change
    rename_column :flights, :data, :date
  end
end
