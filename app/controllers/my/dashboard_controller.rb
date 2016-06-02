class My::DashboardController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @quotes = current_user.user_quotes.page params[:page]
  end
end