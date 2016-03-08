class Admin::TopicCombinationsController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_topic_combination, only: [:show, :edit, :update, :destroy]
  layout "admin"

  # GET /topic_combinations
  # GET /topic_combinations.json
  def index
    @topic_combinations = TopicCombination.all.page params[:page]
  end

  # GET /topic_combinations/1
  # GET /topic_combinations/1.json
  def show
  end

  # GET /topic_combinations/new
  def new
    @topic_combination = TopicCombination.new
  end

  # GET /topic_combinations/1/edit
  def edit
  end

  # POST /topic_combinations
  # POST /topic_combinations.json
  def create
    @topic_combination = TopicCombination.new(topic_combination_params)

    respond_to do |format|
      if @topic_combination.save
        format.html { redirect_to admin_topic_combination_path, notice: 'Topic combination was successfully created.' }
        format.json { render :show, status: :created, location: @topic_combination }
      else
        format.html { render :new }
        format.json { render json: @topic_combination.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topic_combinations/1
  # PATCH/PUT /topic_combinations/1.json
  def update
    respond_to do |format|
      if @topic_combination.update(topic_combination_params)
        format.html { redirect_to admin_topic_combination_path, notice: 'Topic combination was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic_combination }
      else
        format.html { render :edit }
        format.json { render json: @topic_combination.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topic_combinations/1
  # DELETE /topic_combinations/1.json
  def destroy
    @topic_combination.destroy
    respond_to do |format|
      format.html { redirect_to admin_topic_combination_path, notice: 'Topic combination was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic_combination
      @topic_combination = TopicCombination.find_by_slug(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_combination_params
      params.require(:topic_combination).permit(:primary_topic_id, :secondary_topic_id, :slug)
    end
end
