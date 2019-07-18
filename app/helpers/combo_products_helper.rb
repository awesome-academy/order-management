module ComboProductsHelper  
  def find_combo_product combo_id, product_id
    store_location
    ComboProduct.find_by combo_id: combo_id, product_id: product_id
  end
end
