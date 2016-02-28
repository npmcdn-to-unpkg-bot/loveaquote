class BooksController < ApplicationController
  before_action :set_book, only: [:show, :twitter, :facebook, :pinterest]
  
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
  
  def twitter
    url = URI.encode(book_url(@book))
    text = CGI::escape("#{@book.name} Quotes")
    redirect_to "https://twitter.com/intent/tweet?text=#{text}&amp;url=#{url}&amp;via=DoYouLoveAQuote"
  end
  
  def facebook
    url = URI.encode(book_url(@book))
    redirect_to "https://www.facebook.com/sharer/sharer.php?u=#{url}"
  end
  
  def pinterest
    url = URI.encode(book_url(@book))
    media = URI.encode(@author.image_url(:large))
    description = CGI::escape(@book.name +  ' #quotes')
    redirect_to "http://www.pinterest.com/pin/create/bookmarklet/?url=#{url}&amp;media=#{media}&amp;description=#{description}"
  end
  
  private
  
  def set_book
    @book = Book.published.find_by_slug(params[:id])
    redirect_to serve_404_url unless @book
  end
end
