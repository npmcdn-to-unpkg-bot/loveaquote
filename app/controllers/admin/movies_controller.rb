class Admin::MoviesController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  layout "admin"

  # GET /movies
  # GET /movies.json
  def index
    if params[:search].present?
      if params[:status].present?
        case params[:status]
        when "Draft"
          @movies = Movie.draft.search_by_name(params[:search]).order(name: :ASC).page params[:page]
        when "Published"
          @movies = Movie.published.search_by_name(params[:search]).order(name: :ASC).page params[:page]
        end
      else
        @movies = Movie.search_by_name(params[:search]).order(name: :ASC).page params[:page]
      end
    else
      if params[:status].present?
        case params[:status]
        when "Draft"
          @movies = Movie.draft.order(name: :ASC).page params[:page]
        when "Published"
          @movies = Movie.published.order(name: :ASC).page params[:page]
        end
      else
        @movies = Movie.order(name: :ASC).page params[:page]
      end
    end
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to admin_movie_path(@movie), notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to admin_movie_path(@movie), notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to admin_movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find_by_slug(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:name, :slug, :published, :popular, :very_popular, :image, character_sources_attributes: [:id, :character_id, :person_id, :_destroy])
    end
end
