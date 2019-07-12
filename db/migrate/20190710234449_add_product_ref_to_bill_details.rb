class AddProductRefToBillDetails < ActiveRecord::Migration[5.2]
  def change
    add_reference :bill_details, :product, foreign_key: true, null: true
  end
end
