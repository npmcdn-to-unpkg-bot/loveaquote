class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :twitter, :facecharacter, :pinterest]
  
  def index
    if params[:search].present?
      if params[:status].present?
        case params[:status]
        when "Draft"
          @characters = Character.draft.search_by_name(params[:search]).order(name: :ASC).page params[:page]
        when "Published"
          @characters = Character.published.search_by_name(params[:search]).order(name: :ASC).page params[:page]
        end
      else
        @characters = Character.search_by_name(params[:search]).order(name: :ASC).page params[:page]
      end
    else
      if params[:status].present?
        case params[:status]
        when "Draft"
          @characters = Character.draft.order(name: :ASC).page params[:page]
        when "Published"
          @characters = Character.published.order(name: :ASC).page params[:page]
        end
      else
        @characters = Character.order(name: :ASC).page params[:page]
      end
    end
  __END__

  def show
    @quotes = @character.quotes.order(total_share_count: :desc).order(text: :asc).page (params[:page])
    render layout: "character"
  end
  
  def alphabet
    @alphabet = params[:alphabet].upcase
    @characters = Character.by_alphabet(@alphabet).published.order(name: "ASC")
  end
  
  def twitter
    url = URI.encode(character_url(@character))
    text = CGI::escape("#{@character.name} Quotes")
    redirect_to "https://twitter.com/intent/tweet?text=#{text}&amp;url=#{url}&amp;via=DoYouLoveAQuote"
  end
  
  def facecharacter
    url = URI.encode(character_url(@character))
    redirect_to "https://www.facecharacter.com/sharer/sharer.php?u=#{url}"
  end
  
  def pinterest
    url = URI.encode(character_url(@character))
    media = URI.encode(@author.image_url(:large))
    description = CGI::escape(@character.name +  ' #quotes')
    redirect_to "http://www.pinterest.com/pin/create/charactermarklet/?url=#{url}&amp;media=#{media}&amp;description=#{description}"
  end
  
  private
  
  def set_character
    @character = Character.published.find_by_slug(params[:id])
    redirect_to serve_404_url unless @character
  end
end
