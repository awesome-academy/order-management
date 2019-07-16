class ComboProductsController < ApplicationController
  before_action :load_combo_product, only: %i(show)

  def create
    @combo_product = ComboProduct.new combo_product_params
    if @combo_product.save
      flash[:success] = t("controllers.combo_product.success_create")
    else
      flash[:danger] = t("controllers.combo_product.error_create")
    end
    redirect_to @combo_product.product
  end

  def index
    @combo_products = ComboProduct.page(params[:page]).per Settings.num_combo_product
  end

  def show; end 

  private
  def combo_product_params
    params.require(:combo_product).permit ComboProduct::COMBO_PRODUCT_PARAMS
  end

  def load_combo_product
    @combo_product = ComboProduct.find_by id: params[:id]
    return if @combo_product
    flash[:danger] = t("controllers.product.not_exits")
    redirect_to root_path
  end
end
