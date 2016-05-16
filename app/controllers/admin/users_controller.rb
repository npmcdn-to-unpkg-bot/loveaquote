class Admin::UsersController < ApplicationController
    before_filter :authenticate_admin!
    layout "admin"
    
    def index
        @users = User.order(created_at: :DESC).page params[:page]
    end
end