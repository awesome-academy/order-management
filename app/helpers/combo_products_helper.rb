module ComboProductsHelper  
  def find_combo_product combo_id, product_id
    session[:forwarding_url] = request.original_url if request.get?
    ComboProduct.find_by combo_id: combo_id, product_id: product_id
  end
end
