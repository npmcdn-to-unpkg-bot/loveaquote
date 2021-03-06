class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :twitter, :facecharacter, :pinterest]

  def index
    @characters = Character.popular.published.order(name: "ASC").group_by{|a| a.name[0]}
  end

  def show
    @quotes = @character.quotes.order(total_share_count: :desc).order(text: :asc).page (params[:page])
  end

  def alphabet
    @alphabet = params[:alphabet].upcase
    @characters = Character.by_alphabet(@alphabet).published.order(name: "ASC")
  end

  def twitter
    url = URI.encode(character_url( @character ))
    text = CGI::escape("#{@character.name} Quotes")
    redirect_to "https://twitter.com/intent/tweet?text=#{text}&amp;url=#{url}&amp;via=DoYouLoveAQuote"
  end

  def facebook
    url = URI.encode(character_url( @character ))
    redirect_to "https://www.facecharacter.com/sharer/sharer.php?u=#{url}"
  end

  def pinterest
    url = URI.encode(character_url( @character ))
    media = URI.encode(@character.social_image.pinterest_url)
    description = CGI::escape(@character.name +  ' #quotes')
    redirect_to "http://www.pinterest.com/pin/create/charactermarklet/?url=#{url}&amp;media=#{media}&amp;description=#{description}"
  end

  def feed
    @timelines = TimeLine.where(item_type: "Character").order(created_at: :DESC).limit(20)
    respond_to do |format|
      format.html { redirect_to feed_url, status: 301 }
      format.rss { render layout: false }
    end
  end

  private

  def set_character
    @character = Character.published.find_by_slug(params[:id])
      if ! @character
        @redirect = Redirect.find_by_from(character_path(id: params[:id]))
        if ! @redirect
          Delayed::Job.enqueue NotFoundJob.new(character_path(id: params[:id]), request.user_agent)
          redirect_to serve_404_url
        else
          redirect_to @redirect.to, status: 301
        end
      end
  end
end
