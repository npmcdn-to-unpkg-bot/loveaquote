class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :twitter, :facebook, :pinterest]
  
  def index
    @topics = Topic.popular.published.order(name: "ASC").group_by{|a| a.name[0]}
  end

  def show
    @quotes = @topic.quotes.order(total_share_count: :desc).order(text: :asc).page params[:page]
    render layout: "topic"
  end
  
  def alphabet
    @alphabet = params[:alphabet].upcase
    @topics = Topic.by_alphabet(@alphabet).published.order(name: "ASC")
  end
  
  def twitter
    url = URI.encode(topic_url(@topic))
    text = CGI::escape("#{@topic.name} Quotes")
    redirect_to "https://twitter.com/intent/tweet?text=#{text}&amp;url=#{url}&amp;via=DoYouLoveAQuote"
  end
  
  def facetopic
    url = URI.encode(topic_url(@topic))
    redirect_to "https://www.facetopic.com/sharer/sharer.php?u=#{url}"
  end
  
  def pinterest
    url = URI.encode(topic_url(@topic))
    media = URI.encode(@author.image_url(:large))
    description = CGI::escape(@topic.name +  ' #quotes')
    redirect_to "http://www.pinterest.com/pin/create/topicmarklet/?url=#{url}&amp;media=#{media}&amp;description=#{description}"
  end
  
  private
  def set_topic
    @topic = Topic.find_by_slug(params[:id])
    redirect_to serve_404_url unless @topic    
  end
end
