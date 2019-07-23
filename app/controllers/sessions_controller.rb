class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by username: params[:session][:username].downcase
    if user&.authenticate params[:session][:password]
      log_in user
      flash[:success] = t(".success")
      redirect_back_or user
    else
      flash.now[:danger] = t(".err")
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
