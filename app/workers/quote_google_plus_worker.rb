class QuoteGooglePlusWorker
    include Sidekiq::Worker
    
    def perform(id)
        quote = Quote.find(id)    
        quote.update_attribute(:google_plus_share_count, quote.google_plus_share_count + 1)      
    end
end