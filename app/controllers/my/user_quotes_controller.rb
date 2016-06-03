class My::UserQuotesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @user_quotes = current_user.user_quotes.page params[:page]
  end
  
  def new
    @user_quote = UserQuote.new
  end
  
  def create
    @user_quote = UserQuote.new(user_quote_params)
    @user_quote.user = current_user

    respond_to do |format|
      if @user_quote.save
        format.json {render json: @user_quote}
      else
        format.json {head 422}
      end
    end    
  end
  
  private
  
    def user_quote_params
      params.require(:user_quote).permit(:quote_id)
    end    
  
end