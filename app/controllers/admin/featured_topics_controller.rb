class Admin::FeaturedTopicsController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_featured_topic, only: [:destroy]
  
  # GET /topics/new
  def new
    @featured_topic = FeaturedTopic.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create
    @featured_topic = FeaturedTopic.new()
    @featured_topic.topic = Topic.find(params[:featured_topic][:topic_id]) if params[:featured_topic][:topic_id].present?
    @featured_topic.source = Author.find(params[:featured_topic][:author_id]) if params[:featured_topic][:author_id].present?
    @featured_topic.source = Book.find(params[:featured_topic][:book_id]) if params[:featured_topic][:book_id].present?
    
    respond_to do |format|
      if @featured_topic.save
        format.json { render json: @featured_topic, status: :created, location: @topic }
      else
        format.json { render json: @featured_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @featured_topic.update(featured_topic_params)
      else
        format.json { render json: @featured_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @featured_topic.destroy
    head :ok
  end

  private
    def set_featured_topic
      @featured_topic = FeaturedTopic.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def featured_topic_params
      params.require(:featured_topic).permit(:author_id, :book_id, :topic_id)
    end
end