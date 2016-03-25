class BrainyquoteWorker
  include Sidekiq::Worker

  def perform(id)
    person = Person.find(id)
    require 'open-uri'
    fetch_url = person.fetch_url
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
        fetch_url = person.fetch_url[0..-6] + '_' + page_number.to_s + '.html'
      end

      page = Nokogiri::HTML(open(fetch_url))
      page.css('span.bqQuoteLink').each do |q|
        ActiveRecord::Base.no_touching do
          Quote.create(text: q.text.strip, source: person)
        end
      end
    end
    person.update_columns(fetch_url: "")
  end
end