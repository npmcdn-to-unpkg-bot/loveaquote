class QuoteTwitterWorker
    include Sidekiq::Worker

    def perform(id, ua)
        quote = Quote.find(id)
        quote.update(
            twitter_share_count: quote.twitter_share_count + 1,
            total_share_count: quote.total_share_count + 1
        )
        Log.create(source: quote, category: "Social Share", sub_category: "Twitter", description: ua)
    end
end