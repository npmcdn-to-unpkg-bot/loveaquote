class Admin::CharactersController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_character, only: [:show, :edit, :update, :destroy, :review]

  # GET /characters
  # GET /characters.json
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
  end

  # GET /characters/1
  # GET /characters/1.json
  def show
  end

  # GET /characters/new
  def new
    @character = Character.new
  end

  # GET /characters/1/edit
  def edit
    @character.build_seo if @character.seo.nil?
  end

  # POST /characters
  # POST /characters.json
  def create
    @character = Character.new(character_params)

    respond_to do |format|
      if @character.save
        format.html { redirect_to admin_character_path(@character), notice: 'Character was successfully created.' }
        format.json { render :show, status: :created, location: @character }
      else
        format.html { render :new }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /characters/1
  # PATCH/PUT /characters/1.json
  def update
    respond_to do |format|
      if @character.update(character_params)
        format.html { redirect_to admin_character_path(@character), notice: 'Character was successfully updated.' }
        format.json { render :show, status: :ok, location: @character }
      else
        format.html { render :edit }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  def review
    @review = @character.review || @character.build_review
    @review.date = Date.today
    @review.save
    redirect_to admin_character_path(@character)
  end

  # DELETE /characters/1
  # DELETE /characters/1.json
  def destroy
    @character.destroy
    respond_to do |format|
      format.html { redirect_to admin_characters_path, notice: 'Character was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character
      @character = Character.find_by_slug(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def character_params
      params.require(:character).permit(:name, :slug, :image, :published, :popular, :very_popular, seo_attributes: [:id, :title, :description, :_destroy])
    end
end
