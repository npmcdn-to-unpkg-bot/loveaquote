class ProverbsController < ApplicationController
  before_action :set_proverb, only: [:show, :twitter, :faceproverb, :pinterest]
  
  def index
    @proverbs = Proverb.popular.published.order(name: "ASC").group_by{|a| a.name[0]}
    @canonical = proverbs_url(format: :html)
    render layout: "archive"
  end

  def show
    if params[:search].present?
      UserSearchWorker.perform_async(@proverb.class.name, @proverb.id, params[:search])
      @quotes = @proverb.quotes.search_by_text(params[:search]).order(total_share_count: :desc).order(text: :asc).page (params[:page])
    else
      @quotes = @proverb.quotes.order(total_share_count: :desc).order(text: :asc).page (params[:page])
    end
    render layout: "single"
  end
  
  def alphabet
    @alphabet = params[:alphabet].upcase
    @proverbs = Proverb.by_alphabet(@alphabet).published.order(name: "ASC")
    @canonical = alphabet_proverbs_url(format: :html)
    render layout: "alphabet"
  end
  
  def twitter
    url = URI.encode(proverb_url(@proverb))
    text = CGI::escape("#{@proverb.name} Quotes")
    redirect_to "https://twitter.com/intent/tweet?text=#{text}&amp;url=#{url}&amp;via=DoYouLoveAQuote"
  end
  
  def facebook
    url = URI.encode(proverb_url(@proverb))
    redirect_to "https://www.facebook.com/sharer/sharer.php?u=#{url}"
  end
  
  def pinterest
    url = URI.encode(proverb_url(@proverb))
    media = URI.encode(@author.image_url(:large))
    description = CGI::escape(@proverb.name +  ' #quotes')
    redirect_to "http://www.pinterest.com/pin/create/proverbmarklet/?url=#{url}&amp;media=#{media}&amp;description=#{description}"
  end
  
  private
  
  def set_proverb
    @proverb = Proverb.published.find_by_slug(params[:id])
    if ! @proverb
      @redirect = Redirect.find_by_from(proverb_path(id: params[:id]))
      if ! @redirect
        NotFoundWorker.perform_async(proverb_path(id: params[:id]), request.user_agent)
        redirect_to serve_404_url
      else
        redirect_to @redirect.to, status: 301
      end
    end
  end
end