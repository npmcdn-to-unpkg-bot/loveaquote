namespace :loveaquote_mar do
    task :import_topics => :environment do
        require 'open-uri'
        fetch_url = "https://web.archive.org/web/20140306051612/http://www.loveaquote.com/topics/"
        page = Nokogiri::HTML(open(fetch_url))
        
        topics = page.css("article .alphabet ul li a")
        
        topics.each do |topic|
            if !Topic.exists?(name: topic.text)
                puts "Creating topic - #{topic.text}"
                Topic.create(name: topic.text, published: true)
                sleep(0.5)
            end
        end
    end
    
    task :quotes_to_topics => :environment do
        require 'open-uri'
        fetch_url = "https://web.archive.org/web/20140226021056/http://www.loveaquote.com/topics/"
        page = Nokogiri::HTML(open(fetch_url))
        
        topics = page.css("article .alphabet ul li a")
        cant_find_quotes = []
        
        topics.each do |topic|
            if Topic.exists?(name: topic.text.strip)
                puts "== Updating quotes for #{topic.text.strip} =="
                topic_url = "https://web.archive.org" + topic.attr('href')
                
                begin
                    topic_page = Nokogiri::HTML(open(topic_url))
                rescue OpenURI::HTTPError
                    puts "Oops! some HTTP error occured for #{topic.text}"
                else
                    topic = Topic.find_by_name(topic.text.strip)
                    quotes = topic_page.css(".quote-text p")
                    quotes.each do |quote|
                        if Quote.exists?(text: quote.text.strip)
                            quote = Quote.find_by_text(quote.text.strip)
                            QuoteTopic.create(quote_id: quote.id, topic_id: topic.id)
                            puts "Added quote - #{quote.text}"
                            quote.quote_topic_suggestions.each do |suggest|
                                suggest.read = true
                                suggest.save
                            end
                            sleep(0.1)
                        else
                            cant_find_quotes << quote.text.strip
                        end
                    end
                end
            end
            sleep(0.5)
        end
        puts "============== Cant Find Quotes =============="
        cant_find_quotes.each do |quote|
            puts quote
        end
    end
    
    task :import_people => :environment do
        require 'open-uri'
        fetch_url = "https://web.archive.org/web/20140306051612/http://www.loveaquote.com/authors/"
        page = Nokogiri::HTML(open(fetch_url))
    
        people = page.css("article .alphabet ul li a")
        
        people.each do |person|
            if !Person.exists?(name: person.text.strip)
                puts "Creating person - #{person.text}"
                person_url = "https://web.archive.org" + person.attr('href')
                
                begin
                    person_page = Nokogiri::HTML(open(person_url))
                rescue OpenURI::HTTPError
                    puts "Oops! some HTTP error occured for #{person.text}"
                else
                    person = Person.create(name: person.text.strip, published: true) 
                    
                    quotes = person_page.css(".quote-text p")
                    quotes.each do |quote|
                        Quote.create(text: quote.text, source: person)
                    end
                end
                sleep(0.5)
            end
        end
    end
    
    task :import_books => :environment do
        require 'open-uri'
        fetch_url = "https://web.archive.org/web/20140306051612/http://www.loveaquote.com/books/"
        page = Nokogiri::HTML(open(fetch_url))
    
        books = page.css("article .alphabet ul li a")
        person = Person.find_or_create_by(name: "Dummy Person")
        books.each do |book|
            if !Book.exists?(name: book.text.strip)
                puts "Creating book - #{book.text}"
                book_url = "https://web.archive.org" + book.attr('href')
                
                begin
                    book_page = Nokogiri::HTML(open(book_url))
                rescue OpenURI::HTTPError
                    puts "Oops! some HTTP error occured for #{book.text}"
                else
                    book = Book.create(name: book.text.strip, person: person, published: true)
                    quotes = book_page.css(".quote-text p")
                    quotes.each do |quote|
                        Quote.create(text: quote.text, source: book)
                    end
                end
                sleep(0.5)
            end
        end
    end
    
    task :import_movies => :environment do
        require 'open-uri'
        fetch_url = "https://web.archive.org/web/20140306051612/http://www.loveaquote.com/movies/"
        page = Nokogiri::HTML(open(fetch_url))
    
        movies = page.css("article .alphabet ul li a")
        movies.each do |movie|
            if !Movie.exists?(name: movie.text.strip)            
                puts "Creating movie - #{movie.text}"
                movie_url = "https://web.archive.org" + movie.attr('href')
                
                begin
                    movie_page = Nokogiri::HTML(open(movie_url))
                rescue OpenURI::HTTPError
                    puts "Oops! some HTTP error occured for #{movie.text}"
                else
                    movie = Movie.create(name: movie.text.strip, published: true)
                
                    quotes = movie_page.css(".quote-text p")
                    quotes.each do |quote|
                        Quote.create(text: quote.text, source: movie)
                    end
                end
                sleep(0.5)
            end
        end
    end
    
    task :import_tv_shows => :environment do
        require 'open-uri'
        fetch_url = "https://web.archive.org/web/20140306051612/http://www.loveaquote.com/tv-shows/"
        page = Nokogiri::HTML(open(fetch_url))
    
        tv_shows = page.css("article .alphabet ul li a")
        tv_shows.each do |tv_show|
            if !TvShow.exists?(name: tv_show.text.strip)            
                puts "Creating movie - #{tv_show.text}"
                tv_show_url = "https://web.archive.org" + tv_show.attr('href')
                
                begin
                    tv_show_page = Nokogiri::HTML(open(tv_show_url))
                rescue OpenURI::HTTPError
                    puts "Oops! some HTTP error occured for #{tv_show.text}"
                else
                    tv_show = TvShow.create(name: tv_show.text.strip, published: true)
    
                    quotes = tv_show_page.css(".quote-text p")
                    quotes.each do |quote|
                        Quote.create(text: quote.text, source: tv_show)
                    end
                end
                sleep(0.5)
            end
        end
    end
end