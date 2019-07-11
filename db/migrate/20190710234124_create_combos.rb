class CreateCombos < ActiveRecord::Migration[5.2]
  def change
    create_table :combos do |t|
      t.string :name
      t.integer :status
      t.float :price
    end
  end
end
