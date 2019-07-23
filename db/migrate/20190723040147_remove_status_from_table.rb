class RemoveStatusFromTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :tables, :status
  end
end
