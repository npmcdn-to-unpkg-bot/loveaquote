class TopicsController < ApplicationController
  before_action :set_topic, only: [:show]
  
  def index
    @topics = Topic.popular.published.order(name: "ASC").group_by{|a| a.name[0]}
  end

  def show
  end
  
  def alphabet
    @alphabet = params[:alphabet].upcase
    @topics = Topic.by_alphabet(@alphabet).published.order(name: "ASC")
  end
  
  private
  def set_topic
    @topic = Topic.find_by_slug(params[:id])
  end
end
