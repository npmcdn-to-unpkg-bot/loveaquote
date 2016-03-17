namespace :loveaquote do
    task :import_topics, [:date] => :environment do |t, args|
        require 'open-uri'
        fetch_url = "https://web.archive.org/web/#{args[:date]}/http://www.loveaquote.com/topics/"
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

    task :import_people, [:date] => :environment do |t, args|
        require 'open-uri'
        fetch_url = "https://web.archive.org/web/#{args[:date]}/http://www.loveaquote.com/authors/"
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

                quotes = person_page.css(".quote-text p")
                quotes.each do |quote|
                    Quote.create(text: quote.text, source: person)
                end

                pagination = person_page.css(".pagination")

                if pagination.present?
                    last = pagination.css(".last a")
                    last_page_href = last.attr('href').to_s
                    if last_page_href[-3] == "/"
                        last_page = last_page_href[-2]
                    elsif last_page_href[-4] == "/"
                        last_page = last_page_href[-3..-2]
                    end

                    if last_page
                        (2..last_page.to_i).each do |page|
                            url = person_url + "#{page}/"

                            begin
                                person_page = Nokogiri::HTML(open(url))
                            rescue OpenURI::HTTPError
                                puts "Oops! some HTTP error occured for #{person.name} - page - #{page}"
                            else
                                puts "#{person.name} - page - #{page}"
                                quotes = person_page.css(".quote-text p")
                                quotes.each do |quote|
                                    Quote.create(text: quote.text, source: person)
                                end
                            end
                        end
                    end
                end
            end
            sleep(0.5)
        end
    end

    task :import_books, [:date] => :environment do |t, args|
        require 'open-uri'
        fetch_url = "https://web.archive.org/web/#{args[:date]}/http://www.loveaquote.com/books/"
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
                book = Book.find_or_create_by(name: book.text.strip)
                quotes = book_page.css(".quote-text p")
                quotes.each do |quote|
                    Quote.create(text: quote.text, source: book)
                end

                pagination = book_page.css(".pagination")

                if pagination.present?
                    last = pagination.css(".last a")
                    last_page_href = last.attr('href').to_s
                    if last_page_href[-3] == "/"
                        last_page = last_page_href[-2]
                    elsif last_page_href[-4] == "/"
                        last_page = last_page_href[-3..-2]
                    end

                    if last_page
                        (2..last_page.to_i).each do |page|
                            url = book_url + "#{page}/"

                            begin
                                book_page = Nokogiri::HTML(open(url))
                            rescue OpenURI::HTTPError
                                puts "Oops! some HTTP error occured for #{book.name} - page - #{page}"
                            else
                                puts "#{book.name} - page - #{page}"
                                quotes = book_page.css(".quote-text p")
                                quotes.each do |quote|
                                    Quote.create(text: quote.text, source: book)
                                end
                            end
                        end
                    end
                end
            end
            sleep(0.5)
        end
    end

    task :import_movies, [:date] => :environment do |t, args|
        require 'open-uri'
        fetch_url = "https://web.archive.org/web/#{args[:date]}/http://www.loveaquote.com/movies/"
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
                movie = Movie.find_or_create_by(name: movie.text.strip)

                quotes = movie_page.css(".quote-text p")
                quotes.each do |quote|
                    Quote.create(text: quote.text, source: movie)
                end

                pagination = movie_page.css(".pagination")

                if pagination.present?
                    last = pagination.css(".last a")
                    last_page_href = last.attr('href').to_s
                    if last_page_href[-3] == "/"
                        last_page = last_page_href[-2]
                    elsif last_page_href[-4] == "/"
                        last_page = last_page_href[-3..-2]
                    end

                    if last_page
                        (2..last_page.to_i).each do |page|
                            url = movie_url + "#{page}/"

                            begin
                                movie_page = Nokogiri::HTML(open(url))
                            rescue OpenURI::HTTPError
                                puts "Oops! some HTTP error occured for #{movie.name} - page - #{page}"
                            else
                                puts "#{movie.name} - page - #{page}"
                                quotes = movie_page.css(".quote-text p")
                                quotes.each do |quote|
                                    Quote.create(text: quote.text, source: movie)
                                end
                            end
                        end
                    end
                end
            end
            sleep(0.5)
        end
    end

    task :import_tv_shows, [:date] => :environment do |t, args|
        require 'open-uri'
        fetch_url = "https://web.archive.org/web/#{args[:date]}/http://www.loveaquote.com/tv-shows/"
        page = Nokogiri::HTML(open(fetch_url))

        tv_shows = page.css("article .alphabet ul li a")
        tv_shows.each do |tv_show|
            puts "Creating TvShow - #{tv_show.text}"
            tv_show_url = "https://web.archive.org" + tv_show.attr('href')

            begin
                tv_show_page = Nokogiri::HTML(open(tv_show_url))
            rescue OpenURI::HTTPError
                puts "Oops! some HTTP error occured for #{tv_show.text}"
            else
                tv_show = TvShow.find_or_create_by(name: tv_show.text.strip)

                quotes = tv_show_page.css(".quote-text p")
                quotes.each do |quote|
                    Quote.create(text: quote.text, source: tv_show)
                end

                pagination = tv_show_page.css(".pagination")

                if pagination.present?
                    last = pagination.css(".last a")
                    last_page_href = last.attr('href').to_s
                    if last_page_href[-3] == "/"
                        last_page = last_page_href[-2]
                    elsif last_page_href[-4] == "/"
                        last_page = last_page_href[-3..-2]
                    end

                    if last_page
                        (2..last_page.to_i).each do |page|
                            url = tv_show_url + "#{page}/"

                            begin
                                tv_show_page = Nokogiri::HTML(open(url))
                            rescue OpenURI::HTTPError
                                puts "Oops! some HTTP error occured for #{tv_show.name} - page - #{page}"
                            else
                                puts "#{tv_show.name} - page - #{page}"
                                quotes = tv_show_page.css(".quote-text p")
                                quotes.each do |quote|
                                    Quote.create(text: quote.text, source: tv_show)
                                end
                            end
                        end
                    end
                end
            end
            sleep(0.5)
        end
    end

    task :import_proverbs, [:date] => :environment do |t, args|
        require 'open-uri'
        fetch_url = "https://web.archive.org/web/#{args[:date]}/http://www.loveaquote.com/proverbs/"
        page = Nokogiri::HTML(open(fetch_url))

        proverbs = page.css("article .alphabet ul li a")
        proverbs.each do |proverb|
            puts "Creating proverb - #{proverb.text}"
            proverb_url = "https://web.archive.org" + proverb.attr('href')

            begin
                proverb_page = Nokogiri::HTML(open(proverb_url))
            rescue OpenURI::HTTPError
                puts "Oops! some HTTP error occured for #{proverb.text}"
            else
                proverb = Proverb.find_or_create_by(name: proverb.text.strip)

                quotes = proverb_page.css(".proverb-text p")
                quotes.each do |quote|
                    Quote.create(text: quote.text, source: proverb)
                end

                pagination = proverb_page.css(".pagination")

                if pagination.present?
                    last = pagination.css(".last a")
                    last_page_href = last.attr('href').to_s
                    if last_page_href[-3] == "/"
                        last_page = last_page_href[-2]
                    elsif last_page_href[-4] == "/"
                        last_page = last_page_href[-3..-2]
                    end

                    if last_page
                        (2..last_page.to_i).each do |page|
                            url = proverb_url + "#{page}/"

                            begin
                                proverb_page = Nokogiri::HTML(open(url))
                            rescue OpenURI::HTTPError
                                puts "Oops! some HTTP error occured for #{proverb.name} - page - #{page}"
                            else
                                puts "#{proverb.name} - page - #{page}"
                                quotes = proverb_page.css(".quote-text p")
                                quotes.each do |quote|
                                    Quote.create(text: quote.text, source: proverb)
                                end
                            end
                        end
                    end
                end
            end
            sleep(0.5)
        end
    end
end