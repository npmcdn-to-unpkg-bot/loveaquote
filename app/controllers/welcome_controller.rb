class WelcomeController < ApplicationController
  def index
    person_count = Person.very_popular.count
    columns = 2

    @people = []
    @people << Person.very_popular.published.order(name: "ASC").limit(person_count/columns + person_count%columns)
    @people << Person.very_popular.published.order(name: "ASC").limit(person_count/columns).offset( person_count/columns + person_count%columns)

    topic_count = Topic.very_popular.count
    @topics = []
    @topics << Topic.very_popular.published.order(name: "ASC").limit(topic_count/columns + topic_count%columns)
    @topics << Topic.very_popular.published.order(name: "ASC").limit(topic_count/columns).offset(topic_count/columns + topic_count%columns)
  end
end
