class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :set_locale
  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t("controllers.user.please_ln")
    redirect_to login_url
  end

  def admin_user
    return if current_user.manager?
    flash[:danger] = t("controllers.user.no_role")
    redirect_to root_url
  end

  def redirect_back_or(default)
    redirect_to session[:forwarding_url] || default
    session.delete :forwarding_url
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
