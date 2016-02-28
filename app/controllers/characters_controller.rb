class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :twitter, :facebook, :pinterest]
  
  def index
    @characters = Character.popular.published.order(name: "ASC").group_by{|a| a.name[0]}
  end

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
    @character = Character.find_by_slug(params[:id])
    redirect_to serve_404_url unless @character
  end
end
