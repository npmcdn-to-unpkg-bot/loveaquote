class GoodreadsWorker
  include Sidekiq::Worker

  def perform(id)
    book = Book.find(id)
    require 'open-uri'
    fetch_quotes(book, book.fetch_url, 1)
  end

  def fetch_quotes(book, fetch_url, current_page)
    page = Nokogiri::HTML(open(fetch_url))
    page.css('div.quoteText').each do |q|
      quote = Quote.new
      quote.text = q.children.first.text[8..-5]
      quote.source = book
      quote.save
    end

    unless page.css('a.next_page').empty?
      current_page = current_page + 1
      uri = URI.parse(fetch_url)
      fetch_url = "#{uri.scheme}://#{uri.host}#{uri.path}?page=#{current_page.to_s}"
      fetch_quotes(book, fetch_url, current_page)
    end
  end

end