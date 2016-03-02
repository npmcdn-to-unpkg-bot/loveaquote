namespace :loveaquote do
    task :import_topics => :environment do
        require 'open-uri'
        fetch_url = "https://web.archive.org/web/20140226021056/http://www.loveaquote.com/topics/"
        page = Nokogiri::HTML(open(fetch_url))
        
        topics = page.css("article .alphabet ul li a")
        
        topics.each do |topic|
            puts "Creating topic - #{topic.text}"
            Topic.find_or_create_by(name: topic.text, published: true)
            sleep(1)
        end
    end
    
    task :import_people => :environment do
        require 'open-uri'
        fetch_url = "https://web.archive.org/web/20140226021056/http://www.loveaquote.com/authors/"
        page = Nokogiri::HTML(open(fetch_url))
    
        people = page.css("article .alphabet ul li a")
        
        people.each do |person|
            puts "Creating person - #{person.text}"
            person_url = "https://web.archive.org" + person.attr('href')
            
            begin
                person_page = Nokogiri::HTML(open(person_url))
            rescue OpenURI::HTTPError
                puts "Oops! some HTTP error occured for #{person.text}"
            else
                person = Person.find_or_create_by(name: person.text.strip) 
                if !person.published?
                    person.published = true
                    person.save
                end
                
                quotes = person_page.css(".quote-text p")
                quotes.each do |quote|
                    Quote.create(text: quote.text, source: person)
                end
            end
            sleep(1)
        end
    end
    
    task :import_books => :environment do
        require 'open-uri'
        fetch_url = "https://web.archive.org/web/20140226021056/http://www.loveaquote.com/books/"
        page = Nokogiri::HTML(open(fetch_url))
    
        books = page.css("article .alphabet ul li a")
        person = Person.find_or_create_by(name: "Dummy Person")
        books.each do |book|
            puts "Creating book - #{book.text}"
            book_url = "https://web.archive.org" + book.attr('href')
            
            begin
                book_page = Nokogiri::HTML(open(book_url))
            rescue OpenURI::HTTPError
                puts "Oops! some HTTP error occured for #{book.text}"
            else
                if Book.exists?(name: book.text.strip)
                    book = Book.find_by_name(book.text.strip)
                else
                    book = Book.create(name: book.text.strip, person: person, published: true)
                end
                
                quotes = book_page.css(".quote-text p")
                quotes.each do |quote|
                    Quote.create(text: quote.text, source: book)
                end
            end
            sleep(1)
        end
    end
    
    task :import_movies => :environment do
        require 'open-uri'
        fetch_url = "https://web.archive.org/web/20140226021056/http://www.loveaquote.com/movies/"
        page = Nokogiri::HTML(open(fetch_url))
    
        movies = page.css("article .alphabet ul li a")
        movies.each do |movie|
            puts "Creating movie - #{movie.text}"
            movie_url = "https://web.archive.org" + movie.attr('href')
            
            begin
                movie_page = Nokogiri::HTML(open(movie_url))
            rescue OpenURI::HTTPError
                puts "Oops! some HTTP error occured for #{movie.text}"
            else
                if Movie.exists?(name: movie.text.strip)
                    movie = Movie.find_by_name(movie.text.strip)
                else
                    movie = Movie.create(name: movie.text.strip, published: true)
                end
                
                quotes = movie_page.css(".quote-text p")
                quotes.each do |quote|
                    Quote.create(text: quote.text, source: movie)
                end
            end
            sleep(1)
        end
    end
    
    task :import_tv_shows => :environment do
        require 'open-uri'
        fetch_url = "https://web.archive.org/web/20140226021056/http://www.loveaquote.com/tv-shows/"
        page = Nokogiri::HTML(open(fetch_url))
    
        tv_shows = page.css("article .alphabet ul li a")
        tv_shows.each do |tv_show|
            puts "Creating movie - #{tv_show.text}"
            tv_show_url = "https://web.archive.org" + tv_show.attr('href')
            
            begin
                tv_show_page = Nokogiri::HTML(open(tv_show_url))
            rescue OpenURI::HTTPError
                puts "Oops! some HTTP error occured for #{tv_show.text}"
            else
                if TvShow.exists?(name: tv_show.text.strip)
                    tv_show = TvShow.find_by_name(tv_show.text.strip)
                else
                    tv_show = TvShow.create(name: tv_show.text.strip, published: true)
                end
                
                quotes = tv_show_page.css(".quote-text p")
                quotes.each do |quote|
                    Quote.create(text: quote.text, source: tv_show)
                end
            end
            sleep(1)
        end
    end
end