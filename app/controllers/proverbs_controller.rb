class ProverbsController < ApplicationController
  before_action :set_proverb, only: [:show, :twitter, :facebook, :pinterest, :search, :featured_topic]
  before_action :set_featured_topic, only: [:featured_topic]
  
  def index
    @proverbs = Proverb.popular.published.order(name: "ASC").group_by{|a| a.name[0]}
    @canonical = proverbs_url(format: :html)
    render layout: "archive"
  end
  
  def featured_topic
    @quotes = @proverb.quotes.filter_by_topic(@featured_topic.topic.id).order(total_share_count: :desc).order(text: :asc).page params[:page]
    respond_to do |format|
      format.html { render layout: "single" }
    end
  end

  def show
    @quotes = @proverb.quotes.order(total_share_count: :desc).order(text: :asc).page (params[:page])
    expires_in 1.hour, public: true, must_revalidate: true

    if stale?(@proverb)
      respond_to do |format|
        format.html { render layout: "single" }
        format.amp { render layout: "single" }
      end
    end
  end

  def search
    UserSearchWorker.perform_async(@proverb.class.name, @proverb.id, params[:search]) if params[:search].present?
    @quotes = @proverb.quotes.search_by_text(params[:search]).order(total_share_count: :desc).order(text: :asc).page (params[:page])
    render layout: "single"
  end

  def alphabet
    @alphabet = params[:alphabet].upcase
    @proverbs = Proverb.by_alphabet(@alphabet).published.order(name: "ASC")
    @canonical = alphabet_proverbs_url(format: :html)
    render layout: "alphabet"
  end

  def twitter
    url = URI.encode(proverb_url(@proverb, format: :html))
    text = CGI::escape("#{@proverb.name} Quotes")
    redirect_to "https://twitter.com/intent/tweet?text=#{text}&amp;url=#{url}&amp;via=DoYouLoveAQuote"
  end

  def facebook
    url = URI.encode(proverb_url(@proverb, format: :html))
    redirect_to "https://www.facebook.com/sharer/sharer.php?u=#{url}"
  end

  def pinterest
    url = URI.encode(proverb_url(@proverb, format: :html))
    media = URI.encode(@proverb.social_image.pinterest.url)
    description = CGI::escape(@proverb.name + " Proverbs - ##{@proverb.name.downcase} #proverbs")
    redirect_to "http://www.pinterest.com/pin/create/proverbmarklet/?url=#{url}&amp;media=#{media}&amp;description=#{description}"
  end

  def feed
    @timelines = TimeLine.where(item_type: "Proverb").order(created_at: :DESC).limit(20)
    respond_to do |format|
      format.html { redirect_to feed_url, status: 301 }
      format.rss { render layout: false }
    end
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
  
  def set_featured_topic
    @featured_topic = FeaturedTopic.where(source: @proverb).find_by_slug(params[:featured_topic])
  end
end