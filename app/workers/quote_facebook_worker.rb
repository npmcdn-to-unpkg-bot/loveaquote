class QuoteFacebookWorker
    include Sidekiq::Worker
    
    def perform(id)
        quote = Quote.find(id)    
        total_share_count = quote.pinterest_share_count + quote.facebook_share_count + quote.twitter_share_count + quote.google_plus_share_count        
        quote.update_attributes(
            pinterest_share_count: quote.pinterest_share_count + 1,
            total_share_count: total_share_count + 1
        )      
    end
end