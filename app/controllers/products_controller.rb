class ProductsController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :load_product, except: %i(new create index search_product)
  before_action :admin_user, except: %i(show)
  before_action :load_products, only: %i(index search_product)
  before_action ->{create_session :product}

  def index; end
  
  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t(".success_create")
      redirect_to @product
    else
      render :new
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @product.update product_params
        format.html {
          flash[:success] = t(".success_edit")
          redirect_to @product
        }
        format.js
      else
        format.html
          flash[:error] = t(".error_edit")
          rende :edit
        format.js
      end
    end
  end

  def show
    @combo_product = ComboProduct.new
    @combos = Combo.list_combos(@product.combos.pluck(:id)).ordered_by_name
    store_location
  end

  def destroy
    if @product.destroy
      flash[:success] = t(".delete_s")
    else
      flash[:danger] = t(".delete_err")
    end
    redirect_to products_url
  end

  def search_product
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def product_params
    params.require(:product).permit Product::PRODUCT_PARAMS
  end

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t(".not_exits")
    redirect_to root_path
  end

  def load_products
    @products = Product.where nil
    @products = @products.find_by_name(params[:name]) if params[:name].present?
    @products = @products.find_by_status(params[:status]) if params[:status].present?
    @products = @products.page(params[:page]).per Settings.num_product
  end
end
