class Admin::QuoteTopicSuggestionsController < ApplicationController
  before_action :set_quote_topic_suggestion, only: [:show, :edit, :update, :destroy]
  layout "admin"

  # GET /quote_topic_suggestions
  # GET /quote_topic_suggestions.json
  def index
    @quote_topic_suggestions = QuoteTopicSuggestion.all
  end

  # GET /quote_topic_suggestions/1
  # GET /quote_topic_suggestions/1.json
  def show
  end

  # GET /quote_topic_suggestions/new
  def new
    @quote_topic_suggestion = QuoteTopicSuggestion.new
  end

  # GET /quote_topic_suggestions/1/edit
  def edit
  end

  # POST /quote_topic_suggestions
  # POST /quote_topic_suggestions.json
  def create
    @quote_topic_suggestion = QuoteTopicSuggestion.new(quote_topic_suggestion_params)

    respond_to do |format|
      if @quote_topic_suggestion.save
        format.html { redirect_to @quote_topic_suggestion, notice: 'Quote topic suggestion was successfully created.' }
        format.json { render :show, status: :created, location: @quote_topic_suggestion }
      else
        format.html { render :new }
        format.json { render json: @quote_topic_suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quote_topic_suggestions/1
  # PATCH/PUT /quote_topic_suggestions/1.json
  def update
    respond_to do |format|
      if @quote_topic_suggestion.update(quote_topic_suggestion_params)
        format.html { redirect_to @quote_topic_suggestion, notice: 'Quote topic suggestion was successfully updated.' }
        format.json { render :show, status: :ok, location: @quote_topic_suggestion }
      else
        format.html { render :edit }
        format.json { render json: @quote_topic_suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quote_topic_suggestions/1
  # DELETE /quote_topic_suggestions/1.json
  def destroy
    @quote_topic_suggestion.destroy
    respond_to do |format|
      format.html { redirect_to quote_topic_suggestions_url, notice: 'Quote topic suggestion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote_topic_suggestion
      @quote_topic_suggestion = QuoteTopicSuggestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quote_topic_suggestion_params
      params[:quote_topic_suggestion]
    end
end
