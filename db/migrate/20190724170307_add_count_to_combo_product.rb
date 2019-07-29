class AddCountToComboProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :combo_products, :count, :integer
  end
end
