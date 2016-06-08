class QuotesController < ApplicationController
  before_action :set_quote, only: [:pinterest, :facebook, :twitter, :google_plus]

  def twitter
    unless current_admin
      QuoteTwitterWorker.perform_async(@quote.id, request.user_agent) if params[:human].present? && params[:human] == "t"
    end  
    url = URI.encode(view_context.quote_source_url(@quote))
    text = CGI::escape(view_context.truncate(@quote.text, length: (140 - 22 - 23), seperator: " "))

    redirect_to "https://twitter.com/intent/tweet?text=#{text}&amp;url=#{url}&amp;via=DoYouLoveAQuote"
  end

  def facebook
    unless current_admin
      QuoteFacebookWorker.perform_async(@quote.id, request.user_agent) if params[:human].present? && params[:human] == "t"
    end
    url = URI.encode(view_context.quote_source_url(@quote))
    redirect_to "https://www.facebook.com/sharer/sharer.php?u=#{url}"
  end

  def pinterest
    unless current_admin
      QuotePinterestWorker.perform_async(@quote.id, request.user_agent) if params[:human].present? && params[:human] == "t"
    end
    url = URI.encode(view_context.quote_source_url(@quote))
    media = URI.encode(@quote.social_image.pinterest.url)
    description = CGI::escape(@quote.text + ' - ' + @quote.source.name +  ' #quotes')
    redirect_to "http://www.pinterest.com/pin/create/bookmarklet/?url=#{url}&amp;media=#{media}&amp;description=#{description}"
  end

  private

  def set_quote
    @quote = Quote.find(params[:id])
  end
end
