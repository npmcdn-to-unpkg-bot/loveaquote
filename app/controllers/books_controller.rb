class BooksController < ApplicationController
  before_action :set_book, only: [:show, :redirect_to_book, :twitter, :facebook, :pinterest]

  def index
    @books = Book.popular.published.order(name: "ASC").group_by{|a| a.name[0]}
  end

  def show
    @quotes = @book.quotes.order(total_share_count: :desc).order(text: :asc).page (params[:page])
  end

  def alphabet
    @alphabet = params[:alphabet].upcase
    @books = Book.by_alphabet(@alphabet).published.order(name: "ASC")
  end

  def redirect_to_book
    redirect_to book_url(@book), status: 301
  end

  def twitter
    url = URI.encode(book_url( @book ))
    text = CGI::escape("#{@book.name} Quotes")
    redirect_to "https://twitter.com/intent/tweet?text=#{text}&amp;url=#{url}&amp;via=DoYouLoveAQuote"
  end

  def facebook
    url = URI.encode(book_url( @book ))
    redirect_to "https://www.facebook.com/sharer/sharer.php?u=#{url}"
  end

  def pinterest
    url = URI.encode(book_url( @book ))
    media = URI.encode(@book.social_image.pinterest_url)
    description = CGI::escape(@book.name +  ' #quotes')
    redirect_to "http://www.pinterest.com/pin/create/bookmarklet/?url=#{url}&amp;media=#{media}&amp;description=#{description}"
  end

  def feed
    @timelines = TimeLine.where(item_type: "Book").order(created_at: :DESC).limit(20)
    respond_to do |format|
      format.html { redirect_to feed_url, status: 301 }
      format.rss { render layout: false }
    end
  end

  private

  def set_book
    @book = Book.published.find_by_slug(params[:id])
      if ! @book
        @redirect = Redirect.find_by_from(book_path(id: params[:id]))
        if ! @redirect
          Delayed::Job.enqueue NotFoundJob.new(book_path(id: params[:id]), request.user_agent)
          redirect_to serve_404_url
        else
          redirect_to @redirect.to, status: 301
        end
      end
  end
end