class QuoteTwitterWorker
    include Sidekiq::Worker
    
    def perform(id)
        quote = Quote.find(id)    
        quote.update_attribute(:twitter_share_count, quote.twitter_share_count + 1)      
    end
end