class AuthorsController < ApplicationController
  before_action :set_author, only: [:show]
  
  def index
    @authors = Author.popular.published.order(name: "ASC").group_by{|a| a.name[0]}
    @title = "Author List"
    @canonical = "#{authors_url}"
  end
  
  def alphabet
    @alphabet = params[:alphabet].upcase
    @authors = Author.by_alphabet(@alphabet).published.order(name: "ASC")
  end

  def show
    render layout: "author"
  end
  
  private
  
  def set_author
    @author = Author.find_by_slug(params[:id])
  end
end
