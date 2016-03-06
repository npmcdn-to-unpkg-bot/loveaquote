class QuoteFacebookWorker
    include Sidekiq::Worker
    
    def perform(id, ua)
        quote = Quote.find(id)    
        total_share_count = quote.pinterest_share_count + quote.facebook_share_count + quote.twitter_share_count + quote.google_plus_share_count        
        quote.update(
            pinterest_share_count: quote.pinterest_share_count + 1,
            total_share_count: total_share_count + 1
        )
        Log.create(source: quote, category: "Social Share", sub_category: "Facebook", description: ua)
    end
end