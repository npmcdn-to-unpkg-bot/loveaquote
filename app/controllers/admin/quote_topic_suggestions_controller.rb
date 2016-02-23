class Admin::QuoteTopicSuggestionsController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_quote_topic_suggestion, only: [:accept, :decline]
  layout "admin"

  def index
    if params[:topic].present?
      @quote_topic_suggestions = QuoteTopicSuggestion.where(topic_id: params[:topic]).where(read: false).order(quote_id: :ASC).page params[:page]
    else
      @quote_topic_suggestions = QuoteTopicSuggestion.where(read: false).order(quote_id: :ASC).page params[:page]
    end
  end

  def accept
    QuoteTopic.create(quote_id: @quote_topic_suggestion.quote_id, topic_id: @quote_topic_suggestion.topic_id)
    @quote_topic_suggestion.read = true
    @quote_topic_suggestion.save
    respond_to do |format|
      format.json { head :ok }
    end
    
  end
  
  def decline
    @quote_topic_suggestion.read = true
    @quote_topic_suggestion.save
    respond_to do |format|
      format.json { head :ok }
    end
  end
  
  private
  
  def set_quote_topic_suggestion
    @quote_topic_suggestion = QuoteTopicSuggestion.find(params[:id])
  end
    
end