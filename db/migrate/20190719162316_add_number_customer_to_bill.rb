class AddNumberCustomerToBill < ActiveRecord::Migration[5.2]
  def change
    add_column :bills, :number_customer, :integer
  end
end
