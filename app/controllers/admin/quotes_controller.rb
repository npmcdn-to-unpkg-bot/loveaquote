class Admin::QuotesController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_quote, only: [:edit, :update, :destroy, :qotd, :verify, :tweetable, :image]
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
  
  def verify
    respond_to do |format|
      ActiveRecord::Base.no_touching do
        if @quote.toggle!(:verified)
          format.json {render json: {verification_status: @quote.verified}}
        end
      end
    end
  end
  
  def tweetable
    @tweetable_quote = TweetableQuote.new(quote: @quote)
    if @tweetable_quote.save
      respond_to  do |format|
        format.json { render json: @tweetable_quote, status: :ok }
      end
    else
      respond_to  do |format|
        format.json { render json: @tweetable_quote.errors, status: :unprocessable_entity }
      end      
    end
  end

  def edit
  end

  # POST /quotes
  # POST /quotes.json
  def create
    @quote = Quote.new(quote_params)

    respond_to do |format|
      if @quote.save
        format.html {
          if params[:quote][:redirect_to].present?
            redirect_to params[:quote][:redirect_to], notice: 'Quote was successfully created.'
          else
            redirect_to view_context.admin_model_url(@quote.source), notice: 'Quote was successfully created.'
          end
        }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html {
          if params[:quote][:redirect_to].present?
            redirect_to params[:quote][:redirect_to], alert: 'Oops! an error occurred while creating the quote.'
          else
            redirect_to view_context.admin_model_url(@quote.source), alert: 'Oops! an error occurred while creating the quote.'
          end
        }
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
        format.json { head :ok }
      end
    end
  end
  
  def image
    QuoteImageWorker.perform_async(@quote.id)
    respond_to do |format|
      format.json { head :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quote_params
      params.require(:quote).permit(:text, :verified, :character_id, :source_id, :source_type, :topic_ids => [], quote_topics_attributes: [:id, :topic_id, :_destroy])
    end
end