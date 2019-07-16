class RemoveComboIdFromProduct < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :combo_id
  end
end
