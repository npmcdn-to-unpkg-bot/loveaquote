class Admin::TopicAliasesController < ApplicationController
  before_filter :authenticate_admin!
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
    @topic_alias = TopicAlias.new(topic_alias_params)
    
    respond_to do |format|
      if @topic_alias.save
        format.json { render :show, status: :created, location: @topic }
      else
        format.json { render json: @topic_alias.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic_alias.update(topic_params)
      else
        format.json { render json: @topic_alias.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic_alias.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_alias_params
      params.require(:topic_alias).permit(:name, :topic_id)
    end
end