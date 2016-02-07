class QuoteSweeper < ActionController::Caching::Sweeper
    observe Quote
    
    def after_update(quote)
        if quote.source_type == "Author"
            author = Author.find(quote.source_id)
            expire_page(author_path(author))
            quote.topics.each do |topic|
                expire_page(topic_path(topic))
            end
        elsif quote.source_type == "Book"
            book = Book.find(quote.source_id)
            author = book.author
            expire_page(book_path(book))
            expire_page(author_path(author))
            quote.topics.each do |topic|
                expire_page(topic_path(topic))
            end            
        end
    end
    
end