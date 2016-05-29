class Admin::TweetableQuotesController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_tweetable_quote, only: [:destroy]

  def index
    @tweetable_quotes = TweetableQuote.order(created_at: :DESC).page params[:page]
  end
  
  def destroy
    @tweetable_quote.destroy
    respond_to do |format|
      format.html { redirect_to admin_tweetable_quotes_url, notice: 'Quote was successfully removed from TweetableQuote list.' }
      format.json { head :no_content }
    end
  end
  
  private
  
  def set_tweetable_quote
    @tweetable_quote = TweetableQuote.find(params[:id])
  end
  
end
