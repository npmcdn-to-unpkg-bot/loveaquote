class TvShowsController < ApplicationController
  before_action :set_tv_show, only: [:show, :twitter, :facetv_show, :pinterest]
  
  def index
    @tv_shows = TvShow.popular.published.order(name: "ASC").group_by{|a| a.name[0]}
  end

  def show
    @quotes = @tv_show.quotes.order(total_share_count: :desc).order(text: :asc).page (params[:page])
    render layout: "single"
  end
  
  def alphabet
    @alphabet = params[:alphabet].upcase
    @tv_shows = TvShow.by_alphabet(@alphabet).published.order(name: "ASC")
  end
  
  def twitter
    url = URI.encode(tv_show_url(@tv_show))
    text = CGI::escape("#{@tv_show.name} Quotes")
    redirect_to "https://twitter.com/intent/tweet?text=#{text}&amp;url=#{url}&amp;via=DoYouLoveAQuote"
  end
  
  def facetv_show
    url = URI.encode(tv_show_url(@tv_show))
    redirect_to "https://www.facetv_show.com/sharer/sharer.php?u=#{url}"
  end
  
  def pinterest
    url = URI.encode(tv_show_url(@tv_show))
    media = URI.encode(@author.image_url(:large))
    description = CGI::escape(@tv_show.name +  ' #quotes')
    redirect_to "http://www.pinterest.com/pin/create/tv_showmarklet/?url=#{url}&amp;media=#{media}&amp;description=#{description}"
  end
  
  private
  
  def set_tv_show
    @tv_show = TvShow.published.find_by_slug(params[:id])
    redirect_to serve_404_url unless @tv_show
  end
end