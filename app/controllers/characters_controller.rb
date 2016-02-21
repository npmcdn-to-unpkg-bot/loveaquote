class CharactersController < ApplicationController
  before_action :set_character, only: [:show]
  
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
  
  private
  
  def set_character
    @character = Character.find_by_slug(params[:id])
    redirect_to serve_404_url unless @character
  end
end
