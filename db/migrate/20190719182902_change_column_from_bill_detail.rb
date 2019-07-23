class ChangeColumnFromBillDetail < ActiveRecord::Migration[5.2]
  def change
    change_column :bill_details, :type_detail, :integer
  end
end
