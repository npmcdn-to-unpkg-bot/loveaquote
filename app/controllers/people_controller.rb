class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :redirect_to_person, :twitter, :facebook, :pinterest, :featured_topic]
  before_action :set_featured_topic, only: [:featured_topic]
  def index
    @people = Person.popular.published.order(name: "ASC").group_by{|a| a.name[0]}
  end

  def alphabet
    @alphabet = params[:alphabet].upcase
    @people = Person.by_alphabet(@alphabet).published.order(name: "ASC")
  end

  def featured_topic
    @quotes = @person.all_quotes.filter_by_topic(@featured_topic.topic.id).order(total_share_count: :desc).order(text: :asc).page params[:page]
  end

  def show
    @quotes = @person.all_quotes.order(total_share_count: :desc).order(text: :asc).page params[:page]
  end

  def redirect_to_person
    redirect_to person_url(@person), status: 301
  end

  def twitter
    url = URI.encode(person_url(@person))
    text = CGI::escape("#{@person.name} Quotes")
    redirect_to "https://twitter.com/intent/tweet?text=#{text}&amp;url=#{url}&amp;via=DoYouLoveAQuote"
  end

  def facebook
    url = URI.encode(person_url(@person))
    redirect_to "https://www.facebook.com/sharer/sharer.php?u=#{url}"
  end

  def pinterest
    url = URI.encode(person_url(@person))
    media = URI.encode(@person.social_image.pinterest_url)
    description = CGI::escape(@person.name +  ' #quotes #loveaquote - read more at ' + person_url(@person))
    redirect_to "http://www.pinterest.com/pin/create/bookmarklet/?url=#{url}&amp;media=#{media}&amp;description=#{description}"
  end

  def feed
    @timelines = TimeLine.where(item_type: "Person").order(created_at: :DESC).limit(20)
    respond_to do |format|
      format.html { redirect_to feed_url, status: 301 }
      format.rss { render layout: false }
    end
  end

  private

  def set_person
    @person = Person.published.find_by_slug(params[:id])
    if ! @person
      @redirect = Redirect.find_by_from(person_path(id: params[:id]))
      if ! @redirect
        Delayed::Job.enqueue NotFoundJob.new(person_path(id: params[:id]), request.user_agent)
        redirect_to serve_404_url
      else
        redirect_to @redirect.to, status: 301
      end
    end
  end

  def set_featured_topic
    @featured_topic = FeaturedTopic.where(source: @person).find_by_slug(params[:featured_topic])
  end
end