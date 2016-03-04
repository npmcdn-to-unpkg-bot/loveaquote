class Admin::MessagesController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_message, only: [:show, :destroy]
  layout "admin"

  def index
    @messages = Message.order(created_at: :DESC).page params[:page]
  end

  def show
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to admin_messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end
end