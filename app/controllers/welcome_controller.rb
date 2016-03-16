class WelcomeController < ApplicationController
  def index
    @people = Person.cached_very_popular
    @topics = Topic.cached_very_popular
    @books = Book.cached_very_popular
    @qotd = QuoteOfTheDay.today
    @recents = TimeLine.cached_recent
  end
end
