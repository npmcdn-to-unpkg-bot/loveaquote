class WelcomeController < ApplicationController
  def index
    @people = Person.cached_very_popular
    @topics = Topic.cached_very_popular
    @books = Book.cached_very_popular
    @qotd = QuoteOfTheDay.today
  end

  def feed
    @timelines = TimeLine.all.order(created_at: :DESC).limit(20)
    respond_to do |format|
      format.html {}
			format.rss { render layout: false }
		end
  end
end
