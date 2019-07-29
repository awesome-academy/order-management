class ComboProductsController < ApplicationController
  before_action :load_combo_product, except: %i(create index)

  def create
    @combo_product = ComboProduct.new combo_product_params
    @combo_product.save
    respond_to do |format|
      format.html {@combo_product}
      format.js
    end
  end

  def index
    @combo_products = ComboProduct.page(params[:page]).per(Settings.num_combo_product).ordered_by_combo_id
  end

  def show
    respond_to do |format|
      format.html {@combo_product}
      format.js
    end
  end

  def destroy
    @combo_product.destroy
    respond_to do |format|
      format.html {redirect_to combo_products_path}
      format.js
    end
  end

  def edit; end

  def update
    @combo_product.update combo_product_params
    respond_to do |format|
      format.html {@combo_product}
      format.js
    end
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
