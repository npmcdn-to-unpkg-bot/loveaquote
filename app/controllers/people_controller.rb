class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :redirect_to_person, :twitter, :facebook, :pinterest]
  
  def index
    @people = Person.popular.published.order(name: "ASC").group_by{|a| a.name[0]}
    @title = "Person List"
    @canonical = "#{people_url}"
  end
  
  def alphabet
    @alphabet = params[:alphabet].upcase
    @people = Person.by_alphabet(@alphabet).published.order(name: "ASC")
  end

  def show
    @quotes = @person.all_quotes.order(total_share_count: :desc).order(text: :asc).page params[:page]
    render layout: "single"
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
    media = URI.encode(@author.image_url(:large))
    description = CGI::escape(@person.name +  ' #quotes')
    redirect_to "http://www.pinterest.com/pin/create/bookmarklet/?url=#{url}&amp;media=#{media}&amp;description=#{description}"
  end
  
  private
  
  def set_person
    @person = Person.published.find_by_slug(params[:id])
    if ! @person
      @redirect = Redirect.find_by_from(person_path(id: params[:id]))
      if ! @redirect
        NotFoundWorker.perform_async(person_path(id: params[:id]))
        redirect_to serve_404_url
      else
        redirect_to @redirect.to, status: 301
      end
    end    
  end
end
