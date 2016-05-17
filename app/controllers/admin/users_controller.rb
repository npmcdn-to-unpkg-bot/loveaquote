class Admin::UsersController < ApplicationController
    before_filter :authenticate_admin!
    before_action :set_user, only: [:destroy]
    layout "admin"
    
    def index
        @users = User.order(created_at: :DESC).page params[:page]
    end
    
    def destroy
        @user.destroy
        head :ok        
    end
    
    private
    
    def set_user
        @user = User.find(params[:id])
    end    
end