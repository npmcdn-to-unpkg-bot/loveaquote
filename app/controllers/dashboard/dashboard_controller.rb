class Dashboard::DashboardController < ApplicationController
  before_filter :authenticate_user!
  layout "user"
  
  def index
    
  end
end
