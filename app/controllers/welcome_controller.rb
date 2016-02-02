class WelcomeController < ApplicationController
  def index
    author_count = Author.very_popular.count
    columns = 2

    @authors = []
    @authors << Author.very_popular.order(name: "ASC").limit(author_count/columns + author_count%columns)
    @authors << Author.very_popular.order(name: "ASC").limit(author_count/columns).offset( author_count/columns + author_count%columns)

    topic_count = Topic.very_popular.count
    @topics = []
    @topics << Topic.very_popular.order(name: "ASC").limit(topic_count/columns + topic_count%columns)
    @topics << Topic.very_popular.order(name: "ASC").limit(topic_count/columns).offset(topic_count/columns + topic_count%columns)
  end
end
