class Admin::DashboardController < ApplicationController
  before_filter :authenticate_admin!
  layout "admin"
  
  def index
    @time_lines = TimeLine.order(created_at: :DESC).limit(15)
    @people = Person.draft.order(name: :ASC).limit(5)
    @books = Book.draft.order(name: :ASC).limit(5)
    @topics = Topic.draft.order(name: :ASC).limit(5)
  end
  
  def regenerate_social_images
    RegenerateAllSocialImagesWorker.perform_async
    respond_to do |format|
      format.json { head :ok }
    end        
  end
  
  def regenerate_quote_images
    RegenerateAllQuoteImagesWorker.perform_async
    respond_to do |format|
      format.json { head :ok }
    end    
  end
  
end
