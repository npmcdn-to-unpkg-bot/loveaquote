class Topics::TopicCombinationsController < ApplicationController
  before_action :set_topic_combination, only: [:show, :twitter, :facebook, :pinterest]
  
  def index
    @topics = TopicCombination.order(slug: "ASC").group_by{|a| a.name[0]}
    @canonical = topics_topic_combinations_url(format: :html)
    render layout: "archive"
  end

  def show
    if params[:search].present?
      UserSearchWorker.perform_async(@topic_combination.class.name, @topic_combination.id, params[:search])
      @quotes = @topic.quotes.search_by_text(params[:search]).order(total_share_count: :desc).order(text: :asc).page params[:page]
    else
      @quotes = @topic.quotes.order(total_share_count: :desc).order(text: :asc).page params[:page]
    end
    render layout: "single"
  end
  
  def alphabet
    @alphabet = params[:alphabet].upcase
    @topic_combination_combinations = topic_combination.by_alphabet(@alphabet).published.order(name: "ASC")
    @canonical = alphabet_topic_topic_combinations_url(format: :html)
    render layout: "alphabet"
  end
  
  def twitter
    url = URI.encode(topics_topic_combination_url(@topic))
    text = CGI::escape("#{@topic.name} Quotes")
    redirect_to "https://twitter.com/intent/tweet?text=#{text}&amp;url=#{url}&amp;via=DoYouLoveAQuote"
  end
  
  def facebook
    url = URI.encode(topics_topic_combination_url(@topic))
    redirect_to "https://www.facebook.com/sharer/sharer.php?u=#{url}"
  end
  
  def pinterest
    url = URI.encode(topics_topic_combination_url(@topic))
    media = URI.encode(@author.image_url(:large))
    redirect_to "http://www.pinterest.com/pin/create/topic_combinationmarklet/?url=#{url}&amp;media=#{media}&amp;description=#{description}"
  end
  
  private
  
  def set_topic_combination
      @topic = TopicCombination.find_by_slug(params[:id])
      if ! @topic
        @redirect = Redirect.find_by_from(topics_topic_combination_path(id: params[:id]))
        if ! @redirect
          NotFoundWorker.perform_async(topics_topic_combination_path(id: params[:id]), request.user_agent)
          redirect_to serve_404_url
        else
          redirect_to @redirect.to, status: 301
        end
      end
  end
end
