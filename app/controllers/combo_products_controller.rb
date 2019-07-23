class ComboProductsController < ApplicationController
  before_action :load_combo_product, only: %i(show destroy)

  def create
    @combo_product = ComboProduct.new combo_product_params
    if @combo_product.save
      flash[:success] = t(".success_create")
    else
      flash[:danger] = t(".error_create")
    end
    redirect_back_or @combo_product
  end

  def index
    @combo_products = ComboProduct.page(params[:page]).per(Settings.num_combo_product)
  .ordered_by_combo_id
  store_location
  end

  def show; end

  def destroy
    if @combo_product.destroy
      flash[:success] = t(".delete_s")
    else
      flash[:danger] = t(".delete_err")
    end
    redirect_back_or @combo_product
  end

  private
  def combo_product_params
    params.require(:combo_product).permit ComboProduct::COMBO_PRODUCT_PARAMS
  end

  def load_combo_product
    @combo_product = ComboProduct.find_by id: params[:id]
    return if @combo_product
    flash[:danger] = t(".not_exits")
    redirect_to root_path
  end
end
