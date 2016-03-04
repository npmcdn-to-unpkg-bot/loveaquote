class MessagesController < ApplicationController
  
  # GET /messages/new
  def new
    @message = Message.new
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to success_messages_url, notice: 'Message was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:name, :email, :subject, :content)
    end
end
