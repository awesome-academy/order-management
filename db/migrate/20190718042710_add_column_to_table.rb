class AddColumnToTable < ActiveRecord::Migration[5.2]
  def change
    add_column :tables, :status, :integer, default: 0
  end
end
