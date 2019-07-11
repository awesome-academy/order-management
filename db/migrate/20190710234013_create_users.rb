class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :phone
      t.string :address
      t.string :name
      t.string :username
      t.string :password
      t.integer :role

      t.timestamps
    end
  end
end
