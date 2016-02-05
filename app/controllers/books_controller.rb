class BooksController < ApplicationController
  before_action :set_book, only: [:show]
  
  def index
    @books = Book.popular.published.order(name: "ASC").group_by{|a| a.name[0]}
  end

  def show
    render layout: "book"
  end
  
  def alphabet
    @alphabet = params[:alphabet].upcase
    @books = Book.by_alphabet(@alphabet).published.order(name: "ASC")
  end
  
  private
  
  def set_book
    @book = Book.find_by_slug(params[:id])
  end
end
