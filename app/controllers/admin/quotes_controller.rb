class Admin::QuotesController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_quote, only: [:edit, :update, :destroy]
  layout "admin"

  # GET /quotes/new
  def new
    @quote = Quote.new
  end
  
  def edit
  end

  # POST /quotes
  # POST /quotes.json
  def create
    @quote = quote.new(quote_params)

    respond_to do |format|
      if @quote.save
        format.html { redirect_to admin_quotes_url, notice: 'quote was successfully created.' }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotes/1
  # PATCH/PUT /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to edit_admin_quote_url(@quote), notice: 'quote was successfully updated.' }
        format.json { render json: @quote, status: :ok }
      else
        format.html { render :edit }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quote_params
      params.require(:quote).permit(:text)
    end
end