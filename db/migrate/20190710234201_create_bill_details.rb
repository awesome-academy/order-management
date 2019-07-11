class CreateBillDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :bill_details do |t|
      t.string :type_detail
      t.integer :count
      t.float :price
    end
  end
end
