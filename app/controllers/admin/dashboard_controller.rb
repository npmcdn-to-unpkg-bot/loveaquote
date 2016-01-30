class Admin::DashboardController < ApplicationController
  layout "admin"
  def index
    @authors = Author.draft.order(name: :ASC).limit(5)
    @books = Book.draft.order(name: :ASC).limit(5)
    @topics = Topic.draft.order(name: :ASC).limit(5)
  end
end
