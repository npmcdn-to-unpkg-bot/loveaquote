class Admin::SubscribersController < ApplicationController
    before_filter :authenticate_admin!
    before_action :set_subscriber, only: [:destroy]
    layout "admin"
    
    def index
        Subscriber.update_all(read: true)
        @subscribers = Subscriber.order(created_at: :DESC).page params[:page]
    end
    
    def destroy
        @subscriber.destroy
        head :ok        
    end
    
    private
    
    def set_subscriber
        @subscriber = Subscriber.find(params[:id])
    end    
end