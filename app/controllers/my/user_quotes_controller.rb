class My::UserQuotesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user_quote, only: [:edit, :update, :destroy]
  
  def index
    if params[:list].present? && current_user.user_lists.pluck(:id).include?(params[:list].to_i)
      @user_quotes = current_user.user_lists.where(id: params[:list]).first.user_quotes.page params[:page]
    else
      @user_quotes = current_user.user_quotes.page params[:page]
    end
  end
  
  def new
    @user_quote = UserQuote.new
    render layout: false
  end
  
  def create
    @user_quote = UserQuote.new(user_quote_params)
    @user_quote.user = current_user

    respond_to do |format|
      if @user_quote.save
        format.json {render json: {id: @user_quote.id, quote_id: @user_quote.quote_id}}
      else
        format.json {head 422}
      end
    end    
  end
  
  def edit
    render layout: false
  end
  
  def update
    respond_to do |format|
      if @user_quote.update(user_quote_params)
        format.json {render json: {id: @user_quote.id, quote_id: @user_quote.quote_id}}
      else
        format.json {head 422}
      end
    end    
  end  
  
  def destroy
    @user_quote.destroy
    respond_to do |format|
      format.json { render json: {id: @user_quote.id, quote_id: @user_quote.quote_id} }
    end
  end
  
  private
    def set_user_quote
      @user_quote = current_user.user_quotes.where(id: params[:id]).first
    end
  
    def user_quote_params
      params.require(:user_quote).permit(:quote_id, :user_list_ids => [])
    end    
  
end