class AddComboRefToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :combo, foreign_key: true, null: true
  end
end
