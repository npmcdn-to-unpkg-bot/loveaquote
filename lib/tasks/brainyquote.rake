namespace :brainyquote do
    task :fetch => :environment do
    require 'open-uri'
    fetch_url = "http://www.brainyquote.com/quotes/authors/r/robert_green_ingersoll.html"
    page = Nokogiri::HTML(open(fetch_url))
    total_pages = 1

    if !page.css('ul.pagination').empty?
      page.css('ul.pagination li').each do |pagination|
        unless pagination.text.to_i == 0
          total_pages = pagination.text.to_i
        end
      end
    end

    (1..total_pages).each do |page_number|
      if page_number != 1
        fetch_url = fetch_url[0..-6] + '_' + page_number.to_s + '.html'
      end
        puts fetch_url
        
      page = Nokogiri::HTML(open(fetch_url))
      page.css('span.bqQuoteLink').each do |q|
        ActiveRecord::Base.no_touching do
          puts q.text.strip
        end
      end
    end
    end
end