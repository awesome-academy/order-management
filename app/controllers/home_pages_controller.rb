class HomePagesController < ApplicationController
  before_action ->{create_session :home}

  def home; end

  def stat
    start_date = params[:start_date]
    end_date = params[:end_date]
    respond_to do |format|
      render json: {sum: sum_money}
    end
  end

  private
  def sum_money
    10
  end
end
