class CreateComboProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :combo_products do |t|
      t.references :combo, foreign_key: true
      t.references :product, foreign_key: true
    end
  end
end
