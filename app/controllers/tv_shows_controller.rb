class TvShowsController < ApplicationController
  before_action :set_tv_show, only: [:show, :twitter, :facebook, :pinterest]

  def index
    @tv_shows = TvShow.popular.published.order(name: "ASC").group_by{|a| a.name[0]}
  end

  def show
    @quotes = @tv_show.quotes.order(total_share_count: :desc).order(text: :asc).page (params[:page])
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

  def facebook
    url = URI.encode(tv_show_url(@tv_show))
    redirect_to "https://www.facebook.com/sharer/sharer.php?u=#{url}"
  end

  def pinterest
    url = URI.encode(tv_show_url(@tv_show))
    media = URI.encode(@tv_show.social_image.pinterest_url)
    description = CGI::escape(@tv_show.name +  ' #quotes')
    redirect_to "http://www.pinterest.com/pin/create/tv_showmarklet/?url=#{url}&amp;media=#{media}&amp;description=#{description}"
  end

  def feed
    @timelines = TimeLine.where(item_type: "TvShow").order(created_at: :DESC).limit(20)
    respond_to do |format|
      format.html { redirect_to feed_url, status: 301 }
      format.rss { render layout: false }
    end
  end

  private

  def set_tv_show
    @tv_show = TvShow.published.find_by_slug(params[:id])
    if ! @tv_show
      @redirect = Redirect.find_by_from(tv_show_path(id: params[:id]))
      if ! @redirect
        Delayed::Job.enqueue NotFoundJob.new(tv_show_path(id: params[:id]), request.user_agent)
        redirect_to serve_404_url
      else
        redirect_to @redirect.to, status: 301
      end
    end
  end
end