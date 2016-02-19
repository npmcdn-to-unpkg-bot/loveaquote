class QuoteFacebookWorker
    include Sidekiq::Worker
    
    def perform(id)
        quote = Quote.find(id)    
        quote.update_attribute(:facebook_share_count, quote.facebook_share_count + 1)      
    end
end