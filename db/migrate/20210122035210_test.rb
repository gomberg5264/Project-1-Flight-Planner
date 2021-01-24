class Test < ActiveRecord::Migration[5.2]
  def change
    create_table :tests do |t|
      t.text :name
    end  
  end
end
