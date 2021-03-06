class ProverbsController < ApplicationController
  before_action :set_proverb, only: [:show, :twitter, :facebook, :pinterest, :featured_topic]
  before_action :set_featured_topic, only: [:featured_topic]
  
  def index
    @proverbs = Proverb.popular.published.order(name: "ASC").group_by{|a| a.name[0]}
  end
  
  def featured_topic
    @quotes = @proverb.quotes.filter_by_topic(@featured_topic.topic.id).order(total_share_count: :desc).order(text: :asc).page params[:page]
  end

  def show
    @quotes = @proverb.quotes.order(total_share_count: :desc).order(text: :asc).page (params[:page])
  end

  def alphabet
    @alphabet = params[:alphabet].upcase
    @proverbs = Proverb.by_alphabet(@alphabet).published.order(name: "ASC")
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
    media = URI.encode(@proverb.social_image.pinterest_url)
    description = CGI::escape("#{@proverb.quotes.count} #{@proverb.name} Proverbs - ##{@proverb.name.downcase} #proverbs")
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
        Delayed::Job.enqueue NotFoundJob.new(proverb_path(id: params[:id]), request.user_agent)
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