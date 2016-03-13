class WelcomeController < ApplicationController
  def index
    @people = Person.very_popular.published.order(name: "ASC")
    @topics = Topic.very_popular.published.order(name: "ASC")
    @books = Book.very_popular.published.order(name: "ASC")
    @qotd = QuoteOfTheDay.find_by(date: Date.today)
  end
end
