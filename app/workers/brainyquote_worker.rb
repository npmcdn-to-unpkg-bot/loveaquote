class BrainyquoteWorker
  include Sidekiq::Worker

  def perform(id)
    author = Author.find(id)
    require 'open-uri'
    fetch_url = author.fetch_url
    page = Nokogiri::HTML(open(fetch_url))
    total_pages = 1

    if !page.css('ul.pagination').empty?
      page.css('ul.pagination li').each do |pagination|
        unless pagination.text == 'Next'
          total_pages = pagination.text.to_i
        end
      end
    end

    (1..total_pages).each do |page_number|
      if page_number != 1
        fetch_url = author.fetch_url[0..-6] + '_' + page_number.to_s + '.html'
      end

      page = Nokogiri::HTML(open(fetch_url))
      page.css('span.bqQuoteLink').each do |q|
        Quote.create(text: q.text.strip, source: author)
      end
    end
    author.fetch_url = ""
    author.save
  end
end