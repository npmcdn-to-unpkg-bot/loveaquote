class Admin::QuoteOfTheDaysController < ApplicationController
  before_filter :authenticate_admin!
  layout "admin"

  # GET /books
  # GET /books.json
  def index
    @qotds = QuoteOfTheDay.order(date: :DESC).page params[:page]
  end
end
