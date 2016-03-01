class Admin::TopicsController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  layout "admin"

  # GET /topics
  # GET /topics.json
  def index
    if params[:search].present?
      if params[:status].present?
        case params[:status]
        when "Draft"
          @topics = Topic.draft.search_by_name(params[:search]).order(name: :ASC).page params[:page]
        when "Published"
          @topics = Topic.published.search_by_name(params[:search]).order(name: :ASC).page params[:page]
        end
      else
        @topics = Topic.search_by_name(params[:search]).order(name: :ASC).page params[:page]
      end
    else
      if params[:status].present?
        case params[:status]
        when "Draft"
          @topics = Topic.draft.order(name: :ASC).page params[:page]
        when "Published"
          @topics = Topic.published.order(name: :ASC).page params[:page]
        end
      else
        @topics = Topic.order(name: :ASC).page params[:page]
      end
    end
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to admin_topic_url(@topic), notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to admin_topic_url(@topic), notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to admin_topics_url, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find_by_slug(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:name, :slug, :popular, :very_popular, :published)
    end
end
