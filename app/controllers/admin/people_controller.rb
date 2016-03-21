class Admin::PeopleController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_person, only: [:show, :edit, :update, :destroy, :review]
  layout "admin"

  # GET /people
  # GET /people.json
  def index
    if params[:search].present?
      if params[:status].present?
        case params[:status]
        when "Draft"
          @people = Person.draft.search_by_name(params[:search]).order(name: :ASC).page params[:page]
        when "Published"
          @people = Person.published.search_by_name(params[:search]).order(name: :ASC).page params[:page]
        end
      else
        @people = Person.search_by_name(params[:search]).order(name: :ASC).page params[:page]
      end
    else
      if params[:status].present?
        case params[:status]
        when "Draft"
          @people = Person.draft.order(name: :ASC).page params[:page]
        when "Published"
          @people = Person.published.order(name: :ASC).page params[:page]
        end
      else
        @people = Person.order(name: :ASC).page params[:page]
      end
    end
  end

  # GET /people/1
  # GET /people/1.json
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
    @person.build_seo if @person.seo.nil?
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to admin_person_url(@person), notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to admin_person_url(@person), notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def review
    @review = @person.review || @person.build_review
    @review.date = Date.today
    @review.save
    redirect_to admin_person_path(@person)
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to admin_people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find_by_slug(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:name, :fetch_url, :born, :died, :nationality_id, :profession_id, :published, :popular, :very_popular, :image, seo_attributes: [:id, :title, :description, :_destroy])
    end
end
