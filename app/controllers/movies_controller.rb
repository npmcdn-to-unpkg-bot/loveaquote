class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :twitter, :facebook, :pinterest]

  def index
    @movies = Movie.popular.published.order(name: "ASC").group_by{|a| a.name[0]}
    @canonical = movies_url(format: :html)
    render layout: "archive"
  end

  def show
    @quotes = @movie.quotes.order(total_share_count: :desc).order(text: :asc).page (params[:page])
    expires_in 1.hour, public: true, must_revalidate: true

    if stale?(@movie)
      respond_to do |format|
        format.html { render layout: "single" }
        format.amp { render layout: "single" }
      end
    end
  end

  def alphabet
    @alphabet = params[:alphabet].upcase
    @movies = Movie.by_alphabet(@alphabet).published.order(name: "ASC")
    @canonical = alphabet_movies_url(format: :html)
    render layout: "alphabet"
  end

  def twitter
    url = URI.encode(movie_url(@movie, format: :html))
    text = CGI::escape("#{@movie.name} Quotes")
    redirect_to "https://twitter.com/intent/tweet?text=#{text}&amp;url=#{url}&amp;via=DoYouLoveAQuote"
  end

  def facemovie
    url = URI.encode(movie_url(@movie, format: :html))
    redirect_to "https://www.facemovie.com/sharer/sharer.php?u=#{url}"
  end

  def pinterest
    url = URI.encode(movie_url(@movie, format: :html))
    media = URI.encode(@author.image_url(:large))
    description = CGI::escape(@movie.name +  ' #quotes')
    redirect_to "http://www.pinterest.com/pin/create/moviemarklet/?url=#{url}&amp;media=#{media}&amp;description=#{description}"
  end

  def feed
    @timelines = TimeLine.where(item_type: "Movie").order(created_at: :DESC).limit(20)
    respond_to do |format|
      format.html { redirect_to feed_url, status: 301 }
      format.rss { render layout: false }
    end
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