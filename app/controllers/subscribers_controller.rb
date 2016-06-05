class SubscribersController < ApplicationController
  
  def create
    @subscriber = Subscriber.new(subscriber_params)

    respond_to do |format|
      if @subscriber.save
        SubscriberGeoipDataWorker.perform_async(@subscriber.id, request.remote_ip)
        format.js { head :ok }
      else
        format.js { head 422 }
      end
    end
  end

  private
    def subscriber_params
      params.require(:subscriber).permit(:name, :email, :subject, :content)
    end
end
