class QuotesController < ApplicationController
  before_action :set_quote, only: [:pinterest, :facebook, :twitter, :google_plus]
  
  def twitter
    @quote.update_attribute(:twitter_share_count, @quote.twitter_share_count + 1)      
    url = URI.encode(@quote.source_url)
    text = CGI::escape(view_context.truncate(@quote.text, length: (140 - 22 - 23), seperator: " "))
    
    redirect_to "https://twitter.com/intent/tweet?text=#{text}&amp;url=#{url}&amp;via=DoYouLoveAQuote"
  end
  
  private
  
  def set_quote
    @quote = Quote.find(params[:id])
  end
end
