class QuoteOfTheDayWorker
    include Sidekiq::Worker
    
    def perform(id)
        quote = Quote.find(id)
        quote.update(
            quote_of_the_day_count: quote.quote_of_the_day_count + 1,
            total_share_count: quote.total_share_count + 1
        )
    end
end