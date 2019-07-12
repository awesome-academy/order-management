class AddComboRefToBillDetails < ActiveRecord::Migration[5.2]
  def change
    add_reference :bill_details, :combo, foreign_key: true, null: true
  end
end
