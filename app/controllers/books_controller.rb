class BooksController < ApplicationController
  before_action :set_book, only: [:show]
  
  def index
    @books = Book.popular.published.order(name: "ASC").group_by{|a| a.name[0]}
  end

  def show
    @quotes = @book.quotes.order(total_share_count: :desc).order(text: :asc).page (params[:page])
    render layout: "book"
  end
  
  def alphabet
    @alphabet = params[:alphabet].upcase
    @books = Book.by_alphabet(@alphabet).published.order(name: "ASC")
  end
  
  private
  
  def set_book
    @book = Book.find_by_slug(params[:id])
    redirect_to serve_404_url unless @book
  end
end
