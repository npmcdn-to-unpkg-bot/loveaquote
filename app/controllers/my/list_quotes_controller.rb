class My::ListQuotesController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @list = ListQuote.new(list_params)
    @list.user = current_user

    respond_to do |format|
      if @list.save
        format.html { redirect_to my_lists_url, notice: 'List was successfully created.' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
    
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:list_id, :quote_id)
    end      
end