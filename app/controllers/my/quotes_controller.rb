class My::QuotesController < ApplicationController
  before_filter :authenticate_user!
  layout "user"
  
  def index
    @list_quotes = current_user.list_quotes.page params[:page]
  end
end