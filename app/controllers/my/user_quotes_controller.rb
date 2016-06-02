class My::UserQuotesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @user_quotes = current_user.user_quotes.page params[:page]
  end
end