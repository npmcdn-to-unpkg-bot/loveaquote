class QuoteFacebookWorker
    include Sidekiq::Worker

    def perform(id, ua)
        quote = Quote.find(id)
        quote.update(
            facebook_share_count: quote.facebook_share_count + 1,
            total_share_count: quote.total_share_count + 1
        )
        Log.create(source: quote, category: "Social Share", sub_category: "Facebook", description: ua)
    end
end