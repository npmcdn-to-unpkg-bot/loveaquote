module ApplicationHelper
    def quote_source_url(quote)
        case quote.source_type
        when "Person"
            person_url(quote.source)
        when "Book"
            book_url(quote.source)
        else
            "http://www.loveaquote.com"
        end
    end
    
    def admin_quote_source_url(quote)
        case quote.source_type
        when "Person"
            admin_person_url(quote.source)
        when "Book"
            admin_book_url(quote.source)
        else
            "http://www.loveaquote.com/admin"
        end
    end
end
