class Admin::DashboardController < ApplicationController
  before_filter :authenticate_admin!
  layout "admin"
  def index
    @authors = Author.draft.order(name: :ASC).limit(5)
    @books = Book.draft.order(name: :ASC).limit(5)
    @topics = Topic.draft.order(name: :ASC).limit(5)
  end
end
