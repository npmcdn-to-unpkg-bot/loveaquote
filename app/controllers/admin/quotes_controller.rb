class Admin::QuotesController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_quote, only: [:edit, :update, :destroy, :qotd]
  layout "admin"

  def index
    if params[:search].present?
      @quotes = Quote.search_by_text(params[:search]).page params[:page]
    else
      @quotes = Quote.order(created_at: :DESC).page params[:page]
    end
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
  end

  def edit
    @quote.build_chapter_and_page if @quote.chapter_and_page.nil? && @quote.source_type == "Book"
    @quote.build_season_and_episode if @quote.season_and_episode.nil? && @quote.source_type == "TvShow"
  end

  # POST /quotes
  # POST /quotes.json
  def create
    @quote = Quote.new(quote_params)

    respond_to do |format|
      if @quote.save
        format.html {
          redirect_to view_context.admin_model_url(@quote.source), notice: 'Quote was successfully created.'
        }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { redirect_to view_context.admin_model_url(@quote.source), notice: 'Oops! an error occurred while creating the quote.' }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotes/1
  # PATCH/PUT /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to edit_admin_quote_url(@quote), notice: 'Quote was successfully updated.' }
        format.json { render json: @quote, status: :ok }
      else
        format.html { redirect_to view_context.admin_model_url(@quote.source), notice: 'Oops! an error occurred while updating the quote.' }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1
  # DELETE /quotes/1.json
  def destroy
    @quote.destroy
    head :ok
  end

  def qotd
    if QuoteOfTheDay.exists?(date: Date.today)
      date = QuoteOfTheDay.maximum("date").next_day
    else
      date = Date.today
    end
    @qotd = QuoteOfTheDay.new(quote: @quote, date: date)

    respond_to do |format|
      if @qotd.save
        QuoteOfTheDayWorker.perform_async(@quote.id)
        format.js
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quote_params
      params.require(:quote).permit(:text, :character_id, :source_id, :source_type, :topic_ids => [], quote_topics_attributes: [:id, :topic_id, :_destroy], chapter_and_page_attributes: [:id, :chapter, :page, :_destroy], quoted_in_books_attributes: [:id, :isbn, :name, :author, :chapter, :page, :_destroy], season_and_episode_attributes: [:id, :season, :episode, :_destroy], found_ats_attributes: [:id, :link, :_destroy])
    end
end