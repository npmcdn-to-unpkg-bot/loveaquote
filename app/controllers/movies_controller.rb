class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :twitter, :facemovie, :pinterest]
  
  def index
    @movies = Movie.popular.published.order(name: "ASC").group_by{|a| a.name[0]}
  end

  def show
    if params[:search].present?
      UserSearchWorker.perform_async(@movie.class.name, @movie.id, params[:search])
      @quotes = @movie.quotes.search_by_text(params[:search]).order(total_share_count: :desc).order(text: :asc).page (params[:page])
    else
      @quotes = @movie.quotes.order(total_share_count: :desc).order(text: :asc).page (params[:page])
    end
    render layout: "single"
  end
  
  def alphabet
    @alphabet = params[:alphabet].upcase
    @movies = Movie.by_alphabet(@alphabet).published.order(name: "ASC")
  end
  
  def twitter
    url = URI.encode(movie_url(@movie))
    text = CGI::escape("#{@movie.name} Quotes")
    redirect_to "https://twitter.com/intent/tweet?text=#{text}&amp;url=#{url}&amp;via=DoYouLoveAQuote"
  end
  
  def facemovie
    url = URI.encode(movie_url(@movie))
    redirect_to "https://www.facemovie.com/sharer/sharer.php?u=#{url}"
  end
  
  def pinterest
    url = URI.encode(movie_url(@movie))
    media = URI.encode(@author.image_url(:large))
    description = CGI::escape(@movie.name +  ' #quotes')
    redirect_to "http://www.pinterest.com/pin/create/moviemarklet/?url=#{url}&amp;media=#{media}&amp;description=#{description}"
  end
  
  private
  
  def set_movie
    @movie = Movie.published.find_by_slug(params[:id])
    if ! @movie
      @redirect = Redirect.find_by_from(movie_path(id: params[:id]))
      if ! @redirect
        NotFoundWorker.perform_async(movie_path(id: params[:id]), request.user_agent)
        redirect_to serve_404_url
      else
        redirect_to @redirect.to, status: 301
      end
    end
  end
end