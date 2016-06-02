class My::DashboardController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @quotes = current_user.user_quotes.page params[:page]
  end
  
  def mark_for_deletion
    current_user.update_columns(mark_for_deletion: true)    
    redirect_to my_root_url, alert: "Your account has been marked for deletion and will be removed soon. To reactivate, simply login again. Thankyou for your patronage."
  end
  
end