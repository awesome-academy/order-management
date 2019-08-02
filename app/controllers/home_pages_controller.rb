class HomePagesController < ApplicationController
  before_action ->{create_session :home}

  def home; end
end
