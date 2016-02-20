module ApplicationHelper
    def quote_source_url(quote)
        case quote.source_type
        when "Author"
            author_url(quote.source)
        when "Book"
            book_url(quote.source)
        else
            "http://www.loveaquote.com"
        end
    end
end
