class CombosController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :load_combo, except: %i(new create index)
  before_action :admin_user, except: %i(show)

  def index
    @combos = Combo.page(params[:page]).per Settings.num_combo
  end
  
  def new
    @combo = Combo.new
  end

  def create
    @combo = Combo.new combo_params
    if @combo.save
      flash[:success] = t("controllers.combo.success_create")
      redirect_to @combo
    else
      render :new
    end
  end

  def edit; end

  def update
    if @combo.update combo_params
      flash[:success] = t("controllers.combo.success_edit")
      redirect_to @combo
    else
      render :edit
    end
  end

  def show
    @combo_product = ComboProduct.new
    @products = Product.list_products(@combo.products.pluck(:id)).ordered_by_name
    store_location
  end

  def destroy
    if @combo.destroy
      flash[:success] = t("controllers.combo.delete_s")
    else
      flash[:danger] = t("controllers.combo.delete_err")
    end
    redirect_to combos_url
  end

  private
  def combo_params
    params.require(:combo).permit Combo::COMBO_PARAMS
  end

  def load_combo
    @combo = Combo.find_by id: params[:id]
    return if @combo
    flash[:danger] = t("controllers.combo.not_exits")
    redirect_to root_path
  end
end
