class QuoteTwitterWorker
    include Sidekiq::Worker
    
    def perform(id, ua)
        bot_match = false
        
        Log::BOTS.each do |bot|
            if ua =~ /#{bot}/
                bot_match = true
                break
            end
        end
        
        unless bot_match
            quote = Quote.find(id)  
            quote.update(
                twitter_share_count: quote.twitter_share_count + 1,
                total_share_count: quote.total_share_count + 1
            )   
            Log.create(source: quote, category: "Social Share", sub_category: "Twitter", description: ua)
        end
    end
end