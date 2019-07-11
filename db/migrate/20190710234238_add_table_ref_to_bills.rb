class AddTableRefToBills < ActiveRecord::Migration[5.2]
  def change
    add_reference :bills, :table, foreign_key: true
  end
end
