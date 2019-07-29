class Remove < ActiveRecord::Migration[5.2]
  def change
    remove_column :bills, :number_customer
  end
end
