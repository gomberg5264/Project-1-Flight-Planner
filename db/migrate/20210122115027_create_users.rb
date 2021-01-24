class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.text :name
      t.integer :mobile
      t.text :email
      t.string :password_digest
      t.boolean :admin
    end
  end
end
