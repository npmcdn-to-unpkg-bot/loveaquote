class Admin::TweetableQuotesController < ApplicationController
  before_filter :authenticate_admin!
  layout "admin"

  def index
    @tweetable_quotes = TweetableQuote.order(created_at: :DESC).page params[:page]
  end
end
