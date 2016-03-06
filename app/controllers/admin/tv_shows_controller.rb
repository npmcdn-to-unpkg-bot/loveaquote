class Admin::TvShowsController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_tv_show, only: [:show, :edit, :update, :destroy]
  layout "admin"

  # GET /tv_shows
  # GET /tv_shows.json
  def index
    if params[:search].present?
      if params[:status].present?
        case params[:status]
        when "Draft"
          @tv_shows = TvShow.draft.search_by_name(params[:search]).order(name: :ASC).page params[:page]
        when "Published"
          @tv_shows = TvShow.published.search_by_name(params[:search]).order(name: :ASC).page params[:page]
        end
      else
        @tv_shows = TvShow.search_by_name(params[:search]).order(name: :ASC).page params[:page]
      end
    else
      if params[:status].present?
        case params[:status]
        when "Draft"
          @tv_shows = TvShow.draft.order(name: :ASC).page params[:page]
        when "Published"
          @tv_shows = TvShow.published.order(name: :ASC).page params[:page]
        end
      else
        @tv_shows = TvShow.order(name: :ASC).page params[:page]
      end
    end
  end

  # GET /tv_shows/1
  # GET /tv_shows/1.json
  def show
  end

  # GET /tv_shows/new
  def new
    @tv_show = TvShow.new
  end

  # GET /tv_shows/1/edit
  def edit
  end

  # POST /tv_shows
  # POST /tv_shows.json
  def create
    @tv_show = TvShow.new(tv_show_params)

    respond_to do |format|
      if @tv_show.save
        format.html { redirect_to admin_tv_shows_url, notice: 'Tv_show was successfully created.' }
        format.json { render :show, status: :created, location: @tv_show }
      else
        format.html { render :new }
        format.json { render json: @tv_show.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tv_shows/1
  # PATCH/PUT /tv_shows/1.json
  def update
    respond_to do |format|
      if @tv_show.update(tv_show_params)
        format.html { redirect_to admin_tv_shows_url, notice: 'Tv_show was successfully updated.' }
        format.json { render :show, status: :ok, location: @tv_show }
      else
        format.html { render :edit }
        format.json { render json: @tv_show.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tv_shows/1
  # DELETE /tv_shows/1.json
  def destroy
    @tv_show.destroy
    respond_to do |format|
      format.html { redirect_to admin_tv_shows_url, notice: 'Tv_show was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tv_show
      @tv_show = TvShow.find_by_slug(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tv_show_params
      params.require(:tv_show).permit(:name, :slug, :published, :popular, :very_popular, :image, character_sources_attributes: [:id, :character_id, :_destroy])
    end
end