module CombosHelper
  def get_product combos
    combos.pluck :name, :id
  end
end
