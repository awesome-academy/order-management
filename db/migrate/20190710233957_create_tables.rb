class CreateTables < ActiveRecord::Migration[5.2]
  def change
    create_table :tables do |t|
      t.string :number
      t.text :description
      t.integer :amount_chair
    end
  end
end
