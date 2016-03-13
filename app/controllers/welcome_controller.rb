class WelcomeController < ApplicationController
  def index
    @people = Person.cached_very_popular.published.order(name: "ASC")
    @topics = Topic.cached_very_popular.published.order(name: "ASC")
    @books = Book.cached_very_popular.published.order(name: "ASC")
    @qotd = QuoteOfTheDay.find_by(date: Date.today)
  end
end
