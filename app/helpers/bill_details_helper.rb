module BillDetailsHelper  
  def check_product_active selected
    return selected == Settings.selected_product || selected.blank?
  end

  def check_combo_active selected
    return selected == Settings.selected_combo
  end
end
