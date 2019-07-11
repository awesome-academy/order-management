class AddBillRefToBillDetails < ActiveRecord::Migration[5.2]
  def change
    add_reference :bill_details, :bill, foreign_key: true
  end
end
