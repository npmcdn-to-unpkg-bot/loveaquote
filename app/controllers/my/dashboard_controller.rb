class My::DashboardController < ApplicationController
  before_filter :authenticate_user!
  layout "user"
  
  def index
    @my_quotes = current_user.my_quotes
  end
end