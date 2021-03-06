class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :twitter, :facebook, :pinterest]

  def index
    @topics = Topic.popular.published.order(name: "ASC").group_by{|a| a.name[0]}
    @canonical = topics_url
  end

  def show
    @quotes = @topic.quotes.order(total_share_count: :desc).order(text: :asc).page params[:page]
  end

  def alphabet
    @alphabet = params[:alphabet].upcase
    @topics = Topic.by_alphabet(@alphabet).published.order(name: "ASC")
    @canonical = alphabet_topics_url
  end

  def twitter
    url = URI.encode(topic_url(@topic))
    text = CGI::escape("#{@topic.name} Quotes")
    redirect_to "https://twitter.com/intent/tweet?text=#{text}&amp;url=#{url}&amp;via=DoYouLoveAQuote"
  end

  def facebook
    url = URI.encode(topic_url(@topic))
    redirect_to "https://www.facebook.com/sharer/sharer.php?u=#{url}"
  end

  def pinterest
    url = URI.encode(topic_url(@topic))
    media = URI.encode(@topic.social_image.pinterest_url)
    description = CGI::escape(@topic.name +  ' #quotes')
    redirect_to "http://www.pinterest.com/pin/create/topicmarklet/?url=#{url}&amp;media=#{media}&amp;description=#{description}"
  end

  def feed
    @timelines = TimeLine.where(item_type: "Topic").order(created_at: :DESC).limit(20)
    respond_to do |format|
      format.html { redirect_to feed_url, status: 301 }
      format.rss { render layout: false }
    end
  end
  private

  def set_topic
      @topic = Topic.published.find_by_slug(params[:id])
      if ! @topic
        @redirect = Redirect.find_by_from(topic_path(id: params[:id]))
        if ! @redirect
          Delayed::Job.enqueue NotFoundJob.new(topic_path(id: params[:id]), request.user_agent)
          redirect_to serve_404_url
        else
          redirect_to @redirect.to, status: 301
        end
      end
  end
end