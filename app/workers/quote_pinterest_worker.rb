class QuotePinterestWorker
    include Sidekiq::Worker
    
    def perform(id)
        quote = Quote.find(id)    
        quote.update_attribute(:pinterest_share_count, quote.pinterest_share_count + 1)      
    end
end