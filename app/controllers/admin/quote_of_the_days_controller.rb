class Admin::QuoteOfTheDaysController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @qotds = QuoteOfTheDay.order(date: :DESC).page params[:page]
  end
end
