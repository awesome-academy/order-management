module ProductsHelper
  def get_combo combos
    combos.pluck :name, :id
  end
end
